class Hash
  def shutdown_server?
     self['action'] && self['action'] == Ansible::SHUTDOWN_ACTION
  end

  def dealing_with_bg?
    self['queue'] && !self['queue'].blank?
  end
end