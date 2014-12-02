require "tmpdir"
require "tempfile"
require "spider-src"
require "spider-node/version"
require "spider-node/compile_result"
require "open3"

module spider
  module Node
    class << self

      def ssc_version
        Spider::Src.version
      end


      def ssc(*args)
        cmd = [node, Src.tsc_path.to_s, *args]
        Open3.popen3(*cmd) do |stdin, stdout, stderr, wait_thr|
          stdin.close
          [wait_thr.value, stdout.read, stderr.read]
        end
      end
  end
end

#Spider::Node.check_node
