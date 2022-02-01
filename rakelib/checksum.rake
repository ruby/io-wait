# build:checksum prior to rubygems 3.4 calculates meaningless values
desc "Generate SHA512 checksums"
task "build:sha512" => "build" do
  require 'digest/sha2'
  File.open("pkg/SHA512", "wb") do |f|
    Dir.glob("pkg/*.gem") do |pkg|
      f.print(Digest::SHA512.file(pkg), " *", File.basename(pkg), "\n")
    end
  end
end
