Import FraudShared,riskwise,risk_indicators,data_services,CriminalRecords_BatchService,DeathV2_Services,models,AppendIpMetadata,std;
EXPORT fSOAPAppend(boolean	UpdatePii   = _Flags.Update.Pii)	:= MODULE

Shared nodes				:= thorlib.nodes();
Shared threads			:= 2;

//PII Input Process Begin

Shared base := Files().Base.Main_Orig.built;

shared pii_current := Files().base.pii.built; //pii current build

shared pii_previous := Files().base.pii.qa;			//pii previous build

shared pii_updates := Join(pii_current,pii_previous,left=right,left only); //pii updates

Shared pii_input	:= if(UpdatePii,pii_updates,pii_current); 

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
															,self.record_id_new := right.record_id,self:=left));		

//PII Input Process End


shared ciid_base				:= Files().base.ciid.qa;

shared crim_base				:= Files().base.crim.qa;

shared death_base 			:= Files().base.death.qa;

shared fraudpoint_base	:= Files().base.fraudpoint.qa;

shared IpAppend_Base		:= Files().base.IpMetaData.qa;

//original soap output files

shared ciid_orig				:= Files().base.ciid_orig.built;

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
											,self.prim_name							:=left.clean_address.prim_name
											,self.prim_range						:=left.clean_address.prim_range
											,self.sec_range							:=left.clean_address.sec_range
											,self.st										:=left.clean_address.st
											,self.zip										:=left.clean_address.zip
											,self.ssn										:=left.clean_ssn
											,self.dob										:=left.clean_dob
											,self.drivers_license				:=left.drivers_license
											,self.drivers_license_state	:=left.drivers_license_state
											,self.home_phone						:=left.clean_phones.phone_number
											,self.work_phone_						:=left.clean_phones.work_phone
											,self.ip_address						:=left.ip_address
											,self.record_id							:=left.record_id
											,self.fdn_file_info_id			:=left.classification_Permissible_use_access.fdn_file_info_id
											,self												:=left)
									);

		pdist:=distribute(pbase(did>0),hash(record_id));
			 
	 Export All := pdist;
	 
End;

EXPORT CIID		:= MODULE

service_name	:= 'risk_indicators.InstantID_batch';
serviceURL		:= riskwise.shortcuts.prod_batch_analytics_roxie;

string DataRestriction := '00000000000000'; // byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																						// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
string pModel := 'FP1109_0' ;

layout_out:=risk_indicators.Layout_InstantID_NuGen_Denorm;

in_format := record
	risk_indicators.Layout_Batch_In;
	string6 Gender := '';
	string44 PassportUpperLine := '';
	string44 PassportLowerLine := '';
	STRING5 Grade := '';
	string16 Channel := '';
	string8 Income := '';
	string16 OwnOrRent := '';
	string16 LocationIdentifier := '';
	string16 OtherApplicationIdentifier := '';
	string16 OtherApplicationIdentifier2 := '';
	string16 OtherApplicationIdentifier3 := '';
	string8 DateofApplication := '';//https://hpccsystems.com/bb/viewforum.php?f=8
	string8 TimeofApplication := '';
	string50 email := '';
end;

