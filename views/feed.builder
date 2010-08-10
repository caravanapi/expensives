xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title 'Revista Fuças - A primeira Revista de fofocas Nerd'
    xml.description 'A primeira Revista de fofocas Nerd'
    xml.link '/'

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description "<img src=\"#{post.image_url}\" />" + "<p>#{post.subtitle}</p>"
        xml.link "http:://fucas.heroku.com/noticias/#{post.slug}"
      end
    end
  end
end
