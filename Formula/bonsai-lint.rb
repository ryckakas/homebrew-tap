class BonsaiLint < Formula
  desc "Multi-language cognitive complexity linter, as a single static binary"
  homepage "https://github.com/ryckakas/bonsai-lint"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.4.1/bonsai-lint-aarch64-apple-darwin.tar.gz"
      sha256 "5682f1a63a81eda7d637ee34d0fcb06d66d9e04de2e2c18ef79008479c29e0ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.4.1/bonsai-lint-x86_64-apple-darwin.tar.gz"
      sha256 "453d50f1059b058745daa524047572af3c3f75372118f773a2d0822b2f605756"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.4.1/bonsai-lint-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "93a9982455a3bf39123faac9bff0e8971d628866ddab568b022bded073ca61ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.4.1/bonsai-lint-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e7232cda0d82ef7baa7d1c9c9c84ed7eff27c702ff488d1d06ecda2f5c9acfd"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
