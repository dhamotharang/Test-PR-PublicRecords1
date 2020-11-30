IMPORT Overrides;

Overrides.MAC_read_override_base('Aircraft',AircraftRecIDs,flag_file_id,DID_out,persistent_record_id,,,,false);//empty 
Overrides.MAC_read_override_base('Aircraft_Details',AircraftDetailsRecIDs,flag_file_id,,aircraft_mfr_model_code,,,,false);//empty, no DID, use flag file
Overrides.MAC_read_override_base('Aircraft_Engine',AircraftEngineRecIDs,flag_file_id,,engine_mfr_model_code,,,,false);//empty, no DID, use flag file
Overrides.MAC_read_override_base('Alloy',AlloyRecIDs,flag_file_id,did,sequence_number,key_code,rawaid); 
Overrides.MAC_read_override_base('American_Student_new',AmericanStudentNewRecIDs,flag_file_id,did,key); 
Overrides.MAC_read_override_base('Advo',AdvoRecIDs,flag_file_id,,zip,prim_range,prim_name,sec_range,false);
Overrides.MAC_read_override_base('ATF',ATFRecIDs,flag_file_id,did_out,atf_id); //empty
Overrides.MAC_read_override_base('AVM',AVMRecIDs,flag_file_id,,prim_range,prim_name,,,false); //no DID, use flag file
Overrides.MAC_read_override_base('AVM_Medians',AVMMediansRecIDs,flag_file_id,,geolink,,,,false);//no DID, use flag file
Overrides.MAC_read_override_base('BANKRUPT_MAIN',BkMainRecIDs,flag_file_id,,tmsid,court_code,case_number);
Overrides.MAC_read_override_base('BANKRUPT_SEARCH',BkSearchRecIDs,flag_file_id,did,tmsid,name_type,did);
Overrides.MAC_read_override_base('Concealed_Weapons',CCWRecIDs,flag_file_id,did_out,persistent_record_id); //empty
Overrides.MAC_read_override_base('DID_Death',DeathDidRecIDs,flag_file_id,did,state_death_id,,,,false); //empty
Overrides.MAC_read_override_base('Email_Data',EmailRecIDs,flag_file_id,did,email_rec_key,,,,false);
Overrides.MAC_read_override_base('Gong',GongRecIDs,flag_file_id,l_did,persistent_record_id);
Overrides.MAC_read_override_base('Header',HeaderRecIDs,,head.did,head.persistent_record_id);
Overrides.MAC_read_override_base('Hunting_Fishing',HuntingFishingRecIDs,flag_file_id,did_out,persistent_record_id);
//Overrides.MAC_read_override_base('Ibehavior_Consumer',IbehaviorConsumerRecIDs,flag_file_id,did,(string)persistent_record_id);
//Overrides.MAC_read_override_base('Ibehavior_Purchase',IbehaviorPurchaseRecIDs,flag_file_id,,(string)persistent_record_id);
Overrides.MAC_read_override_base('Impulse',ImpulseRecIDs,flag_file_id,did,created,,,,false);
Overrides.MAC_read_override_base('Infutor',InfutorRecIDs,flag_file_id,did,persistent_record_id,,,,false);
Overrides.MAC_read_override_base('Inquiries',InquiriesRecIDs,flag_file_id,person_q.appended_adl,search_info.transaction_id,,,,false);
Overrides.MAC_read_override_base('Liensv2_main',LiensMainRecIDs,flag_file_id,,persistent_record_id,,,,false); 
Overrides.MAC_read_override_base('Liensv2_party',LiensPartyRecIDs,flag_file_id,did,persistent_record_id,,,,false); 
Overrides.MAC_read_override_base('Marriage_Main',MarriageMainRecIDs,flag_file_id,,persistent_record_id); //thor_data400::base::override::fcra::qa::marriage_main not existing on PROD
Overrides.MAC_read_override_base('Marriage_Search',MarriageSearchRecIDs,flag_file_id,did,persistent_record_id); 
Overrides.MAC_read_override_base('Paw',PeopleAtWorkRecIDs,flag_file_id,did,contact_id,,,,false);
Overrides.MAC_read_override_base('Pilot_Certificate',PilotCertRecIDs,flag_file_id,,persistent_record_id);//thor_data400::base::override::fcra::qa::pilot_certificate not existing on PROD
Overrides.MAC_read_override_base('Pilot_Registration',PilotRegRecIDs,flag_file_id,did_out,persistent_record_id);
Overrides.MAC_read_override_base('Proflic',ProfessionalLicenseRecIDs,flag_file_id,did,prolic_key,,,,false);
Overrides.MAC_read_override_base('Proflic_Mari',ProfLicenseMariRecIDs,flag_file_id,did,persistent_record_id);
// PersonContext
// PropertyAssessment
Overrides.MAC_read_override_base('Assessment',PropertyAssessmentRecIDs,flag_file_id,,(string)ln_fares_id,,,,false);//no DID, use flag file
// PropertyDeed
Overrides.MAC_read_override_base('Deed',PropertyDeedRecIDs,flag_file_id,,(string)ln_fares_id,,,,false);//no DID, use flag file
// DeedByResidence
Overrides.MAC_read_override_base('Property_Search',PropertySearchRecIDs,flag_file_id,did,(string)persistent_record_id,,,,false);
Overrides.MAC_read_override_base('So_Main',SexOffendersMainRecIDs,flag_file_id,did,(string)offender_persistent_id); 
Overrides.MAC_read_override_base('So_Offenses',SexOffendersOffensesRecIDs,flag_file_id,,(string)offense_persistent_id); 
// SSN
// SSNFromInquiries
Overrides.MAC_read_override_base('SSN_Table',SSNRecIDs,flag_file_id,,ssn,,,,false);
Overrides.MAC_read_override_base('Thrive',ThriveRecIDs,flag_file_id,did,persistent_record_id,,,,false);
Overrides.MAC_read_override_base('UCC_Main',UCCMainRecIDs,flag_file_id,,persistent_record_id);
Overrides.MAC_read_override_base('UCC_Party',UCCPartyRecIDs,flag_file_id,did,persistent_record_id);
Overrides.MAC_read_override_base('Watercraft',WatercraftRecIDs,flag_file_id,did,persistent_record_id);
Overrides.MAC_read_override_base('Watercraft_Cguard',WatercraftCIDRecIDs,flag_file_id,,persistent_record_id,,,,false);
Overrides.MAC_read_override_base('Watercraft_Details',WatercraftWIDRecIDs,flag_file_id,,persistent_record_id,,,,false);
Overrides.MAC_read_override_base('Offenders',OffendersRecIDs,flag_file_id,did,(string)offender_key); 
Overrides.MAC_read_override_base('Offenders_Plus',OffendersPlusRecIDs,flag_file_id,did,(string)offender_persistent_id);
Overrides.MAC_read_override_base('Offenses',OffensesRecIDs,flag_file_id,,(string)offense_persistent_id); 
Overrides.MAC_read_override_base('Court_Offenses',CourtOffensesRecIDs,flag_file_id,,(string)offense_persistent_id); 
Overrides.MAC_read_override_base('Punishment',PunishmentRecIDs,flag_file_id,,(string)punishment_persistent_id); 


