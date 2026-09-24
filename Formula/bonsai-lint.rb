class BonsaiLint < Formula
  desc "Cognitive complexity linter for PHP, JavaScript, TypeScript, Vue and Go, as a single static binary"
  homepage "https://github.com/ryckakas/bonsai-lint"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.3.0/bonsai-lint-aarch64-apple-darwin.tar.gz"
      sha256 "2557aff1d276358d207521110c00a11945fd8e03243c584d4bf03a7f4739d6c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.3.0/bonsai-lint-x86_64-apple-darwin.tar.gz"
      sha256 "73e945b6173558c5db7ceeb371ac2fb204e0a72250841ca6461f6ecee69868c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.3.0/bonsai-lint-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "baa2940ed9fcdadc1dd20a5a983f47efc372e22f3438f58c82cb8e515216cae2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.3.0/bonsai-lint-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c3e41151a0edadc3b835a55360768cd7a5824b4946b5fc32c3a3fde67785f6a"
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
