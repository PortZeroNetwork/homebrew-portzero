class Portzero < Formula
  desc "Eliminate port conflicts in local dev environments with virtual NIC port forwarding"
  homepage "https://portzero.cloud"
  version "0.0.8"
  license "PolyForm-Shield-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/portzero-darwin-arm64.tar.gz"
      sha256 "8f8c3cbdd7216b68c7057f208bc6e7072e1d7f5f9dec6030afcde343be000195" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/portzero-darwin-amd64.tar.gz"
      sha256 "c547f516cf7ccfc514fa087495568f07230acfcfd5d87be3f8d03fb58249999f" # x86_64
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
