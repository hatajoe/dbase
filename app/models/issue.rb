class Issue < GithubResource
  belongs_to :milestone

  #
  # @param [Sawyer::Resource] payload
  # @return [Proc]
  #
  def self.from_payload(payload)
    -> {
      find_or_initialize_by_resource(
        payload,
        milestone_id: milestone.id,
        state: response.state,
        title: response.title,
        body: response.body
      ).save
    }
  end

  #
  # @param [Sawyer::Resource] response
  # @param [Milestone] milestone
  # @return [Issue]
  #
  def self.from_response(response, milestone)
    find_or_initialize_by_resource(
      response,
      id: response.id,
      milestone_id: milestone.id,
      number: response.number,
      url: response.html_url,
      state: response.state,
      title: response.title,
      body: response.body
    )
  end
end
