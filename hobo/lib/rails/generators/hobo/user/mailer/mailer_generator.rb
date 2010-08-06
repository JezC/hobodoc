module Hobo
  class User::MailerGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    include Hobo::Generators::InviteOnlyModule

    def self.banner
      "rails generate hobo:user:mailer #{self.arguments.map(&:usage).join(' ')} [--invite-only]"
    end

    check_class_collision :suffix => 'Mailer'

    def generate_mailer
      template 'mailer.rb.erb', File.join('app/mailers', "#{file_path}_mailer.rb")
    end

    def generate_mails
      mailer_dir = File.join("app/views", class_path[0..-2], "#{file_name.singularize}_mailer")
      template 'forgot_password.erb', File.join(mailer_dir, "forgot_password.erb")
      template( 'invite.erb', File.join(mailer_dir, "invite.erb")) if invite_only?
    end

    hook_for :test_framework, :as => :mailer

  end
end