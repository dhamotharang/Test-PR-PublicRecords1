import tools;

export FAA_Keyfilenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=

module

	//FAAKeys Non-FCRA	
	export FAA_Keys_NonFCRA := module
		 
		  shared lkeyTemplate	 					 	:= if (pversion <> ''
																						,prte_csv._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::faa::'
																						,prte_csv._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::faa'
																						);
			export aircraft_id							:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::aircraft_id');
			export aircraft_info						:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::aircraft_info');
			export aircraft_linkids					:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::aircraft_linkids');
			export aircraft_reg_bdid				:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::aircraft_reg_bdid');			
			export aircraft_reg_did					:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::aircraft_reg_did');
			export aircraft_reg_nnum				:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::aircraft_reg_nnum');
			export airmen_certs							:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::airmen_certs');			
			export airmen_id								:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::airmen_id');
			export airmen_did								:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::airmen_did');			
			export airmen_rid								:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::airmen_rid');
			export engine_info							:= tools.mod_FilenamesBuild(lkeyTemplate	+ pversion + '::engine_info');	

			export dAll_filenames 					:= aircraft_id.dAll_filenames
																			 + aircraft_info.dAll_filenames
																			 + aircraft_linkids.dAll_filenames
																			 + aircraft_reg_bdid.dAll_filenames
																			 + aircraft_reg_did.dAll_filenames
																			 + aircraft_reg_nnum.dAll_filenames
																			 + airmen_certs.dAll_filenames
																			 + airmen_id.dAll_filenames
																			 + airmen_did.dAll_filenames
																			 + airmen_rid.dAll_filenames
																			 + engine_info.dAll_filenames
																			 ;
	end;

	//FAAKeys Non-FCRA	AutoKeys
	export FAA_AutoKeys_NonFCRA := module
			
			shared lautokeyTemplate	 			 	:= if (pversion <> ''
																						,prte_csv._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::faa::'
																						,prte_csv._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::faa'
																						);
			export aircraft_id							:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::aircraft_id');
			export aircraft_linkids					:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::aircraft_linkids');
			export aircraft_reg_bdid				:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::aircraft_reg_bdid');
			export aircraft_reg_did					:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::aircraft_reg_did');
			export aircraft_reg_nnum				:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::aircraft_reg_nnum');
			export airmen_did								:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::airmen_did');													
			export addressb2								:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::addressb2');
			export address									:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::address');
			export citystnameb2							:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::citystnameb2');
			export citystname								:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::citystname');
			export nameb2										:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::nameb2');
			export namewords2								:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::namewords2');
			export name											:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::name');
			export payload									:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::payload');
			export ssn2											:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::ssn2');
			export stnameb2									:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::stnameb2');
			export stname										:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::stname');
			export zipb2										:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::zipb2');
			export zip											:= tools.mod_FilenamesBuild(lautokeyTemplate + pversion	+ '::autokey::zip');
					
			export dAll_filenames 					:= aircraft_id.dAll_filenames
																			 + aircraft_linkids.dAll_filenames
																			 + aircraft_reg_bdid.dAll_filenames
																			 + aircraft_reg_did.dAll_filenames
																			 + aircraft_reg_nnum.dAll_filenames
																			 + airmen_did.dAll_filenames												
																			 + addressb2.dAll_filenames
																			 + address.dAll_filenames
																			 + citystnameb2.dAll_filenames
																			 + citystname.dAll_filenames
																			 + nameb2.dAll_filenames
																			 + namewords2.dAll_filenames
																			 + name.dAll_filenames
																			 + payload.dAll_filenames
																			 + ssn2.dAll_filenames												
																			 + stnameb2.dAll_filenames
																			 + stname.dAll_filenames
																			 + zipb2.dAll_filenames
																			 + zip.dAll_filenames
																			 ;
	end;																


	//FAAKeys Non-FCRA	AutoKeys
	export FAA_AutoKeys_Airmen_NonFCRA := module
			
			shared lautokeyAirmenTemplate	 	:=  if (pversion <> ''
																							,prte_csv._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::faa::airmen::'
																							,prte_csv._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::faa::airmen'
																							);
			
			export airmen_address						:= tools.mod_FilenamesBuild(lautokeyAirmenTemplate + pversion	+ '::autokey::address'); 
			export airmen_citystname				:= tools.mod_FilenamesBuild(lautokeyAirmenTemplate + pversion	+ '::autokey::citystname');
			export airmen_name							:= tools.mod_FilenamesBuild(lautokeyAirmenTemplate + pversion	+ '::autokey::name');
			export airmen_payload						:= tools.mod_FilenamesBuild(lautokeyAirmenTemplate + pversion	+ '::autokey::payload');
			export airmen_ssn2							:= tools.mod_FilenamesBuild(lautokeyAirmenTemplate + pversion	+ '::autokey::ssn2');
			export airmen_stname						:= tools.mod_FilenamesBuild(lautokeyAirmenTemplate + pversion	+ '::autokey::stname');
			export airmen_zip								:= tools.mod_FilenamesBuild(lautokeyAirmenTemplate + pversion	+ '::autokey::zip');
					
			export dAll_filenames 					:= airmen_address.dAll_filenames
																			 + airmen_citystname.dAll_filenames
																			 + airmen_name.dAll_filenames
																			 + airmen_payload.dAll_filenames
																			 + airmen_ssn2.dAll_filenames
																			 + airmen_stname.dAll_filenames
																			 + airmen_zip.dAll_filenames
																			 ;
	end;

	//FCRA_FAAKeys FCRA
	export FAA_Keys_FCRA := module

			shared lkeyTemplateFCRA				 	:=  if (pversion <> ''
																						 ,prte_csv._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::faa::fcra::'
																						 ,prte_csv._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::faa::fcra'
																						 );
			
			export aircraft_reg_did					:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::aircraft_reg_did');
			export aircraftreg_did					:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::aircraftreg_did');
			export aircraft_id							:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::aircraft_id');
			export aircraft_info						:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::aircraft_info');
			export airmen_certs							:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::airmen_certs');
			export airmen_did								:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::airmen_did');
			export airmen_rid								:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::airmen_rid');
			export engine_info							:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::engine_info');

			export dAll_filenames 					:= aircraftreg_did.dAll_filenames
																			 + aircraft_id.dAll_filenames
																			 + aircraft_info.dAll_filenames
																			 + airmen_certs.dAll_filenames
																			 + airmen_did.dAll_filenames
																			 + airmen_rid.dAll_filenames
																			 + engine_info.dAll_filenames
																			 + aircraft_reg_did.dAll_filenames																																	
																			 ; 

	end;													

	export dAll_filenames 							:= FAA_Keys_NonFCRA.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.dAll_filenames
																			 + FAA_AutoKeys_Airmen_NonFCRA.dAll_filenames
																			 + FAA_Keys_FCRA.dAll_filenames
																			 + FAA_Keys_NonFCRA.aircraft_id.dAll_filenames
																			 + FAA_Keys_NonFCRA.aircraft_info.dAll_filenames
																		   + FAA_Keys_NonFCRA.aircraft_linkids.dAll_filenames
																			 + FAA_Keys_NonFCRA.aircraft_reg_bdid.dAll_filenames
																			 + FAA_Keys_NonFCRA.aircraft_reg_did.dAll_filenames
																			 + FAA_Keys_NonFCRA.aircraft_reg_nnum.dAll_filenames
																			 + FAA_Keys_NonFCRA.airmen_certs.dAll_filenames
																			 + FAA_Keys_NonFCRA.airmen_id.dAll_filenames
																			 + FAA_Keys_NonFCRA.airmen_did.dAll_filenames
																			 + FAA_Keys_NonFCRA.airmen_rid.dAll_filenames
																			 + FAA_Keys_NonFCRA.engine_info.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.aircraft_id.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.aircraft_linkids.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.aircraft_reg_bdid.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.aircraft_reg_did.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.aircraft_reg_nnum.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.airmen_did.dAll_filenames												
																			 + FAA_AutoKeys_NonFCRA.addressb2.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.address.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.citystnameb2.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.citystname.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.nameb2.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.namewords2.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.name.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.payload.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.ssn2.dAll_filenames												
																			 + FAA_AutoKeys_NonFCRA.stnameb2.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.stname.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.zipb2.dAll_filenames
																			 + FAA_AutoKeys_NonFCRA.zip.dAll_filenames
																			 + FAA_AutoKeys_Airmen_NonFCRA.airmen_address.dAll_filenames
																			 + FAA_AutoKeys_Airmen_NonFCRA.airmen_citystname.dAll_filenames
																			 + FAA_AutoKeys_Airmen_NonFCRA.airmen_name.dAll_filenames
																			 + FAA_AutoKeys_Airmen_NonFCRA.airmen_payload.dAll_filenames
																			 + FAA_AutoKeys_Airmen_NonFCRA.airmen_ssn2.dAll_filenames
																			 + FAA_AutoKeys_Airmen_NonFCRA.airmen_stname.dAll_filenames
																			 + FAA_AutoKeys_Airmen_NonFCRA.airmen_zip.dAll_filenames
																			 + FAA_Keys_FCRA.aircraftreg_did.dAll_filenames
																			 + FAA_Keys_FCRA.aircraft_id.dAll_filenames
																			 + FAA_Keys_FCRA.aircraft_info.dAll_filenames
																			 + FAA_Keys_FCRA.airmen_certs.dAll_filenames
																			 + FAA_Keys_FCRA.airmen_did.dAll_filenames
																			 + FAA_Keys_FCRA.airmen_rid.dAll_filenames
																			 + FAA_Keys_FCRA.engine_info.dAll_filenames
																			 + FAA_Keys_FCRA.aircraft_reg_did.dAll_filenames														
																			 ;

end: DEPRECATED('Use PRTE2_FAA.Constants instead.');
