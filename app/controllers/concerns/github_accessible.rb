#
# GithubAccessible manipulates the Octokit interface
#
module GithubAccessible
  #
  # @param [String] access_token
  # @return [Array<Repository>]
  #
  def repos(access_token)
    @repos ||= Octokit::Client.new(opt(access_token)).repos.map { |r| Repository.new(id: r.id, full_name: r.full_name, url: r.html_url) }
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
      map { |m| build_milestones(repository, m) }
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
      map do |p|
        repository.projects.find_or_initialize_by(id: p.id).tap do |project|
          project.assign_attributes(
            id: p.id,
            repository_id: repository.id,
            number: p.number,
            url: p.html_url,
            name: p.name,
            body: p.body,
          )
        end
      end
  end

  #
  # @param [String] access_token
  # @param [Project] project
  # @return [Array<ProjectColumn>]
  #
  def project_columns(access_token, project)
    Octokit::Client.new(opt(access_token)).
      project_columns(project.id).
      map do |pc|
        project.project_columns.find_or_initialize_by(id: pc.id).tap do |column|
          column.assign_attributes(
            id: pc.id,
            project_id: project.id,
            name: pc.name
          )
        end
      end
  end

  #
  # @param [String] access_token
  # @param [ProjectColumn] project_column
  # @return [Array<ProjectCard>]
  #
  def project_cards(access_token, project_column)
    Octokit::Client.new(opt(access_token)).
      column_cards(project_column.id).
      map do |pc|
        project_column.project_cards.find_or_initialize_by(id: pc.id).tap do |card|
          card.assign_attributes(
            id: pc.id,
            issue_id: (pc.content_url.try(:split, '/').try(:last)).to_i,
            project_column_id: project_column.id,
            note: pc.note,
            content_url: pc.content_url
          )
        end
      end
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
      map do |i|
        milestone.issues.find_or_initialize_by(id: i.id).tap do |issue|
          issue.assign_attributes(
            id: i.id,
            milestone_id: milestone.id,
            number: i.number,
            url: i.html_url,
            state: i.state,
            title: i.title,
            body: i.body
          )
        end
      end
  end

  private

  #
  # @param [String] access_token
  # @return [Hash]
  #
  def opt(access_token)
    { access_token: access_token, auto_paginate: true }
  end

  #
  # @param [Repository] repository
  # @param [Sawyer::Resource] milestone
  # @return [Milestone]
  #
  def build_milestones(repository, milestone)
    repository.milestones.where(id: milestone.id).first_or_initialize(
      id: milestone.id,
      repository_id: repository.id,
      number: milestone.number,
      title: milestone.title,
      description: milestone.description,
      url: milestone.html_url,
      open_issues: milestone.open_issues,
      closed_issues: milestone.closed_issues,
      due_on: milestone.due_on
    )
  end
end
