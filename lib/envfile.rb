#! /your/favourite/path/for/ruby
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

require 'json'
require 'psych'
require 'pathname'

# Envfile  understands  various  input   file  formats  and  executes  commands
# according to that.
#
# It should be noted  that Envfile is (unlike the ENV object  itself) a kind of
# Hash.  So if you  want to modify some environment variables,  feel free to do
# so as you normally do with Hashes.  It is of course up to you to properly set
# them up.
class Envfile < Hash

   # Utility method to setup, fire, then forget.
   #
   # @param [String] envfile  an envfile path
   # @param [String] cmd      program file path
   # @param [String] argv     passed to cmd
   #
   # @see Envfile#exec!
   def self.run_with_envfile envfile, cmd, *argv
      new.parse(envfile).exec!(cmd, argv)
   end

   # Load up the contents of the given file.
   # @param [String]  envfile path to a file
   #
   # @note When called multiple times  with different envfile per instance, and
   #       if any  of the env key  collides, the result is  undefined.  I would
   #       like to advise you no to do such thing.
   def parse envfile
      path = Pathname.new envfile
      update case path.extname
             when '.pl',  '.perl' then parse_perl    path
             when '.js',  '.json' then parse_json    path
             when '.yml', '.yaml' then parse_yaml    path
             else                      parse_xaicron path
             end
   end

   # Executes the given cmd under self's setup.
   # @param [String] cmd      program file path
   # @param [String] argv     passed to cmd
   #
   # @note This  method does  not always  return.  But when  it does  it always
   #       results into an exception.
   #
   # @raise [Errno::ENOENT]        envfile does not exist
   # @raise [Errno::ENOEXEC]       cmd not runnable
   # @raise [Errno::EACCESS]       permission denied to exec
   # @raise [Errno::ELOOP]         symlink is too deep
   # @raise [Errno::ENAMETOOLONG]  file path too long
   def exec! cmd, argv
      exec self, [cmd, cmd], *argv, close_others: true
   end

   # 
   private

   def parse_json path
      path.open do |f|
         return JSON.load f
      end
   end

   def parse_yaml path
      path.open do |f|
         return Psych.load f
      end
   end

   def parse_perl path
      IO.popen 'perl', 'r+' do |io|
         io.puts <<-"end"
				use App::envfile;
				use JSON::XS;
				my $json = JSON::XS->new->utf8->allow_nonref;
				my $envf = App::envfile->new->parse_envfile('#{path}');
				print $json->encode($envf);
				exit;
			end
         io.close_write
         return JSON.load io
      end
   end

   def parse_xaicron path
      path.open do |f|
         return f.each_line.reject do |i|
            /^\s*#/ =~ i
         end.map do |i|
            i.chomp.split %r/=/, 2
         end.each_with_object Hash.new do |(k, v), h|
            h[k] = v
         end
      end
   end
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
