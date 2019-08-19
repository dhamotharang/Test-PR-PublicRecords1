/*--SOAP--
<message name="ProspectSurvival_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="Version" type="xsd:integer"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO--Prospect Survival Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
			&lt;LexID&gt;&lt;/LexID&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;p_City_name&gt;&lt;/p_City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
      &lt;DL_Number&gt;&lt;/DL_Number&gt;
      &lt;DL_State&gt;&lt;/DL_State&gt;
      &lt;Home_Phone&gt;&lt;/Home_Phone&gt;
      &lt;Work_Phone&gt;&lt;/Work_Phone&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import address, risk_indicators, models, riskwise, ut, gateway, STD;


export ProspectSurvival_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

batchin := dataset([],Models.layouts.Layout_LeadIntegrity_Batch_In) 			: stored('batch_in',few);
gateways := Gateway.Constants.void_gateway;

unsigned1 dppa := 0 		: stored('DPPAPurpose');
unsigned1 glb := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
unsigned1 version := 1      : stored('Version');
string ModelName_in := '' : stored('ModelName');
model_name := STD.Str.ToLowerCase( modelname_in );
string5   industry_class_val := '';
boolean   isUtility := false;
boolean   ofac_Only := false;
boolean   ofacSearching := false;
boolean   excludewatchlists := true;

string   DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

bsOptions := risk_Indicators.iid_constants.BSOptions.IncludeDoNotmail;

bsVersion := 4;

// add sequence to matchup later to add acctno to output
Models.layouts.Layout_LeadIntegrity_Batch_In into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));

unsigned3 history_date := 999999 		: stored('HistoryDateYYYYMM');

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');

Risk_Indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
	self.did 		:= le.LexId;
	self.score := if(le.lexid<>0, 100, 0);  // hard code the DID score to 100 if DID is passed in on input

	// clean up input
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	self.seq := le.seq;	
	self.ssn := IF(le.ssn='000000000','',le.ssn);	// blank out social if it is all 0's
	self.dob := dob_val;
	self.age := if ((integer)dob_val != 0,(STRING3)ut.Age((integer)dob_val), '');
	
	self.phone10 := le.Home_Phone;
	self.wphone10 := le.Work_Phone;
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.fname := STD.Str.touppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	self.lname := STD.Str.touppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	self.mname := STD.Str.touppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	self.suffix := STD.Str.touppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	self.title := STD.Str.touppercase(if(valid_cleaned, cleaned_name[1..5],''));

	street_address := le.street_addr;
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
		
	self.prim_range := Address.CleanFields(clean_addr).prim_range;
	self.predir := Address.CleanFields(clean_addr).predir;
	self.prim_name := Address.CleanFields(clean_addr).prim_name;
	self.addr_suffix := Address.CleanFields(clean_addr).addr_suffix;
	self.postdir := Address.CleanFields(clean_addr).postdir;
	self.unit_desig := Address.CleanFields(clean_addr).unit_desig;
	self.sec_range := Address.CleanFields(clean_addr).sec_range;
	self.p_city_name := Address.CleanFields(clean_addr).p_city_name;
	self.st := Address.CleanFields(clean_addr).st;
	self.z5 := Address.CleanFields(clean_addr).zip;
	self.zip4 := Address.CleanFields(clean_addr).zip4;
	self.lat := Address.CleanFields(clean_addr).geo_lat;
	self.long := Address.CleanFields(clean_addr).geo_long;
	self.addr_type := Address.CleanFields(clean_addr).rec_type[1];
	self.addr_status := Address.CleanFields(clean_addr).err_stat;
	self.county := Address.CleanFields(clean_addr).county[3..5]; // we only want the county fips, not all 5.  first 2 are the state fips
	self.geo_blk := Address.CleanFields(clean_addr).geo_blk;
	
	self.dl_number := STD.Str.touppercase(dl_num_clean);
	self.dl_state := STD.Str.touppercase(le.dl_state);
	
	self.historydate := if(le.historydateyyyymm=0, history_date, le.historydateyyyymm) ;
	self := [];
END;
cleanIn := project(batchinseq, into_in(left));

// set variables for passing to bocashell function
boolean 	require2ele := false;
boolean   isLn := false;	// not needed anymore

boolean   doRelatives := true;
boolean   doDL := false;
boolean   doVehicle := false;
boolean   doDerogs := true;
boolean   suppressNearDups := false;
boolean   fromBIID := false;
boolean   isFCRA := false;
boolean   fromIT1O := false;
boolean   doScore := false;
boolean   nugen := true;
// for ITA, we can't use FARES Data, so filter that out of the property searching
boolean 	filter_out_fares := True;  

iid := risk_indicators.InstantID_Function(cleanIn, gateways, dppa, glb, isUtility, isLn, ofac_only, 
								suppressNearDups, require2Ele, fromBIID, isFCRA, excludewatchlists, fromIT1O, 
								in_BSversion := bsVersion,in_DataRestriction:=DataRestriction,in_DataPermission:=DataPermission,
                                LexIdSourceOptout := LexIdSourceOptout, 
                                TransactionID := TransactionID, 
                                BatchUID := BatchUID, 
                                GlobalCompanyID := GlobalCompanyID);

clam := risk_indicators.Boca_Shell_Function(iid, gateways, dppa, glb, isUtility, isLn, doRelatives, doDL, 
								doVehicle, doDerogs, bsVersion, doScore, nugen, filter_out_fares,DataRestriction:=DataRestriction, BSOptions:=bsOptions, 
								DataPermission:=DataPermission,
                                LexIdSourceOptout := LexIdSourceOptout, 
                                TransactionID := TransactionID, 
                                BatchUID := BatchUID, 
                                GlobalCompanyID := GlobalCompanyID);

LeadIntegrity := Models.get_LeadIntegrity_Attributes(clam,version);
 

ProspectSurvival_layout := Record
  string30 acctNo;
	string3 addrs_15yr;
	string5 avg_lres;
	string1 bankrupt;
	string3 crim_rel_within25miles;
	string1 income_level;
	string5 inq_count24;
	string5 inq_highriskcredit;
	string5 inq_mortgage;
	string5 paw_business_count;
	string1 rc_altlname1_flag;
	string3 rel_educationunder8_count;
	string3 ssns_per_addr;
	string3 unrel_liens;
	string20 add1_avm_automated_valuation_2;
	string3 attr_eviction_count60;
	string3 attr_total_number_derogs;
	string6 avg_mo_per_addr;
	string5 gong_did_phone_ct;
	string3 liens_historical_unreleased_ct;
	string13 property_owned_assessed_total;
	string3 rel_felony_count;
	string3 rel_incomeunder25_count;
	string3 rel_prop_owned_count;
	string1 presence_of_a_foreclosure;
	string10 CurrAddrMedianIncome;
	string5 InputAddrCountyIndex;
	string2 LiensUnreleasedCount;
	string2 NumSrcsConfirmIDAddr;
	string2 PrevAddrConfScore;
	string10 PrevAddrMedianHomeVal;
	string1 SSNIssued;
	string2 SSNPerID;
	string1 WealthIndex;
	string1 DoNotMail;
	string8 MostRecentUnrelDate;
	string8 HighIssueDate;
	string1 MostRecentBankruptType;
	string1 InputAddrCurrAddrMatch;
	string4 TimeSinceSubjectphone1stSeen;
	string2 AddrPerSsn;
	string1 AddrStability;
	string2 LastName36;
	string1 InputAddrDwellType;
	string2 SsnPerAddr;
	string1 InputAddrFamilyOwned;
	string4 TimeSincePrevAddrDate1stSeen;
	string1 InputAddrActivePhoneList;
	string2 IdPerSfduAddr;
	string1 PrevAddrActivePhoneList;
	string10 PrevAddrMedianIncome;
  string3 score1;
	end;


ProspectSurvival_layout into_prospect(clam le, LeadIntegrity ri) := TRANSFORM
    self.acctNo													:= (string)le.seq;
		self.addrs_15yr											:= (string)le.other_address_info.addrs_last_15years;
		self.avg_lres												:= (string)le.other_address_info.avg_lres;
		self.bankrupt												:=  if(le.bjl.bankrupt, '1', '0');
		self.crim_rel_within25miles					:= (string)le.relatives.criminal_relative_within25miles;
		self.income_level										:= (string)le.student.income_level_code;
		self.inq_count24										:= (string)le.acc_logs.inquiries.count24;
		self.inq_highriskcredit							:= (string)le.acc_logs.highriskcredit.counttotal;
		self.inq_mortgage										:= (string)le.acc_logs.mortgage.counttotal;
		self.paw_business_count							:= (string)le.employment.business_ct;
		self.rc_altlname1_flag							:= (string)le.iid.altlastpop;
		self.rel_educationunder8_count			:= (string)le.relatives.relative_educationunder8_count;
		self.ssns_per_addr									:= (string)le.velocity_counters.ssns_per_addr;
		self.unrel_liens										:= (string)le.bjl.liens_unreleased_count30 ; 
		self.add1_avm_automated_valuation_2	:= (string)le.avm.input_address_information.avm_automated_valuation2;
		self.attr_eviction_count60					:= (string)le.bjl.eviction_count60;
		self.attr_total_number_derogs				:= (string)le.total_number_derogs;
		self.avg_mo_per_addr								:= (string)le.address_history_summary.avg_mo_per_addr;
		self.gong_did_phone_ct							:= (string)le.phone_verification.gong_did.gong_did_phone_ct;
		self.liens_historical_unreleased_ct	:= (string)le.bjl.liens_historical_unreleased_count; 
		self.property_owned_assessed_total	:= (string)le.address_verification.owned.property_owned_assessed_total;
		self.rel_felony_count								:= (string)le.relatives.relative_felony_count;
		self.rel_incomeunder25_count				:= (string)le.relatives.relative_incomeunder25_count;
		self.rel_prop_owned_count						:= (string)le.relatives.owned.relatives_property_count;
		self.presence_of_a_foreclosure			:= iF(le.bjl.foreclosure_flag,'1', '0');  
		self.CurrAddrMedianIncome						:= (string)ri.CurrAddrMedianIncome;
		self.InputAddrCountyIndex						:= (string)ri.InputAddrCountyIndex;
		self.LiensUnreleasedCount						:= (string)ri.LiensUnreleasedCount;
		self.NumSrcsConfirmIDAddr						:= (string)ri.NumSrcsConfirmIDAddr;
		self.PrevAddrConfScore							:= (string)ri.PrevAddrConfScore;
		self.PrevAddrMedianHomeVal					:= (string)ri.PrevAddrMedianHomeVal;
		self.SSNIssued											:= (string)ri.SSNIssued;
		self.SSNPerID												:= (string)ri.SSNPerID;
		self.WealthIndex										:= (string)ri.WealthIndex;
		self.DoNotMail                			:= if(le.iid.iid_flags & (1<<risk_indicators.iid_constants.IIDFlag.IsDoNotMail)>0,'1','0');
		self.MostRecentUnrelDate  					:= (string)ri.MostRecentUnrelDate;
		self.HighIssueDate  								:= (string)ri.HighIssueDate;
		self.MostRecentBankruptType 				:= (string)ri.MostRecentBankruptType;   
		self.InputAddrCurrAddrMatch				  := (string)ri.InputAddrCurrAddrMatch;   
		self.TimeSinceSubjectphone1stSeen		:= (string)ri.TimeSinceSubjectPhoneFirstSeen;
		self.AddrPerSsn											:= (string)ri.AddrPerSsn;
		self.AddrStability									:= (string)ri.AddrStability;
		self.LastName36											:= (string)ri.LastNames36;
		self.InputAddrDwellType							:= (string)ri.InputAddrDwellType;
		self.SsnPerAddr											:= (string)ri.SsnPerAddr;
		self.InputAddrFamilyOwned						:= (string)ri.InputAddrFamilyOwned;
		self.TimeSincePrevAddrDate1stSeen		:= (string)ri.TimeSincePrevAddrDateFirstSeen;
		self.InputAddrActivePhoneList				:= (string)ri.InputAddrActivePhoneList;
		self.IdPerSfduAddr									:= (string)ri.IdPerSfduAddr;
		self.PrevAddrActivePhoneList				:= (string)ri.PrevAddrActivePhoneList;
		self.PrevAddrMedianIncome						:= (string)ri.PrevAddrMedianIncome;
		self 																:= [];
end;	
	

//join clam and lead ind
with_ACCTNO := join(clam, LeadIntegrity, (string)left.seq=(string)right.seq, into_prospect(left,right),keep(1));

model := case( trim(model_name),
	'anmk909_0' => ungroup(Models.ANMK909_0_1( clam )),
	''          => dataset( [], Models.Layout_ModelOut ),
	fail( Models.Layout_ModelOut, 'Invalid model name requested' )
);

ProspectSurvival_layout addScore( with_ACCTNO le, model ri ) := TRANSFORM
	self.score1 := ri.score;
	// self.scorename1 := ?
	self := le;
end;

with_model := join( with_ACCTNO, model, (integer)left.acctno=right.seq, addScore(left,right), left outer );

doNotMail_opt := project(with_model(DoNotMail='1'), 
													transform(ProspectSurvival_layout,
																		self.acctNo := left.acctNo, 
																		self.DoNotMail := left.DoNotMail, self := []));
reg_Mail_opt := project(with_model(DoNotMail='0'), 
													transform(ProspectSurvival_layout,self := left));

after_dnm := doNotMail_opt + reg_Mail_opt;

with_model_input := join(after_dnm, batchinseq, (integer)left.acctno=right.seq, 
												transform(ProspectSurvival_layout, 
																	self.acctno := right.acctno,
																	self.DoNotMail := left.DoNotMail,
																	self := left), left outer);
	
output(with_model_input, named('Results'));


ENDMACRO;

