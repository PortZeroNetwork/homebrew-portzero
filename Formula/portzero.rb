class Portzero < Formula
  desc "Eliminate port conflicts in local dev environments with virtual NIC port forwarding"
  homepage "https://portzero.cloud"
  version "0.0.9"
  license "PolyForm-Shield-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/portzero-darwin-arm64.tar.gz"
      sha256 "df9e7945677987e6c9c98f1ff0078e3f7b59b1f0d2eaf52aae86145e2be5985b" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/portzero-darwin-amd64.tar.gz"
      sha256 "d279bf964f4ce9b31b5fe23f6c23f17bf23c61ca5d9f3eb4d47be9b36e46cf52" # x86_64
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/portzero-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/portzero-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "portzero"
  end

  def post_install
    # Generate the local CA certificate (writes to ~/.portzero or platform equivalent).
    # Idempotent — existing certs are kept. Does not require elevated privileges on most platforms.
    system "#{bin}/portzero", "trust", "generate"
  end

  def caveats
    <<~EOS
      To complete setup for local tunnels and the dashboard:

      1. (macOS) Install the CA certificate to your system keychain so browsers trust
         *.portzero.local HTTPS (requires administrator privileges):

           sudo HOME="$HOME" portzero trust install

      2. (macOS) Install and start the root LaunchDaemon (requires administrator privileges):

           sudo portzero autostart enable

         The daemon starts immediately and restarts automatically at boot.
         Plist installed at: /Library/LaunchDaemons/cloud.portzero.daemon.plist

         Note: use `sudo portzero autostart enable/disable` to manage the daemon,
         not `brew services`.

      3. Pin portzero.local in /etc/hosts (required on macOS for the dashboard):

           echo '10.254.0.2 portzero.local # portzero-local' | sudo tee -a /etc/hosts

      Once done, open http://portzero.local in your browser.

      To stop/remove: sudo portzero autostart disable

      Linux users may need additional steps for capabilities and user services; see
      the installer or docs.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/portzero --version")
  end
end
