class Constant < ActiveRecord::Base
  APP_NAME = 'Sunny World'

  ONEPAY_URL = 'https://mtf.onepay.vn/onecomm-pay/vpc.op'
  ONEPAY_URL_EX = 'https://mtf.onepay.vn/vpcpay/vpcpay.op'
  WEBHOOK_TOKEN = 'sunnyworld2017'
  BRANCH_MASTER = 'master'

  ONEPAY_ACCESSCODE = 'D67342C2'
  ONEPAY_MERCHANT = 'ONEPAY'
  ONEPAY_ACCESSCODE_EX = '6BEB2546'
  ONEPAY_MERCHANT_EX = 'TESTONEPAY'
  ONEPAY_SERVER_KEY = 'UROI8FJO989FOIJ897YFJIJO87FD89F'

  GOOGLE_SERVER_KEY = 'AIzaSyB-CkC9hbVY0g8_p8FtTDRRml1cSb3BJZQ'

  ROLE_ADMIN = 'admin'
  ROLE_AGENT = 'agent'
  ROLE_GUEST = 'guest'
  ROLE_BLOGER = 'bloger'

  HOUSE_STATUS_PENDING = 'pending'
  HOUSE_STATUS_APPROVE = 'approve'
  HOUSE_STATUS_REJECT = 'reject'

  BLOG_STATUS_PENDING = 'pending'
  BLOG_STATUS_APPROVE = 'approve'
  BLOG_STATUS_REJECT = 'reject'

  # Host
  LOCALHOST = "localhost"

  # Response
  MESSAGE_FAIL = "Fail!"
  MESSAGE_SUCCESS = "Success!"
  MESSAGE_NO_RECORD= "No record!"

  STATUS_CODE_FAIL = 0
  STATUS_CODE_SUCCESS = 1
  STATUS_NO_RECORD = 2

  # AWS / Minio
  S3_BUCKET = 'sunnyworld'

  # Service
  SERVICE_POST = '1001'

  # Sample
  SAMPLE_HOUSE = 'sunnyworld_background.jpeg'
  SAMPLE_BLOG = 'sunnyworld_background.jpeg'

  # Provider for bookmark
  PROVIDER_POSTS = 'posts'
  PROVIDER_AGENTS = 'agents'
  PROVIDER_PROJECT = 'projects'
  PROVIDER_BLOGS = 'blogs'

end
