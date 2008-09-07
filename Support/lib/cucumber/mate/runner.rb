module Cucumber
  module TextMate
    
    class Runner
  
      def run_file(stdout, options={})
        options.merge!({:files => [single_file]})
        run(stdout, options)
      end

      def run_focussed(stdout, options={})
        options.merge!({:files => [single_file], :line => ENV['TM_LINE_NUMBER']})
        run(stdout, options)
      end

      def run(stdout, options)
        argv = options[:files].dup
    
        argv << '--format'
        argv << 'html'
    
        if options[:line]
          argv << '--line'
          argv << options[:line]
        end
    
        Dir.chdir(project_directory) do
          puts `./script/cucumber.rake #{argv.join(' ')}`
          # ::Spec::Runner::CommandLine.run(::Spec::Runner::OptionParser.parse(argv, STDERR, stdout))
        end
      end

      protected
  
      def single_file
        File.expand_path(ENV['TM_FILEPATH'])
      end

      def project_directory
        File.expand_path(ENV['TM_PROJECT_DIRECTORY'])
      end
  
    end
    
  end
end