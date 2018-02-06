require 'html-proofer'
require 'rubocop/rake_task'
require 'jekyll'

task default: %w[proof verify rubocop]

task :build do
  config = Jekyll.configuration(
    'source' => './',
    'destination' => './_site'
  )
  site = Jekyll::Site.new(config)
  Jekyll::Commands::Build.build site, config
end

task proof: 'build' do
  HTMLProofer.check_directory(
    './_site', \
    assume_extension: true, \
    check_html: true, \
    disable_external: true, \
	log_level: 'debug', \
	url_ignore: ['/add'], \
	verbose: true
  ).run
end

task proof_external: 'build' do
  HTMLProofer.check_directory(
    './_site', \
    assume_extension: true, \
    check_html: true, \
	check_sri: true, \
	external_only: false, \
	verbose: true, \
	log_level: 'info', \
	url_ignore: ['/add'], \
	http_status_ignore: [0, 301, 302, 403, 503], \
    cache: { timeframe: '1w' }, \
    hydra: { max_concurrency: 12 }
  ).run
end

namespace :docker do
  desc "build docker images"
  
  task :build, [:tag] do |t, args|
    args.with_defaults(:tag => "latest")
    puts "Generating stats (HTML partial) of websites supporting Bitcoin Cash"
    Dir.chdir(File.join('.', 'scripts', 'python')) do
      puts `python ./bchAccepted.py`
    end
    puts "Generating static files for nginx"
    puts `bundle exec jekyll build`
    puts "Building acceptbitcoincash docker image with tag #{args.tag}"
    puts `docker build -t kenman345/acceptbitcoincashdocker:#{args.tag} .`
  end
end

task :verify do
  ruby './verify.rb'
end

task :verify_images do
  ruby './verify_images.rb'
end

RuboCop::RakeTask.new
