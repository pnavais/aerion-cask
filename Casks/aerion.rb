cask "aerion" do
  version "0.3.1"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "ae0bb46f6e6acfdc798c05567554fbca8a865deea3d1bf6f888ff2b3054d0eae"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.1/Aerion-darwin-amd64.zip"
  else
    sha256 "82a2e00d89ed81e6523a81a6ab269e0139d3d3f17422cf9e6efcc1de8d752f5a"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.1/Aerion-darwin-arm64.zip"
  end

  name "Aerion"
  desc "An Open Source Lightweight E-Mail Client"
  homepage "https://github.com/hkdb/aerion"

  app "Aerion.app"

  # Per upstream docs — clear extended attrs so Gatekeeper permits launch
  postflight do
    system_command "xattr",
                   args: ["-cr", "#{appdir}/Aerion.app"]
  end

  zap trash: [
    "~/Library/Application Support/aerion/",
    "~/Library/caches/Aerion/",
  ]

  depends_on macos: ">= :sequoia"
end
