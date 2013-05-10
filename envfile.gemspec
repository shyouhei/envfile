#! /your/favourite/path/for/gem
# -*- coding: utf-8; -*-
#
# Copyright(c) 2013 URABE, Shyouhei.
#
# Permission is hereby granted, free of  charge, to any person obtaining a copy
# of  this code, to  deal in  the code  without restriction,  including without
# limitation  the rights  to  use, copy,  modify,  merge, publish,  distribute,
# sublicense, and/or sell copies of the code, and to permit persons to whom the
# code is furnished to do so, subject to the following conditions:
#
#        The above copyright notice and this permission notice shall be
#        included in all copies or substantial portions of the code.
#
# THE  CODE IS  PROVIDED "AS  IS",  WITHOUT WARRANTY  OF ANY  KIND, EXPRESS  OR
# IMPLIED,  INCLUDING BUT  NOT LIMITED  TO THE  WARRANTIES  OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE  AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHOR  OR  COPYRIGHT  HOLDER BE  LIABLE  FOR  ANY  CLAIM, DAMAGES  OR  OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF  OR IN CONNECTION WITH  THE CODE OR THE  USE OR OTHER  DEALINGS IN THE
# CODE.

require 'rubygems'

Gem::Specification.new do |gem|
   gem.required_ruby_version = '>= 1.9.3'
   gem.name                  = 'evnfile'
   gem.version               = '0.0.1'
   gem.author                = 'Urabe, Shyouhei'
   gem.homepage              = 'https://github.com/shyouhei/envfile'
   gem.license               = 'MIT'
   gem.executables           << 'envfile'
   gem.files                 = Dir.glob ['lib/**/*.rb', 'README']
   gem.summary               = <<-end.chomp.sub /^\s+/, ''
		envfile(1), to execute another command under a modified environment
   end
   gem.description           = <<-end.chomp.sub /^\s+/, ''
		The `envfile(1)` program  is a program to run another  program; much like
		`sudo(1)`  or  `chroot(1)`.   The  difference is  that  this  program  is
		designed to modify environment variables before that.
   end

   gem.add_development_dependency 'yard',      '~> 0.8'
   gem.add_development_dependency 'rdoc',      '~> 4.0'
   gem.add_development_dependency 'rspec',     '~> 2.13'
   gem.add_development_dependency 'simplecov', '>= 0'
   gem.add_development_dependency 'pry'
   gem.add_development_dependency 'rake'
   gem.add_development_dependency 'bundler'

   gem.add_runtime_dependency 'pit'
   gem.add_runtime_dependency 'json'
   gem.add_runtime_dependency 'psych'
end

# 
# Local Variables:
# mode: ruby
# coding: utf-8
# indent-tabs-mode: nil
# tab-width: 3
# ruby-indent-level: 3
# fill-column: 79
# default-justification: full
# End:
# vi:ts=3:sw=3:
