cask "magent" do
  version "1.0.0"
  sha256 "61eef661202663710b7faebe61a7566b1319540aaecbde84b1c8581d0f7e9568"

  url "https://github.com/vapor-pawelw/magent/releases/download/v#{version}/Magent.zip"
  name "Magent"
  desc "Native macOS app for managing coding agents as parallel git worktree sessions"
  homepage "https://github.com/vapor-pawelw/magent"

  app "Magent.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Magent.app"],
                   sudo: false
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.provenance", "#{appdir}/Magent.app"],
                   sudo: true
  end

  zap trash: [
    "~/Library/Application Support/Magent",
    "~/Library/Preferences/com.magent.app.plist",
  ]
end
