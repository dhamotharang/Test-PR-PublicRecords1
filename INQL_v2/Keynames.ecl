import tools,Data_Services,STD, _Control;

export Keynames(
						
						boolean isUpdate = false,
	          boolean isFCRA = false, 
						string pVersion = ''

) :=
module

shared data_env 			:= if(isFCRA,'fcra::','');
shared isSF						:= trim(pVersion)='';

shared prefix     := if(_Control.ThisEnvironment.ThisDaliIp = STD.System.Util.ResolveHostName(_Control.IPAddress.prod_thor_dali)
												,'~',Data_Services.foreign_prod);

shared prefixSF   						:= prefix + 'thor_data400::key::inquiry_table::'+ data_env;
shared prefixLG   						:= prefix + 'thor_data400::key::inquiry::'+ data_env;

EXPORT addressSFTemplate			:= prefixSF + if(isUpdate,'@version@::address_update','address_@version@');
EXPORT addressLGTemplate			:= prefixLG + if(isUpdate,'@version@::address_update','@version@::address');
EXPORT Address								:= tools.mod_FilenamesBuild(addressSFTemplate,pVersion,addressLGTemplate);

EXPORT didSFTemplate					:= prefixSF + if(isUpdate,'@version@::did_update','did_@version@');
EXPORT didLGTemplate					:= prefixLG + if(isUpdate,'@version@::did_update','@version@::did');
EXPORT DID										:= tools.mod_FilenamesBuild(didSFTemplate,pVersion,didLGTemplate);

EXPORT feinSFTemplate					:= prefixSF + if(isUpdate,'@version@::fein_update','fein_@version@');
EXPORT feinLGTemplate					:= prefixLG + if(isUpdate,'@version@::fein_update','@version@::fein');
EXPORT FEIN										:= tools.mod_FilenamesBuild(feinSFTemplate,pVersion,feinLGTemplate);

EXPORT ipaddrSFTemplate				:= prefixSF + if(isUpdate,'@version@::ipaddr_update','ipaddr_@version@');
EXPORT ipaddrLGTemplate				:= prefixLG + if(isUpdate,'@version@::ipaddr_update','@version@::ipaddr');
EXPORT IPADDR									:= tools.mod_FilenamesBuild(ipaddrSFTemplate,pVersion,ipaddrLGTemplate);

EXPORT linkidsSFTemplate			:= prefixSF + if(isUpdate,'@version@::linkids_update','linkids_@version@');
EXPORT linkidsLGTemplate			:= prefixLG + if(isUpdate,'@version@::linkids_update','@version@::linkids');
EXPORT Linkids								:= tools.mod_FilenamesBuild(linkidsSFTemplate,pVersion,linkidsLGTemplate);

EXPORT nameSFTemplate					:= prefixSF + if(isUpdate,'@version@::name_update','name_@version@');
EXPORT nameLGTemplate					:= prefixLG + if(isUpdate,'@version@::name_update','@version@::name');
EXPORT Name										:= tools.mod_FilenamesBuild(nameSFTemplate,pVersion,nameLGTemplate);

EXPORT phoneSFTemplate				:= prefixSF + if(isUpdate,'@version@::phone_update','phone_@version@');
EXPORT phoneLGTemplate				:= prefixLG + if(isUpdate,'@version@::phone_update','@version@::phone');
EXPORT Phone									:= tools.mod_FilenamesBuild(phoneSFTemplate,pVersion,phoneLGTemplate);

EXPORT ssnSFTemplate					:= prefixSF + if(isUpdate,'@version@::ssn_update','ssn_@version@');
EXPORT ssnLGTemplate					:= prefixLG + if(isUpdate,'@version@::ssn_update','@version@::ssn');
EXPORT SSN										:= tools.mod_FilenamesBuild(ssnSFTemplate,pVersion,ssnLGTemplate);

EXPORT transactionidSFTemplate			:= prefixSF + if(isUpdate,'@version@::transaction_id_update','transaction_id_@version@');
EXPORT transactionidLGTemplate			:= prefixLG + if(isUpdate,'@version@::transaction_id_update','@version@::transaction_id');
EXPORT Transaction_id								:= tools.mod_FilenamesBuild(transactionidSFTemplate,pVersion,transactionidLGTemplate);

