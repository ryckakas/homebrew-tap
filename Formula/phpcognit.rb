class Phpcognit < Formula
  desc "Cognitive complexity linter for PHP, as a single static binary"
  homepage "https://github.com/ryckakas/phpcognit"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.1.1/phpcognit-aarch64-apple-darwin.tar.xz"
      sha256 "260689511c2ede5aeffb0d94e537a487d87812d7a925072e20380709eee627a1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.1.1/phpcognit-x86_64-apple-darwin.tar.xz"
      sha256 "82d1a25aa93162398c722d19b6fa95571ab1b3aa27212d266b48dc1a292c27a3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.1.1/phpcognit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "58215bf806ee42637275318f2052885282850b9c53899bf7169f9cd0a749e52f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.1.1/phpcognit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "25529e9f0a30045ddd4a96e7a45a07e196ecf6755e51ba0f04097780fd3304aa"
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