BaseOverrideFileIDs :=(
				AircraftRecIDs
				+ AlloyRecIDs
				+ AmericanStudentNewRecIDs
				+ AdvoRecIDs
				+ ATFRecIDs
				+ AVMRecIDs
		    + AVMMediansRecIDs
			   + BkSearchRecIDs
				 + BkMainRecIDs
				// + CriminalRecIDs
				+ OffendersRecIDs
				+ OffendersPlusRecIDs
				+ OffensesRecIDs
				+ CourtOffensesRecIDs
				+ PunishmentRecIDs
				+ CCWRecIDs
			  + DeathDidRecIDs
				+ EmailRecIDs
				+ GongRecIDs
				+ HeaderRecIDs
				+ HuntingFishingRecIDs
				+ ImpulseRecIDs
				+ InfutorRecIDs
				+ InquiriesRecIDs
			 + LiensPartyRecIDs
				+ LiensMainRecIDs
			  + MarriageMainRecIDs
				+ MarriageSearchRecIDs
				// + OptOutRecIDs
				+ PeopleAtWorkRecIDs
				+ PilotCertRecIDs
				+ PilotRegRecIDs
			  + ProfessionalLicenseRecIDs
				+ ProfLicenseMariRecIDs
				// + PersonContextRecIDs
				+ PropertyAssessmentRecIDs
			  + PropertyDeedRecIDs
				+ PropertySearchRecIDs
				 + SexOffendersMainRecIDs
				 + SexOffendersOffensesRecIDs
				 + SSNRecIDs
				// + SSNFromInquiriesRecIDs
				+ ThriveRecIDs
				+ UCCMainRecIDs
				+ UCCPartyRecIDs
		  	+ WatercraftRecIDs
				+ WatercraftCIDRecIDs
				+ WatercraftWIDRecIDs
				
): persist('~thor_data400::persist::override_basefileIDs');

export GetOverrideBase := BaseOverrideFileIDs;
