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
  version "1.2.2"
  sha256 "50005e99fce77cc5ea78e66f3d099abd903397848744e53afc906e824313a50e"

  url "https://github.com/vapor-pawelw/magent-releases/releases/download/v1.2.2/Magent.dmg"
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
