cask "magent" do
  version "1.0.0"
  sha256 "PLACEHOLDER"

  url "https://github.com/vapor-pawelw/magent/releases/download/v#{version}/Magent.zip"
  name "Magent"
  desc "Native macOS app for managing coding agents as parallel git worktree sessions"
  homepage "https://github.com/vapor-pawelw/magent"

  app "Magent.app"

  zap trash: [
    "~/Library/Application Support/Magent",
    "~/Library/Preferences/com.magent.app.plist",
  ]
end
