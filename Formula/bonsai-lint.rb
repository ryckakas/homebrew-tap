class BonsaiLint < Formula
  desc "Cognitive complexity linter for PHP, JavaScript and TypeScript, as a single static binary"
  homepage "https://github.com/ryckakas/bonsai-lint"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.1.0/bonsai-lint-aarch64-apple-darwin.tar.xz"
      sha256 "2b5c6d483b40eb66cb7aae2a069564a2d4002abff5f5768fa0eed3a32b7ff2c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.1.0/bonsai-lint-x86_64-apple-darwin.tar.xz"
      sha256 "a2b1398dbd97af60866bcf2b1db1a5a663a6a41477bde10dd796407c1c07db65"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.1.0/bonsai-lint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "475759932bde2c0f8c5364539d7ebd772a93544daa7830fbc15269fc56357917"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.1.0/bonsai-lint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ec4150bc43ea59eec2ce5183984c40c0bfc729641068da0e5b8382a72d1c7b44"
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
