IMPORT ut, DID_Add, Header, header_slimsort, watchdog, business_regression, roxiekeybuild, lib_fileservices, versioncontrol, header_services,mdr;

export proc_build_business_contacts_base_files(

	 string																		pversion
	,dataset(Layout_Business_Contacts_Temp	)	pBC_Add_AID	= BC_Add_AID	()
	,dataset(Layout_Business_Contacts_Stats	)	pBC_Stats		= BC_Stats		()

) := 
module

	shared names := filenames(pversion).base;
	
	// Filtering empty/zero global_sid business contacts records for append global_sid macro call.
	shared pBC_Add_AID_for_gsid := pBC_Add_AID(global_sid = 0);
	
	// Filtering business contact records with non-blank global_sid's to avoid sending them to append global_sid macro call.
	shared pBC_Add_AID_w_gsid   := pBC_Add_AID(global_sid <> 0);
	
	// Appending Global_Sid's using macro macGetGlobalDSID call.
	shared pBC_Add_AID_w_gsid_appended := mdr.macGetGlobalSID(pBC_Add_AID_for_gsid, 'BusinessHeader', 'source', 'global_sid');
	
	shared pBC_Add_AID_gsid := pBC_Add_AID_w_gsid_appended + pBC_Add_AID_w_gsid;

	shared layout_ssn_assign := RECORD
		UNSIGNED6 uid;
		UNSIGNED8 did;
		QSTRING9  ssn;
	END;

	layout_ssn_assign SlimForSSN(Business_Header.Layout_Business_Contacts_Temp l) := TRANSFORM
		SELF.ssn := IF(l.ssn = 0, '', INTFORMAT(l.ssn, 9, 1));
		SELF := l;
	END;

	shared Contacts_DID := PROJECT(pBC_Add_AID_gsid(did != 0), SlimForSSN(LEFT));

	// Append SSN by DID to Contacts
	DID_Add.MAC_Add_SSN_By_DID(Contacts_DID, did, ssn, Business_Contacts_SSN_Append) 

	shared Business_Contacts_SSN_Append_Dist := DISTRIBUTE(Business_Contacts_SSN_Append, HASH(uid));
	shared Business_Contacts_BDID_Dist := DISTRIBUTE(pBC_Add_AID_gsid, HASH(uid));

	Business_Header.Layout_Business_Contact_full_new AssignSSNs(Business_Header.Layout_Business_Contacts_Temp l, layout_ssn_assign r) := TRANSFORM
		SELF.ssn := IF(r.ssn != '', (UNSIGNED6) r.ssn, l.ssn);
		self.vendor_id := if((MDR.sourceTools.SourceIsVehicle(l.source) or MDR.sourceTools.sourceIsWC(l.source)) and l.vendor_id = '' and l.company_state != '', l.company_state + hash(l.company_name), l.vendor_id);
		SELF := l;
	END;

	shared Business_Contacts := JOIN(Business_Contacts_BDID_Dist,
														Business_Contacts_SSN_Append_Dist,
														LEFT.uid = RIGHT.uid,
														AssignSSNs(LEFT, RIGHT),
														LEFT OUTER, LOCAL);
	
	shared Business_Contacts_filtered := filters.BasesOut.Business_Contacts(Business_Contacts);
								 
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add Dummy data to corp base file
	/////////////////////////////////////////////////////////////////////////////////////////////////
	shared dummy_dataset := dataset(
	[
		 {999999001001,999999001001,35,'26-RVH9999999001001',20021124,pversion,'DU','C','N',FALSE,FALSE,'GENERAL PARTNER','','','MARK','','MARSUPIAL','','0','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,'163','440','42.23264','-83.385796',0,'mark.marsuial@marsupial_manor.com',351762213,'','MARSUPIAL MANOR III','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,0,0}
		,{999999001001,999999001001,35,'26-RVH9999999001001',20021124,20050713,'DU','H','N',FALSE,FALSE,'MANAGING PARTNER','','','MARK','','MARSUPIAL','','0','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,'163','440','42.23264','-83.385796',0,'',351762213,'','MARSUPIAL MANOR III','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,0,0}

	], Layout_Business_Contact_full_new);	


	//output(dummy_dataset);

	//************************************************************************
	//ADD INFORMATION - CNG 20070510 - dW20070517-160309 dW20070517-160309
	//************************************************************************

	Drop_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
	Record
	string15	bdid := '0';       
	string15	did := '0';        
	string3		contact_score := '0';
	string34	vendor_id := ''; 
	string10	dt_first_seen;
	string10	dt_last_seen;
	string2   	source;
	string1   	record_type;
	string1   	from_hdr := 'N'; 
	string1   	glb := '0';
	string1	  	dppa := '0';
	string35 	company_title;
	string35 	company_department := '';
	string5  	title;
	string20 	fname;
	string20 	mname;
	string20 	lname;
	string5  	name_suffix;
	string1   	name_score;
	string10 	prim_range;
	string2   	predir;
	string28 	prim_name;
	string4  	addr_suffix;
	string2   	postdir;
	string5  	unit_desig;
	string8		sec_range;
	string25	city;
	string2		state;
	string8		zip;
	string5 	zip4;
	string3   	county;
	string4   	msa;
	string10 	geo_lat;
	string11 	geo_long;
	string15	phone;
	string60	email_address;
	string10	ssn := '0';
	string34 	company_source_group := '';
	string120 	company_name;
	string10 	company_prim_range;
	string2   	company_predir;
	string28 	company_prim_name;
	string4  	company_addr_suffix;
	string2   	company_postdir;
	string5  	company_unit_desig;
	string8  	company_sec_range;
	string25 	company_city;
	string2   	company_state;
	string8 	company_zip;
	string5 	company_zip4;
	string15 	company_phone;
	string10 	company_fein := '0';
	string2		eor;
	end; 

	//***********END*************************************************************
	//output two base files for now, since need first one for package file and keys
	//second goes into the build, used for output business contacts and paw creation

	VersionControl.macBuildNewLogicalFile( names.contacts.new						,Business_Contacts_filtered + dummy_dataset,Build_Contacts			);
	VersionControl.macBuildNewLogicalFile( names.contactsPlus.new				,Business_Contacts_filtered + dummy_dataset										,Build_ContactsPlus	);
	VersionControl.macBuildNewLogicalFile( names.PeopleAtWorkStats.new	,pBC_Stats																										,Build_Stats				);

	shared o_reg := business_regression.Proc_BC_Regression_Test;

	dothis := OUTPUT('MAKE SURE THESE TWO FILES HAVE THE SAME NUMBER OF RECORDS, PLEASE!');

	export all := 
	SEQUENTIAL(

		 Build_Contacts			
		,Build_ContactsPlus	
		,promote(pversion,'^.*?base::business_header.*?contacts.*$'							).new2built
		,Build_Stats				
		,promote(pversion,'^.*?base::business_header.*?people_at_work_stats.*$'	).new2built
		,dothis

	);
end;