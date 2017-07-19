class Webhook < ActiveRecord::Base

  def update_script
    system('bash update.sh')
  end
  handle_asynchronously :update_script

end
