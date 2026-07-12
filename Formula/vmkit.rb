class Vmkit < Formula
  desc "Parallels VM system-test control plane (golden snapshots, guarded guest exec)"
  homepage "https://github.com/PortZeroNetwork/vmkit"
  # Private repo: install over SSH (your machines have keys). If the repo goes
  # public later, switch to the release-tarball url + sha256 form.
  url "git@github.com:PortZeroNetwork/vmkit.git",
      using:    :git,
      tag:      "v0.1.0",
      revision: "4f47bd83d651585d930ef66db53c39ca853a0d70"
  version "0.1.0"
  license "GPL-3.0-or-later"

  depends_on :macos

  def install
    libexec.install "bin", "lib", "guest-lib", "templates", "docs", "VERSION"
    # Wrapper (not a symlink): vmkit locates lib/ relative to its own realpath.
    (bin/"vmkit").write_env_script libexec/"bin/vmkit", {}
  end

  def caveats
    <<~EOS
      One-time setup on each machine:
        vmkit init-host     # write ~/.config/vmkit/host.conf, then edit it
        vmkit doctor        # validate against the human-setup contract

      Docs (human setup, guest capability matrix, failure catalog):
        #{libexec}/docs
    EOS
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/vmkit version")
  end
end
