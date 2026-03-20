class GitHubPrivateRepositoryReleaseAssetDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "").to_s
    if token.empty?
      raise CurlDownloadStrategyError,
            "HOMEBREW_GITHUB_API_TOKEN is required to download private GitHub release assets."
    end

    meta[:headers] ||= []
    meta[:headers] << "Accept: application/octet-stream"
    meta[:headers] << "Authorization: Bearer #{token}"
    meta[:headers] << "X-GitHub-Api-Version: 2022-11-28"
    super
  end
end

cask "magent" do
  version "1.3.1"
  sha256 "aa0e0ef2411d01c784e4e3e3d844d8c499c2a8bc32922a614d6065e1adbbb7c2"

  url "https://github.com/vapor-pawelw/magent-releases/releases/download/v1.3.1/Magent.dmg"
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
