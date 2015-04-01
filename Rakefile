task :build do
  IO.popen "gem build ./yunhe.gemspec" do |f|
    while line = f.gets do
     puts line
    end
  end 
end

task :install do
  IO.popen "gem install ./*.gem" do |f|
    while line = f.gets do
     puts line
    end
  end 
end