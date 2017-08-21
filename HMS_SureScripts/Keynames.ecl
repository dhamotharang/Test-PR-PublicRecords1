import tools;

export Keynames(

	 string		pversion							= '',
   boolean pUseProd = false ) := module

	export lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'	;
	
	shared lDid			:= lFileTemplate + 'did';

	export Did		:= tools.mod_FilenamesBuild(ldid	,pversion);

	export did_dAll_filenames := Did.dAll_filenames;
	
	shared llnpid		:= lFileTemplate + 'lnpid';
	export lnpid		:= tools.mod_FilenamesBuild(llnpid,pversion);
	export lnpid_dAll_filenames := lnpid.dAll_filenames;
	
	// shared lSPIid		:= lFileTemplate + 'spi';
	// export spiid		:= tools.mod_FilenamesBuild(lspiid,pversion);
	// export dAll_filenames := spiid.dAll_filenames;
	

	// export address_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::address::@version@::'	;
	// export entity_lFileTemplate	    		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::entity::@version@::'	;
	// export Statelicense_lFileTemplate	  := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::Statelicense::@version@::'	;
  // export dea_lFileTemplate	    			:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::dea::@version@::'	;
  // ?export csr_lFileTemplate	    			:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::csr::@version@::'	;
  // export npi_lFileTemplate	    			:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::npi::@version@::'	;
	// export phone_lFileTemplate	    		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::phone::@version@::'	;
	// ?export language_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::language::@version@::'	;
	// ?export specialty_lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::specialty::@version@::'	;
	// ?export disciplinaryact_lFileTemplate:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::disciplinaryact::@version@::'	;
	// ?export provider_lFileTemplate				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::provider::@version@::'	;
	
	//Address Key
	// shared address_lgroup_key						:= address_lFileTemplate + 'ln_key';
	// export address_group_key						:= tools.mod_FilenamesBuild(address_lgroup_key	,pversion);
	// export address_group_dAll_filenames	:= address_group_key.dAll_filenames;
	
	// shared address_laddr_key						:= address_lFileTemplate + 'key';
	// export address_addr_key							:= tools.mod_FilenamesBuild(address_laddr_key	,pversion);
	// export address_addr_dAll_filenames	:= address_addr_key.dAll_filenames;
	
	// export address	:= address_group_key.dAll_filenames + address_addr_key.dAll_filenames;
	
	//StateLicense Key
	// shared Statelicense_lgroup_key						:= license_lFileTemplate + 'ln_key';
	// export Statelicense_group_key						:= tools.mod_FilenamesBuild(license_lgroup_key	,pversion);
	// export Statelicense_group_dAll_filenames	:= license_group_key.dAll_filenames;
	
	// shared Statelicense_llnum_key						:= license_lFileTemplate + 'number';
	// export Statelicense_lnum_key							:= tools.mod_FilenamesBuild(license_llnum_key	,pversion);
	// export Statelicense_lnum_dAll_filenames	:= license_lnum_key.dAll_filenames;
	
	// export Statelicense	:= license_group_key.dAll_filenames + license_lnum_key.dAll_filenames;
	
	//DEA Key
	// shared dea_lgroup_key								:= dea_lFileTemplate + 'ln_key';
	// export dea_group_key								:= tools.mod_FilenamesBuild(dea_lgroup_key	,pversion);
	// export dea_group_dAll_filenames			:= dea_group_key.dAll_filenames;

	// shared dea_ldea_num									:= dea_lFileTemplate + 'dea_number';
	// export dea_dea_num									:= tools.mod_FilenamesBuild(dea_ldea_num	,pversion);
	// export dea_dea_dAll_filenames				:= dea_dea_num.dAll_filenames;
	
	// export dea	:= dea_group_key.dAll_filenames + dea_dea_num.dAll_filenames;
	
	//provider keys - group_key, addr_key
	// shared provider_lgroup_key					:= provider_lFileTemplate + 'ln_key';
	// export provider_group_key						:= tools.mod_FilenamesBuild(provider_lgroup_key	,pversion);
	// export provider_group_dAll_filenames:= provider_group_key.dAll_filenames;

	// shared provider_llic_key						:= provider_lFileTemplate + 'license_number';
	// export provider_lic_key							:= tools.mod_FilenamesBuild(provider_llic_key	,pversion);
	// export provider_lic_dAll_filenames	:= provider_lic_key.dAll_filenames;
	
	// shared provider_ldea_key						:= provider_lFileTemplate + 'dea_number';
	// export provider_dea_key							:= tools.mod_FilenamesBuild(provider_ldea_key	,pversion);
	// export provider_dea_dAll_filenames	:= provider_dea_key.dAll_filenames;
	
	// shared provider_lnpi_key						:= provider_lFileTemplate + 'npi_number';
	// export provider_npi_key							:= tools.mod_FilenamesBuild(provider_lnpi_key	,pversion);
	// export provider_npi_dAll_filenames	:= provider_npi_key.dAll_filenames;

	// export provider	:= provider_group_key.dAll_filenames
										// +  provider_lic_key.dAll_filenames
										// +  provider_dea_key.dAll_filenames
										// +  provider_npi_key.dAll_filenames;

	
end; // module