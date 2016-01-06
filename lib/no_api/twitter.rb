require 'no_api'
require 'no_api/util'
require 'nokogiri'
require 'mechanize'

module NoApi
  TWITTER_BASE_URL = 'twitter.com'
  TWITTER_URL = 'https://twitter.com'

  class Twitter
    include NoApi::Util
    attr_reader :screen_name

    def initialize(screen_name)
      @screen_name = screen_name
    end

    def bio
      @bio ||= extract_bio(user_page)
    end

    def url
      @url ||= extract_url(user_page)
    end

    def avatar_url
      @avatar_url ||= extract_avatar_url(user_page)
    end

    def num_follows
      @profile_stats['following']
    end

    def num_followers
      @profile_stats['followers']
    end

    def num_tweets
      @profile_stats['tweets']
    end

    def profile_stats
      @profile_stats ||= extract_profile_stats(user_page)
    end

    def fullname
      @fullname ||= extract_fullname(user_page)
    end

    def location
      @location ||= extract_location(user_page)
    end

    # TODO: 鍵付き判定
    def tweets
      @tweets ||= extract_tweets(user_page)
    end

#    private

    def user_page
      return @user_page unless @user_page.nil?

      page = Nokogiri::HTML.parse("#{TWITTER_URL}/#{@screen_name}")
      page = agent.get("#{TWITTER_URL}/#{@screen_name}?lang=en")
      @user_page = Nokogiri::HTML.parse(page.content.toutf8)
    end

    def agent
      @agent ||= Mechanize.new
    end

    # These functions have to be updated constantly
    def extract_bio(page)
      page.css('.bio').first.children[1].children.first.text.strip
    end

    def extract_url(page)
      page.css('.url').first.children[1].children[1].children.first.text.strip
    end

    def extract_tweets(page)
      page.css('.tweet-text').inject([]){|arr, tweet_tag|
        arr << tweet_tag.children[1].children.first.text.strip
      }
    end

    def extract_avatar_url(page)
      page.css('.avatar').first.children[1].attributes['src'].value.strip.gsub(/_normal/,'')
    end

    def extract_fullname(page)
      page.css('.fullname').first.children.first.text.strip
    end

    def extract_location(page)
      page.css('.location').first.children.first.text.strip
    end

    def extract_profile_stats(page)
      profile_stats = {}
      page.css('.profile-stats').first.children[1].children.each do |child|
        puts child.css('.statlabel')
        if label = child.css('.statlabel').first
          profile_stats.store(label.children.first.text.strip.downcase,
                              parse_num_with_unit(child.css('.statnum').first.children.first.text.strip))
        end
      end
      profile_stats
    end
  end
end
