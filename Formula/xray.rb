# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Xray < Formula
  desc "Xray, Penetrates Everything. Also the best v2ray-core, with XTLS support. Fully compatible configuration."
  homepage "https://t.me/projectxray"
  # download binary from upstream directly
  url "https://github.com/XTLS/Xray-core/releases/download/v1.1.4/Xray-macos-64.zip"
  version "1.1.4"
  sha256 "9e12f4b7a18d124ce118167761152e31aca4e51dccc509a7858b780c468c8b37"
  license "Mozilla Public License Version 2.0"

  def install
    bin.install "xray"
    pkgshare.install "geoip.dat" # installed to /usr/local/Cellar/xray/{version}/share/xray, symlinked to /usr/local/share/xray
    pkgshare.install "geosite.dat"
    (etc/"xray").mkpath
  end

  def caveats
    <<~EOS
      check out example configs at https://github.com/XTLS/Xray-examples
      and save your config.json to #{etc}/xray
    EOS
  end

  test do
    system "#{bin}/xray", "version"
  end

  plist_options :manual => "xray -config #{HOMEBREW_PREFIX}/etc/xray/config.json"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <true/>
          <key>RunAtLoad</key>
          <true/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{bin}/xray</string>
            <string>run</string>
            <string>-config</string>
            <string>#{etc}/xray/config.json</string>
          </array>
        </dict>
      </plist>
    EOS
  end
end