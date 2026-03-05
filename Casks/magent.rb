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
  version "1.1.0"
  sha256 "07bdfea594643cfa41509bb24f9c42439372ef08d01e0e0967623ae7ce186b7c"

  url "https://api.github.com/repos/vapor-pawelw/magent/releases/assets/366454950", using: GitHubPrivateRepositoryReleaseAssetDownloadStrategy
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
