class Phpcognit < Formula
  desc "Cognitive complexity linter for PHP, as a single static binary"
  homepage "https://github.com/ryckakas/phpcognit"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.2.1/phpcognit-aarch64-apple-darwin.tar.xz"
      sha256 "80e648bad8c2cbf9e5d99d6d178e04134e7eb40134f734d75edbf9f1e13bbdd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.2.1/phpcognit-x86_64-apple-darwin.tar.xz"
      sha256 "48789bfecfeb509cd9b1a073bc2629a4b1bed33a9146c176bf8836299f17d14f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.2.1/phpcognit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b816def7e614671f8a4b21b2ec2dd10ffe43c660c85a697beafbb5abbe46cc35"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ryckakas/phpcognit/releases/download/v0.2.1/phpcognit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b5c222b3ee854b1f9a0bb16dcce0694e7094ed57aa7047eb8096080abe7f6fe0"
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
