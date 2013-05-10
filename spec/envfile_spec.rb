#! /your/favourite/path/for/rspec
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

require_relative 'spec_helper'

describe Envfile do
   describe ".new" do
      it { expect(Envfile.new).to be_kind_of(Envfile) }
   end

   describe ".parse" do
      subject { Envfile.new }

      context "no arg" do
         it { expect { subject.parse }.to raise_exception(ArgumentError) }
      end

      context "arg not found" do
         it { expect { subject.parse '' }.to raise_exception(Errno::ENOENT) }
      end

      context "raw file" do
         let(:file) { File.expand_path('../fixtures/foobar.env', __FILE__) }
         subject { Envfile.new.parse(file) }

         it { expect { subject }.to_not raise_exception }
         it { expect(subject).to be_kind_of(Envfile) }
         it { expect(subject).to include("FOO") }
         it { expect(subject).to include("BAR") }
         it { expect(subject).to_not include("BAZ") }
         it { expect(subject["FOO"]).to eq("foo") }
         it { expect(subject["BAR"]).to eq("bar") }
      end

      context "complex raw file" do
         let(:file) { File.expand_path('../fixtures/complex.env', __FILE__) }
         subject { Envfile.new.parse(file) }

         it { expect { subject }.to_not raise_exception }
         it { expect(subject).to be_kind_of(Envfile) }
         it { expect(subject).to include("    FOO") }
         it { expect(subject).to include("BAR BAZ") }
         it { expect(subject["    FOO"]).to eq("    foo") }
         it { expect(subject["BAR BAZ"]).to eq("bar baz") }
      end

      context "yaml" do
         let(:file) { File.expand_path('../fixtures/foobar.yml', __FILE__) }
         subject { Envfile.new.parse(file) }

         it { expect { subject }.to_not raise_exception }
         it { expect(subject).to be_kind_of(Envfile) }
         it { expect(subject).to include("FOO") }
         it { expect(subject).to include("BAR") }
         it { expect(subject).to_not include("BAZ") }
         it { expect(subject["FOO"]).to eq("foo") }
         it { expect(subject["BAR"]).to eq("bar") }
      end

      context "json" do
         let(:file) { File.expand_path('../fixtures/foobar.json', __FILE__) }
         subject { Envfile.new.parse(file) }

         it { expect { subject }.to_not raise_exception }
         it { expect(subject).to be_kind_of(Envfile) }
         it { expect(subject).to include("FOO") }
         it { expect(subject).to include("BAR") }
         it { expect(subject).to_not include("BAZ") }
         it { expect(subject["FOO"]).to eq("foo") }
         it { expect(subject["BAR"]).to eq("bar") }
      end

      context "perl" do
         let(:file) { File.expand_path('../fixtures/foobar.perl', __FILE__) }
         subject { Envfile.new.parse(file) }

         it { expect { subject }.to_not raise_exception }
         it { expect(subject).to be_kind_of(Envfile) }
         it { expect(subject).to include("FOO") }
         it { expect(subject).to include("BAR") }
         it { expect(subject).to_not include("BAZ") }
         it { expect(subject["FOO"]).to eq("foo") }
         it { expect(subject["BAR"]).to eq("bar") }
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
