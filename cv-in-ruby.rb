%w(active_support active_record ap).each{|g| require g }
 
module Skills
  def main_skills
    {
      :programming_languages  => %w(Ruby C#),
      :development_frameworks => %w(Sinatra Rails ASP.NET/MVC Mono),
      :database               => %w(MySQL SQL-Server),
      :testing                => %w(Test::Unit MiniTest RSpec Shoulda FactoryGirl
                                     Machinist Cucumber Capybara Steak Selenium
                                     Autotest Spork Guard),    
      :orms                   => %w(ActiveRecord Sequel DataMapper),
      :front_end              => %w(Javascript CSS),
      :scm                    => %w(Git Subversion),
      :web_servers            => %w(Nginx Apache IIS),
      :app_servers            => %w(Passenger Thin Unicorn)
    }
  end
end
 
module Experience
  def self.included(base)
    class << base
      def experience
        jobs = []
 
        jobs << {
          :company  => "OnApp",
          :industry => "Cloud and CDN software for hosting providers ",  
          :roles    => ["Lead Web Developer"],
          :when     => { :from => "2011/03", :to => Time.now }
        }
 
        jobs << {
          :company  => "Clash Media",
          :industry => "Online advertising, lead generation",  
          :roles    => ["Web Developer", "Lead Architect",
                        "Technical Evangelist"],
          :when     => { :from => "2008/04", :to => "2010/12"  }
        }
 
        jobs << {
          :company  => "Leisure Direction",
          :industry => "Travel",  
          :roles    => ["Web Developer", "Systems Administrator"],
          :when     => { :from => "2005/03", :to => "2008/04" }
        }
 
        # TODO: add previous positions on request
 
        jobs
      end
    end
  end
end
 
class VitoBotta < ActiveRecord::Base
 
  include Experience
  extend Skills
 
  has_one :passion,   :through => "computing"
  has_many :skills,   :through => "experience", :include => "practice"
  has_many :projects, :through => "github", :foreign_key => "github.com/vitobotta"
 
  validates_presence_of :innovation
  validates_presence_of :learning_opportunities
  validates_presence_of :friendly_team
  validates_presence_of :pair_programming
 
  def self.objectives
    objs = []
    objs.push "Further develop my web development skills"
    objs.push "Have fun while contributing to some smart people's growth plans"
  rescue Exception => e
    puts "TODO: push harder!!"
    raise e
  end  
 
  def self.contact
    `open http://#{name.downcase}.com/contact/`
  end
 
  def self.inspect
    puts <<-END
 
    I am a passionate developer with 15 years commercial experience
    and 360° skills in the design, development and maintenance of modern,
    user centred as well as enterprise-scale web applications on Unix platforms,
    with a strong interest in performance,
    scalability, security and search engine optimisation.
 
    For more details, get in touch!
 
    END
  end
 
  def self.method_missing(method, *topics, &block)
    if method =~ /reference/
      raise StandardError, "Talk to me first!"
    else
      questions = ", specifically about #{topics.join(', ')}"
      puts "Got any questions on #{method}#{ questions unless topics.empty? }? " \
      " then contact me!"
      contact
    end
  end
 
end
- See more at: http://vitobotta.com/cv-resume/?goback=.gde_22413_member_42714027#sthash.N0DWXoAV.dpuf