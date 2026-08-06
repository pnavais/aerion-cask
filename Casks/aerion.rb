cask "aerion" do
  version "0.3.3"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "3cac3480eff23883740b90f12d970646fccc22abb2194b81f41eff0ce8ea22f8"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.3/Aerion-darwin-amd64.zip"
  else
    sha256 "4f6b3f439dde5a0d20a2b559426e31b54f04e4a90d1aa5e3fa2bea790647f944"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.3/Aerion-darwin-arm64.zip"
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
