cask "magent" do
  version "1.0.1"
  sha256 "6090767815385acd51b8d3b26de22308dbbd7da6ecd7e0bbbcfb661b469e6cbe"

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
