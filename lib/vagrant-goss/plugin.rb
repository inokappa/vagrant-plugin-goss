module VagrantPlugins
  module Goss
    class Plugin < Vagrant.plugin('2')
      name 'goss'
      description <<-DESC
      This plugin executes a goss suite against a running Vagrant instance.
      DESC

      config(:goss, :provisioner) do
        require_relative 'config'
        Config
      end

      provisioner(:goss) do
        require_relative 'provisioner'
        Provisioner
      end
    end
  end
end
