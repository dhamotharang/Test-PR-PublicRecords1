IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_Workers_Compensation, PRTE2_Common, autokey, AutoKeyI;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

	//flags for DOPS notification
	is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 					:= is_running_in_prod AND NOT skipDOPS;
	//
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_workers_compensation_bdid,
		Constants.KeyName_Workers_Compensation + '@version@::bdid',
		Constants.KeyName_Workers_Compensation  + filedate + '::bdid', build_key_workers_compensation_bdid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_workers_compensation_linkids.key,
		Constants.KeyName_Workers_Compensation + '@version@::linkids',
		Constants.KeyName_Workers_Compensation  + filedate + '::linkids', build_key_workers_compensation_linkids);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_Workers_Compensation + '@version@::bdid', 
		Constants.KeyName_Workers_Compensation  + filedate + '::bdid',
		move_built_key_workers_compensation_bdid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_Workers_Compensation + '@version@::linkids', 
		Constants.KeyName_Workers_Compensation  + filedate + '::linkids',
		move_built_key_workers_compensation_linkids);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_Workers_Compensation + '@version@::bdid', 
		'Q', 
		move_qa_key_workers_compensation_bdid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_Workers_Compensation + '@version@::linkids', 
		'Q', 
		move_qa_key_workers_compensation_linkids);
									
				
		autokey.mac_useFakeIDs 
				(Files.file_autokey, 
				ds_withFakeID_AKB,  
				proc_build_payload_key_AKB, 
				Constants.ak_keyname, 
				Constants.ak_logical(filedate), 
				did, 
				bdid) 		
		 
	ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 
	 
	ds_inLayoutMaster_AKB := PROJECT(ds_forLayoutMaster_AKB, 
													 TRANSFORM(Autokey.Layouts.Master, 
		SELF.inp.fname      := ''; 
		SELF.inp.mname      := ''; 
		SELF.inp.lname      := ''; 
		SELF.inp.ssn        := ''; 
		SELF.inp.dob        := 0; 
		SELF.inp.phone      := ''; 
		SELF.inp.prim_name  := ''; 
		SELF.inp.prim_range := ''; 
		SELF.inp.st         := ''; 
		SELF.inp.city_name  := ''; 
		SELF.inp.zip        := ''; 
		SELF.inp.sec_range  := ''; 
		SELF.inp.states     := LEFT.zero; 
		SELF.inp.lname1     := LEFT.zero; 
		SELF.inp.lname2     := LEFT.zero;
		SELF.inp.lname3     := LEFT.zero;
		SELF.inp.city1      := LEFT.zero;
		SELF.inp.city2      := LEFT.zero;
		SELF.inp.city3      := LEFT.zero;
		SELF.inp.rel_fname1 := LEFT.zero;
		SELF.inp.rel_fname2 := LEFT.zero;
		SELF.inp.rel_fname3 := LEFT.zero;
		SELF.inp.lookups    := LEFT.zero;
		SELF.inp.DID        := LEFT.zero;
		SELF.inp.bname      := LEFT.Description;   /* Business Name */
		SELF.inp.fein       := LEFT.FEIN;           
		SELF.inp.bphone     := '';  
		SELF.inp.bprim_name := LEFT.m_prim_name;    
		SELF.inp.bprim_range:= LEFT.m_prim_range; 
		SELF.inp.bst        := LEFT.m_st;            
		SELF.inp.bcity_name := LEFT.m_v_city_name;  
		SELF.inp.bzip       := LEFT.m_zip;         
		SELF.inp.bsec_range := LEFT.m_sec_range; 
		SELF.inp.BDID       := LEFT.bdid;           
		SELF.fakeid         := LEFT.FakeID; 
		SELF.p              := []; 
		SELF.b              := [])); 	  
	  	 	 
	mod_AKB := module(AutokeyB2.Fn_Build.params) 
		EXPORT DATASET(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
		EXPORT STRING L_inkeyname := 	Constants.ak_keyname; 
		EXPORT STRING L_inlogical := 	Constants.ak_logical(filedate); 
		EXPORT SET OF STRING1 L_build_skip_set := Constants.ak_skip_set; 
	end; 
												
	build_auto_keys := PARALLEL( proc_build_payload_key_AKB, 
															 AutokeyB2.Fn_Build.Do(mod_AKB,
															 AutoKeyI.BuildI_Indv.DoBuild,
															 AutoKeyI.BuildI_Biz.DoBuild) );
		
	AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname,moveToQA);		 
						 
	retval := SEQUENTIAL(build_auto_keys,moveToQA);									
	

	// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION  
	//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion('WorkersCompensationKeys', filedate, notifyEmail,'B','N','N');
	
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);
	//
	
	RETURN sequential
				(	build_key_workers_compensation_bdid 
					,build_key_workers_compensation_linkids
					,move_built_key_workers_compensation_bdid 
					,move_built_key_workers_compensation_linkids 
					,move_qa_key_workers_compensation_bdid 
					,move_qa_key_workers_compensation_linkids 
					,retval 
				);

END;
