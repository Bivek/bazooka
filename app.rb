require File.dirname(__FILE__) + '/lib/ansible'

module Bazooka
  class App < Sinatra::Base
    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      password =  Digest::SHA1.hexdigest(password)
      username == 'ammunition' && password == 'c143a977311b8354ea69c1dcc042c3be91756591'
    end

    post 'api/v1/' do
      accept_params do |p|
        p.string :platform, required: true
        p.string :queue, required: false
        p.integer :action, required: false
      end
      Ansible.play(params)
    end
  end

  def self.root
    `pwd`.strip
  end
end