class Phpcognit < Formula
  desc "Cognitive complexity linter for PHP, as a single static binary"
  homepage "https://github.com/ryckakas/phpcognit"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.2.0/phpcognit-aarch64-apple-darwin.tar.xz"
      sha256 "c0b5d3eea58a6d578b53b96398cfe5b65892f1a68590696734c3049c4c9344a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.2.0/phpcognit-x86_64-apple-darwin.tar.xz"
      sha256 "9c3b99e97b50cbea9bbd398071fbf1434bac137781da33a1bfb5fe31b6ecd5c6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.2.0/phpcognit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c1125d0db65bec6569a1ed7087497cf2c342a2d8b07ade3122bf812bfb83ed28"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.2.0/phpcognit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "318231d6402dbeaf662eabad3f56da39362b2184bbb34c0a4524f999bd78b944"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "phpcognit"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "phpcognit"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "phpcognit"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "phpcognit"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
