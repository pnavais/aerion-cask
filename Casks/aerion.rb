cask "aerion" do
  version "0.3.4"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "0eedad86d31e3f219d0b3694304737e3650f5c6cec7836ba35811a8cb77a8d22"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.4/Aerion-darwin-amd64.zip"
  else
    sha256 "0487013eec6f41971eff44a7b6a9b8ede7e58e38674f8888347518cc2ed66706"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.4/Aerion-darwin-arm64.zip"
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
