#!/usr/bin/env ruby

require "nokogiri"
require "open-uri"

URL = "http://www.gl5.ru/k/korzh-max/"

html = Nokogiri::HTML(open("#{URL}/korzh-max.html"))
html_links = html.css("div[@itemprop = 'text']").css("a")

links = []
html_links.each_with_index do |html_link, index|
  links << html_link[:href]
end
links.pop

links.each do |link|
  puts "### " + url = "#{URL}#{link}"
  song_html = Nokogiri::HTML(open(url))

  song = song_html.css("div[@itemprop = 'text']").to_s
  song.gsub!("<div itemprop=\"text\">", "")
  song.gsub!("-", "")
  song.gsub!("<br>", "")
  song.gsub!("Припев:", "")
  song.gsub!("<p>", "")
  song.gsub!("</p>", "")
  song.gsub!("<a name=\"comments\"></a>", "")
  song.gsub!("</div>", "")
  song.gsub!("<p align=\"left\">", "")
  song.gsub!(/<a href=.*<\/a>/, "")
  song.gsub!(/<img src=.*>/, "")
  song.gsub!(/<em>.*<\/em>/, "")
  song.gsub!(/<em>.*\n.*<\/em>/, "")
  song.gsub!(/<font.*<\/font>/, "")
  song.gsub!(/<strong.*<\/strong>/, "")
  song.gsub!(/<strong.*\n.*<\/strong>/, "")
  song.gsub!(/<li>.*<\/li>/, "")
  song.gsub!(/<li>.*\n.*<\/li>/, "")
  song.gsub!(/<ul.*>/, "")
  song.gsub!("</ul>", "")
  song.gsub!(/<hr.*>/, "")
  song.gsub!("<center>", "")
  song.gsub!(/<h2>.*<\/h2>/, "")

  puts song
end
