cask "aerion" do
  version "0.3.2"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "43454eebd07acb51a68b5b6593ccb675fae88fb4530ebee63cc2408bfae924ba"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.2/Aerion-darwin-amd64.zip"
  else
    sha256 "6c468802141868232045c391500fd01a0963a1f49afe90f49e682b9c9e5a14dc"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.2/Aerion-darwin-arm64.zip"
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
