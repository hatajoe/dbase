#
# GithubResourceable manipulates the model of the Github payloads
#
module GithubResourceable
  extend ActiveSupport::Concern

  module ClassMethods
    #
    # @param [Sawyer::Resource] resource
    # @param [Hash] attributes
    # @return [GithubResource]
    #
    def find_or_initialize_by_resource(resource, attributes)
      find_or_initialize_by(id: resource.id).tap { |model| model.assign_attributes(attributes) }
    end

    #
    # @param [String] url
    # @return [Integer]
    #
    def resource_id(url)
      url.try(:split, '/').try(:last).to_i
    end

    #
    # @param [String] url
    # @return [String]
    #
    def resource_reponame(url)
      url.try(:split, '/')[-2..-1].join('/')
    end

    #
    # @param [String] url
    # @return [String]
    #
    def milestone_reponame(url)
      url.try(:split, '/')[-3..-2].join('/')
    end
  end

  #
  # @param [Sawyer::Resource] action destroy resource if 'deleted' specified.
  # @return [TrueClass or FalseClass]
  #
  def save_or_destroy(action: '')
    if action == 'deleted'
      !!destroy
    else
      save
    end
  end
end