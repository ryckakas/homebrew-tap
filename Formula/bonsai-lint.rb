class BonsaiLint < Formula
  desc "Cognitive complexity linter for PHP, JavaScript, TypeScript and Vue, as a single static binary"
  homepage "https://github.com/ryckakas/bonsai-lint"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.2.1/bonsai-lint-aarch64-apple-darwin.tar.xz"
      sha256 "1f76ed4bca6db7249f458959199ec258673fc199ffcaf9c72fd49dfc33d5f159"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.2.1/bonsai-lint-x86_64-apple-darwin.tar.xz"
      sha256 "18d45a5a06f987054afb3ec3c23fe8f7591504aba0ae86f14c5a000569933f3b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.2.1/bonsai-lint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "959027b96bb13a65d5a025954eb55bcbc38f4b8429b884b5c49dbaed82aac21c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.2.1/bonsai-lint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e042c332559c83fc461d8a6d0dc078ccf6e610a2a3c7d7f00c08234b442ea7fe"
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
