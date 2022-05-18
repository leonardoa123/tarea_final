require "uri"
require "net/http"
require "json"


def request(api_url)
    url = URI(api_url)
    
    http = Net::HTTP.new(url.host, url.port)
   
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.use_ssl = true
    
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    return JSON.parse(response.body)
end

def build_web_page(array)
    f = File.open("index.html", "a")
    f.write("<html>","\n","<head>","\n","</head>","\n","<body>","\n","\t","<ul>","\n")
    array[0..5].each do |e|
        f = File.open("index.html", "a")
        f.write("\t\t","<li>","<img src=\"#{e["img_src"]}\" alt=\"#{e["id"]}\">","</li>","\n")
    end
    f.write("\t","</ul>","\n","</body>","\n","</html>")
end

def  photos_count(array)
    array_fotos = []
    grupo = []
    array.each do |e|
        array_fotos << e["camera"]["name"]
    end
    grupo = array_fotos.group_by{|x| x}
    grupo.each do |k,v|
        grupo[k] = v.count
    end  
    return grupo
end

fotos_nasa = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=#{ARGV[0]}&sol=1000")

build_web_page(fotos_nasa["photos"])

print photos_count(fotos_nasa["photos"])