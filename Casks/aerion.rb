cask "aerion" do
  version "0.3.6"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "800beac959a66d3e31c4af1157618b4dc6b65ce40899f99d456d0163fbeb93ea"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.6/Aerion-darwin-amd64.zip"
  else
    sha256 "9bb613d402bdf5b8beeea65926dc2c13bb379003c08dfd138bd0750ba3aae767"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.6/Aerion-darwin-arm64.zip"
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
