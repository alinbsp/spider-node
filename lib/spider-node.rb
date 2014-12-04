require "tmpdir"
require "tempfile"
require "spider-src"
require "spider-node/version"
require "spider-node/compile_result"
require "open3"

module Spider
  module Node
    class << self

      def spider_version
        Spider::Src.version
      end


      def spiderc(*args)
        cmd = [node, Src.js_path.to_s, *args]
        Open3.popen3(*cmd) do |stdin, stdout, stderr, wait_thr|
          stdin.close
          [wait_thr.value, stdout.read, stderr.read]
        end
      end

    def compile_file(source_file, *spiderc_options)
      Dir.mktmpdir do |output_dir|
        output_file = File.join(output_dir, "out.js")
        exit_status, stdout, stderr = spiderc(*spiderc_options, '--out', output_file, source_file)

        output_js = File.exists?(output_file) ? File.read(output_file) : nil
        CompileResult.new(
            output_js,
            exit_status,
            stdout,
            stderr,
        )
      end
    end

  def compile(source, *spiderc_options)
    js_file = Tempfile.new(["spider-node", ".spider"])
    begin
      js_file.write(source)
      js_file.close
      result = compile_file(js_file.path, *spiderc_options)
      if result.success?
        result.js
      else
        raise result.stderr
      end
    ensure
      js_file.unlink
    end
  end

  end
end

Spider::Node.check_node
