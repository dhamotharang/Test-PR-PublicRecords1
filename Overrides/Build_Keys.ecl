
import RoxieKeyBuild,FCRA;
EXPORT Build_Keys(string infiledate) := function
	build_key(keydatasetname,datasetname,infiledate,environment,suffix,retval,legacy='false') := macro
		
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(overrides.Keys.keydatasetname,
																						overrides.getfilename(datasetname,environment,,legacy).keyfile
																						,stringlib.StringFindReplace(overrides.getfilename(datasetname,environment,suffix,legacy).keyfile,'@version@',infiledate)
																						,retval
																						,true);
		
	endmacro;
		
	build_key(bankrupt_filing,'bankrupt_filing',infiledate,'fcra','ffid_v3',bankrupt_filingretval);
	build_key(bankrupt_search,'bankrupt_search',infiledate,'fcra','ffid_v3',bankrupt_searchretval);
	build_key(criminal_offender,'criminal_offender',infiledate,'fcra','ffid',criminal_offenderretval);
	// build_key(criminal_offenses,'criminal_offenses',infiledate,'fcra','ffid',criminal_offensesretval);
	// build_key(criminal_punishment,'criminal_punishment',infiledate,'fcra','ffid',criminal_punishmentretval);
	build_key(flag.did,'flag',infiledate,'fcra','did',flagdidretval);
	build_key(flag.ssn,'flag',infiledate,'fcra','ssn',flagssnretval);
	build_key(liens,'liens',infiledate,'fcra','ffid',liensretval);
	build_key(pcr.did,'pcr',infiledate,'fcra','did',pcrdidretval);
	build_key(pcr.ssn,'pcr',infiledate,'fcra','ssn',pcrssnretval);
	build_key(pcr.uid,'pcr',infiledate,'fcra','uid',pcruidretval);
	build_key(pcr.npcr_ssn,'pcr',infiledate,'nonfcra','ssn',npcrssnretval);
	build_key(pcr.npcr_did,'pcr',infiledate,'nonfcra','did',npcrdidretval);
	build_key(piinonfcra.ssn,'pii',infiledate,'nonfcra','ssn',npiissnretval);
	build_key(piinonfcra.did,'pii',infiledate,'nonfcra','did',npiididretval);
	build_key(liensv2_main,'liensv2_main',infiledate,'fcra','ffid',liensv2_mainretval);
	build_key(liensv2_party,'liensv2_party',infiledate,'fcra','ffid',liensv2_partyretval);
	// build_key(property_assessment_v2,'property_assessment_v2',infiledate,'fcra','ffid',property_assessment_v2retval);
	// build_key(property_deeds_v3,'property_deeds_v3',infiledate,'fcra','ffid',property_deeds_v3retval);
	// build_key(property_search_v2,'property_search_v2',infiledate,'fcra','ffid',property_search_v2retval);
	build_key(pii.ssn,'pii',infiledate,'fcra','ssn',piissnretval,true);
	build_key(pii.did,'pii',infiledate,'fcra','did',piididretval,true);
	build_key(aircraft,'aircraft',infiledate,'fcra','ffid',aircraftretval);
	build_key(watercraft_old,'watercraft',infiledate,'fcra','ffid',watercraftretval);
	build_key(watercraft,'watercraft',infiledate,'fcra','watercraft_sid',watercraft_sidretval);
	build_key(watercraft_cguard,'watercraft',infiledate,'fcra','watercraft_cid',watercraft_cguardretval);
	build_key(watercraft_details,'watercraft',infiledate,'fcra','watercraft_wid',watercraft_detailsretval);
	build_key(proflic,'proflic',infiledate,'fcra','ffid',proflicretval);
	build_key(student,'student',infiledate,'fcra','ffid',studentretval);
	build_key(avm,'avm',infiledate,'fcra','ffid',avmretval);
	build_key(gong,'gong',infiledate,'fcra','ffid',gongretval);
	build_key(impulse,'impulse',infiledate,'fcra','ffid',impulseretval);
	build_key(infutor,'infutor',infiledate,'fcra','ffid',infutorretval);
	build_key(header,'header',infiledate,'fcra','did',headerretval);
	build_key(advo,'advo',infiledate,'fcra','ffid',advoretval);
	build_key(email_data,'email_data',infiledate,'fcra','ffid',email_dataretval);
	build_key(inquiries,'inquiries',infiledate,'fcra','ffid',inquiriesretval);
	build_key(paw,'paw',infiledate,'fcra','ffid',pawretval);
	// build_key(ln_propertyv2,'ln_propertyv2',infiledate,'fcra','did.ownershipv4',ln_propertyv2retval);
	build_key(offenders,'crim',infiledate,'fcra','offenders',offendersretval);
	build_key(offenders_plus,'crim',infiledate,'fcra','offenders_plus',offenderplusretval);
	build_key(offenses,'crim',infiledate,'fcra','offenses',offensesretval);
	build_key(court_offenses,'crim',infiledate,'fcra','courtoffenses',courtoffensesretval);
	build_key(activity,'crim',infiledate,'fcra','activity',activityretval);
	build_key(punishment,'crim',infiledate,'fcra','punishment',punishmentretval);
	build_key(ssn_table,'ssn_table',infiledate,'fcra','ffid',ssn_tableretval);
	build_key(alloy,'alloy',infiledate,'fcra','ffid',alloyretval);
	build_key(american_student_new,'student_new',infiledate,'fcra','ffid',american_student_newretval);
	build_key(ibehavior_consumer,'ibehavior_consumer',infiledate,'fcra','ffid',ibehavior_consumerretval);
	build_key(ibehavior_purchase,'ibehavior_purchase',infiledate,'fcra','ffid',ibehavior_purchaseretval);
	build_key(aircrafts,'aircrafts',infiledate,'fcra','ffid',aircraftsretval);
	build_key(aircraft_details,'aircraft_details',infiledate,'fcra','ffid',aircraft_detailsretval);
	build_key(aircraft_engine,'aircraft_engine',infiledate,'fcra','ffid',aircraft_engineretval);
	build_key(pilot_registration,'pilot_registration',infiledate,'fcra','ffid',pilot_registrationretval);
	build_key(pilot_certificate,'pilot_certificate',infiledate,'fcra','ffid',pilot_certificateretval);
	build_key(concealed_weapons,'concealed_weapons',infiledate,'fcra','ffid',concealed_weaponsretval);
	build_key(hunting_fishing,'hunting_fishing',infiledate,'fcra','ffid',hunting_fishingretval);
	build_key(atf,'atf',infiledate,'fcra','ffid',atfretval);
	build_key(marriage_main,'marriage_main',infiledate,'fcra','ffid',marriage_mainretval);
	build_key(marriage_search,'marriage_search',infiledate,'fcra','ffid',marriage_searchretval);
	build_key(so_main,'so_main',infiledate,'fcra','ffid',so_mainretval);
	build_key(so_offenses,'so_offenses',infiledate,'fcra','ffid',so_offensesretval);
	build_key(property.assessment,'property_assessment',infiledate,'fcra','ffid',property_assessmentretval);
	build_key(property.deed,'property_deed',infiledate,'fcra','ffid',property_deedretval);
	build_key(property.property_search,'property_search',infiledate,'fcra','ffid',property_searchretval);
	build_key(property.ownership,'property_ownership',infiledate,'fcra','did',property_ownershipretval);
	build_key(ucc_main,'ucc_main',infiledate,'fcra','ffid',ucc_mainretval);
	build_key(ucc_party,'ucc_party',infiledate,'fcra','ffid',ucc_partyretval);
	build_key(consumerstatement_lexid,'consumerstatement',infiledate,'fcra','lexid',cons_lexidretval);
	build_key(consumerstatement_ssn,'consumerstatement',infiledate,'fcra','ssn',cons_ssnretval);
	build_key(proflic_mari,'proflic_mari',infiledate,'fcra','ffid',proflic_mariretval);
	build_key(thrive,'thrive',infiledate,'fcra','ffid',thriveretval);
	build_key(avm_medians,'avm_medians',infiledate,'fcra','ffid',avm_mediansretval);
	build_key(address_data,'address_data',infiledate,'fcra','ffid',address_dataretval);
	build_key(did_death,'did_death',infiledate,'fcra','ffid',did_deathretval);
	
	return sequential(
	//	FCRA.Override_Prep_For_Property,
		parallel
		(
			bankrupt_filingretval
			,bankrupt_searchretval
			,criminal_offenderretval
		/*	,criminal_offensesretval
			,criminal_punishmentretval*/
			,flagdidretval
			,flagssnretval
			,liensretval
			,pcrdidretval
			,pcrssnretval
			,pcruidretval
			,npcrdidretval
			,npcrssnretval
			,npiissnretval
			,npiididretval
			,liensv2_mainretval
			,liensv2_partyretval
			/*,property_assessment_v2retval
			,property_deeds_v3retval
			,property_search_v2retval*/
			),
			parallel(
			piissnretval
			,piididretval
			,aircraftretval
			,watercraftretval
			,watercraft_sidretval
			,watercraft_cguardretval
			,watercraft_detailsretval
			,proflicretval
			,avmretval
			,gongretval
			,impulseretval
			,infutorretval
			,headerretval
			,advoretval
			,email_dataretval
			,inquiriesretval
			,pawretval
		//	,ln_propertyv2retval
			,offendersretval
			,offenderplusretval
			,offensesretval
			,courtoffensesretval
			,punishmentretval
			,activityretval
			),
			parallel(
			
			ssn_tableretval
			,alloyretval
			,american_student_newretval
			,studentretval
			,ibehavior_consumerretval
			,ibehavior_purchaseretval
			,aircraftsretval
			,aircraft_detailsretval
			,aircraft_engineretval
			,pilot_registrationretval
			,pilot_certificateretval
			,concealed_weaponsretval
			,hunting_fishingretval
			,atfretval
			,marriage_mainretval
			,marriage_searchretval
			,so_mainretval
			,so_offensesretval
			,property_assessmentretval
			,property_deedretval
			,property_searchretval
			,property_ownershipretval
			,ucc_mainretval
			,ucc_partyretval
			,cons_lexidretval
			,cons_ssnretval
			,proflic_mariretval
			,thriveretval
			,avm_mediansretval
			,address_dataretval
			,did_deathretval
			)
		);
	
end;