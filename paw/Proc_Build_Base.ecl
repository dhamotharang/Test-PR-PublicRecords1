IMPORT Business_Header,watchdog,header_services, ut, versioncontrol, corp2,mdr;

export Proc_Build_Base(

	 string																											pversion
	,dataset(Layout.Business_Contact_Stats_Seq								) pfBusinessContactsStats 			= fBusinessContactsStats()
	,dataset(watchdog.Layout_Best															)	pWatchdogBest									= watchdog.File_Best
	,dataset(business_header.Layout_Business_Contact_Sequenced)	pBusinessContacts							= File_contact_plus_seq_in
	,dataset(corp2.Layout_Corporate_Direct_Corp_Base					)	pCorpInactives								= fCorpInactives				()

) :=
function

	Employee_Stats 	   := DISTRIBUTE(pfBusinessContactsStats, HASH(seqNum));
	CorpInactives      := pCorpInactives;
	dDead              := DISTRIBUTE(pWatchdogBest(DID<>0 and dod<>''),HASH(did));
	Employees          := DISTRIBUTE(IF(business_header.Flags.Out.ShouldFilter, 
																			business_header.filters.outs.PeopleAtWorkSeq(pBusinessContacts), 
																			pBusinessContacts
																			), HASH(seqNum)
																	 ) ;

	Layout.Employment_Out AddScore(Employees L ,Employee_Stats R) := TRANSFORM
		
			SELF.ssn 							:= IF(L.ssn <> 0,(STRING9) INTFORMAT(L.ssn, 9,  1), '');
			SELF.dt_first_seen  	:= MAP(	business_header.validatedate((STRING8)L.dt_first_seen) = '' => '',
																		(STRING8)L.dt_first_seen
																	 );
				SELF.dt_last_seen   := MAP(	business_header.validatedate((STRING8)L.dt_last_seen) = ''  => (STRING8)SELF.dt_first_seen, 
																		L.dt_last_seen < (INTEGER)SELF.dt_first_seen => (STRING8)SELF.dt_first_seen,
																		(STRING8)L.dt_last_seen
																	 );
			SELF.company_zip 			:= IF(L.company_zip <> 0, (STRING5)INTFORMAT(L.company_zip, 5, 1), '');
			SELF.company_zip4 		:= IF(L.company_zip4 <> 0, (STRING4)INTFORMAT(L.company_zip4, 4, 1), '');
			SELF.zip 							:= IF(L.zip <> 0, (STRING5)INTFORMAT(L.zip, 5, 1), '');
			SELF.zip4 						:= IF(L.zip4 <> 0, (STRING4)INTFORMAT(L.zip4, 4, 1), '');
			SELF.phone 						:= IF(L.phone <> 0, (STRING10)INTFORMAT(L.phone, 10, 1), '');
			SELF.company_phone  	:= (STRING)IF(0 != r.best_phone and not MDR.sourceTools.SourceIsDunn_Bradstreet(l.source), r.best_phone, l.company_phone);
			SELF.company_fein 		:= IF(L.company_fein <> 0, (STRING9)INTFORMAT(L.company_fein, 9, 1), '');
			SELF.Old_score 				:= IF(r.combined_score = 0, '', INTFORMAT(r.combined_score, 3, 1));
			SELF.score 						:= IF(r.combined_new_score= 0, '', INTFORMAT(r.combined_new_score, 3, 1));
			SELF.GLB 							:= IF(L.glb, 'Y', 'N');
			SELF.DPPA_State 			:= IF(L.dppa, L.vendor_id[1..2], '');
			SELF.title 						:= ''; // Name titles set to empty - fix for bug#36593
			SELF.name_suffix 			:= IF(ut.is_unk(l.name_suffix),'',l.name_suffix);
			SELF.source_count     := r.source_count;
			SELF.active_phone_flag:= IF(r.has_gong_yp, 'Y', 'N');
			SELF.contact_id				:= 0;
			SELF 									:= L;
	END;
	Layout.Employment_Out Pdead(Layout.Employment_Out L,dDead R) := TRANSFORM
		
			SELF.dead_flag				:=IF(r.DID<>0,1,0);
			SELF									:=L;
	END;
	Layout.Employment_Out Cdead(Layout.Employment_Out L,Layout.Employment_Out R) := TRANSFORM
		
			SELF.company_status		:=IF(MDR.sourceTools.SourceIsINFOUSA_DEAD_COMPANIES(R.source) OR l.company_status='DEAD','DEAD','');
			SELF               		:=R;
	END;

	Layout.Employment_Out Inactives(Layout.Employment_Out L, corp2.Layout_Corporate_Direct_Corp_Base R) := TRANSFORM
			// if I get a valid corp bdid, then the bdid is inactive. 
			SELF.company_status  	:=  IF(R.bdid<>0 or MDR.sourceTools.SourceIsINFOUSA_DEAD_COMPANIES(l.source),'DEAD','');
			SELF                	:=  L;
	END;

	Employees_score 	   	   	:= JOIN(Employees,Employee_Stats,LEFT.seqNum = RIGHT.seqNum,
																		AddScore(LEFT, RIGHT), LOCAL);
		
	Employees_scoreDISt		  	:= DISTRIBUTE(Employees_score (did<>0),hash(did));
	dpdead    				  			:= JOIN(Employees_scoreDISt,dDead,left.did= right.did, pdead(left,right),left outer,local)+Employees_score(did=0);
	dpdeadDist				  			:= DISTRIBUTE(dpdead(bdid>0) ,HASH(bdid));
	
	//  join to file of corp inactives in order to set the company status field.
	dpdeadCorp              	:= JOIN(dpdeadDist,corpInactives,left.bdid=right.bdid, Inactives(left,right),left outer,local);
				
	dPCdead                 	:= dpdeadCorp +dpdead(bdid=0);
	
	dAdd_Contact_id						:= project(dPCdead, transform(Layout.Employment_Out, 
																													self.contact_id := hash64(left.did,
																																										left.bdid,
																																										left.ssn,
																																										left.company_name,
																																										left.company_prim_range,
																																										left.company_predir,
																																										left.company_prim_name,
																																										left.company_addr_suffix,
																																										left.company_unit_desig,
																																										left.company_sec_range,
																																										left.company_city,
																																										left.company_state,
																																										left.company_zip,
																																										left.company_title,
																																										left.company_phone,
																																										left.company_fein,
																																										left.fname,
																																										left.mname,
																																										left.lname,
																																										left.name_suffix,
																																										left.prim_range,
																																										left.predir,
																																										left.prim_name,
																																										left.addr_suffix,
																																										left.unit_desig,
																																										left.sec_range,
																																										left.city,
																																										left.state,
																																										left.zip,
																																										left.phone,
																																										left.email_address,
																																										left.source,
																																										left.vendor_id);
																													self := left;));
																													
	// Filtering empty/zero global_sid PAW records for append global_sid macro call.
	dAdd_Contact_id_for_gsid := dAdd_Contact_id(global_sid = 0);
	
	// Filtering PAW records with non-blank global_sid's to avoid sending them to append global_sid macro call.
	dAdd_Contact_id_w_gsid   := dAdd_Contact_id(global_sid <> 0);
	
	// Appending Global_Sid's using macro macGetGlobalDSID call.
	dAdd_Contact_id_w_gsid_appended := mdr.macGetGlobalSID(dAdd_Contact_id_for_gsid, 'PAWV2', 'source', 'global_sid');
	
	dAdd_Contact_id_gsid := dAdd_Contact_id_w_gsid_appended + dAdd_Contact_id_w_gsid;																												
	
	VersionControl.macBuildNewLogicalFile( filenames(pversion).base.new		,dAdd_Contact_id_gsid,Out			);

	return sequential(
		 out
		,promote(pversion, 'base').new2built
	);

end;