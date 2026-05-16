cask "aerion" do
  version "0.2.3"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "0e972f51559068fcc9e4ca55b9ac304833441e7490299863dabc24a537722118"
    url "https://github.com/hkdb/aerion/releases/download/v0.2.3/Aerion-darwin-amd64.zip"
  else
    sha256 "22c9696d2b0f59334bd7368e49c89a0b1fffe945ca52f17f4edb52b7154f5da2"
    url "https://github.com/hkdb/aerion/releases/download/v0.2.3/Aerion-darwin-arm64.zip"
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
