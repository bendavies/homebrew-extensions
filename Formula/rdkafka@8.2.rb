# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://github.com/arnaud-lb/php-rdkafka/archive/e570ef17571f22ec973094904e0854a1871bc4d1.tar.gz"
  sha256 "7c7f5225f6a87826da67eedd2667cb2dbb970d698b1437efa5b18c45ba495be4"
  version "5.0.0"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "8308c3cb05d3c836a249a9b70a3289110b651ee65a7522bbfbc58154cb550674"
    sha256 cellar: :any,                 big_sur:       "c2fd9564a21ab6cdc8133de89ada374eff2a3272e27e5a7ab8455b32bc15415e"
    sha256 cellar: :any,                 catalina:      "dcdf9053691486b067e71547dd97bb56c61bf1f10bb719eafd0f164c7880d4b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b78165ee0f452c49736e3d6628043666da6cf105e194daf997a5d86328ae7288"
  end

  depends_on "librdkafka"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
