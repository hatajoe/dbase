#
# GithubAccessible manipulates the Octokit interface
#
module GithubAccessible
  @@events = {
    issues: -> (payload) { Issue.from_payload(payload.issue) },
    milestone: -> (payload) { Milestone.from_payload(payload.milestone) },
    project_card: -> (payload) { ProjectCard.from_payload(payload.project_card) },
    project_column: -> (payload) { ProjectColumn.from_payload(payload.project_column) },
    project: -> (payload) { Project.from_payload(payload.project) },
    pull_request: -> (payload) { Issue.from_payload(payload.pull_request) },
    repository: -> (payload) { Repository.from_payload(payload.repository) },
  }.freeze

  #
  # @param [String] access_token
  # @return [Array<Repository>]
  #
  def repos(access_token)
    @repos ||= Octokit::Client.new(opt(access_token)).
      repos.
      map { |payload| Repository.from_payload(payload) }
  end

  #
  # @param [String] access_token
  # @param [Repository] repository
  # @param [Hash] options
  # @return [Array<Milestone>]
  #
  def milestones(access_token, repository, options: {})
    Octokit::Client.new(opt(access_token)).
      milestones(repository.full_name, options).
      map { |payload| repository.milestones.from_payload(payload) }
  end

  #
  # @param [String] access_token
  # @param [Repository] repository
  # @param [Hash] options
  # @return [Array<Project>]
  #
  def projects(access_token, repository, options: {})
    Octokit::Client.new(opt(access_token)).
      projects(repository.full_name, options).
      map { |payload| repository.projects.from_payload(payload) }
  end

  #
  # @param [String] access_token
  # @param [Project] project
  # @return [Array<ProjectColumn>]
  #
  def project_columns(access_token, project)
    Octokit::Client.new(opt(access_token)).
      project_columns(project.id).
      map { |payload| project.project_columns.from_payload(payload) }
  end

  #
  # @param [String] access_token
  # @param [ProjectColumn] column
  # @return [Array<ProjectCard>]
  #
  def project_cards(access_token, column)
    Octokit::Client.new(opt(access_token)).
      column_cards(column.id).
      map { |payload| column.project_cards.from_payload(payload) }
  end

  #
  # @param [String] access_token
  # @param [Milestone] milestone
  # @param [Hash] options
  # @return [Array<ProjectCard>]
  #
  def issues(access_token, milestone, options: {})
    Octokit::Client.new(opt(access_token)).
      list_issues(milestone.repository.full_name, options.merge(milestone: milestone.number, state: :all)).
      map { |payload| milestone.issues.from_payload(payload) }
  end

  #
  # @param [String] access_token
  # @param [Repository] repository
  # @param [String] secret
  #
  def create_hook(access_token, repository, secret)
    Octokit::Client.new(opt(access_token)).
      create_hook(repository.full_name, 'web', {
        url: webhooks_url,
        content_type: 'json',
        secret: secret,
      }, {
        events: @@events.keys,
        active: true,
      })
  end

  #
  # @param [String] access_token
  # @param [Repository] repository
  # @param [Hash] options
  #
  def delete_hook(access_token, repository, options: {})
    client = Octokit::Client.new(opt(access_token))
    client.hooks(repository.full_name).
      select { |h| h.name == 'web' }.
      map(&:id).
      each { |id| client.remove_hook(repository.full_name, id, options) }
  end

  #
  # @param [String] payload_body
  # @param [String] hub_signature
  # @param [String] secret
  # @return [TrueClass or FalseClass]
  #
  def verify_signature?(payload_body, hub_signature, secret)
    signature = "sha1=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), secret, payload_body)}"
    Rack::Utils.secure_compare(signature, hub_signature)
  end

  #
  # @param [String] event
  # @param [[Sawyer::Resource]] payload
  # @return [ApplicationRecord or NilClass]
  #
  def resolve_webhook(event, payload)
    @@events[event.to_sym].try(:call, payload)
  end

  #
  # @param [String] payload_body
  # @return [Sawyer::Resource]
  #
  def parse_payload(payload_body)
    Octokit::Client.new.parse_payload(payload_body)
  end

  private

  #
  # @param [String] access_token
  # @return [Hash]
  #
  def opt(access_token)
    { access_token: access_token, auto_paginate: true }
  end
end
