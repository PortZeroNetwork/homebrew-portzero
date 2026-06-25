class Portzero < Formula
  desc "Developer tool that eliminates port conflicts in local development"
  homepage "https://portzero.cloud"
  version "0.0.3"
  license "PolyForm-Shield-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v\#{version}/port-zero-aarch64-apple-darwin.tar.gz"
      sha256 "263cf78216a206c64ce5b26e9700cd08eb7a64c4cec2b15c31356c3162ef769c" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v\#{version}/port-zero-x86_64-apple-darwin.tar.gz"
      sha256 "ded88f02696d37f873e5d80493245f0a7b9cb931f86670597c0cb2bb783bcf62" # x86_64
    end
  end

  def install
    bin.install "portzero"
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/portzero --version")
  end
end
