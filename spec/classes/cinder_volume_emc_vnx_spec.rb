require 'spec_helper'

describe 'cinder::volume::emc_vnx' do
  let :req_params do
    {
      :san_ip                => '127.0.0.2',
      :san_login             => 'emc',
      :san_password          => 'password',
      :iscsi_ip_address      => '127.0.0.3',
      :storage_vnx_pool_name => 'emc-volumes'
    }
  end

  let :facts do
    {:osfamily => 'Redhat' }
  end

  let :params do
    req_params
  end

  describe 'emc vnx volume driver' do
    it 'configure emc vnx volume driver' do
      should contain_cinder_config('DEFAULT/volume_driver').with_value('cinder.volume.drivers.emc.emc_cli_iscsi.EMCCLIISCSIDriver')
      should contain_cinder_config('DEFAULT/san_ip').with_value('127.0.0.2')
      should contain_cinder_config('DEFAULT/san_login').with_value('emc')
      should contain_cinder_config('DEFAULT/san_password').with_value('password')
      should contain_cinder_config('DEFAULT/iscsi_ip_address').with_value('127.0.0.3')
      should contain_cinder_config('DEFAULT/storage_vnx_pool_name').with_value('emc-volumes')
    end

    it 'ensure emc vnx dependency is installed' do
      should contain_package('emc_vnx_dependency').with(
        :ensure => 'present',
        :name   => 'naviseccli'
      )
    end

  end
end
