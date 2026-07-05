# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "subtitleedit" do
  version "5.0.0"
  sha256 "f1793a7b8d8a66338b3515bcb9499a0bc847382ed7607c0f4cdc3c28f69030c3"

  url "https://github.com/SubtitleEdit/subtitleedit/releases/download/v#{version}/SubtitleEdit-macOS-ARM64.dmg",
      verified: "github.com/SubtitleEdit/subtitleedit/releases/download/"
  name "SubtitleEdit"
  desc "Open source cross-platform subtitle editor"
  homepage "https://www.nikse.dk/subtitleedit"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url "https://github.com/SubtitleEdit/subtitleedit.git"
    strategy :github_releases
    # Exclude beta versions
    regex(/([0-9]\.[0-9]\.[0-9])(?:-beta[0-9]{0-2}){0}/)
  end

  conflicts_with cask: "subtitleedit@beta"
  depends_on macos: :monterey

  app "Subtitle Edit.app"

  # SubtitleEdit is currently unsigned.
  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/Subtitle Edit.app"
    system "codesign", "--force", "--deep", "--sign", "-", "#{appdir}/Subtitle Edit.app"
  end

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: "~/Library/Application Support/Subtitle Edit"
end
