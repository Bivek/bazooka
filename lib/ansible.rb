require 'json'

module Ansible
  extend self

  def play(params)
    params = JSON.parse(params)
    if (params['queue'] && !params['queue'].blank?)
      spin_up_bg_server(params)
    else
      spin_up_app_server(params)
    end
  end

  def spin_up_app_server(params)
    `ansible-playbook #{playbooks_path}/app_server_playbook.yml --extra-vars "platform=#{params['platform']}"`
  end

  def spin_up_bg_server(params)
    `ansible-playbook #{playbooks_path}/bg_server_playbook.yml --extra-vars "platform=#{params['platform']} queue=#{params['queue']}"`
  end

  def playbooks_path
    "#{Bazooka.root}/anisble/playbooks"
  end
end