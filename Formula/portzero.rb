class Portzero < Formula
  desc "Eliminate port conflicts in local dev environments with virtual NIC port forwarding"
  homepage "https://portzero.cloud"
  version "1.0.9"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/portzero-darwin-arm64.tar.gz"
      sha256 "6f2732660c803f890f4f220767affbc0c84b3f9a32db86677357187124a06162" # arm64
    end
    on_intel do
      url "https://github.com/PortZeroNetwork/portzero-local/releases/download/v#{version}/portzero-darwin-amd64.tar.gz"
      sha256 "4b12713c0e88220bd4e222fcaa5caf0f14ad4045c9fe5abac9eb3c2013d20de4" # x86_64
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
