# -*- mode: ruby -*-
# vi: set ft=ruby :

# Script-Variablen
VM_NAME    = 'RoR Dev on Vagrant'
DB_VERSION = '5.7'
DB_HOST    = 'localhost'
DB_PORT    = '3306'
DB_ROOT_PW = 'holdrio79'

Vagrant.configure("2") do |config|
  config.env.enable

  config.vm.box = "generic/ubuntu1604"
  config.vm.box_version = "1.3.30"

  config.vm.provider "hyperv" do |hv|
    hv.memory = 2048
    hv.cpus = 2
    hv.enable_virtualization_extensions = true
    hv.differencing_disk = true
    hv.vmname = VM_NAME
  end

  # Rails Server Port im Host erreichbar machen
  config.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true

  # Mounten des Standard-Ordner deaktivieren
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Synchronisation und Mounten des App-Ordners erstellen
  # TODO >> rsync-Einstellung fuer @HOME-DEV-PC
  config.vm.synced_folder ENV['HOST_DIR'], ENV['GUEST_DIR'], disabled: false, create: true,
    type: "smb", smb_username: ENV['USERNAME'], smb_password: ENV['PC_USER_PW'],
    mount_options: [ "vers=3.0" ]

  # TODO >> Sync von Directory mit Input und Output MySQL-Daten

  # Ubuntu mit Dependencies installieren
  config.vm.provision :shell, path: "_scripts/install-ubuntu.sh",
    privileged: true, keep_color: false

  # MySQL-Datenbank installieren
  config.vm.provision :shell, path: "_scripts/install-mysql.sh",
    privileged: true, keep_color: false,
    env: { 'VERSION' => DB_VERSION, 'ROOT_PW' => DB_ROOT_PW }

  # Ruby on Rails installieren
  config.vm.provision :shell, path: "_scripts/install-ruby.sh",
    privileged: false, keep_color: false, run: "always",
    env: { 'APP_DIR' => ENV['GUEST_DIR'], 'RUBY_VERSION' => ENV['RUBY_VERSION']  }

  # Die database.yml anhand der Environment-Variablen erstellen.
  config.vm.provision :shell, path: "_scripts/app_config_database.sh",
    privileged: false, keep_color: false, run: "always",
    env: { 'APP_DIR' => ENV['GUEST_DIR'], 'HOST' => DB_HOST, 'PORT' => DB_PORT, 'ROOT_PW' => DB_ROOT_PW,
      'PROD_DB' => ENV['DB_PRODUCTION'], 'DEV_DB' => ENV['DB_DEVELOPMENT'], 'TEST_DB' => ENV['DB_TEST'],
      'USER_DB' => ENV['DB_USER'], 'USER_DB_PW' => ENV['DB_USER_PW']
    }

  # Ausfuehren Bundle install
  config.vm.provision :shell, path: "_scripts/app_bundle.sh",
    privileged: false, keep_color: false, run: "always",
    env: { 'APP_DIR' => ENV['GUEST_DIR'] }

  # TODO Trigger Plug-In
  # >> Export MySQL-Datenbank beim Zerstören der VM
  # >> Export MySQL-Datenbank beim Anhalten der VM ???
  # >> Import MySQL-Datenbank beim Erstellen der Datenbank

end