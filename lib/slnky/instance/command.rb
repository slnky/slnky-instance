module Slnky
  module Instance
    class Command < Slnky::Command::Base
      attr_writer :client
      def client
        @client ||= Slnky::Instance::Client.new
      end

      command :terminate, 'terminate instance', <<-USAGE.strip_heredoc
        Usage: terminate [options] NAME

        NAME is instance id or instance name
        -h --help           print help.
      USAGE

      def handle_terminate(request, response, opts)
        name = opts.name
        list = client.find(name)
        if list.count == 0
          log.info "no instances found matching '#{name}'"
        elsif list.count > 1
          log.info "found #{list.count} instances: #{list.map{|e| "#{e.id}=>#{e.tags['Name']}"}.join(',')}"
        else
          if client.terminate(list.first.id)
            log.info "terminated #{list.first.id}"
          else
            log.error "failed to terminate #{list.first.id}"
          end
        end
      end

      # # use docopt to define arguments and options
      # command :echo, 'respond with the given arguments', <<-USAGE.strip_heredoc
      #   Usage: echo [options] ARGS...
      #
      #   -h --help           print help.
      #   -x --times=TIMES    print x times [default: 1].
      # USAGE
      #
      # # handler methods receive request, response, and options objects
      # def handle_echo(request, response, opts)
      #   # parameters (non-option arguments) are available as accessors
      #   args = opts.args
      #   # as are the options themselves (by their 'long' name)
      #   1.upto(opts.times.to_i) do |i|
      #     # just use the log object to respond, it will automatically send it
      #     # to the correct channel.
      #     log.info args.join(" ")
      #   end
      # end
    end
  end
end
