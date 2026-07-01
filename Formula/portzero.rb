class Portzero < Formula
  desc "Developer tool that eliminates port conflicts in local development"
  homepage "https://portzero.cloud"
  version "0.0.5"
  license "PolyForm-Shield-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/port-zero-aarch64-apple-darwin.tar.gz"
      sha256 "eb89737c0d75a4eb1ea21f624b2a811f2b632df4c317ea731c5d281164b3b421" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/port-zero-x86_64-apple-darwin.tar.gz"
      sha256 "b719b84c2d77709888ae782895f6242f30c4a2737b022b59bcfda2a6a60d31be" # x86_64
    end
  end

  def install
    bin.install "portzero"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/portzero --version")
  end
end
