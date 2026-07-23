class Seconv < Formula
  desc "Subtitle Edit batch file converter"
  homepage "http://www.nikse.dk/SubtitleEdit/Help"
  url "https://github.com/SubtitleEdit/subtitleedit/archive/refs/tags/v5.0.0.tar.gz"
  version "5.0.0"
  sha256 "bdd86c67c97caa5105d6fc9a1adc3aaafffb9722d9c400560819a17e7dcfead5"
  license "MIT"

  livecheck do
    url "https://github.com/SubtitleEdit/subtitleedit.git"
    strategy :github_releases
    regex(/([0-9]\.[0-9]\.[0-9])(?:-(beta|rc)[0-9]{0-2}){0}/i)
  end

  depends_on "dotnet" => :build
  depends_on macos: :monterey

  def install
    # I love C#! I love how straightforward the binary build process is!
    # Use self-contained dotnet
    system "dotnet", "publish", "--self-contained", "-c", "Release",
      "-p:PublishSingleFile=true", "-r", "osx-arm64", "src/seconv/SeConv.csproj"
    bin.install "src/seconv/bin/Release/net10.0/osx-arm64/publish/seconv" => "seconv"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test seconv`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "seconv", "--help"
  end
end
