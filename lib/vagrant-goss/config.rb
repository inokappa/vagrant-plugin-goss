module VagrantPlugins
  module Goss
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :output_format
      attr_accessor :spec_file
      attr_accessor :vars_file
      attr_accessor :goss_path
      attr_accessor :root_path

      def initialize
        super
        @output_format = UNSET_VALUE
        @spec_file = UNSET_VALUE
        @vars_file = UNSET_VALUE
        @goss_path = UNSET_VALUE
        @root_path = UNSET_VALUE
      end

      def finalize!
        @output_format = 'documentation' if @output_format == UNSET_VALUE
        @spec_file = 'goss.yaml' if @spec_file == UNSET_VALUE
        @vars_file = '' if @vars_file == UNSET_VALUE
        @goss_path = 'goss' if @goss_path == UNSET_VALUE
        @root_path = '/vagrant' if @goss_path == UNSET_VALUE
      end
    end
  end
end