layoutSoap := record
		dataset(in_format) batch_in;
		unsigned1 DPPAPurpose := 1;   //CHANGE ACCORDINGLY
		unsigned1 GLBPurpose := 1;    //CHANGE ACCORDINGLY
		STRING5 IndustryClass := '';
		boolean LnBranded  := false;
		boolean OfacOnly := false ;
		unsigned3 HistoryDateYYYYMM := 999999;
		boolean PoBoxCompliance := false;
		boolean ExcludeWatchLists := false;
		unsigned1 OFACversion :=1 ;
		boolean IncludeAdditionalWatchlists := false;
		boolean IncludeOfac := false;
		real GlobalWatchlistThreshold :=.84 ;
		boolean IncludeFraudScores := true;
		boolean IncludeRiskIndices := true ;
		boolean UseDobFilter := false;
		integer2 DobRadius := 2 ;
		unsigned1 RedFlag_version := 0 ;
		boolean RedFlagsOnly := false ;
		boolean IncludeDLVerification  := true;
		string Model := pModel;
		boolean IncludeTargusE3220 := false ;
		string50 DataRestrictionMask :=  DataRestriction;
		boolean ExactFirstNameMatch := false;
		boolean ExactLastNameMatch := false ;
		boolean ExactAddrMatch := false ;
		boolean ExactPhoneMatch := false;
		boolean ExactSSNMatch := false;
		boolean ExactDOBMatch := false ;
		boolean ExactDriverLicenseMatch := false;
		boolean ExactFirstNameMatchAllowNicknames  := false;
		string10 ExactMatchLevel := risk_indicators.iid_constants.default_ExactMatchLevel;  // default to using the scoring thresholds.
		boolean   IncludeAllRiskIndicators := true;
		unsigned1 NumReturnCodes :=  risk_indicators.iid_constants.DefaultNumCodes;
		string15  DOBMatchType := '';
		unsigned1 DOBMatchYearRadius := 0	;
		boolean suppressNearDups := false;
		boolean require2ele := false;
		boolean fromBiid := false;
		boolean isFCRA := false;
		boolean	nugen := true;
		boolean	inCalif := false;
		boolean	fdReasonsWith38 := false;
		boolean OFAC := true; 
		boolean Include_ALL_Watchlist:= false ;
		boolean Include_BES_Watchlist:= false ;
		boolean Include_CFTC_Watchlist:= false ;
		boolean Include_DTC_Watchlist:= false;
		boolean Include_EUDT_Watchlist:= false ;
		boolean Include_FBI_Watchlist:= false ;
		boolean Include_FCEN_Watchlist:= false;
		boolean Include_FAR_Watchlist:= false ;
		boolean Include_IMW_Watchlist:= false;
		boolean Include_OFAC_Watchlist:= false ;
		boolean Include_OCC_Watchlist:= false ;
		boolean Include_OSFI_Watchlist:= false ;
		boolean Include_PEP_Watchlist:= false ;
		boolean Include_SDT_Watchlist:= false;
		boolean Include_BIS_Watchlist:= false ;
		boolean Include_UNNT_Watchlist:= false ;
		boolean Include_WBIF_Watchlist:= false ;
End;

in_format make_batch_in(pii_base le, integer c) := TRANSFORM
	self.seq := c;
	self.AcctNo	:= (string)le.record_id;
	SELF.Name_First := le.fname;
	SELF.Name_Middle := le.mname;
	SELF.Name_Last := le.lname;
	SELF.Name_suffix := le.name_suffix;
	SELF.prim_name := le.prim_name;
	SELF.prim_range := le.prim_range;
	SELF.sec_range := le.sec_range;
	SELF.St := le.st;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.home_phone;
	SELF.work_Phone := le.work_phone_;
	SELF.SSN := le.SSN;
	SELF.DOB := (string)le.dob;
	SELF.DL_Number := le.drivers_license;
	SELF.DL_State := le.drivers_license_state;
	SELF.ip_addr := le.ip_address;
	SELF := le;
	SELF := [];
END;

layoutSoap make_rv_in(pii_base le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
END;

soap_in := DISTRIBUTE(project(pii_base, make_rv_in(LEFT, counter)),RANDOM() % nodes);

xlayout := RECORD
	(layout_out)
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
	SELF := [];
END;

soap_results := soapcall(	soap_in,
						serviceURL,
						service_name,
						{soap_in}, 
						DATASET(xlayout),
						PARALLEL(threads), 
						onFail(myFail(LEFT))
						)
						// (errorcode='')
						;


shared p	:=	dedup(project(soap_results,Transform(Layouts.CIID,self.record_id	:= (unsigned8)left.AcctNo,self:=left,self:=[])),record,all);

//Assign record_ids to the ciid appends

shared ciid_recid_map	:= Join(Pii_Base_norm, P, left.record_id = right.record_id, Transform(Layouts.CIID, self.record_id	:=left.record_id_new,self:=right));

//Assign fdn_file_info_ids
shared ciid_base_map	:= Join(pii_input ,ciid_recid_map, left.record_id=right.record_id,Transform(Layouts.Ciid
																	,self.fdn_file_info_id	:= left.fdn_file_info_id,self:=right));

//Anonymize if needed for a specific source

shared ciid_anon	:= Anonymize.ciid(ciid_base_map).all;

Export orig	:= if(updatepii,dedup((ciid_base_map + ciid_orig),all),ciid_base_map); //Non Anonymzie file

Export all		:= if(updatepii,dedup((ciid_anon + ciid_base),all),ciid_anon);

END;

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
																	,self:=right));

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
	unsigned1 GLBPurpose := 1;//Needs to be changed accordingly. 
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
																	,self.fdn_file_info_id	:= left.fdn_file_info_id,self:=right));

