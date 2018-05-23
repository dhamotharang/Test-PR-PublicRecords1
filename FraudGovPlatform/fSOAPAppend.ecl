Import FraudShared,riskwise,risk_indicators,data_services,CriminalRecords_BatchService,DeathV2_Services;
EXPORT fSOAPAppend	:= MODULE

Shared nodes				:= thorlib.nodes();
Shared threads			:= 2;

Shared base := Fraudshared.Files().Base.Main.qa;

Shared pii_base	:= Files().base.pii.built;

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
											,self.ssn										:=left.ssn
											,self.dob										:=left.dob
											,self.drivers_license				:=left.drivers_license
											,self.drivers_license_state	:=left.drivers_license_state
											,self.home_phone						:=left.clean_phones.phone_number
											,self.work_phone						:=left.clean_phones.work_phone
											,self.ip_address						:=left.ip_address				
											,self												:=left)
									);

		pdist:=distribute(pbase(did>0),hash(did));
	Export All :=dedup(pdist,record,all);
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
		string10 ExactMatchLevel := 	false;
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
	SELF.work_Phone := le.work_phone;
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

p:=project(soap_results,Layouts.CIID);

Export All	:= p;

END;

EXPORT Crim		:= MODULE

service_name	:= 'criminalrecords_batchservice.batchservice';
soap_host		:= riskwise.shortcuts.prod_batch_analytics_roxie;

layout_in   := CriminalRecords_BatchService.Layouts.batch_in;
layout_out  := CriminalRecords_BatchService.Layouts.batch_out;

//FraudGov only retunring the records for following crim categories. Per GRP-247
#CONSTANT('includebadchecks', TRUE);
#CONSTANT('includebribery', TRUE);
#CONSTANT('ncludeburglarycomm', TRUE);
#CONSTANT('ncludeburglaryres', TRUE);
#CONSTANT('ncludeburglaryveh', TRUE);
#CONSTANT('ncludecomputer', TRUE);
#CONSTANT('ncludecounterfeit', TRUE);
#CONSTANT('ncludefraud', TRUE);
#CONSTANT('ncludeidtheft', TRUE);
#CONSTANT('ncludemvtheft', TRUE);
#CONSTANT('ncluderobberycomm', TRUE);
#CONSTANT('ncluderobberyres', TRUE);
#CONSTANT('ncludeshoplift', TRUE);
#CONSTANT('ncludestolenprop', TRUE);
#CONSTANT('ncludetheft', TRUE);
#CONSTANT('ncludetraffic', TRUE);


layout_in make_batch_in(pii_base L) := TRANSFORM
	SELF.acctno := '1';
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

soap_input := DISTRIBUTE(project(pii_base, make_batch_in(left)),RANDOM() % nodes);

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
						HEADING('<batch_in><Row>','</Row></batch_in>'),
						PARALLEL(threads), 
						onFail(myFail(LEFT))
						)
						(offender_key<>'')
						;
Export All := Project(soap_results,Layouts.Crim);
									
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
	SELF.acctno := '1';
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
						(matchcode<>'',errorcode='')
						;
Export All := Project(soapResponse,Layouts.Death);
						
END;

END;