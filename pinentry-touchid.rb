# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class PinentryTouchid < Formula
  desc "Custom GPG pinentry program for macOS that allows using Touch ID for fetching the password from
the macOS keychain.
"
  homepage "https://github.com/jorgelbg/pinentry-touchid"
  version "0.0.2"
  bottle :unneeded
  depends_on :macos

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/jorgelbg/pinentry-touchid/releases/download/v0.0.2/pinentry-touchid_0.0.2_macos_amd64.tar.gz"
      sha256 "60e839947b76b37c68c8b0385009eaf2a60325372d5e699c528e2c3d348444e4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/jorgelbg/pinentry-touchid/releases/download/v0.0.2/pinentry-touchid_0.0.2_macos_arm64.tar.gz"
      sha256 "6f8cca4896ccb1ef4d27fc1c829850e37b435b8bb6edec9842c8defaf8ea1669"
    end
  end

  depends_on "pinentry-mac"
  depends_on "pinentry"

  def install
    bin.install "pinentry-touchid"
  end

  def caveats; <<~EOS
    ✅  Add the following line to your ~/.gnupg/gpg-agent.conf file:
          pinentry-program #{bin}/pinentry-touchid

    🔄  Then reload your gpg-agent:
          gpg-connect-agent reloadagent /bye

    🔑  Run the following command to disable "Save in Keychain" in pinentry-mac:
          defaults write org.gpgtools.common DisableKeychain -bool yes

    ⛔️  If you are upgrading from a previous version, you will be asked to give
        access again to the keychain entry. Click "Always Allow" after the
        Touch ID verification to prevent this dialog from showing.
  EOS
  end

  test do
    system "#{bin}/pinentry-touchid -check"
  end
end
