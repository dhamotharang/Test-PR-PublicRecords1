/*2013-05-31T21:06:33Z (Dnikam)
C:\Users\nikadh01\AppData\Roaming\HPCC Systems\eclide\Dnikam\BocaDev\Overrides\Keys\2013-05-31T21_06_33Z.ecl
*/
import fcra;
EXPORT Keys := module
	export bankrupt_filing := FCRA.key_override_bkv3_main_ffid;
	export bankrupt_search := fcra.key_override_bkv3_search_ffid;
	export criminal_offender := fcra.key_override_crim_offender_ffid;
	// export criminal_offenses := fcra.key_override_crim_offenses_ffid;
	// export criminal_punishment := fcra.key_override_crim_punishment_ffid;
	export offenders := FCRA.key_override_crim.offenders;
	export offenders_plus := FCRA.key_override_crim.offenders_plus;
	export court_offenses := FCRA.key_override_crim.court_offenses;
	export activity := FCRA.key_override_crim.activity;
	export offenses := FCRA.key_override_crim.offenses;
	export punishment := FCRA.key_override_crim.punishment;
	export flag := module
		export did := fcra.key_override_flag_did;
		export ssn := fcra.key_override_flag_ssn;
	end;
	export liens := fcra.key_override_liens_ffid;
	export pcr := module
		export did := fcra.key_override_pcr_did;
		export ssn := fcra.key_override_pcr_ssn;
		export uid := fcra.key_override_pcr_uid;
		export npcr_ssn := fcra.key_override_npcr_ssn;
		export npcr_did := fcra.key_override_npcr_did;
	end;
	export piinonfcra := module
		export ssn := fcra.key_override_pii_ssn;
		export did := fcra.key_override_pii_did;
	end;
	export liensv2_main := fcra.key_override_liensv2_main_ffid;
	export liensv2_party := fcra.key_override_liensv2_party_ffid;
	// export property_assessment_v2 := fcra.Key_Override_Prop_Assessment_v2_ffid;
	// export property_deeds_v3 := fcra.Key_Override_Prop_Deed_v3_ffid;
	// export property_search_v2 := fcra.Key_Override_Prop_Search_v2_ffid;
	export pii := module
		export ssn := fcra.key_fcra_override_pii_ssn;
		export did := fcra.key_fcra_override_pii_did;
	end;
	export aircraft := fcra.key_override_aircraft_ffid;
	export watercraft_old := fcra.Key_Override_Watercraft_FFID;
	export watercraft := fcra.key_override_watercraft.sid;
	export watercraft_cguard := fcra.key_override_watercraft.cid;
	export watercraft_details := fcra.key_override_watercraft.wid;
	
	export proflic := fcra.key_override_proflic_ffid;
	export student := fcra.key_override_student_ffid;
	export avm := fcra.key_override_avm_ffid;
	export gong := fcra.Key_Override_Gong_FFID;
	export impulse := FCRA.Key_Override_Impulse_FFID;
	export infutor := FCRA.Key_Override_Infutor_FFID;
	export header := FCRA.Key_Override_Header_DID;
	export advo := FCRA.Key_Override_ADVO_ffid;
	export email_data := FCRA.Key_Override_Email_Data_ffid;
	export inquiries := FCRA.Key_Override_Inquiries_ffid;
	export paw := FCRA.Key_Override_PAW_ffid;
	// export ln_propertyv2 := FCRA.Key_Override_Prop_Ownership_V4_FCRA;
	export ssn_table := FCRA.Key_Override_SSN_Table_FFID;
	export alloy := FCRA.Key_Override_Alloy_FFID;
	export american_student_new := FCRA.Key_Override_Student_New_FFID;
	export ibehavior_consumer := FCRA.key_override_ibehavior.consumer;
	export ibehavior_purchase := FCRA.key_override_ibehavior.purchase;
	export aircrafts := FCRA.key_override_faa.aircraft;
	export aircraft_details := FCRA.key_override_faa.aircraft_details;
	export aircraft_engine := FCRA.key_override_faa.aircraft_engine;
	export pilot_registration := FCRA.key_override_faa.airmen_reg;
	export pilot_certificate := FCRA.key_override_faa.airmen_cert;
	export concealed_weapons := FCRA.key_override_ccw.concealed_weapons;
	export hunting_fishing := FCRA.key_override_hunting_fishing.hunting_fishing;
	export atf := FCRA.key_override_atf.atf;
	export marriage_main := FCRA.key_override_marriage.marriage_main;
	export marriage_search := FCRA.key_override_marriage.marriage_search;
	export so_main := FCRA.key_override_sexoffender.so_main;
	export so_offenses := FCRA.key_override_sexoffender.so_offenses;
	export property := module
		export assessment := FCRA.Key_Override_Property.assessment;
		export deed := FCRA.Key_Override_Property.deed;
		export property_search := FCRA.Key_Override_Property.search;
		export ownership := FCRA.Key_Override_Property.ownership;
	end;
	export ucc_main := FCRA.key_override_ucc.main;
	export ucc_party := FCRA.key_override_ucc.party;
	export consumerstatement_lexid := FCRA.Key_cnsmr_statement_lexid;
	export consumerstatement_ssn := FCRA.Key_cnsmr_statement_ssn;
	export proflic_mari := FCRA.Key_Override_Proflic_Mari_ffid.proflic_mari;
	export thrive := FCRA.Key_Override_Thrive_ffid.thrive;
	export avm_medians := FCRA.key_override_avm.avm_medians;
	export address_data := FCRA.key_override_avm.address_data;
	export did_death := FCRA.key_override_death_master.did_death;
	// export consumerstatement := module
		// export lexid := FCRA.key_override_lexid;
		// export ssn := FCRA.key_override_ssn;
	// end;
	
end;