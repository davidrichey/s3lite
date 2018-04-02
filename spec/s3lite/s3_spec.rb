class TestClass
  include S3lite::S3
end

RSpec.describe S3lite::S3 do
  describe 's3' do
    context 's3_get' do
      it 'success' do
        S3lite.aws_key = 'K3Y'
        S3lite.aws_secret_key = 'S3CR3T'
        S3lite.s3_bucket = 'BUCK3T'
        stub_request(:get, "https://s3.amazonaws.com/#{S3lite.s3_bucket}/basepath/some-path")
          .to_return(status: 200, body: { uuid: 'uuid', name: 'Teddy Flood' }.to_json, headers: { 'Content-Type' => 'application/json' })

        get = TestClass.new.s3_get('basepath/some-path')
        expect(get.class).to eq Aws::S3::Types::GetObjectOutput
        expect(get.body.read).to eq({ uuid: 'uuid', name: 'Teddy Flood' }.to_json)
      end

      it 'forbidden' do
        S3lite.aws_key = 'K3Y'
        S3lite.aws_secret_key = 'S3CR3T'
        S3lite.s3_bucket = 'BUCK3T'
        stub_request(:get, "https://s3.amazonaws.com/#{S3lite.s3_bucket}/basepath/some-path")
          .to_return(status: 403, body: '', headers: {})

        expect do
          TestClass.new.s3_get('basepath/some-path')
        end.to raise_error(Aws::S3::Errors::Forbidden)
      end

      it 'not found' do
        S3lite.aws_key = 'K3Y'
        S3lite.aws_secret_key = 'S3CR3T'
        S3lite.s3_bucket = 'BUCK3T'
        stub_request(:get, "https://s3.amazonaws.com/#{S3lite.s3_bucket}/basepath/some-path")
          .to_return(status: 404, body: '', headers: {})

        expect do
          TestClass.new.s3_get('basepath/some-path')
        end.to raise_error(Aws::S3::Errors::NotFound)
      end
    end

    it 'gives aws s3 resource' do
      S3lite.aws_key = 'K3Y'
      S3lite.aws_secret_key = 'S3CR3T'
      S3lite.s3_bucket = 'BUCK3T'
      expect(S3lite::S3Resource.send(:s3_resource).class).to eq Aws::S3::Resource
    end

    context 'errors' do
      it 'has no aws s3 bucket' do
        expect do
          S3lite.aws_key = nil
          S3lite.aws_secret_key = nil
          S3lite.s3_bucket = nil
          S3lite::S3Resource.send(:s3_resource_object, 'test')
        end.to raise_error('No AWS S3 Bucket Set')
      end

      it 'has no aws access key' do
        expect do
          S3lite.aws_key = nil
          S3lite.aws_secret_key = nil
          S3lite::S3Resource.send(:s3_resource)
        end.to raise_error('No AWS Access Key Set')
      end

      it 'has no aws secret access key' do
        expect do
          S3lite.aws_key = 'K3Y'
          S3lite.aws_secret_key = nil
          S3lite::S3Resource.send(:s3_resource)
        end.to raise_error('No AWS Secret Access Key Set')
      end
    end
  end
end
