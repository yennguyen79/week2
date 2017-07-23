require "bundler/setup"
Bundler.require

get "/" do 
lines = File.read("todo.md").split("\n")

items = lines.map do |line|
  {
    name = line[6..-1]
    status = (line[3]=="x") ? "done" : "undone"
  }
  {name: name, status: status}
  end

  erb :"index.html", locals: {items: items}
end


post "/submit" do
  new_item = {name: params["item-name"], status:"undone"}

  File.open("todo.md", "a") do |f|
    f << "\n"
    f << "- [ ] " + new_item[:name] 
  end
  redirect to("/")
  
end