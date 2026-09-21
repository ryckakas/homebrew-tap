class BonsaiLint < Formula
  desc "Cognitive complexity linter for PHP, JavaScript, TypeScript and Vue, as a single static binary"
  homepage "https://github.com/ryckakas/bonsai-lint"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.2.0/bonsai-lint-aarch64-apple-darwin.tar.xz"
      sha256 "ab3d66e2afe8768e5c567eee9f7153d9c4e5c3e9d37c2e9ebf91e4f333ede1b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.2.0/bonsai-lint-x86_64-apple-darwin.tar.xz"
      sha256 "180d09588d468ea1de14dbe36dd6f0a07a0d3927de4da214814611c33c263e74"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.2.0/bonsai-lint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b288f60068cc237e8165b544e3aca705c0197e99d7950cceda29e23ca860857d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.2.0/bonsai-lint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6cc197dc7a80fae62057ed4a0ce9f50ba9d10b615422143bdc0e8568ec4e51f9"
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
