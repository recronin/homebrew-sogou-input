cask "sogou-input" do
  version "4.7.0.5698"
  sha256 "12569c55927582274997c811e8953613e25a00c694480be4f2ef3af71bbf2731"

  url "https://github.com/recronin/homebrew-sogou-input/releases/download/v#{version}/sogou_input_v#{version}.zip",
      verified: "github.com/recronin/homebrew-sogou-input/"
  name "Sogou Input Method"
  desc "Chinese input method"
  homepage "https://pinyin.sogou.com/mac/"

  livecheck do
    url "https://github.com/recronin/homebrew-sogou-input/releases"
    regex(/v?(\d+(?:\.\d+)+)/i)
  end

  auto_updates true
  depends_on macos: ">= :mojave"
  depends_on arch: [:x86_64, :arm64]

  stage_only true

  postflight do
    app_path = Dir["#{staged_path}/sogou*.app"].first
    if app_path.nil?
      puts "No Sogou app found in #{staged_path}"
    else
      system_command "/usr/bin/open",
                     args:         [app_path],
                     print_stderr: false,
                     print_stdout: false
    end
  rescue
    nil
  end
end
