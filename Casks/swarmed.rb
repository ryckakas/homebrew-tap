# The cask release.yml writes to ryckakas/homebrew-tap at every release, with the version and the
# zip's checksum filled in. Change it here: the next release overwrites the tap's copy.
cask "swarmed" do
  version "0.4.11"
  sha256 "d088244081cd19d65fbc226df701c35eea712c006151a5a982abfebb2bd55aa5"

  url "https://github.com/ryckakas/swarmed/releases/download/v#{version}/Swarmed-#{version}-macos-universal.zip"
  name "Swarmed"
  desc "Runs coding agents side by side, each in a git worktree of its own"
  homepage "https://github.com/ryckakas/swarmed"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Swarmed updates itself (Settings → About), so brew leaves it to that.
  auto_updates true

  app "Swarmed.app"
  binary "#{appdir}/Swarmed.app/Contents/MacOS/swarmed"

  # The settings, conversations and notes in the data directory. The worktrees under ~/swarmed are
  # left alone: they hold work.
  zap trash: [
    "~/Library/Application Support/swarmed",
    "~/Library/Caches/dev.kauneckas.swarmed",
    "~/Library/WebKit/dev.kauneckas.swarmed",
  ]

  caveats <<~EOS
    Swarmed is not signed with an Apple Developer ID yet, so macOS stops it the first time it
    opens. To allow it: System Settings → Privacy & Security → Open Anyway.
  EOS
end
