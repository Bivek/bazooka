require 'json'

module Ansible
  extend self
  SHUTDOWN_ACTION = 0
  require_relative './utils.rb'

  def play(params)
    params = JSON.parse(params) rescue params
    if params.shutdown_server?
      shutdown_server(params)
    else
      spin_up_server(params)
    end
  end

  private

  def shutdown_server(params)
    if params.dealing_with_bg?
      kill_bg_server(params)
    else
      kill_app_server(params)
    end
  end

  def spin_up_server(params)
    if params.dealing_with_bg?
      spin_up_bg_server(params)
    else
      spin_up_app_server(params)
    end
  end

  def spin_up_app_server(params)
    `ansible-playbook #{playbooks_path}/spin/app_server_playbook.yml --extra-vars "platform=#{params['platform']}"`
  end

  def spin_up_bg_server(params)
    `ansible-playbook #{playbooks_path}/spin/bg_server_playbook.yml --extra-vars "platform=#{params['platform']} queue=#{params['queue']}"`
  end

  def kill_app_server(params)
    `ansible-playbook #{playbooks_path}/kill/app_server_playbook.yml`
  end

  def kill_bg_server(params)
    `ansible-playbook #{playbooks_path}/kill/bg_server_playbook.yml`
  end

  def playbooks_path
    "#{Bazooka.root}/anisble/playbooks"
  end
end