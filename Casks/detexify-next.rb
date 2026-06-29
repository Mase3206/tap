# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
cask "detexify-next" do
  version "0.2.5"
  sha256 "bd062d4713f7fd6ebb06a1d30478f1c7d11bf8170679b55fe1b93c3fd54a8e85"

  url "https://github.com/kirel/detexify-next/releases/download/v#{version}/DetexifyNext-#{version}-macOS-arm64.zip",
      verified: "github.com/kirel/detexify-next/releases/download/"
  name "detexify-next"
  desc "Draw a handwritten LaTeX symbol and get ranked commands immediately"
  homepage "https://detexify.kirelabs.org/#/mac"

  livecheck do
    url "https://github.com/kirel/detexify-next.git"
    strategy ""
  end

  depends_on macos: :ventura

  app "Detexify Next.app"

  zap trash: [
    "~/Library/Caches/org.kirelabs.detexify-next",
    "~/Library/Preferences/org.kirelabs.detexify-next.plist",
    "~/Library/WebKit/org.kirelabs.detexify-next",
  ]
end
