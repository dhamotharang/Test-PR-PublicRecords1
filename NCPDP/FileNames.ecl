import versioncontrol;

export FileNames(string pversion = '') := module
		export prov_info_lInputTemplate		:= 	_Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::prov_information::@version@::data';
		export prov_relat_lInputTemplate	:= 	_Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::prov_relationship::@version@::data';
		export medicaid_lInputTemplate		:= 	_Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::medicaid::@version@::data';
		export taxonomy_lInputTemplate		:=	_Dataset().thor_cluster_files + 'in::' 	 + _Dataset().name + '::taxonomy::@version@::data';
		export demographic_lInputTemplate	:=	_Dataset().thor_cluster_files + 'in::'	 + _Dataset().name + '::demographic::@version@::data';
		export pay_center_lInputTemplate	:=	_Dataset().thor_cluster_files + 'in::' 	 + _Dataset().name + '::pay_center::@version@::data';
		export parent_org_lInputTemplate	:=	_Dataset().thor_cluster_files + 'in::' 	 + _Dataset().name + '::parent_org::@version@::data';
		export eprescribe_lInputTemplate	:=	_Dataset().thor_cluster_files + 'in::' 	 + _Dataset().name + '::eprescribe::@version@::data';
		export remit_info_lInputTemplate	:=	_Dataset().thor_cluster_files + 'in::' 	 + _Dataset().name + '::remit_information::@version@::data';
		export state_license_lInputTemplate	:=	_Dataset().thor_cluster_files + 'in::' + _Dataset().name + '::state_license::@version@::data';
		export services_info_lInputTemplate	:= 	_Dataset().thor_cluster_files + 'in::' + _Dataset().name + '::services_information::@version@::data';
		export change_owner_lInputTemplate	:= _Dataset().thor_cluster_files+'in::'+ _Dataset().name + '::change_ownership::@version@::data';

		export prov_info_lBaseTemplate		:= 	_Dataset().thor_cluster_files + 'base::'   + _Dataset().name + '::prov_information::@version@::data';
		export prov_relat_lBaseTemplate	:= 	_Dataset().thor_cluster_files + 'base::'   + _Dataset().name + '::prov_relationship::@version@::data';
		export medicaid_lBaseTemplate		:= 	_Dataset().thor_cluster_files + 'base::'   + _Dataset().name + '::medicaid::@version@::data';
		export taxonomy_lBaseTemplate		:=	_Dataset().thor_cluster_files + 'base::' 	 + _Dataset().name + '::taxonomy::@version@::data';
		export demographic_lBaseTemplate	:=	_Dataset().thor_cluster_files + 'base::'	 + _Dataset().name + '::demographic::@version@::data';
		export pay_center_lBaseTemplate	:=	_Dataset().thor_cluster_files + 'base::' 	 + _Dataset().name + '::pay_center::@version@::data';
		export parent_org_lBaseTemplate	:=	_Dataset().thor_cluster_files + 'base::' 	 + _Dataset().name + '::parent_org::@version@::data';
		export eprescribe_lBaseTemplate	:=	_Dataset().thor_cluster_files + 'base::' 	 + _Dataset().name + '::eprescribe::@version@::data';
		export remit_info_lBaseTemplate	:=	_Dataset().thor_cluster_files + 'base::' 	 + _Dataset().name + '::remit_information::@version@::data';
		export state_license_lBaseTemplate	:=	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::state_license::@version@::data';
		export services_info_lBaseTemplate	:=	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::services_information::@version@::data';
		export change_owner_lBaseTemplate	:= _Dataset().thor_cluster_files+'base::'+ _Dataset().name + '::change_ownership::@version@::data';
		export final_lBaseTemplate			:= _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::combined_file::@version@::data';
		export keybuild_lBaseTemplate		:= _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::keybuild_file::@version@::data';

		export lKeybuildTemplate	:= 	_Dataset().thor_cluster_files + 'temp::' + _Dataset().name + '::@version@::data';	
		export prov_info_Input   	:= 	versioncontrol.mInputFilenameVersions(prov_info_lInputTemplate);
		export prov_relat_Input		:=  versioncontrol.mInputFileNameVersions(prov_relat_lInputTemplate);
		export medicaid_Input			:=	versioncontrol.mInputFileNameVersions(medicaid_lInputTemplate);
		export taxonomy_Input			:=	versioncontrol.mInputFileNameVersions(taxonomy_lInputTemplate);
		export demographic_Input	:=	versioncontrol.mInputFileNameVersions(demographic_lInputTemplate);
		export pay_center_Input		:=	versioncontrol.mInputFileNameVersions(pay_center_lInputTemplate);
		export parent_org_Input		:=	versioncontrol.mInputFileNameVersions(parent_org_lInputTemplate);
		export eprescribe_Input		:=	versioncontrol.mInputFileNameVersions(eprescribe_lInputTemplate);
		export remit_info_Input		:=	versioncontrol.mInputFileNameVersions(remit_info_lInputTemplate);
		export state_lic_Input		:=  versioncontrol.mInputFileNameVersions(state_license_lInputTemplate);
		export services_info_input := versioncontrol.mInputFileNameVersions(services_info_lInputTemplate);
		export change_owner_Input	:=	versioncontrol.mInputFileNameVersions(change_owner_lInputTemplate);
		
		export prov_info_Base  		:= 	versioncontrol.mBuildFilenameVersions(prov_info_lBaseTemplate,pversion);
		export prov_relat_base		:=	versioncontrol.mBuildFilenameVersions(prov_relat_lBaseTemplate,pversion);
		export medicaid_base			:=	versioncontrol.mBuildFilenameVersions(medicaid_lBaseTemplate,pversion);
		export taxonomy_base			:=	versioncontrol.mBuildFilenameVersions(taxonomy_lBaseTemplate,pversion);
		export demographic_base		:=	versioncontrol.mBuildFilenameVersions(demographic_lBaseTemplate,pversion);
		export pay_center_base		:=	versioncontrol.mBuildFilenameVersions(pay_center_lBaseTemplate,pversion);
		export parent_org_base		:=	versioncontrol.mBuildFilenameVersions(parent_org_lBaseTemplate,pversion);
		export eprescribe_base		:=	versioncontrol.mBuildFilenameVersions(eprescribe_lBaseTemplate,pversion);
		export remit_info_base		:=	versioncontrol.mBuildFilenameVersions(remit_info_lBaseTemplate,pversion);
		export state_lic_Base			:=  versioncontrol.mBuildFilenameVersions(state_license_lBaseTemplate,pversion);
		export services_info_base	:=	versioncontrol.mBuildFilenameVersions(services_info_lBaseTemplate,pversion);
		export change_owner_base	:=	versioncontrol.mBuildFilenameVersions(change_owner_lBaseTemplate,pversion);
		export final_Base					:=  versioncontrol.mBuildFilenameVersions(final_lBaseTemplate,pversion);
		export keybuild_base			:=	versioncontrol.mBuildFilenameVersions(keybuild_lBaseTemplate,pversion);
                                                                       
		export dAll_filenames			:=	prov_info_Base.dAll_filenames +
																	prov_relat_base.dAll_filenames +
																	medicaid_base.dAll_filenames +
																	taxonomy_base.dAll_filenames +
																	demographic_base.dAll_filenames +
																	pay_center_base.dAll_filenames +
																	parent_org_base.dAll_filenames +
																	eprescribe_base.dAll_filenames +
																	remit_info_base.dAll_filenames +
																	state_lic_Base.dAll_filenames +
																	services_info_base.dAll_filenames +
																	change_owner_base.dAll_filenames +
																	final_base.dAll_filenames +
																	keybuild_base.dAll_filenames;

		
end;