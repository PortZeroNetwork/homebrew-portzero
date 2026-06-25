class Portzero < Formula
  desc "Developer tool that eliminates port conflicts in local development"
  homepage "https://portzero.cloud"
  version "0.0.3"
  license "PolyForm-Shield-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v\#{version}/port-zero-aarch64-apple-darwin.tar.gz"
      sha256 "332ea9ca24e9fbf22b268126df499aca7f830eb69774824158ae22886540a918" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v\#{version}/port-zero-x86_64-apple-darwin.tar.gz"
      sha256 "c94234239a8d0886eea4118fe5703928d17c5a91ba0fd9152aa6134774432c3f" # x86_64
    end
  end

  def install
    bin.install "portzero"
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/portzero --version")
  end
end
