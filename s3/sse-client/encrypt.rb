require 'openssl'
require 'aws-sdk-s3'

key = OpenSSL::PKey::RSA.new(1024)

bucket = 'sse-client-frank-solution-architect-0032'
# encryption client

s3 = Aws::S3::EncryptionV2::Client.new(encryption_key: key, key_wrap_schema: :rsa_oaep_sha1, content_encryption_schema:  :aes_gcm_no_padding, security_profile: :v2 )

# round-trip an object, encrypted/decrypted locally
s3.put_object(bucket:bucket, key:'hello.txt', body:'handshake')
s3.get_object(bucket:bucket, key:'hello.txt').body.read
#=> 'handshake'

# reading encrypted object without the encryption client
# results in the getting the cipher text
Aws::S3::Client.new.get_object(bucket:bucket, key:'hello.txt').body.read
#=> "... cipher text ..."