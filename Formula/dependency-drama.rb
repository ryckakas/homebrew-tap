class DependencyDrama < Formula
  desc "Deadpan jokes about your dependencies, each one a true fact from the lockfile"
  homepage "https://github.com/ryckakas/dependency-drama#readme"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/dependency-drama/releases/download/v0.1.0/dependency-drama-aarch64-apple-darwin.tar.xz"
      sha256 "b6cdff0009e08f93f10b95256e6a37a8b4aeb3bc9e89b1d9021df4b7eaacd92a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/dependency-drama/releases/download/v0.1.0/dependency-drama-x86_64-apple-darwin.tar.xz"
      sha256 "ff94dd9e90e480336b19767e4ba51571807a5691c8b8b78aea0964771c0a6c98"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/dependency-drama/releases/download/v0.1.0/dependency-drama-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9bf184f662be92b5b0bd7b96c8141ca70dcfa6651ade20e900970d16e1970c4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/dependency-drama/releases/download/v0.1.0/dependency-drama-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fc1539b14cbed54c90d96eab9afd038b859e9483f593246adef0019db039b6d3"
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
