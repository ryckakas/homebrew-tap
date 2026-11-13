class DependencyDrama < Formula
  desc "Deadpan jokes about your dependencies, each one a true fact from the lockfile"
  homepage "https://github.com/ryckakas/dependency-drama#readme"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/dependency-drama/releases/download/v0.1.1/dependency-drama-aarch64-apple-darwin.tar.xz"
      sha256 "4dd085cdfd837ccbd21045f8ec647718e9a165198f23867b7b202f22252d7a00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/dependency-drama/releases/download/v0.1.1/dependency-drama-x86_64-apple-darwin.tar.xz"
      sha256 "3aac98fac5513477aeca2de9ec53ff701df30b5718981c39c3d5de47d9b66f6f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/dependency-drama/releases/download/v0.1.1/dependency-drama-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "50febafee6e1b743dddc363dd5a837ef9ee947e2a9999ea06479ee8e4ef69aab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/dependency-drama/releases/download/v0.1.1/dependency-drama-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fb165500eaa7d7eefcf169d52664e6c6f90a4c3eaa7eb4dc9c342685237109aa"
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
      bin.install "dependency-drama"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dependency-drama"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dependency-drama"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dependency-drama"
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
