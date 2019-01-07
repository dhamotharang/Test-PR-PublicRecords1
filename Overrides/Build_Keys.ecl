
import RoxieKeyBuild,FCRA,STD,_control;
EXPORT Build_Keys(string infiledate, boolean isprte = false) := function
	build_key(keydatasetname,datasetname,infiledate,environment,suffix,retval,keyedfield,legacy='false') := macro
	
		#uniquename(nonprtereturnvalue)
		#uniquename(prtereturnvalue)
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(overrides.Keys.keydatasetname,
																						overrides.getfilename(datasetname,environment,,legacy).keyfile
																						,stringlib.StringFindReplace(overrides.getfilename(datasetname,environment,suffix,legacy).keyfile,'@version@',infiledate)
																						,%nonprtereturnvalue%
																						,true);
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						index(
																								overrides.Keys.keydatasetname((unsigned6)keyedfield < 0)
																								,{keyedfield}
																								,{overrides.Keys.keydatasetname}
																								,stringlib.StringFindReplace(overrides.getfilename(datasetname,environment,suffix,legacy,isprte).keyfile,'@version@','qa')
																							)
																						,overrides.getfilename(datasetname,environment,,legacy,isprte).keyfile
																						,stringlib.StringFindReplace(overrides.getfilename(datasetname,environment,suffix,legacy,isprte).keyfile,'@version@',infiledate)
																						,%prtereturnvalue%
																						,true);
		
		retval := if (~isprte
					,%nonprtereturnvalue%
					,%prtereturnvalue%
				);
		
	endmacro;
	Shared SearchPattern:='^dataopsowner:([^ ]*) ';
	Shared PulledName:=regexfind(SearchPattern,STD.System.Job.Name(),0);

	build_key(bankrupt_filing,'bankrupt_filing',infiledate,'fcra','ffid_v3',bankrupt_filingretval, flag_file_id);
	build_key(bankrupt_search,'bankrupt_search',infiledate,'fcra','ffid_v3',bankrupt_searchretval, flag_file_id);
	build_key(criminal_offender,'criminal_offender',infiledate,'fcra','ffid',criminal_offenderretval, flag_file_id);
	// build_key(criminal_offenses,'criminal_offenses',infiledate,'fcra','ffid',criminal_offensesretval, flag_file_id);
	// build_key(criminal_punishment,'criminal_punishment',infiledate,'fcra','ffid',criminal_punishmentretval, flag_file_id);
	build_key(flag.did,'flag',infiledate,'fcra','did',flagdidretval, l_did);
	build_key(flag.ssn,'flag',infiledate,'fcra','ssn',flagssnretval, l_ssn);
	build_key(liens,'liens',infiledate,'fcra','ffid',liensretval, flag_file_id);
	build_key(pcr.did,'pcr',infiledate,'fcra','did',pcrdidretval, s_did);
	build_key(pcr.ssn,'pcr',infiledate,'fcra','ssn',pcrssnretval, ssn);
	build_key(pcr.uid,'pcr',infiledate,'fcra','uid',pcruidretval, uid);
	build_key(pcr.npcr_ssn,'pcr',infiledate,'nonfcra','ssn',npcrssnretval, ssn);
	build_key(pcr.npcr_did,'pcr',infiledate,'nonfcra','did',npcrdidretval, s_did);
	build_key(piinonfcra.ssn,'pii',infiledate,'nonfcra','ssn',npiissnretval, ssn);
	build_key(piinonfcra.did,'pii',infiledate,'nonfcra','did',npiididretval, s_did);
	build_key(liensv2_main,'liensv2_main',infiledate,'fcra','ffid',liensv2_mainretval, flag_file_id);
	build_key(liensv2_party,'liensv2_party',infiledate,'fcra','ffid',liensv2_partyretval, flag_file_id);
	// build_key(property_assessment_v2,'property_assessment_v2',infiledate,'fcra','ffid',property_assessment_v2retval, flag_file_id);
	// build_key(property_deeds_v3,'property_deeds_v3',infiledate,'fcra','ffid',property_deeds_v3retval, flag_file_id);
	// build_key(property_search_v2,'property_search_v2',infiledate,'fcra','ffid',property_search_v2retval, flag_file_id);
	build_key(pii.ssn,'pii',infiledate,'fcra','ssn',piissnretval, ssn,true);
	build_key(pii.did,'pii',infiledate,'fcra','did',piididretval, s_did,true);
	build_key(aircraft,'aircraft',infiledate,'fcra','ffid',aircraftretval, flag_file_id);
	build_key(watercraft_old,'watercraft',infiledate,'fcra','ffid',watercraftretval, flag_file_id);
	build_key(watercraft,'watercraft',infiledate,'fcra','watercraft_sid',watercraft_sidretval, flag_file_id);
	build_key(watercraft_cguard,'watercraft',infiledate,'fcra','watercraft_cid',watercraft_cguardretval, flag_file_id);
	build_key(watercraft_details,'watercraft',infiledate,'fcra','watercraft_wid',watercraft_detailsretval, flag_file_id);
	build_key(proflic,'proflic',infiledate,'fcra','ffid',proflicretval, flag_file_id);
	build_key(student,'student',infiledate,'fcra','ffid',studentretval, flag_file_id);
	build_key(avm,'avm',infiledate,'fcra','ffid',avmretval, flag_file_id);
	build_key(gong,'gong',infiledate,'fcra','ffid',gongretval, flag_file_id);
	build_key(impulse,'impulse',infiledate,'fcra','ffid',impulseretval, flag_file_id);
	build_key(infutor,'infutor',infiledate,'fcra','ffid',infutorretval, flag_file_id);
	build_key(header,'header',infiledate,'fcra','did',headerretval, did);
	build_key(advo,'advo',infiledate,'fcra','ffid',advoretval, flag_file_id);
	build_key(email_data,'email_data',infiledate,'fcra','ffid',email_dataretval, flag_file_id);
	build_key(inquiries,'inquiries',infiledate,'fcra','ffid',inquiriesretval, flag_file_id);
	build_key(paw,'paw',infiledate,'fcra','ffid',pawretval, flag_file_id);
	// build_key(ln_propertyv2,'ln_propertyv2',infiledate,'fcra','did.ownershipv4',ln_propertyv2retval, flag_file_id);
	build_key(offenders,'crim',infiledate,'fcra','offenders',offendersretval, flag_file_id);
	build_key(offenders_plus,'crim',infiledate,'fcra','offenders_plus',offenderplusretval, flag_file_id);
	build_key(offenses,'crim',infiledate,'fcra','offenses',offensesretval, flag_file_id);
	build_key(court_offenses,'crim',infiledate,'fcra','courtoffenses',courtoffensesretval, flag_file_id);
	build_key(activity,'crim',infiledate,'fcra','activity',activityretval, flag_file_id);
	build_key(punishment,'crim',infiledate,'fcra','punishment',punishmentretval, flag_file_id);
	build_key(ssn_table,'ssn_table',infiledate,'fcra','ffid',ssn_tableretval, flag_file_id);
	build_key(alloy,'alloy',infiledate,'fcra','ffid',alloyretval, flag_file_id);
	build_key(american_student_new,'student_new',infiledate,'fcra','ffid',american_student_newretval, flag_file_id);
	//build_key(ibehavior_consumer,'ibehavior_consumer',infiledate,'fcra','ffid',ibehavior_consumerretval, flag_file_id);
	//build_key(ibehavior_purchase,'ibehavior_purchase',infiledate,'fcra','ffid',ibehavior_purchaseretval, flag_file_id);
	build_key(aircrafts,'aircrafts',infiledate,'fcra','ffid',aircraftsretval, flag_file_id);
	build_key(aircraft_details,'aircraft_details',infiledate,'fcra','ffid',aircraft_detailsretval, flag_file_id);
	build_key(aircraft_engine,'aircraft_engine',infiledate,'fcra','ffid',aircraft_engineretval, flag_file_id);
	build_key(pilot_registration,'pilot_registration',infiledate,'fcra','ffid',pilot_registrationretval, flag_file_id);
	build_key(pilot_certificate,'pilot_certificate',infiledate,'fcra','ffid',pilot_certificateretval, flag_file_id);
	build_key(concealed_weapons,'concealed_weapons',infiledate,'fcra','ffid',concealed_weaponsretval, flag_file_id);
	build_key(hunting_fishing,'hunting_fishing',infiledate,'fcra','ffid',hunting_fishingretval, flag_file_id);
	build_key(atf,'atf',infiledate,'fcra','ffid',atfretval, flag_file_id);
	build_key(marriage_main,'marriage_main',infiledate,'fcra','ffid',marriage_mainretval, flag_file_id);
	build_key(marriage_search,'marriage_search',infiledate,'fcra','ffid',marriage_searchretval, flag_file_id);
	build_key(so_main,'so_main',infiledate,'fcra','ffid',so_mainretval, flag_file_id);
	build_key(so_offenses,'so_offenses',infiledate,'fcra','ffid',so_offensesretval, flag_file_id);
	build_key(property.assessment,'property_assessment',infiledate,'fcra','ffid',property_assessmentretval, flag_file_id);
	build_key(property.deed,'property_deed',infiledate,'fcra','ffid',property_deedretval, flag_file_id);
	build_key(property.property_search,'property_search',infiledate,'fcra','ffid',property_searchretval, flag_file_id);
	build_key(property.ownership,'property_ownership',infiledate,'fcra','did',property_ownershipretval, did);
	build_key(ucc_main,'ucc_main',infiledate,'fcra','ffid',ucc_mainretval, flag_file_id);
	build_key(ucc_party,'ucc_party',infiledate,'fcra','ffid',ucc_partyretval, flag_file_id);
	build_key(consumerstatement_lexid,'consumerstatement',infiledate,'fcra','lexid',cons_lexidretval, lexid);
	build_key(consumerstatement_ssn,'consumerstatement',infiledate,'fcra','ssn',cons_ssnretval, ssn);
	build_key(proflic_mari,'proflic_mari',infiledate,'fcra','ffid',proflic_mariretval, flag_file_id);
	build_key(thrive,'thrive',infiledate,'fcra','ffid',thriveretval, flag_file_id);
	build_key(avm_medians,'avm_medians',infiledate,'fcra','ffid',avm_mediansretval, flag_file_id);
	build_key(address_data,'address_data',infiledate,'fcra','ffid',address_dataretval, flag_file_id);
	build_key(did_death,'did_death',infiledate,'fcra','ffid',did_deathretval, flag_file_id);
	
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
		//	,ibehavior_consumerretval
		//	,ibehavior_purchaseretval
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
			),
			_control.fSubmitNewWorkunit('#workunit(\'name\',\''+PulledName+' Scrubs Overrides\');\r\n'+
			'Scrubs_Overrides.fnRunScrubs(\''+infiledate+'\',\'Darren.Knowles@lexisnexisrisk.com; Charlene.Ros@lexisnexisrisk.com\');\r\n',std.system.job.target())
		);
	
end;