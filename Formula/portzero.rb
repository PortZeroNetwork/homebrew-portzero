class Portzero < Formula
  desc "Eliminate port conflicts in local dev environments with virtual NIC port forwarding"
  homepage "https://portzero.cloud"
  version "1.1.0"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero/releases/download/v#{version}/portzero-darwin-arm64.tar.gz"
      sha256 "323549a53301442f7a93284ad2ab07c1c617d0607694baf88b45ef6b304613e1" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero/releases/download/v#{version}/portzero-darwin-amd64.tar.gz"
      sha256 "f5a72e40af9eb00136b9fd0257dfb9d35286185b2fcfa4aa739f234856ee3c65" # x86_64
    end
  end

  def install
    bin.install "portzero"
  end

  def post_install
    # Generate the local CA certificate (writes to ~/Library/Application Support/PortZero/).
    # Idempotent — existing certs are kept. Does not require elevated privileges.
    system "#{bin}/portzero", "trust", "generate"
  end

  def caveats
    <<~EOS
      To complete setup, run:

        sudo portzero setup

      This command documents each action before it runs, then:
        - installs the CA certificate to your system keychain so browsers trust
          *.portzero.local HTTPS
        - installs and starts the root LaunchDaemon
        - pins portzero.local in /etc/hosts so your browser can reach the dashboard

      macOS mDNSResponder intercepts all *.local names before the PortZero resolver
      is consulted, so the management dashboard needs that static hosts entry.

      Once done, open http://portzero.local in your browser.

      Manual equivalents:
        sudo HOME="$HOME" portzero trust install
        sudo portzero autostart enable
        echo '10.254.0.2 portzero.local # portzero-local' | sudo tee -a /etc/hosts

      To stop/remove autostart: sudo portzero autostart disable
      Do not use `brew services`; it cannot pin HOME correctly for a root daemon.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/portzero --version")
  end
end
