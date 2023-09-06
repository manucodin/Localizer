class Localizer < Formula
    desc "Localizer is a simple tool for search your strings not localized in your project."
    homepage "https://github.com/manucodin/Localizer"
    version "1.1.0"
    url "https://github.com/manucodin/Localizer/releases/download/#{version}/localizer.zip"
  
    def install
        system "make", "install", "prefix=#{prefix}"
    end
    
    test do
        system "#{bin}/swift-syntax-highlight" "import Foundation\n"
    end
end
