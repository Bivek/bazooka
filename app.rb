require File.dirname(__FILE__) + '/lib/ansible'

module Bazooka
  class App < Sinatra::Base
    set :raise_errors, true

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      password =  Digest::SHA1.hexdigest(password)
      username == 'ammunition' && password == 'c143a977311b8354ea69c1dcc042c3be91756591'
    end

    post '/api/v1/scale' do
      params = request.body.read
      Ansible.play(params)
      if $?.success?
        {msg: 'Processed successfully', status: 200}.to_json
      else
        {msg: 'Sorry, something terrible happened', status: 500}.to_json
      end
    end
  end

  def self.root
    `pwd`.strip
  end
end