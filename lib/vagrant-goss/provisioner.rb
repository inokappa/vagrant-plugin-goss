require 'open3'
require 'open-uri'
require 'fileutils'
require 'json'

module VagrantPlugins
  module Goss
    class Provisioner < Vagrant.plugin('2', :provisioner)
      def initialize(machine, config)
        super
        @root_path = config.root_path
        @output_format = config.output_format
        @spec_file = @root_path + config.spec_file
        @vars_file = @root_path + config.vars_file
        @goss_path = @root_path + config.goss_path
      end

      def provision
        vars_option = "--vars #{@vars_file} " if @vars_file != ''
        run = "#{@goss_path} --gossfile #{@spec_file} " +
              "#{vars_option} " +
              "validate " +
              "--format #{@output_format} --color" 
        run_command(run) if download_goss(@goss_path)
      end

      private

      def latest_goss_url
        r = open('https://api.github.com/repos/aelsabbahy/goss/releases').read
        JSON.parse(r).first['assets'].map do |asset|
          asset['browser_download_url'] if asset['name'] == 'goss-linux-amd64'
        end.compact[0]
      end

      def download_goss(goss_path)
        run = "wget --quiet #{latest_goss_url} -O #{goss_path}"
        run_command(run)
        run = "chmod 755 #{goss_path}"
        run_command(run)
        true
      end

      # refer to: https://github.com/hashicorp/vagrant/blob/master/plugins/provisioners/shell/provisioner.rb#L67-L81
      def handle_comm(type, data)
        if [:stderr, :stdout].include?(type)
          # Output the data with the proper color based on the stream.
          color = type == :stdout ? :green : :red

          # Clear out the newline since we add one
          data = data.chomp
          return if data.empty?

          options = {}
          options[:color] = color if !config.keep_color

          @machine.ui.detail(data.chomp, options)
        end
      end

      # refer to: https://github.com/hashicorp/vagrant/blob/master/plugins/provisioners/shell/provisioner.rb#L122-L128
      def run_command(cmd)
        machine.communicate.tap do |comm|
          comm.execute(
            cmd,
            sudo: false,
            error_key: :ssh_bad_exit_status_muted
          ) do |type, data|
            handle_comm(type, data)
          end
        end
      end
    end
  end
end
