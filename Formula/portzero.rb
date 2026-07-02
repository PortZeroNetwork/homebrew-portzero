class Portzero < Formula
  desc "Developer tool that eliminates port conflicts in local development"
  homepage "https://portzero.cloud"
  version "0.0.7"
  license "PolyForm-Shield-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/port-zero-aarch64-apple-darwin.tar.gz"
      sha256 "0c952f20e852c11ecf181322689be51eedd9b91266eed4f61d97cd77affa65d3" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/port-zero-x86_64-apple-darwin.tar.gz"
      sha256 "3bf6e721a1e21a15d4b78a845e83f0c744a00add8d01485dadb8c42af3554611" # x86_64
    end
  end

  def install
    bin.install "portzero"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/portzero --version")
  end
end
