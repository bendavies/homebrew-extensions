# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT80 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://github.com/php-memcached-dev/php-memcached/archive/19a02bb5bfaeb520b857a2d64172f7d2a9615fb3.tar.gz"
  sha256 "63fdeff6398ebbe1c15c89b86a628a2e00305fb36f4304b3a1f5aa097ad098f6"
  version "3.1.5"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "156d31183c41f62c19ac9fab86444116fe0d4c0b546497d54139703314547e7a"
    sha256                               big_sur:       "70e0a23e8a6e12611e7f3068ea3fb9fc2286cca73d94fe677b637548522b3c8d"
    sha256                               catalina:      "283589376dc4a73c966e0d48374cb156c39ddd148443fbc4432abd7b1806c041"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f18bec2862d40b67a3d9a6bf147056fdad1996037f04ae808b1cc3f7689ccc55"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
      (buildpath/"include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  def install
    args = %W[
      --enable-memcached
      --enable-memcached-igbinary
      --enable-memcached-json
      --enable-memcached-msgpack
      --disable-memcached-sasl
      --enable-memcached-session
      --with-libmemcached-dir=#{Formula["libmemcached"].opt_prefix}
      --with-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    patch_memcached
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
