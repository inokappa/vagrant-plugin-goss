Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'

  config.vm.provider "virtualbox" do |vb|
     vb.memory = '512'
  end  

  config.vm.synced_folder '.', '/vagrant',
    disabled: false,
    type: 'rsync',
    rsync__exclude: [
      '.envrc',
      '.ruby-version',
      '.env',
      './tmp/',
      './bk/'
    ]
  config.vm.provision :shell, inline: <<~BASH
    sudo yum install -y httpd
  BASH

  config.vm.provision :goss do |goss|
    goss.root_path = '/vagrant'
    # root_path からの絶対パスで指定する #{root_path}/foo/bar であれば, /foo/bar と指定
    goss.spec_file = '/spec/goss.yaml'
    # root_path からの絶対パスで指定する #{root_path}/baz であれば, /baz と指定
    goss.vars_file = '/node.yml'
    # root_path からの絶対パスで指定する #{root_path}/foo/bar であれば, /foo/bar と指定
    goss.goss_path = '/bin/goss'
    # goss の output format を指定する, デフォルトは documentation, junit, json, nagios, rspecish, tap, silent
    # goss.output_format = 'junit'
  end
end
