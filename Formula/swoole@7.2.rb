# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhp72Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.1.tar.gz"
  sha256 "d4c9b1c3966faeee996344920554993885465377e40fa5ebb4e716593072eb57"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "a2bb543cdd127867b3b329fdf877832e8a56f21a165a998cfec429862310e1d0" => :big_sur
    sha256 "5ef4f089bc6a39aa30785eca79e3a05452f2cbcb6a5d8ce9e210f9b58a7a715a" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file
  end
end
