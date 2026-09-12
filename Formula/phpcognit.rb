class Phpcognit < Formula
  desc "Cognitive complexity linter for PHP, as a single static binary"
  homepage "https://github.com/ryckakas/phpcognit"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.1.0/phpcognit-aarch64-apple-darwin.tar.xz"
      sha256 "b6c32b61977879ba0562f9bc28c3cc73ac86a5ffad6c2504c32bbbb0a247757d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.1.0/phpcognit-x86_64-apple-darwin.tar.xz"
      sha256 "4532fd927799f316a9f4a9735d194e0ff5e1d3c0d22b7b9898b0daf949f8c60f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.1.0/phpcognit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c288bc55000e959cb5bb4e82d1f3771a179773ccb3e83e6cae155e87e364a498"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.1.0/phpcognit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e9118f1386fa26fc8ed84473de7d398d7b35235138436a3a3d430466c5a6349"
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
