# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Localizer < Formula
  desc "Localizer is a simple tool for search your strings not localized in your project."
  homepage "https://github.com/manucodin/Localizer"
  version "1.0.0"
  url "https://github.com/manucodin/Localizer.git", branch: "homebrew-support"
  sha256 ""
  license ""

  def install
    bin.install Dir["bin/*"]
  end

  test do
    system "#{bin}/localizer" "import Foundation\n"
  end
end
