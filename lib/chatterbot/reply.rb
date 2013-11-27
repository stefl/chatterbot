module Chatterbot

  #
  # reply method for responding to tweets
  module Reply

    # handle replies for the bot
    def replies(&block)
      return unless require_login

      debug "check for replies since #{since_id_reply}"

      opts = since_id_reply > 0 ? {:since_id_reply => since_id_reply} : {}
      opts[:count] = 200

      results = client.mentions(opts)
      results.each { |s|
        unless ! block_given? || on_blacklist?(s) || skip_me?(s)
          update_since_id_reply(s)
          yield s         
        end
      }
    end
  end
end