//Anonymize if needed for a specific source
shared Death_anon	:= Anonymize.Death(death_base_map).all;

Export orig	:= if(updatepii,dedup((death_base_map + Death_orig),all),death_base_map);	//Non Anonymzie file

Export all	:= if(updatepii,dedup((Death_anon + Death_base),all),Death_anon);	
				
END;

EXPORT FraudPoint	:= MODULE

service_name	:= 'Models.FraudAdvisor_Batch_Service';
serviceURL		:= riskwise.shortcuts.prod_batch_analytics_roxie;

string DataRestriction := '00000000000000'; // byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
									// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
string pModel := 'FP31505_0' ;

//===================  options  ==============================================================
boolean 	includeV1 			:= true;  //set to 'true' to request version 1 attributes, else set to 'false'
boolean   includeV2 			:= true;	//set to 'true' to request version 2 attributes, else set to 'false'
unsigned1 redflags 			:= 1;		//set to 1 to request red flags, else set to 0
//============================================================================================

layout_out:= models.Layout_FD_Batch_Out;

layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING ModelName;
	STRING DataRestrictionMask;
	INTEGER DPPAPurpose;
	INTEGER GLBPURPOSE;
	BOOLEAN IncludeVersion1;
	BOOLEAN IncludeVersion2;
	UNSIGNED1 RedFlag_version;
END;

Risk_Indicators.Layout_Batch_In make_batch_in(pii_base le, integer c) := TRANSFORM
	self.seq := c;
	self.acctno := (string)le.record_id;
	SELF.Name_First := le.fname;
	SELF.Name_Middle := le.mname;
	SELF.Name_Last := le.lname;
	SELF.Name_suffix := le.name_suffix;
	SELF.prim_name := le.prim_name;
	SELF.prim_range := le.prim_range;
	SELF.sec_range := le.sec_range;
	SELF.St := le.st;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.home_phone;
	SELF.work_Phone := le.work_phone_;
	SELF.SSN := le.SSN;
	SELF.DOB := (string)le.dob;
	SELF.DL_Number := le.drivers_license;
	SELF.DL_State := le.drivers_license_state;
	SELF.ip_addr := le.ip_address;
	self.historydateyyyymm := 999999;  //to run with current date
	SELF := le;
	SELF := [];
END;

layout_soap_input make_fp_in(pii_base le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', serviceURL}], risk_indicators.layout_gateways_in);
	SELF.ModelName := pModel;
	SELF.DataRestrictionMask := DataRestriction; 
	SELF.DPPAPurpose := 1;
	SELF.GLBPURPOSE := 1;
	SELF.IncludeVersion1 := includeV1;   
	SELF.IncludeVersion2 := includeV2;		
	SELF.RedFlag_version := redflags;			
END;

soap_in := DISTRIBUTE(project(pii_base, make_fp_in(LEFT, counter)),RANDOM() % nodes);

xlayout := RECORD
	layout_out;
	STRING errorcode; 
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
	SELF := [];
END;

soap_results := soapcall(	soap_in,
						serviceURL,
						service_name,
						{soap_in}, 
						DATASET(xlayout),
						PARALLEL(threads), 
						onFail(myFail(LEFT))
						)
						// (errorcode='')
						;
						
shared fp	:= dedup(project(soap_results	,Transform(Layouts.FraudPoint
																	,self.record_id	:=(unsigned8)left.acctno
																	,self:=left,self:=[])),record,all);

//Assign record_ids to the fraudpoint appends

shared Fp_recid_map	:= Join(Pii_Base_norm, fP, left.record_id = right.record_id, Transform(Layouts.FraudPoint, self.record_id	:=left.record_id_new,self:=right));

//Assign fdn_file_info_ids

shared Fp_base_map	:= Join(pii_input ,Fp_recid_map, left.record_id=right.record_id,Transform(Layouts.FraudPoint,
																	self.did:=left.did,self.fdn_file_info_id	:= left.fdn_file_info_id,self:=right));
																	

Fp_combine	:= dedup((Fp_base_map + fraudpoint_base),all);

Export all		:= if(updatepii, Fp_combine,Fp_base_map);	 

END;

EXPORT IPMetaData	:= MODULE

IpAppend	:= AppendIpMetadata.macAppendIPMetadata(pii_input,ip_address);

pIpAppend	:= Project(IpAppend, Layouts.IPMetaData);

Export All	:= If(UpdatePii, (pIpAppend + IpAppend_Base) , pIpAppend);

END;

END;