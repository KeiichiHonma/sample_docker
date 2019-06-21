Nagareboshi.configure do |config|
  config.send = true # sendをtrueにすると実際にPOSTでデータが送られる。
  config.send = Rails.env.production? # 本番環境のみ実行したい場合はこちらを記載。
end
