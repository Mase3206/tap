# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "subtitleedit@beta" do
  version "5.1.0-rc13"
  sha256 "ce0aa9a7256b1f152bac8e26016a620b5d11c3fbc728359b03dafb7003eac93a"

  url "https://github.com/SubtitleEdit/subtitleedit/releases/download/v#{version}/SubtitleEdit-macOS-ARM64.dmg"
  name "SubtitleEdit (beta)"
  desc "Open source cross-platform subtitle editor"
  homepage "https://github.com/SubtitleEdit/subtitleedit"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url "https://github.com/SubtitleEdit/subtitleedit.git"
    # Only include beta versions
    regex(/([0-9]\.[0-9]\.[0-9]-(beta|rc)[0-9]{0,2})/i)
  end

  conflicts_with cask: "subtitleedit"
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
