IMPORT American_Student_List,InfutorCID,GONG,AlloyMedia_student_list,watercraft,Prof_LicenseV2,
AVM_V2,Impulse_Email,doxie,Advo,email_data,Inquiry_AccLogs,PAW,Risk_Indicators,AlloyMedia_student_list,
FAA,emerges,ATF,marriage_divorce_v2,UCCV2,Prof_License_Mari,Thrive,BankruptcyV3,liensv2,doxie_files,SexOffender,LN_PropertyV2;

EXPORT payload_keys := module
  shared isFCRA := true;
	export watercraft := watercraft.key_watercraft_sid(isFCRA);
//	export watercraft_cguard := watercraft.key_watercraft_cid(IsFCRA);
//	export watercraft_details := watercraft.key_watercraft_wid(IsFCRA);	
	export proflic := Prof_LicenseV2.Key_Proflic_Did(IsFCRA);
	export student := American_Student_List.Key_DID_FCRA;
	export avm := AVM_V2.Key_AVM_Address_FCRA;
	export gong := Gong.Key_FCRA_History_did;
	export impulse := Impulse_Email.Key_Impulse_DID_FCRA;
	export infutor := InfutorCID.Key_Infutor_DID_FCRA;
	export header := doxie.Key_fcra_Header;
	export advo := Advo.Key_Addr1_FCRA_history;
	export email_data := email_data.Key_Did_FCRA;
	export inquiries := Inquiry_AccLogs.Key_FCRA_DID;
	export paw := PAW.Key_DID_FCRA;
	export ssn_table := Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA;
	export alloy := AlloyMedia_student_list.Key_DID_FCRA;
	export american_student_new := American_Student_List.Key_DID_FCRA;
	export aircrafts := FAA.key_aircraft_did(isFCRA);
	export aircraft_details := FAA.key_aircraft_id(IsFCRA);
	export aircraft_engine := FAA.key_engine_info(IsFCRA);
	export pilot_registration := FAA.key_airmen_did(isFCRA);
	export pilot_certificate := FAA.key_airmen_certs(IsFCRA);
	export concealed_weapons := emerges.key_ccw_rid(isFCRA);
	export hunting_fishing := eMerges.Key_HuntFish_Rid(isFCRA);
	export atf := ATF.Key_atf_did(isFCRA);
	export marriage_main := marriage_divorce_v2.key_mar_div_id_main(isFCRA);
	export marriage_search := marriage_divorce_v2.key_mar_div_id_search(IsFCRA);
	export ucc_main := UCCV2.Key_Rmsid_Main(IsFCRA);
	export ucc_party := UCCV2.key_rmsid_party(isFCRA);
	export proflic_mari := Prof_License_Mari.key_did(isFCRA);
	export thrive := Thrive.keys().did_fcra.qa;
	export avm_medians := avm_v2.Key_AVM_Medians_fcra;
	export did_death := Doxie.key_death_masterV2_ssa_DID_fcra;
  export bankrupt_main := BankruptcyV3.key_bankruptcyV3_main_full(isFCRA);
	export bankrupt_search := BankruptcyV3.key_bankruptcyv3_search_full_bip(IsFCRA);
	export liensv2_main := liensv2.key_liens_main_id_FCRA;
	export liensv2_party := liensv2.key_liens_party_id_FCRA;
	export offenders := doxie_files.Key_Offenders(isFCRA);
	export offenses := doxie_files.Key_Offenses(isFCRA);
	export punishment := doxie_files.Key_Punishment(isFCRA);
	export Offenders_plus := doxie_files.Key_Offenders_OffenderKey(isFCRA);
  export court_offenses := doxie_files.key_court_offenses(isFCRA);
  export so_main := SexOffender.key_SexOffender_SPK(isFCRA);
	export so_offenses := SexOffender.Key_SexOffender_offenses(isFCRA);
	export property := module
	export deed := LN_PropertyV2.key_deed_fid(isFCRA);
	export assessment := LN_PropertyV2.key_assessor_fid(isFCRA);
	export property_search := ln_propertyv2.key_search_fid(IsFCRA);

end;
	
end;
