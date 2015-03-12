require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs.push ['lib', 'test']
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose    = true
end

RuboCop::RakeTask.new

task :default => [:test, :rubocop]

