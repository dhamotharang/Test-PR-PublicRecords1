Import riskwise,risk_indicators,data_services,CriminalRecords_BatchService,DeathV2_Services,models,AppendIpMetadata,std,AppendRelativesAddressMatch,Advo,didville,PhonesInfo,
gateway,riskprocessing,_control,Autokey_batch,DriversV2_Services;

EXPORT fSOAPAppend(boolean	UpdatePii   = _Flags.Update.Pii)	:= MODULE

	Shared nodes				:= 150;//The data to be distributed on 150 nodes before sending to soapcall. 
	Shared threads			:= 1;

	//PII Input Process Begin

	Shared base := Files().Base.Main_Orig.built;
	shared pii_current :=Files().base.pii.built; //pii current build

	shared pii_previous := Files().base.pii.qa;			//pii previous build

	shared pii_updates := Join(pii_current,pii_previous,left.record_id=right.record_id,left only); //pii updates

Shared pii_input	:= if(UpdatePii,pii_updates,pii_current):independent; 

	//Add record_id to the pii soap input

	shared pii_input_prep	:= Project(pii_input,Transform({Layouts.pii, dataset({unsigned8 record_id}) record_ids}
																									,self.record_ids		:= Dataset([{left.record_id}],{unsigned8 record_id})
																									,self:=left));
																	

	shared pii_srt	:= sort(pii_input_prep,record, except record_id,fdn_file_info_id,record_ids);

	Recordof(pii_srt) Roll_recid	(pii_srt L , pii_srt R) := Transform
		self.Record_ids	:= L.Record_Ids + R.Record_Ids;
		self := L;
	End;

	// soap input with rolledup record_ids
	shared pii_base	:= rollup(pii_srt,Roll_Recid(left,right),record,except record_id, fdn_file_info_id,record_ids); 

	// normalized record_ids dataset for soap append outputs.

	shared Pii_Base_norm := normalize(pii_base,left.Record_ids,transform({recordof(left),unsigned8 record_id_new}
																,self.record_id_new := right.record_id,self:=left)):independent;		

	//PII Input Process End


	shared crim_base				:= Files().base.crim.qa;

	shared death_base 			:= Files().base.death.qa;

	shared IpAppend_Base		:= Files().base.IpMetaData.qa;

	shared Advo_Base				:= Files().base.Advo.qa;

	shared DLHistory_Base		:= Files().base.DLHistory.qa;
	
	shared BestInfo_Base		:= Files().base.BestInfo.qa;
	
	shared PrepaidPhone_Base:= Files().base.PrepaidPhone.qa;
	
	shared BocaShell_Base		:= Files().base.BocaShell.qa;

	//original soap output files

	shared crim_orig				:= Files().base.crim_orig.built;

	shared death_orig 			:= Files().base.death_orig.built;


	//Pii
	Export Pii := Module

			pbase:=Project(base,transform(Layouts.Pii
												,self.did										:=left.did
												,self.fname									:=left.cleaned_name.fname
												,self.mname									:=left.cleaned_name.mname
												,self.lname									:=left.cleaned_name.lname
												,self.name_suffix						:=left.cleaned_name.name_suffix
												,self.prim_range						:=left.clean_address.prim_range
												,self.predir								:=left.clean_address.predir
												,self.prim_name							:=left.clean_address.prim_name
												,self.addr_suffix						:=left.clean_address.addr_suffix
												,self.postdir								:=left.clean_address.postdir
												,self.unit_desig						:=left.clean_address.unit_desig
												,self.sec_range							:=left.clean_address.sec_range
												,self.p_city_name						:=left.clean_address.p_city_name
												,self.st										:=left.clean_address.st
												,self.zip										:=left.clean_address.zip
												,self.address_1							:=left.address_1
												,self.ssn										:=left.clean_ssn
												,self.dob										:=left.clean_dob
												,self.drivers_license				:=left.drivers_license
												,self.drivers_license_state	:=left.drivers_license_state
												,self.home_phone						:=left.clean_phones.phone_number
												,self.work_phone_						:=left.clean_phones.work_phone
												,self.email_address					:=left.email_address
												,self.ip_address						:=left.ip_address
												,self.reported_date					:=left.reported_date
												,self.record_id							:=left.record_id
												,self.fdn_file_info_id			:=left.classification_Permissible_use_access.fdn_file_info_id
												,self												:=left)
										);

			pdist:=distribute(pbase(did>0),hash(record_id));
				 
		 Export All := pdist;
		 
	End;

	EXPORT Crim		:= MODULE

			service_name	:= 'criminalrecords_batchservice.batchservice';
			soap_host		:= riskwise.shortcuts.prod_batch_analytics_roxie;

			layout_in   := CriminalRecords_BatchService.Layouts.batch_in;

			layout_out  := CriminalRecords_BatchService.Layouts.batch_out;

			layout_in make_batch_in(pii_base L) := TRANSFORM
				SELF.acctno := (string)l.record_id;
				SELF.Name_First := L.fname;
				SELF.Name_Middle := L.mname;
				SELF.Name_Last := L.lname;
				SELF.Name_suffix := L.name_suffix;
				SELF.prim_name := L.prim_name;
				SELF.prim_range := L.prim_range;
				SELF.sec_range := L.sec_range;
				SELF.St := L.st;
				SELF.z5 := L.ZIP;
				SELF.SSN := L.SSN;
				SELF.DOB := (string)L.dob;
				SELF := L;
				SELF := [];
			END;

			//Removed the Constant parameters for soap input and added them as flags as in Roxie. GRP-2332

			layout_soap := RECORD
				DATASET(layout_in) batch_in;
				BOOLEAN IncludeBadChecks:= TRUE;
				BOOLEAN IncludeBribery:= TRUE;
				BOOLEAN IncludeBurglaryComm:= TRUE;
				BOOLEAN IncludeBurglaryRes:= TRUE;
				BOOLEAN IncludeBurglaryVeh:= TRUE;
				BOOLEAN IncludeComputer:= TRUE;
				BOOLEAN IncludeCounterfeit:= TRUE;
				BOOLEAN IncludeFraud:= TRUE;
				BOOLEAN IncludeIdTheft:= TRUE;
				BOOLEAN IncludeMVTheft:= TRUE;
				BOOLEAN IncludeRobberyComm:= TRUE;
				BOOLEAN IncludeRobberyRes:= TRUE;
				BOOLEAN IncludeShoplift:= TRUE;
				BOOLEAN IncludeStolenProp:= TRUE;
				BOOLEAN IncludeTheft:= TRUE;
				BOOLEAN IncludeAtLeast1Offense:= TRUE;
			END;

			layout_Soap trans(pii_base L) := TRANSFORM
				batch := PROJECT(L, make_batch_in(LEFT));
				SELF.batch_in := batch;
				self := L;
			END;

			soap_input := DISTRIBUTE(project(pii_base, trans(LEFT)),RANDOM() % nodes);
											
			xlayout := RECORD
				(layout_out)
				STRING errorcode;
			END;

			xlayout myFail(soap_input le) := TRANSFORM
				SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
				SELF := [];
			END;

			soap_results := soapcall( soap_input, 
									soap_host, 
									service_name,  
									{soap_input},
									DATASET(xlayout),
									PARALLEL(threads), 
									onFail(myFail(LEFT))
									)
									(offender_key<>'')
									;
			shared p	:=	dedup(project(soap_results,Transform(Layouts.Crim,self.record_id	:= (unsigned8)left.AcctNo,self:=left,self:=[])),record,all);

			//Assign record_ids to the crim appends

			shared Crim_recid_map	:= Join(Pii_Base_norm, P, left.record_id = right.record_id, Transform(Layouts.Crim, self.record_id	:=left.record_id_new,self:=right));

			//Assign fdn_file_info_ids

			shared Crim_base_map	:= Join(pii_input , Crim_recid_map, left.record_id=right.record_id,Transform(Layouts.Crim
																				,self.fdn_file_info_id	:= left.fdn_file_info_id
																				,self.fname_orig	:= left.fname
																				,self.mname_orig	:= left.mname
																				,self.lname_orig	:= left.lname
																				,self.ssn_orig		:= left.ssn
																				,self.dob_orig		:= left.dob
																				,self.did_orig		:= left.did
																				,self:=right)):independent;

			shared Crim_anon	:= Anonymize.Crim(Crim_base_map).all;

			Export orig		:= if(updatepii,dedup((Crim_base_map + Crim_orig),all),Crim_base_map);	// Non-Anonymzied file

			Export all			:= if(updatepii,dedup((Crim_anon + Crim_base),all),Crim_anon);
								
	END;

	EXPORT Death	:= MODULE

			service_name	:= 'batchservices.death_batchservice';
			serviceURL		:= riskwise.shortcuts.prod_batch_analytics_roxie;

			layout_in   := DeathV2_Services.Layouts.BatchIn;
			layout_out  := DeathV2_Services.Layouts.BatchOut;

			layoutSoap := record
				dataset(layout_in) batch_in;
				unsigned1 DPPAPurpose := 1;//Needs to be changed accordingly. 
				unsigned1 GLBPurpose := 5;//Needs to be changed accordingly. 
			end;

			layout_in make_batch_in(pii_base L) := TRANSFORM
				SELF.acctno := (string)l.record_id;
				SELF.Name_First := L.fname;
				SELF.Name_Middle := L.mname;
				SELF.Name_Last := L.lname;
				SELF.Name_suffix := L.name_suffix;
				SELF.prim_name := L.prim_name;
				SELF.prim_range := L.prim_range;
				SELF.sec_range := L.sec_range;
				SELF.St := L.st;
				SELF.z5 := L.ZIP;
				SELF.SSN := L.SSN;
				SELF.DOB := (string)L.dob;
				SELF := L;
				SELF := [];
			END;

			layoutSoap trans(pii_base L) := TRANSFORM
				batch := PROJECT(L, make_batch_in(LEFT));
				SELF.batch_in := batch;
				self := L;
			END;

			soap_input := DISTRIBUTE(project(pii_base, trans(LEFT)),RANDOM() % nodes);

			xlayout := RECORD
				(layout_out)
				STRING errorcode;
			END;

			xlayout myFail(soap_input le) := TRANSFORM
				SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
				SELF := [];
			END;

			soapResponse := soapcall( soap_input,
									serviceURL,
									service_name,
									{soap_input},
									DATASET(xlayout),
									PARALLEL(threads), 
									onFail(myFail(LEFT))
									)
									(matchcode<>'')
									;

			shared p	:=	dedup(project(soapResponse,Transform(Layouts.Death,self.record_id	:= (unsigned8)left.AcctNo,self:=left,self:=[])),record,all);

			//Assign record_ids to the death appends

			shared Death_recid_map	:= Join(Pii_Base_norm, P, left.record_id = right.record_id, Transform(Layouts.Death, self.record_id	:=left.record_id_new,self:=right));

			//Assign fdn_file_info_ids

			shared death_base_map	:= Join(pii_input ,Death_recid_map, left.record_id=right.record_id,Transform(Layouts.Death
																				,self.fdn_file_info_id	:= left.fdn_file_info_id,self.did_orig:=left.did,self:=right)):independent;

			//Anonymize if needed for a specific source
			shared Death_anon	:= Anonymize.Death(death_base_map).all;

			Export orig	:= if(updatepii,dedup((death_base_map + Death_orig),all),death_base_map);	//Non Anonymzie file

			Export all	:= if(updatepii,dedup((Death_anon + Death_base),all),Death_anon);	
					
	END;

	EXPORT IPMetaData	:= MODULE

			IpAppend	:= AppendIpMetadata.macAppendIPMetadata(pii_input,ip_address);

			pIpAppend	:= Project(IpAppend, Layouts.IPMetaData);

			Export All	:= If(UpdatePii, (pIpAppend + IpAppend_Base) , pIpAppend);

	END;

	EXPORT Advo	:= MODULE
		 
			Advo	:= Advo.mac_AppendADVO(pii_input,,prim_range,prim_name,addr_suffix,predir,postdir,sec_range,zip);

			pAdvo	:= Project(Advo, Layouts.Advo);

			Export All	:= If(UpdatePii, (pAdvo + Advo_Base) , pAdvo);
		 
	END;

	EXPORT DL_History	:= MODULE

		service_name	:= 'driversv2_services.batch_service';

		soap_host		:= riskwise.shortcuts.prod_batch_analytics_roxie;

		string DataRestriction := risk_indicators.iid_constants.default_DataRestriction;
		string DataPermission := risk_indicators.iid_constants.default_DataPermission; 
		layout_in := layouts.Drivers_Batch.layout_in;
		layout_out := layouts.Drivers_Batch.layout_out;

		layout_in make_batch_in(layout_in le, integer c) := TRANSFORM
				self.seq := c;
				self := le;			
				SELF := [];
		END;
					
		layout_soap := RECORD
			datapermissionmask :=DataPermission;
			string datarestrictionmask:= DataRestriction;
			BOOLEAN IncludeNonDMVSources := true;
			INTEGER DPPAPurpose:=1;
			INTEGER GLBPurpose:= 5;
			BOOLEAN return_current_only := false;
			DATASET(layout_in) batch_in;
		END;

		layout_Soap trans(layout_in L, integer c) := TRANSFORM
				batch := PROJECT(L, make_batch_in(LEFT, c));
				SELF.batch_in := batch;
				self := L;
		END;

		tr_inputs := project(pii_base, transform( layout_in , 
				SELF.did := LEFT.did;
				SELF.name_first := LEFT.fname;
				SELF.name_middle := LEFT.mname;
				SELF.name_last := LEFT.lname;
				SELF.name_suffix := LEFT.name_suffix;
				SELF.prim_range := LEFT.prim_range;
				SELF.predir := LEFT.predir;
				SELF.prim_name := LEFT.prim_name;
				SELF.addr_suffix := LEFT.addr_suffix;
				SELF.postdir := LEFT.postdir;
				SELF.unit_desig := LEFT.unit_desig;
				SELF.sec_range := LEFT.sec_range;
				SELF.p_city_name := LEFT.p_city_name;
				SELF.St := LEFT.st;
				SELF.z5 := LEFT.ZIP;
				SELF.SSN := LEFT.SSN;
				SELF.DOB := (string)LEFT.dob;
				SELF.homephone := LEFT.home_phone;
				SELF.workphone := LEFT.work_phone_;
				SELF.dl := LEFT.drivers_license;
				SELF.dlstate := LEFT.drivers_license_state;
				SELF := LEFT;
				SELF := [];		
		));

		ddp_inputs := DEDUP(tr_inputs, ALL);
		
		soap_input := DISTRIBUTE(project(ddp_inputs, trans(LEFT, counter)),RANDOM() % nodes);
					
					
		xlayout := RECORD
			(layout_out)
			STRING errorcode;
		END;


		xlayout myFail(soap_input le) := TRANSFORM
			SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
			SELF := [];
		END;			

		soap_results := soapcall( soap_input, 
			soap_host, 
			service_name,  
			{soap_input},
			DATASET(xlayout),
			PARALLEL(threads), 
			onFail(myFail(LEFT))
			)
			(errorcode='')
		;			

		shared p :=	dedup(project(soap_results,
			Transform(Layouts.DLHistory
				,self.did	:= (unsigned6)left.did
				,self:=left
				,self:=[])),record,all);

		//Assign record_ids to the DL History

		shared DLHistory_base_map	:=  Join( pii_input , P, 
											left.did = right.did, 
											Transform(Layouts.DLHistory
												,self.did := left.did												
												,self:=right)):independent;


		DLHistory_Update	:= if( UpdatePii,  dedup( DLHistory_base_map + DLHistory_Base, ALL ), dedup( DLHistory_base_map, ALL)  );


		Export all			:= DLHistory_Update;
	END;
	EXPORT Best_Info ( dataset(FraudGovPlatform.Layouts.DLHistory) DLHistory )		:= MODULE

			service_name	:= 'didville.did_batch_service_raw';
			soap_host		:= riskwise.shortcuts.prod_batch_analytics_roxie;

			layout_in   := didville.Layout_Did_InBatchRaw;
			layout_out  := didville.Layout_Did_OutBatch_Raw;
			

			string DataRestriction := risk_indicators.iid_constants.default_DataRestriction; // byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																							// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

			string DataPermission := risk_indicators.iid_constants.default_DataPermission; 
			
			
			layout_in make_batch_in(pii_base L) := TRANSFORM

					SELF.acctno := (string)L.record_id;
					SELF.did := (string)L.did;
					SELF := [];
			END;

			//Removed the Constant parameters for soap input and added them as flags as in Roxie. GRP-2332

			layout_soap := RECORD
				INTEGER ALLOWALL := 1;
				STRING120 APPENDS := 'BEST_ALL, VERIFY_ALL';				
				STRING APPENDTHRESHOLD := '';
				STRING APPLICATIONTYPE := '';
				STRING DATAPERMISSIONMASK := DataPermission;
				STRING DATARESTRICTIONMASK := DataRestriction;
				BOOLEAN DEDUPED := TRUE;
				DATASET(layout_in) did_batch_in;
				BOOLEAN GLBDATA := FALSE;
				INTEGER GLBPURPOSE := 5;
				BOOLEAN INCLUDEMINORS := TRUE;
				STRING5 INDUSTRYCLASS := '';
				UNSIGNED8 MAX_RESULTS_PER_ACCT := 1;
				BOOLEAN PATRIOTPROCESS := FALSE;
				STRING SSNMASK := '';
				STRING120 VERIFY := 'BEST_ALL, VERIFY_ALL';
				BOOLEAN INCLUDERANKING := FALSE;
			END;

			layout_Soap trans(pii_base L) := TRANSFORM
					batch := PROJECT(L, make_batch_in(LEFT));
					SELF.did_batch_in  := batch;
					self := L;
			END;

			soap_input := DISTRIBUTE(project(pii_base, trans(LEFT)),RANDOM() % nodes);
																			
			xlayout := RECORD
					(layout_out)
					STRING errorcode;
			END;

			xlayout myFail(soap_input le) := TRANSFORM
					SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
					SELF := [];
			END;

			soap_results := soapcall( soap_input, 
				soap_host, 
				service_name,  
				{soap_input},
				DATASET(xlayout),
				PARALLEL(threads), 
				onFail(myFail(LEFT))
				)
				// (errorcode='')
				;
			shared p	:=	dedup(project(soap_results,Transform(Layouts.BestInfo,
				self.record_id	:= (unsigned8)left.AcctNo,
				self.did	:= (unsigned6)left.did,
				self:=left,self:=[])),record,all);

			//Assign record_ids to the BestInfo appends

			shared BestInfo_recid_map	:= Join(Pii_Base_norm, P, left.record_id = right.record_id, Transform(Layouts.BestInfo, self.record_id	:=left.record_id_new,self:=right));

			//Assign fdn_file_info_ids

			shared BestInfo_base_map	:= Join(pii_input , BestInfo_recid_map, left.record_id=right.record_id,Transform(Layouts.BestInfo
													,self.did := left.did
													,self.reported_date := left.reported_date
													,self:=right)):independent;

			shared BestInfo_base_map2	:= Join(BestInfo_base_map , sort(DLHistory, -dt_last_seen), 
											left.did=right.did and
											(( 	(Unsigned8) left.reported_date[1..6] between right.dt_first_seen and right.dt_last_seen ) OR 
											(
												(Unsigned8) left.reported_date[1..6] >= right.dt_first_seen and 
												(Unsigned8) left.reported_date[1..6] >= right.dt_last_seen
											)),
											Transform(Layouts.BestInfo
													,self.best_drivers_license_state := right.orig_state
													,self.best_drivers_license := right.dl_number
													,self.best_drivers_license_exp := right.expiration_date
													,self.best_drivers_dt_first_seen := right.dt_first_seen
													,self.best_drivers_dt_last_seen := right.dt_last_seen
													,self:=left), 
													left outer,
													keep(1)):independent;			

			BestInfo_Update	:= if(UpdatePii,dedup((BestInfo_base_map2 + BestInfo_base),all),BestInfo_base_map2);

			

			Export all := BestInfo_Update;
								
	END;

	EXPORT PrepaidPhone	:= MODULE
		Phone_key := pull(PhonesInfo.Key_Phones_Type)(prepaid='1');
	//get transactions between phone vendor dates
		jPhone1 := join(distribute(Phone_key,hash(phone))
					,distribute(pii_input(home_phone<>''),hash(home_phone))
					,left.phone=right.home_phone
					and 
					((unsigned8)right.reported_date between left.vendor_first_reported_dt and left.vendor_last_reported_dt)				
					,Transform(Layouts.PrepaidPhone
							,self.phone:=right.home_phone
							,self.reported_date:=right.reported_date
							,self.vendor_first_reported_dt:=left.vendor_first_reported_dt
							,self.vendor_last_reported_dt :=left.vendor_last_reported_dt
							,self.prepaid := left.prepaid
							,self.record_id :=right.record_id
							,self.fdn_file_info_id	:=right.fdn_file_info_id
							,self:=right)
					,right outer,local);

		dPhone1 := dedup(sort(jPhone1(prepaid='1'),record_id,-vendor_last_reported_dt,local),record_id,local);
	//get remaining prepaid matches
		pii_input_2 := Join(pii_input(home_phone<>''),dPhone1,left.record_id=right.record_id,left only);

		jPhone2 := join(distribute(Phone_key,hash(phone))
								,distribute(pii_input_2,hash(home_phone))
								,left.phone=right.home_phone
								and 
								((unsigned8)right.reported_date >= left.vendor_first_reported_dt)				
								,Transform(Layouts.PrepaidPhone
										,self.phone:=right.home_phone
										,self.reported_date:=right.reported_date
										,self.vendor_first_reported_dt:=left.vendor_first_reported_dt
										,self.vendor_last_reported_dt :=left.vendor_last_reported_dt
										,self.prepaid := left.prepaid
										,self.record_id :=right.record_id
										,self.fdn_file_info_id	:=right.fdn_file_info_id
										,self:=right)
								,right outer,local);
								
		dPhone2 := dedup(sort(jPhone2(prepaid='1'),record_id,-vendor_last_reported_dt,local),record_id,local);

		Phone_final := dPhone1 + dPhone2;

		Export All	:= If(UpdatePii, dedup((Phone_final + PrepaidPhone_Base),all) , Phone_final);
		 
	END;
	
	 EXPORT BocaShell	:= Module
   	
   unsigned1 parallel_calls :=threads;  
   boolean FraudPointMode := true;
   boolean RemoveFares := false;	
   boolean LeadIntegrityMode := false; 
   string DataRestrictionMask := risk_indicators.iid_constants.default_DataRestriction;
   string DataPermissionMask  := risk_indicators.iid_constants.default_DataPermission; 
   string IntendedPurpose := '';  
   unsigned3 LastSeenThreshold := 0;	
   unsigned1 glba := 5;
   unsigned1 dppa := 1;
   boolean RetainInputDID := True; 
   layout_input := RECORD
       STRING Account;
       STRING FirstName;
       STRING MiddleName;
       STRING LastName;
       STRING StreetAddress;
       STRING City;
       STRING State;
       STRING Zip;
       STRING HomePhone;
       STRING SSN;
       STRING DateOfBirth;
       STRING WorkPhone;
       STRING income;  
       string DLNumber;
       string DLState;			
       string BALANCE; 
       string CHARGEOFFD; 
       string FormerName;
       string EMAIL;  
       string employername;
       string historydate;
       string IPAddr;
    		string LexID; 
   		unsigned8 record_id;
   		unsigned6 fdn_file_info_id;
    END;
   bs_service := 'risk_indicators.boca_shell';  
   roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; 
	 
   ds_in := Project(pii_input,Transform(layout_input,
   						   self.Account :=(string)left.record_id
   							,self.FirstName :=left.fname
   							,self.MiddleName :=left.mname
   							,self.LastName :=left.lname
   							,self.StreetAddress :=left.address_1
   							,self.City :=left.p_city_name
   							,self.State :=left.st
   							,self.Zip :=left.zip
   							,self.HomePhone :=left.home_phone
   							,self.SSN :=left.ssn
   							,self.DateOfBirth :=left.dob
   							,self.WorkPhone :=left.work_phone_
   							,self.income :=''
   							,self.DLNumber :=left.drivers_license
   							,self.DLState :=left.drivers_license_state
   							,self.BALANCE :='' 
   							,self.CHARGEOFFD :='' 
   							,self.FormerName :=''
   							,self.EMAIL :=left.email_address  
   							,self.employername :=''
   							,self.historydate :=left.reported_date
   							,self.IPAddr :=left.ip_address
   							,self.LexID :=(string)left.did
   							,self.record_id						:=left.record_id
   							,self.fdn_file_info_id		:=left.fdn_file_info_id
   							,self:=left));
   ds_input := ds_in;
  
	l := RECORD
		string old_account_number;
    Risk_Indicators.Layout_InstID_SoapCall;
   END;
	
	l assignAccount (ds_input le, INTEGER c) := TRANSFORM
		self.old_account_number := le.Account;
		SELF.AccountNumber := (string)c;
    SELF.GLBPurpose  := glba;
    SELF.DPPAPurpose := dppa;
   	self.retainInputDID := RetainInputDID;
   	self.did := le.LexID; 
   self.historydateyyyymm := map(
   		regexfind('^\\d{8} \\d{8}$', le.historydate) => (unsigned)le.historydate[..6],
   		regexfind('^\\d{8}$',        le.historydate) => (unsigned)le.historydate[..6],
   		                                                (unsigned)le.historydate
   );
     self.historyDateTimeStamp := map(
         le.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
   			regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
   			regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',
   			regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',		
   			                                                le.historydate
   	);
     SELF.IncludeScore := true;
     SELF.datarestrictionmask := datarestrictionmask;
    SELF.datapermissionmask := datapermissionmask;
    SELF.FraudPointMode := FraudPointMode;
    SELF.RemoveFares := RemoveFares;
   SELF.LeadIntegrityMode := LeadIntegrityMode;
    SELF.LastSeenThreshold := LastSeenThreshold;
   	self.bsversion := 55;	
   	tmx_gw := riskwise.shortcuts.gw_threatmetrix;
    self.gateways := project(tmx_gw, transform(Gateway.Layouts.Config, self := left, self := []) );   //dev TMX gateway
		self.TurnOffTumblings := true; 
   	SELF := le;
    SELF := [];
   END;
   p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
   s := BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                  bs_service, roxieIP, parallel_calls,nodes);
																									

		riskprocessing.layouts.layout_internal_shell getold(s le, l ri) :=	TRANSFORM
			SELF.AccountNumber := ri.old_account_number;
			SELF := le;
		END;

	 res := JOIN (distribute(s,hash(seq))
						,distribute(p_f,hash((unsigned)accountnumber)),LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT),local);	
						
   isFCRA := false;
   Shell_Out := FraudGovPlatform.fn_BocaShell_ToRin(res, isFCRA, DataRestrictionMask, IntendedPurpose);
	 
	 Base_Map := Join(distribute(Shell_Out,hash(record_id)),
										distribute(Pii_Input,hash(record_id)),left.record_id=right.record_id
											,Transform(recordof(left),self.fdn_file_info_id:=right.fdn_file_info_id,self:=left),local);
	 
	 Export All := If(UpdatePii, dedup((Base_Map + BocaShell_Base),all) , dedup(Base_Map,all));
   END;

END;