EXPORT emailSFTemplate				:= prefixSF + if(isUpdate,'@version@::email_update','@version@::email');
EXPORT emailLGTemplate				:= prefixLG + if(isUpdate,'@version@::email_update','@version@::email');
EXPORT Email								  := tools.mod_FilenamesBuild(emailSFTemplate,pVersion,emailLGTemplate) ;

EXPORT billgroupsSFTemplate				:= prefixSF + '@version@::billgroups_did';
EXPORT billgroupsLGTemplate				:= prefixLG + '@version@::billgroups_did';
EXPORT Billgroups_did						  := tools.mod_FilenamesBuild(billgroupsSFTemplate,pVersion,billgroupsLGTemplate) ;

EXPORT induseverticalSFTemplate		:= prefixSF + 'industry_use_vertical_@version@';
EXPORT induseverticalLGTemplate		:= prefixSF + '@version@::industry_use_vertical';
EXPORT Industry_use_vertical			:= tools.mod_FilenamesBuild(induseverticalSFTemplate,pVersion,induseverticalLGTemplate) ;

EXPORT induseverticallogSFTemplate		:= prefixSF + 'industry_use_vertical_login_@version@';
EXPORT induseverticallogLGTemplate		:= prefixSF + '@version@::industry_use_vertical_login';
EXPORT Industry_use_vertical_login		:= tools.mod_FilenamesBuild(induseverticallogSFTemplate,pVersion,induseverticallogLGTemplate) ;

EXPORT lookupfuncdescSFTemplate				:= prefixSF + 'lookup_function_desc_@version@';
EXPORT lookupfuncdescLGTemplate				:= prefixSF + '@version@::lookup_function_desc';
EXPORT Lookup_function_desc						:= tools.mod_FilenamesBuild(lookupfuncdescSFTemplate,pVersion,lookupfuncdescLGTemplate) ;

EXPORT didriskSFtemplate     					:= STD.STr.RemoveSuffix(prefixSF,'::')  + '_did_@version@';
EXPORT didriskLGtemplate							:= prefixSF + '@version@::did';
EXPORT DID_Risk												:= tools.mod_FilenamesBuild(didriskSFtemplate,pVersion,didriskLGtemplate) ;

EXPORT nonfcra_daily 						  		:=      Address.dAll_filenames +
																						  DID.dAll_filenames +
																							FEIN.dAll_filenames +
																							IPaddr.dAll_filenames +
																							linkids.dAll_filenames +
																							name.dAll_filenames +
																							phone.dAll_filenames +
																							email.dAll_filenames +
																							SSN.dAll_filenames +
																							transaction_id.dAll_filenames +
																							industry_use_vertical.dAll_filenames +
																							industry_use_vertical_login.dAll_filenames +
																							lookup_function_desc.dAll_filenames +
																							DID_Risk.dAll_filenames;


EXPORT nonfcra_weekly 						  	:=      Address.dAll_filenames +
																						  DID.dAll_filenames +
																							FEIN.dAll_filenames +
																							IPaddr.dAll_filenames +
																							linkids.dAll_filenames +
																							name.dAll_filenames +
																							phone.dAll_filenames +
																							email.dAll_filenames +
																							SSN.dAll_filenames +
																							billgroups_did.dAll_filenames +
																							transaction_id.dAll_filenames;

EXPORT fcra_weekly 						  			:=      Address.dAll_filenames +
																						  DID.dAll_filenames +
																							phone.dAll_filenames +
																							SSN.dAll_filenames +
																							billgroups_did.dAll_filenames +
																							industry_use_vertical.dAll_filenames +
																							industry_use_vertical_login.dAll_filenames;

export dAll_filenames := 

    Address.dAll_filenames +
		DID.dAll_filenames +
		FEIN.dAll_filenames +
		IPaddr.dAll_filenames +
		linkids.dAll_filenames +
		name.dAll_filenames +
		phone.dAll_filenames +
		email.dAll_filenames +
		SSN.dAll_filenames +
		transaction_id.dAll_filenames +
		billgroups_did.dAll_filenames +
		industry_use_vertical.dAll_filenames +
		industry_use_vertical_login.dAll_filenames +
		lookup_function_desc.dAll_filenames +
		DID_Risk.dAll_filenames	
		;

end;
	
	
	