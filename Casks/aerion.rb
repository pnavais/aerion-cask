cask "omlx" do
  version "0.2.3-build1"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "680ea33cf62619f5d4b99bc4267f03d53e896adbce57d445fbc3d935bcba45e50"
    url "https://github.com/hkdb/aerion/releases/download/v0.2.3-build1/Aerion-darwin-amd64.zip"
  else
    sha256 "a6b98f12402ed66f26231f3074b7fe4e43a852e3d2d36e5855f8cf3bbe33b0d5"
    url "https://github.com/hkdb/aerion/releases/download/v0.2.3-build1/Aerion-darwin-arm64.zip"
  end

  name "Aerion"
  desc "An Open Source Lightweight E-Mail Client"
  homepage "https://github.com/hkdb/aerion"

  app "Aerion.app"

  zap trash: [
    "~/Library/Application Support/aerion/"
    "~/Library/caches/Aerion/"
  ]

  depends_on macos: ">= :sequoia"
end
