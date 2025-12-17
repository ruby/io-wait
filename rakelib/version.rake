class << (helper = Bundler::GemHelper.instance)
  def update_gemspec
    path = gemspec.loaded_from
    File.open(path, "r+b") do |f|
      d = f.read
      if d.sub!(/^(_VERSION\s*=\s*)".*"/) {$1 + gemspec.version.to_s.dump}
        f.rewind
        f.truncate(0)
        f.print(d)
      end
    end
  end

  def commit_bump
    dir, base = File.split(gemspec.loaded_from)
    sh(["git", "-C", dir, "commit", "-m", "bump up to #{gemspec.version}", base])
  end

  def version=(v)
    gemspec.version = v
    update_gemspec
    commit_bump
  end

  def bump(major, minor = 0, teeny = 0, pre: nil)
    self.version = [major, minor, teeny, *pre].compact.join(".")
  end

  def next_prerelease(*pre)
    if pre.empty?
      "dev"
    elsif (pre = pre.join(".") ).sub!(/\d+(?~.*\d)/) {$&.succ}
      pre
    else
      pre << ".1"
    end
  end
end

major, minor, teeny, *prerelease = helper.gemspec.version.segments

task "bump:dev", [:pre] do |t, pre: helper.next_prerelease(*prerelease)|
  helper.bump(major, minor, teeny, pre: pre)
end

task "bump:teeny", [:pre] do |t, pre: nil|
  teeny += 1 if pre and !pre.empty?
  helper.bump(major, minor, teeny, pre: pre)
end

task "bump:minor", [:pre] do |t, pre: nil|
  minor += 1 if pre and !pre.empty?
  helper.bump(major, minor, pre: pre)
end

task "bump:major", [:pre] do |t, pre: nil|
  major += 1 if pre and !pre.empty?
  helper.bump(major, pre: pre)
end

task "bump" => (prerelease.empty? ? "bump:teeny" : "bump:dev")

task "tag" do
  helper.__send__(:tag_version)
end
