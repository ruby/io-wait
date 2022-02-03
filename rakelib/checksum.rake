# build:checksum prior to rubygems 3.4 calculates meaningless values
desc "Generate SHA512 checksums"
task "build:sha512" => "pkg/SHA512"
task "pkg/SHA512" => "build" do |t|
  require 'digest/sha2'
  File.open(t.name, "wb") do |f|
    Dir.glob("pkg/*.gem") do |pkg|
      f.print(Digest::SHA512.file(pkg), " *", File.basename(pkg), "\n")
    end
  end
  Bundler.ui.confirm "SHA512 checksums are written to #{t.name}."
end
