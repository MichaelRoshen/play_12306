


require 'open-uri'
require 'openssl'
require 'mini_magick'
require 'rtesseract' 
require 'rmagick'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
base_url = 'https://kyfw.12306.cn/otn/passcodeNew/getPassCodeNew?module=login&rand=sjrand&0.5230064517818391'



# def parse_img_to_str(img_url)  
#   img = MiniMagick::Image.open(img_url)  
#   img.resize '200%x200%' # 放大  
#   img.colorspace("GRAY") # 灰度化  
#   img.monochrome # 去色  
#   str = RTesseract.new(img.path).to_s # 识别  
  # File.unlink(img.path) # 删除临时文件  
  # if str.nil?  
  #   return nil  
  # else  
  #   return str.strip.to_f  
  # end  
# end  

# puts parse_img_to_str(image_url)  

# (1..10).each do |i|
# 	data = open(base_url){|f| f.read}
# 	t = Time.now.hash.to_s
# 	File.open("tmp#{t}.jpg",'w'){|f|f.write(data)}
# 	sleep 3
# end

image_url = './tmp642292901650551204.jpg'
img = MiniMagick::Image.open(image_url)
# img.resize '150%x150%' 
# img.monochrome # 去色  
tif_file = RTesseract.new(img.path).crop!(127, 3, 260, 22).image 
img = MiniMagick::Image.open(tif_file)
img.resize '200%x200%' 
tif_file = RTesseract.new(img.path).image 
`cp #{tif_file} /home/tianji/ruby_project/`
`sudo tesseract #{tif_file} result -l chi_sim -psm 7 nobatch`

# image_url = './1.jpg'
# img = MiniMagick::Image.open(image_url) 
# img.resize '200%x200%'
# img.colorspace("RGB")
# img.monochrome
# tif_file = RTesseract.new(img.path).image 
# `cp #{tif_file} /home/tianji/ruby_project/`
# `sudo tesseract #{tif_file} result -l eng `
