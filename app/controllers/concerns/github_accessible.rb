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

  private

  #
  # @param [String] access_token
  # @return [Hash]
  #
  def opt(access_token)
    { access_token: access_token, auto_paginate: true }
  end
end
