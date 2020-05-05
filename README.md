# Vagrant Provisioner Plugin for Goss 

vagrant-plugin-goss is a vagrant plugin that implements [goss](https://github.com/aelsabbahy/goss) as a provisioner.

## Installation

Build the gem by running.

```sh
$ rake build
```

Install the plugin by running.

```sh
$ vagrant plugin install path/to/built/gem
```

## Example Usage

Write goss.yaml.

```sh
$ mkdir spec
$ cat << EOF > ./spec/goss.yaml
package:
  httpd:
    installed: true
  wget:
    installed: true
EOF
```

`wget` command is required on the target host.

Next, configure the provisioner in your Vagrantfile.

```ruby
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

  # `wget` command is required on the target host.
  config.vm.provision :shell, inline: <<~BASH
    sudo yum install -y wget httpd
  BASH

  config.vm.provision :goss do |goss|
    goss.root_path = '/vagrant'
    # root_path からの絶対パスで指定する #{root_path}/foo/bar であれば, /foo/bar と指定
    goss.spec_file = '/spec/goss.yaml'
    # root_path からの絶対パスで指定する #{root_path}/baz であれば, /baz と指定
    # goss.vars_file = '/vars.yaml'
    # root_path からの絶対パスで指定する #{root_path}/foo/bar であれば, /foo/bar と指定
    goss.goss_path = '/goss'
    # goss の output format を指定する, デフォルトは documentation, junit, json, nagios, rspecish, tap, silent
    # goss.output_format = 'junit'
    goss.sudo = true
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
