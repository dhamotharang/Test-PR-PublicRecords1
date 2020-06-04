import doxie, data_services, BIPV2;

EXPORT Keys := module


	export bdid		:= INDEX(files.base(bdid > 0), {bdid}, {NCPDP_provider_id}, Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' + doxie.Version_SuperKey + '::BDID'); 
	
	export dea		:= INDEX(files.base(DEA_registration_id != ''), {DEA_registration_id}, {NCPDP_provider_id}, Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' + doxie.Version_SuperKey + '::DEA');

	export did		:= INDEX(files.base(did > 0), {did},	{NCPDP_provider_id}, Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' + doxie.Version_SuperKey + '::DID');
	
	export fein		:= INDEX(files.base(federal_tax_id != ''), {federal_tax_id}, {NCPDP_provider_id}, Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' + doxie.Version_SuperKey + '::FEIN');
	
	export linkids := MODULE
    
	// DEFINE THE INDEX
	shared superfile_name		:= Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' +doxie.Version_SuperKey+ '::linkids';
    // This project is used to remove the record_type which was added to the Keybuild record layout
	shared Base := files.linkids;


	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;
	
	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;
	
	export lnpid	:= INDEX(files.final_base(NCPDP_provider_id != '' AND lnpid > 0), {lnpid}, {ncpdp_provider_id}, Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' + doxie.Version_SuperKey + '::lnpid');
	
	export ncpdp_id := INDEX(files.ncpdp(NCPDP_provider_id != ''), {NCPDP_provider_id}, {files.ncpdp}, Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' + doxie.Version_SuperKey + '::NCPDP_ID');
	
	export	npi		:= INDEX(files.base(national_provider_id != ''), {national_provider_id}, {NCPDP_provider_id}, Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' + doxie.Version_SuperKey + '::NPI');
	
	export	sln_state := INDEX(files.base(state_license_number != '' AND Phys_state != ''), {state_license_number, Phys_state}, {NCPDP_provider_id}, Data_services.data_location.prefix('DEFAULT') + 'prte::key::NCPDP::' + doxie.Version_SuperKey + '::SLN_State');
	

end;	