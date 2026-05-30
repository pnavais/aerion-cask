cask "aerion" do
  version "0.2.5"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "84fe2c6b4a3f1cd6ce21648b361e8913d959a052857c1d44a44d7c2e005e8a41"
    url "https://github.com/hkdb/aerion/releases/download/v0.2.5/Aerion-darwin-amd64.zip"
  else
    sha256 "352744e0c214f22c0d5547cbb6f96b7b10881a34bb7b47e28b0a56518875e214"
    url "https://github.com/hkdb/aerion/releases/download/v0.2.5/Aerion-darwin-arm64.zip"
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
