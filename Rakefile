require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push ['lib', 'test']
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose    = true
end

task :rubocop do |t|
  sh 'rubocop'
end

task :default => [:test, :rubocop]

