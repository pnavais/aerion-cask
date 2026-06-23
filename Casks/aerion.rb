cask "aerion" do
  version "0.3.0"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "97437dfecce167273017fda125ac07b0017e2b2464441f2947362d616f6e6a3a"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.0/Aerion-darwin-amd64.zip"
  else
    sha256 "80f9c97a18ffd5d2e1dee689d4d9b7454c1c51483978bf82f491b589db7a6616"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.0/Aerion-darwin-arm64.zip"
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
