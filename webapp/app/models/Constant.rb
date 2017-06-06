class Constant < ActiveRecord::Base
  APP_NAME = 'Color Admin'

  GOOGLE_SERVER_KEY = 'AIzaSyB-CkC9hbVY0g8_p8FtTDRRml1cSb3BJZQ'

  ROLE_ADMIN = 'admin'
  ROLE_AGENT = 'agent'
  ROLE_GUEST = 'guest'
  ROLE_BLOGER = 'bloger'

  HOUSE_STATUS_PENDING = 'pending'
  HOUSE_STATUS_APPROVE = 'approve'
  HOUSE_STATUS_REJECT = 'reject'

  # Response
  MESSAGE_FAIL = "Fail!"
  MESSAGE_SUCCESS = "Success!"
  MESSAGE_NO_RECORD= "No record!"

  STATUS_CODE_FAIL = 0
  STATUS_CODE_SUCCESS = 1
  STATUS_NO_RECORD = 2

  S3_BUCKET = 'sunnyworld'

end
