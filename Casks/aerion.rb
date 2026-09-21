cask "aerion" do
  version "0.3.5"

  # Choose the correct archive for Intel (amd64) vs Apple Silicon (arm64)
  if Hardware::CPU.intel?
    sha256 "07cd3581d5d56d3d91d71936ae875acd944c32c80cb1102f8ca3def3f300edff"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.5/Aerion-darwin-amd64.zip"
  else
    sha256 "0d2e01dd0505b13edfc287290c57322859a7fcc79f8a142dff94c6baebea7490"
    url "https://github.com/hkdb/aerion/releases/download/v0.3.5/Aerion-darwin-arm64.zip"
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
