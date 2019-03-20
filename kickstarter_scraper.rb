# require libraries/modules here
require "pry"
require "nokogiri"

# This just opens a file and reads it into a variable
html = File.read ('fixtures/kickstarter.html')
# retrieves the html doc above with Nokogiri
kickstarter = Nokogiri::HTML(html) 
# kickstarter.css("li.project.grid_4").first 
# project =  kickstarter.css("li.project.grid_4")
# project_title = projects.css("h2.bbcard_name strong a").text
# img_link = project.css("div.project-thumbnail a img").attribute("src").value
# project_descri = project.css("p.bbcard_blurb").text
# project_location = project.css("span.location-name").text
# amount_funded = project.css("li.first.funded strong").text.gsub("%","").to_i # the extra bit removes the % sign 
# #I cna use the Nokogiri attribute mehtod on a Nokogiri elment to grab the vaue of that elment. since the html tag <img has a src 
# # attribute we can do .attribute("src") to grab the link inside src 
# # time to put the data together 
def create_project_hash
  html = File.read ('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects= {}
  #iterate trhoug projects 
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects
end

binding.pry 
p 'No opportunity to learn and grow from errors'

# this is how i grab the name from the below element 

# projects.css("h2.bbcard_name strong a").text
# <h2 class="bbcard_name">
# <strong>
# <a href="/projects/289243549/moby-dick-an-oratorio?ref=city" target="">Moby Dick: An Oratorio</a>
# </strong>
# <span>
# by
# W4 New Music
# </span>
# </h2>

# project.css("div.project-thumbnail a img").attribute("src").value is how we grab the link from the
# below element

# <div class="project-thumbnail">
# <a href="/projects/289243549/moby-dick-an-oratorio?ref=city" target=""><img alt="Photo-little" class="projectphoto-little" height="150" src="https://s3.amazonaws.com/ksr/projects/845788/photo-little.jpg?1391022013" width="200"></a>
# </div>

# try to grab  the descrption which i did hah 
# project.css("p.bbcard_blurb").text

# <p class="bbcard_blurb">
# Four young composers join forces with an indie orchestra to present this musical reflection on a literary masterpiece.
# </p>

# i think this is the correct element to target for loction
 
# <span class="location-name">Brooklyn, NY</span>

# time to figure out percentage funded 
# project.css("li.first.funded strong").text # if there is space inbetween the class info then it means this element belongs to more than one class

# <li class="first funded">
# <strong>133%</strong>
# funded
# </li>