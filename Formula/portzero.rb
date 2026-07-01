class Portzero < Formula
  desc "Developer tool that eliminates port conflicts in local development"
  homepage "https://portzero.cloud"
  version "0.0.4"
  license "PolyForm-Shield-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/port-zero-aarch64-apple-darwin.tar.gz"
      sha256 "20ee530e091cfcbd424c2f006f39a957fab9002c0eef4da1e543b4914fb114f1" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/port-zero-x86_64-apple-darwin.tar.gz"
      sha256 "5b16e127a833a53b8f856bfe287d2408a18a455a48ef269db71aab27dc58965d" # x86_64
    end
  end

  def install
    bin.install "portzero"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/portzero --version")
  end
end
