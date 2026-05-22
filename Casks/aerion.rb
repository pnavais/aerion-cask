cask "aerion" do
  version "0.2.4"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "34bd91699f75c087b9440afc67ce3fa0a236732eb3b31c72b088924cd611ff23"
    url "https://github.com/hkdb/aerion/releases/download/v0.2.4/Aerion-darwin-amd64.zip"
  else
    sha256 "0dc0969511700c57b095d09a641b5d216b065b68236bdfb6693ede67652445e5"
    url "https://github.com/hkdb/aerion/releases/download/v0.2.4/Aerion-darwin-arm64.zip"
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
