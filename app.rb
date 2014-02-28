Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file}

module Bazooka
  class App < Sinatra::Base
    post 'api/v1/' do
      accept_params do |p|
        p.string :server_tag, :required => true
        p.string :queues, :required => false
      end
      Ansible.play(params)
    end
  end

  def self.root
    `pwd`.strip
  end
end