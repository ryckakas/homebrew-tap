class BonsaiLint < Formula
  desc "Cognitive complexity linter for PHP, JavaScript and TypeScript, as a single static binary"
  homepage "https://github.com/ryckakas/bonsai-lint"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.1.1/bonsai-lint-aarch64-apple-darwin.tar.xz"
      sha256 "60be2c2b3008d4afb8acf10f68c6babaac5ba77febf8c7101ce150e80d97405b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.1.1/bonsai-lint-x86_64-apple-darwin.tar.xz"
      sha256 "7d1eb3e257e4f28d7cdb240d1b4fcf8e2ce4532a55d6841267be2fe51d9d533e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.1.1/bonsai-lint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5584df89aa2b7a8f0ef5445fa892e526234f458a3bbbf3a986acb66dc7e153ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.1.1/bonsai-lint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "472b29786b0e37d89860597bd792cfe3e6b6fa1575acdc62972827318562139d"
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
      bin.install "bonsai-lint"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bonsai-lint"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bonsai-lint"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bonsai-lint"
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
