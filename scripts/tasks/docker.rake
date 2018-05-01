namespace :docker do
  desc 'build docker images'
  task :build do
    puts 'Generating static files for nginx'
    puts `bundle exec jekyll build`
    puts 'Building acceptbitcoincash docker image'
    puts `docker build -t kenman345/acceptbitcoincashdocker .`
  end
end
