IMPORT Header,ut,Header_SlimSort,MDR,DID_Add,DidVille,Address,RoxieKeyBuild,header_services,jtrost_stuff,VersionControl,Orbit3,dops,DOPSGrowthCheck,dx_header, DriversV2, suppress;

EXPORT proc_build_quick_hdr(
	STRING filedate, 
	STRING leMailTarget='jose.bello@lexisnexis.com;gregory.rose@lexisnexisrisk.com;Gabriel.Marcan@lexisnexis.com;Harry.Gist@lexisnexis.com;Debendra.Kumar@lexisnexisrisk.com',
	STRING leMailTargetScoring='jose.bello@lexisnexis.com;gregory.rose@lexisnexisrisk.com;Gabriel.Marcan@lexisnexis.com;Debendra.Kumar@lexisnexisrisk.com;Scoring_QA@risk.lexisnexis.com'
) := FUNCTION

	versionCheck := IF(
		filedate[1..6] = ut.GetDate[1..6] AND (header.Sourcedata_month.v_version[1..6] = filedate[1..6] OR header.Sourcedata_month.v_eq_as_of_date[1..6] = filedate[1..6]),
		OUTPUT('The version dates are good'),
		FAIL('Either the filedate or the header.Sourcedata_month date or both are not good')
	);

	SuccessBody := IF(
		VersionControl.IsValidVersion(filedate),
		'Quick Header ' + filedate + ' is ready for CERT deployment, please respond immediately if we can send to cert',''
	);

	RoxieKeyBuild.Mac_Daily_Email_Local('QUICK HEADER','FAIL see workunit:'+workunit,filedate,send_fail_msg,leMailTarget);

	dops_FCRA_QH  := roxiekeybuild.updateversion('FCRA_QuickHeaderKeys',filedate,'gregory.rose@lexisnexisrisk.com,jose.bello@lexisnexis.com',,'F');
	dops_QH       := roxiekeybuild.updateversion('QuickHeaderKeys',filedate,'gregory.rose@lexisnexisrisk.com,jose.bello@lexisnexis.com',,'N');
	dops_SS       := roxiekeybuild.updateversion('QHsourceKeys',filedate,'gregory.rose@lexisnexisrisk.com,jose.bello@lexisnexis.com',,'N');

	// Update Orbit with the correct entries in build in progress mode.

	oQH_fcra      := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'FCRA_Quick_Header',filedate,'F',leMailTarget,runaddcomponentsonly := false);	
	oQH_nonfcra   := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'Quick Header',filedate,'N',leMailTarget,runaddcomponentsonly := false);	
	oQH_qhs       := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'QHsourceKeys',filedate,'N',leMailTarget,runaddcomponentsonly := false);	

	EQ_records_in0 := header.fn_preprocess(true);

	ut.MAC_Sequence_Records(EQ_records_in0, rid, seqd);

	// rid is an unsigned6 which may extend up to 281,474,976,710,655
	// therefore, if we start sequensing from 999,999,999,999
	// there is a capacity for 280,474,976,710,656 unique rids
	header.Layout_New_Records to_form(seqd l) := TRANSFORM
		self.rid := l.rid + Header.constants.QH_start_rid;
		self := l;
	END;

	// do not remove this persist.  it is used in Header.Key_Rid_SrcID_Prep
	// if we have to restart with eq_records as a dataset, also look at 
	// heaer_quick.fn_patch_dids lines 64-73 as this will probably need to be sandboxed as well
	// if the counts were completed.

	//eq_records_in := DATASET('~thor_data400::persist::qh_seqd',header.Layout_New_Records,flat);
	eq_records_in := PROJECT(seqd,to_form(left)): persist('~thor_data400::persist::qh_seqd');

	dids0 := PROJECT(eq_records_in,header.layout_header);

	dids  := header_quick.fn_patch_dids(dids0);

	//Build roxie keys
	roxie_keys := header_quick.FN_keyBuild(dids,filedate) :SUCCESS(FileServices.SendEmail(leMailTargetScoring, 'Quick Header Completed',SuccessBody)), FAILURE(send_fail_msg);

	a0 := dids(did>0);

	a := PROJECT(a0,header.Layout_Header);

	full_ShortSuppress := DriversV2.Regulatory.applyDriversLicenseSup_DIDVend(a);

	addr1 := header.File_Headers(header.isPreGLB(header.File_Headers));
	addr2 := addr1(not mdr.Source_is_DPPA(src));
	header.MAC_Best_Address(addr2, did, 4, b)

	//note RID sequencing is not necessary for moxie
	header.mac_despray(full_ShortSuppress, b, full_out)

	rFullOut := RECORD // Referenced string_rec layout in header.MAC_Despray
		string15 did;
		string15 rid;
		string2  src;
		string6  dt_first_seen;
		string6  dt_last_seen;
		string6  dt_vendor_last_reported;
		string6  dt_vendor_first_reported;
		string6  dt_nonglb_last_seen;
		string1  rec_type;
		string18 vendor_id;
		string10 phone;
		string9  ssn;
		string8  dob;
		string5  title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5  name_suffix;
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  suffix;
		string2  postdir;
		string10 unit_desig;
		string8  sec_range;
		string25 city_name;
		string2  st;
		string5  zip;
		string4  zip4;
		string3  county;
		string4  msa;
		string1  tnt;  
		string1  valid_ssn;
	END;
	full_out_r := PROJECT(full_out, rFullOut);
	full_out_suppress :=  Header.Prep_Build.applyDidAddressSup2(full_out_r );						  	


	fSendMail(string pSubject, string pBody) := fileservices.sendemail(leMailTarget,pSubject,pBody);

	weekly_handling := SEQUENTIAL(
		OUTPUT(header.file_header_in_weekly.File,,'~thor400_84::in::'+header.sourcedata_month.v_eq_as_of_date+'::eq_weekly_with_as_of_date',__compressed__),
		fileservices.addsuperfile('~thor400_84::in::eq_weekly_with_as_of_date2','~thor400_84::in::'+header.sourcedata_month.v_eq_as_of_date+'::eq_weekly_with_as_of_date'),
		fileservices.addsuperfile('~thor400_84::in::eq_weekly_history','~thor400_84::in::eq_weekly',,true),
		fileservices.clearsuperfile('~thor400_84::in::eq_weekly')
	);

	//Persistence and Growth Checks
	GetDops:=dops.GetDeployedDatasets('P','B','F');
	OnlyQuickHeader:=GetDops(datasetname='FCRA_QuickHeaderKeys ');
	father_filedate := OnlyQuickHeader[1].buildversion;
	SET OF STRING Key_QuickHeader_InputSet:=['fname','lname','name_suffix','prim_range','prim_name','sec_range','city_name','st','zip','dob','ssn','mname','phone','src'];
	header_quick_index := header_quick.FN_key_DID(DATASET([],dx_header.Layout_Header), '~thor_data400::key::headerquick::fcra::'+filedate+'::did');
	DeltaCommands:= SEQUENTIAL(
		DOPSGrowthCheck.CalculateStats(
			'FCRA_QuickHeaderKeys ',
			'header_quick_index',
			'Key_QuickHeader',
			'~thor_data400::key::headerquick::fcra::'+filedate+'::did',
			'did',
			'persistent_record_ID','','','','',
			filedate,father_filedate,
			true,
			true
		),
		DOPSGrowthCheck.DeltaCommand(
			'~thor_data400::key::headerquick::fcra::'+filedate+'::did',
			'~thor_data400::key::headerquick::fcra::'+father_filedate+'::did',
			'FCRA_QuickHeaderKeys ',
			'Key_QuickHeader',
			'header_quick_index',
			'persistent_record_ID',
			filedate,
			father_filedate,
			Key_QuickHeader_InputSet,
			true,
			true
		),
		DOPSGrowthCheck.ChangesByField(
			'~thor_data400::key::headerquick::fcra::'+filedate+'::did',
			'~thor_data400::key::headerquick::fcra::'+father_filedate+'::did',
			'FCRA_QuickHeaderKeys ',
			'Key_QuickHeader',
			'header_quick_index',
			'persistent_record_ID','',
			filedate,father_filedate,
			true,
			true
		),
		DopsGrowthCheck.PersistenceCheck(
			'~thor_data400::key::headerquick::fcra::'+filedate+'::did',
			'~thor_data400::key::headerquick::fcra::'+father_filedate+'::did',
			'FCRA_QuickHeaderKeys ',
			'Key_QuickHeader',
			'header_quick_index',
			'persistent_record_ID',
			Key_QuickHeader_InputSet,
			Key_QuickHeader_InputSet,
			filedate,
			father_filedate,
			true,
			true
		)
	);

	RETURN SEQUENTIAL(
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, weekly_handling, 610),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, roxie_keys, 620),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, Header_Quick.Proc_Accept_SRC_toQA(filedate), 630),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, Header_Quick.proc_build_ssn_suppression(filedate), 640),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, Header_Quick.proc_build_current_wa_residents_file, 650),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, SEQUENTIAL(oQH_fcra,oQH_nonfcra,oQH_qhs), 660),
		//,SEQUENTIAL(/*dops_FCRA_QH,dops_QH,*/dops_SS)
		DeltaCommands
	);
END;
