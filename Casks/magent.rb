cask "magent" do
  version "1.1.0"
  sha256 "07bdfea594643cfa41509bb24f9c42439372ef08d01e0e0967623ae7ce186b7c"

  url "https://github.com/vapor-pawelw/magent/releases/download/v#{version}/Magent.zip"
  name "mAgent"
  desc "Native macOS app for managing coding agents as parallel git worktree sessions"
  homepage "https://github.com/vapor-pawelw/magent"

  app "Magent.app"

  preflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{staged_path}/Magent.app"]
  end

  zap trash: [
    "~/Library/Application Support/Magent",
    "~/Library/Preferences/com.magent.app.plist",
  ]
end
