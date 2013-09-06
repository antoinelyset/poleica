require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push ['lib', 'test']
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :init_libreoffice do |t|
  require 'poleica'
  Poleica.new('test/support/files/example.doc').to_pdf
  expected_path = 'test/support/files/example-1eb0afc1a8a2179e723c58a49d5a84c6.pdf'
  File.delete(expected_path) if File.exists?(expected_path)
end

task :rubocop do |t|
  sh 'rubocop'
end

task :default => [:test, :rubocop]

