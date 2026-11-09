class BonsaiLint < Formula
  desc "Multi-language cognitive complexity linter, as a single static binary"
  homepage "https://github.com/ryckakas/bonsai-lint"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.5.1/bonsai-lint-aarch64-apple-darwin.tar.gz"
      sha256 "1b44a791e526808c1e99ba590ada8ca606e8c7dd9b2b3fb94fe040a1a4e7c060"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.5.1/bonsai-lint-x86_64-apple-darwin.tar.gz"
      sha256 "fbbda206944a662b9a2bc30aff08bf6abf44833b68f7652ef4c92c5ba444d633"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.5.1/bonsai-lint-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "59a35225827c1f74e0c8ad2e1d3f0c25dad32f2933d2a917b5994494bcdf1421"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/bonsai-lint/releases/download/v0.5.1/bonsai-lint-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b873ac3c0c16aee6433f1fae005a53fcdf2d708bbed0b0cbbbfdc20dcad4aa0"
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
