12306图像识别

 环境搭建：

http://michael-roshen.iteye.com/blog/1982817

sudo apt-get install libmagickwand-dev
sudo apt-get install imagemagick
sudo apt-get install tesseract-ocr

gem install mini_magick
gem install rtesseract
gem install rmagick


抓取12306验证图片

require 'open-uri'
require 'openssl'
require 'mini_magick'
require 'rtesseract' 
require 'rmagick'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
base_url = 'https://kyfw.12306.cn/otn/passcodeNew/getPassCodeNew?module=login&rand=sjrand&0.5230064517818391'
(1..10).each do |i|
	data = open(base_url){|f| f.read}
	t = Time.now.hash.to_s
	File.open("tmp#{t}.jpg",'w'){|f|f.write(data)}
	sleep 3
end

切割图片



识别图片

1.下载中文训练库

下载地址：http://pan.baidu.com/share/link?shareid=391619&uk=3742563016

或者

$ wget http://tesseract-ocr.googlecode.com/files/chi_sim.traineddata.gz
$ gunzip chi_sim.traineddata.gz
$ sudo cp chi_sim.traineddata /usr/local/share/tessdata/

图片切割crop!
image_url = './tmp-1152568412014198433.jpg
img = MiniMagick::Image.open(image_url) 
RTesseract.new(img.path).crop!(127, 3, 260, 22).image 
=> /tmp/20150320-1794-1aohntm.tif

图片识别为文字，存放在phototest.txt文件中
sudo tesseract 20150320-1794-1aohntm.tif phototest -l chi_sim 
=> phototest.txt


