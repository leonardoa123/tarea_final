require "uri"
require "net/http"
require "json"


def request()
    url = URI('https://api.nasa.gov/planetary/apod?api_key=iNIr3BUgxaNB4qGmwhBhE83v43VuwSC3kYcyvpbR&count=20')
    
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
        f.write("\t\t","<li>","<img src=\"#{e["url"]}\" alt=\"#{e["title"]}\">","</li>","\n")
    end
    f.write("\t","</ul>","\n","</body>","\n","</html>")
end


fotos_nasa = request()

build_web_page(fotos_nasa)