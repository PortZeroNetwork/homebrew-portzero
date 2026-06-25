class Portzero < Formula
  desc "Developer tool that eliminates port conflicts in local development"
  homepage "https://portzero.cloud"
  version "0.0.2"
  license "PolyForm-Shield-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v\#{version}/port-zero-aarch64-apple-darwin.tar.gz"
      sha256 "1540864c9e593b36948c141a366c1ade46684c6a95a6e8bd31e328d9b8affcfe" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v\#{version}/port-zero-x86_64-apple-darwin.tar.gz"
      sha256 "eb2a9e6ce73c0fccfddf1a2d56438e1062383ad251a3866d176da841df8df331" # x86_64
    end
  end

  def install
    bin.install "portzero"
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/portzero --version")
  end
end
