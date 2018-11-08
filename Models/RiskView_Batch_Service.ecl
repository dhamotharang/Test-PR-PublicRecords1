/*--SOAP--
<message name="RiskView Batch Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="IncludeAllScores" type="xsd:boolean"/>
	<part name="IncludeAllAttributes" type="xsd:boolean"/>
	<part name="IncludeScoresAttributes" type="xsd:boolean"/>
	<part name="IncludeAuto" type="xsd:boolean"/>
	<part name="IncludeBankcard" type="xsd:boolean"/>
	<part name="IncludeRetail" type="xsd:boolean"/>
	<part name="IncludeTelecom" type="xsd:boolean"/>
	<part name="IncludeMoney" type="xsd:boolean"/>
	<part name="IncludePreScreen" type="xsd:boolean"/>
	<part name="IncludeLifestyle" type="xsd:boolean"/>
	<part name="IncludeDemographic" type="xsd:boolean"/>
	<part name="IncludeFinancial" type="xsd:boolean"/>
	<part name="IncludeProperty" type="xsd:boolean"/>
	<part name="IncludeDerogatory" type="xsd:boolean"/>
	<part name="IncludeVersion2" type="xsd:boolean"/>
	<part name="IncludeVersion3" type="xsd:boolean"/>
	<part name="IncludeVersion4" type="xsd:boolean"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="AlternateModel" type="xsd:string"/>
	<part name="FlagshipVersion" type="xsd:integer"/>
	<part name="IsPreScreen" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="FFDOptionsMask"	type="xsd:string"/>	
</message>
*/
/*--INFO-- Contains RiskView Scores AirWaves, Auto, Bankcard, Retail, Money and Pre-Screen and Attributes Versions 1 and 2*/
/*--HELP-- 
<pre>
&lt;Batch_In&gt;
  &lt;Row&gt;
    	&lt;Seq&gt;&lt;/Seq&gt;
    	&lt;AcctNo&gt;&lt;/AcctNo&gt;
    	&lt;SSN&gt;&lt;/SSN&gt;
    	&lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
    	&lt;Name_First&gt;&lt;/Name_First&gt;
    	&lt;Name_Middle&gt;&lt;/Name_Middle&gt;
    	&lt;Name_Last&gt;&lt;/Name_Last&gt;
    	&lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
    	&lt;DOB&gt;&lt;/DOB&gt;
    	&lt;Street_Addr&gt;&lt;/Street_Addr&gt;
    	&lt;Prim_Range&gt;&lt;/Prim_Range&gt;
    	&lt;Predir&gt;&lt;/Predir&gt;
    	&lt;Prim_Name&gt;&lt;/Prim_Name&gt;
    	&lt;Suffix&gt;&lt;/Suffix&gt;
    	&lt;Postdir&gt;&lt;/Postdir&gt;
    	&lt;Unit_Desig&gt;&lt;/Unit_Desig&gt;
    	&lt;Sec_Range&gt;&lt;/Sec_Range&gt;
    	&lt;P_City_Name&gt;&lt;/P_City_Name&gt;
    	&lt;St&gt;&lt;/St&gt;
    	&lt;Z5&gt;&lt;/Z5&gt;
    	&lt;Age&gt;&lt;/Age&gt;
    	&lt;DL_Number&gt;&lt;/DL_Number&gt;
    	&lt;DL_State&gt;&lt;/DL_State&gt;
    	&lt;Home_Phone&gt;&lt;/Home_Phone&gt;
    	&lt;Work_Phone&gt;&lt;/Work_Phone&gt;
    	&lt;IP_Addr&gt;&lt;/IP_Addr&gt;
      &lt;HistorydateYYYYMM&gt;&lt;/HistorydateYYYYMM&gt;
			&lt;custom_input1&gt;&lt;/custom_input1&gt;
			&lt;custom_input2&gt;&lt;/custom_input2&gt;
			&lt;custom_input3&gt;&lt;/custom_input3&gt;
			&lt;custom_input4&gt;&lt;/custom_input4&gt;
			&lt;custom_input5&gt;&lt;/custom_input5&gt;
			&lt;lexid&gt;&lt;/lexid&gt;
  &lt;/Row&gt;
&lt;/Batch_In&gt;
</pre>
*/

import address, risk_indicators, models, riskwise, ut, fcra_opt_out, gateway, FFD;


export RiskView_Batch_Service := MACRO


// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

	#WEBSERVICE(FIELDS(
		'AlternateModel',
		'batch_in',
		'FlagshipVersion',
		'DataRestrictionMask',
		'DataPermissionMask',
		'IndustryClass',
		'gateways',
		'IncludeAllScores',
		'IncludeAllAttributes',
		'IncludeScoresAttributes',
		'IncludeAuto',
		'IncludeBankcard',
		'IncludeRetail',
		'IncludeTelecom',
		'IncludeMoney',
		'IncludePreScreen',
		'IncludeLifestyle',
		'IncludeDemographic',
		'IncludeFinancial',
		'IncludeProperty',
		'IncludeDerogatory',
		'IncludeVersion2',
		'IncludeVersion3',
		'IncludeVersion4',
		'IsPreScreen',
		'FFDOptionsMask'
	));

VALIDATING := False;

batchin := dataset([],risk_indicators.Layout_Batch_In_Plus_Custom) 	: stored('batch_in',few);

gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	SELF.servicename := le.servicename;
	SELF.url := IF(le.servicename IN ['targus'], '', le.url); // Don't allow Targus Gateway
	SELF := le;
END;
gateways := PROJECT(gateways_in, gw_switch(LEFT));

boolean	IncludeAllScores := false					: stored('IncludeAllScores');
boolean	IncludeAllAttributes := false			: stored('IncludeAllAttributes');
boolean	IncludeScoresAttributes := false	: stored('IncludeScoresAttributes');
boolean	IncludeAuto := false							: stored('IncludeAuto');
boolean	IncludeBankcard := false					: stored('IncludeBankcard');
boolean	IncludeRetail := false						: stored('IncludeRetail');
boolean	IncludeTelecom := false						: stored('IncludeTelecom');
boolean	IncludeMoney_temp   := false			: stored('IncludeMoney');

boolean	IncludePreScreenTemp := false			: stored('IncludePreScreen');
boolean	IncludeLifestyle := false					: stored('IncludeLifestyle');
boolean	IncludeDemographic := false				: stored('IncludeDemographic');
boolean	IncludeFinancial := false					: stored('IncludeFinancial');
boolean	IncludeProperty := false					: stored('IncludeProperty');
boolean	IncludeDerogatory := false				: stored('IncludeDerogatory');
boolean IncludeVersion2 := false					: stored('IncludeVersion2');
boolean IncludeVersion3 := false					: stored('IncludeVersion3');
boolean IncludeVersion4 := false					: stored('IncludeVersion4');
string5  	industry_class_val := '' 				: stored('IndustryClass');

string    AlternateModel_in := '' 				: stored('AlternateModel');
boolean	IsPreScreenTemp := false					: stored('IsPreScreen');
integer FlagshipVersion := 1            	: stored('FlagshipVersion');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean OutputConsumerStatements := strFFDOptionsMask_in[1] = '1';	

AlternateModel := StringLib.StringToLowercase( trim( AlternateModel_in ) );

// Since Payment Score is goofy - we need to make sure we turn on the Money section when the model is requested.
IncludeMoney := IF(AlternateModel IN ['rvc1412_1','rvc1405_4','rvc1405_3','rvc1405_2','rvc1405_1','rvc1307_1',
	'rvc1301_1', 'rvc1208_1', 'rvc1112_0', 'rvc1110_1', 'rvc1110_2', 'rvc1412_2', 'rvc1703_1','rvc1801_1','rvc1805_1','rvc1805_2'], TRUE, IncludeMoney_temp);

AltRetails    := ['ex89', 'rvr1104_2', 'rvr1210_1'];
AltTelecoms   := ['ex23'];
AltAuto       := ['rva707_0', 'rva1309_1'];
AltPreScreens := ['rvp1012_1', 'rvp1208_1', 'rvp1401_1', 'rvp1401_2','rvp1503_1'];

// all new models should go here. with old models, we completely blank out scores & reasons for prescreen opt-out. this allows us to return 222+rc95
Newer_AltModels := ['rvr1104_2', 'rvc1112_0', 'rvc1110_1', 'rvc1110_2', 'rvp1012_1', 'rvp1208_1', 'rvc1208_1', 'rvr1210_1', 'rvc1301_1',
										'rva1309_1', 'rvc1307_1', 'rvp1401_1', 'rvp1401_2', 'rvc1405_1', 'rvc1405_2', 'rvc1405_3', 'rvc1405_4', 'rvc1412_1',
										'rvp1503_1', 'rvb1402_1', 'ied1002_0', 'rvc1412_2', 'rvc1703_1','rvc1801_1','rvc1805_1','rvc1805_2'];

CustomIndex := case( AlternateModel,
	'ex23' => '102',
	'ex89' => '103',
	'rva707_0' => Risk_Indicators.BillingIndex.RVA_rva707_0,
	'rvr1104_2' => Risk_Indicators.BillingIndex.RVR1104_2,
  'rvc1112_0' => Risk_Indicators.BillingIndex.RVC1112_0,
  'rvc1110_1' => Risk_Indicators.BillingIndex.RVC1110_1,
  'rvc1110_2' => Risk_Indicators.BillingIndex.RVC1110_2,
  'rvp1012_1' => Risk_Indicators.BillingIndex.RVP1012_1,
  'rvp1208_1' => Risk_Indicators.BillingIndex.RVP1208_1,
  'rvc1208_1' => Risk_Indicators.BillingIndex.RVC1208_1,
  'rvr1210_1' => Risk_Indicators.BillingIndex.RVR1210_1,
  'rvc1301_1' => Risk_Indicators.BillingIndex.RVC1301_1,
	'rva1309_1' => Risk_Indicators.BillingIndex.RVA1309_1,
	'rvc1307_1' => Risk_Indicators.BillingIndex.RVC1307_1,
	'rvp1401_1' => Risk_Indicators.BillingIndex.RVP1401_1,
	'rvp1401_2' => Risk_Indicators.BillingIndex.RVP1401_2,
	'rvp1503_1' => Risk_Indicators.BillingIndex.RVP1503_1,
	'rvc1405_1' => Risk_Indicators.BillingIndex.RVC1405_1,
	'rvc1405_2' => Risk_Indicators.BillingIndex.RVC1405_2,
	'rvc1405_3' => Risk_Indicators.BillingIndex.RVC1405_3,
	'rvc1405_4' => Risk_indicators.BillingIndex.RVC1405_4,
	'rvc1412_1' => Risk_indicators.BillingIndex.RVC1412_1,
	'rvb1402_1' => Risk_indicators.BillingIndex.RVB1402_1,
	'ied1002_0' => Risk_indicators.BillingIndex.IED1002_0,
	'rvc1412_2' => Risk_indicators.BillingIndex.RVC1412_2,
	'rvc1703_1' => Risk_indicators.BillingIndex.RVC1703_1,
	'rvc1801_1' => Risk_indicators.BillingIndex.RVC1801_1,
  'rvc1805_1' => Risk_indicators.BillingIndex.RVC1805_1,
  'rvc1805_2' => Risk_indicators.BillingIndex.RVC1805_2,
	'' => '',
	error('Invalid model input: ' + alternatemodel)
);

CustomScoreName := case( AlternateModel,
	'ex23' => 'TelecomAWD60630',
	'ex89' => 'RetailTRD60500',
	'rva707_0' => 'AutoRVA70700',
	'rvr1104_2' => 'RetailRVR11042',
  'rvc1112_0' => 'Payment',
  'rvc1110_1' => 'PaymentRVC11101',
  'rvc1110_2' => 'ProbateRVC11102',
  'rvp1012_1' => 'RVP10121', // PrescreenRVP10121 gets truncated to PrescreenRVP101, so use the shorter name
  'rvp1208_1' => 'RVP12081', 
  'rvc1208_1' => 'RVC12081',
  'rvr1210_1' => 'RVR12101',
  'rvc1301_1' => 'RVC13011',
  'rva1309_1' => 'RVA13091',
  'rvc1307_1' => 'RVC13071',	
	'rvp1401_1' => 'RVP14011',
	'rvp1401_2' => 'RVP14012',
	'rvc1405_1' => 'RVC14051',
	'rvc1405_2' => 'RVC14052',
	'rvc1405_3' => 'RVC14053',
	'rvc1405_4' => 'RVC14054',
	'rvc1412_1' => 'RVC14121',
	'rvp1503_1' => 'RVP15031',
	'rvb1402_1' => 'RVB14021',
	'ied1002_0' => 'IncomeIED10020',
	'rvc1412_2' => 'RVC14122',
	'rvc1703_1' => 'RVC17031',
	'rvc1801_1' => 'RVC18011',
  'rvc1805_1' => 'RVC18051',
  'rvc1805_2' => 'RVC18052',
	''
);

// per steve and brian, leave this default supression turned on when IncludePrescreen is requested
	
// We cannot set IsPreScreen to true automatically when the Prescreen model is requested along with any other model.
// Check to see if any of these models are selected.  If so, then IncludePrescreen cannot be true. Any other model will
// take priority over the prescreen model.  We should still be able to select the IsPreScreen setting along with any of the other
// models (auto, retail, telco, bankcard, or money) which will allow prescreen suppressions later in this code.

IncludedNonPrescreenModel := IncludeAuto or IncludeBankcard or IncludeRetail or IncludeTelecom or IncludeMoney or IncludeAllScores;
IncludePrescreen := IncludePrescreenTemp and not IncludedNonPrescreenModel;
IsPreScreen := IncludePrescreen or IsPreScreenTemp; 


doMoney       := IncludeAllAttributes or IncludeScoresAttributes or IncludeMoney; 
doLifestyle   := IncludeAllAttributes or IncludeScoresAttributes or IncludeLifestyle; 
doDemographic := IncludeAllAttributes or IncludeScoresAttributes or IncludeDemographic;
doFinancial   := IncludeAllAttributes or IncludeScoresAttributes or IncludeFinancial;
doProperty    := IncludeAllAttributes or IncludeScoresAttributes or IncludeProperty;
doDerog       := IncludeAllAttributes or IncludeScoresAttributes or IncludeDerogatory;
doVersion2    := IncludeVersion2;
doVersion3    := IncludeVersion3;
doVersion4    := IncludeVersion4;


bsVersion := max( FlagshipVersion, map(
	AlternateModel IN ['rvr1210_1', 'rvc1301_1', 'rva1309_1', 'rvc1307_1', 'rvp1401_1', 'rvp1401_2', 'rvc1405_1', 'rvc1405_2', 'rvc1405_3',
										 'rvc1405_4', 'rvc1412_1', 'rvp1503_1', 'rvb1402_1', 'ied1002_0', 'rvc1412_2', 'rvc1703_1','rvc1801_1','rvc1805_1','rvc1805_2'] => 41,
	AlternateModel IN ['rvr1104_2', 'rvc1112_0', 'rvc1110_1', 'rvc1110_2', 'rvp1012_1', 'rvp1208_1', 'rvc1208_1'] => 4,
	doVersion4 => 4,
	doVersion3 => 3,  
	doVersion2 => 2,  
	isPreScreen => 2,  // prescreen should default to 2
	IncludeMoney => 2,  // Money service should default to 2
	AlternateModel = 'rva707_0' => 2,	// Custom auto should default to 2
	1 // otherwise default to 1
));


// add sequence to matchup later to add acctno to output
Risk_Indicators.Layout_Batch_In_Plus_Custom into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));



Risk_Indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
	// clean up input
	self.did := (unsigned)le.LexID;
	self.score := if((unsigned)le.lexID <> 0, 100, 0);
	ssn_val := le.ssn;
	hphone_val := riskwise.cleanPhone(le.home_phone);
	wphone_val := riskwise.cleanphone(le.work_phone);
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	self.seq := le.seq;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.age := if ((integer)le.age = 0 and (integer)le.dob != 0, (string3)ut.GetAgeI((integer)le.dob), (le.age));
	
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.fname := stringlib.stringtouppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	self.lname := stringlib.stringtouppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	self.mname := stringlib.stringtouppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	self.suffix := stringlib.stringtouppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	self.title := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],''));

	street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
		
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..65];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
	
	self.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := stringlib.stringtouppercase(le.dl_state);
	
	// if the record level history date isn't populated yet, use the default value of 999999
	self.historydate := if(le.HistoryDateYYYYMM=0, risk_indicators.iid_constants.default_history_date, le.historydateYYYYMM); 
	self := [];
END;
batchinseq_temp := if(VALIDATING, batchin, batchinseq);
cleanIn := project(batchinseq_temp, into_in(left));


// set variables for passing to bocashell function fcra
boolean   isUtility := StringLib.StringToUpperCase(industry_class_val) = 'UTILI';
boolean 	require2ele := AlternateModel in ['ex23','ex89'];
unsigned1 dppa := 0;	// not needed for FCRA
unsigned1 glba := 0;	// not needed for FCRA
boolean   isLn := false;	// not needed anymore
boolean doRelatives := false;	// does attributes version2 need relatives?
boolean doDL := false;
boolean doVehicle := false;	// does attributes version2 need vehicle?
boolean doDerogs := true;
boolean ofacOnly := true;
boolean suppressNearDups := false;
boolean fromBIID := false;
boolean excludeWatchlists := true;	// turned off the ofac searching as I don't think it is needed
boolean fromIT1O := false;
unsigned1 ofacVersion := 1;
boolean includeOfac := false;
boolean includeAddWatchlists := false;
real    watchlistThreshold := 0.84;
boolean doScore := false;
boolean nugen := true;  // for reason code settings in the shell

boolean FilterLiens := DataRestriction[risk_indicators.iid_constants.posLiensJudgRestriction]='1' ;
unsigned8 BSOptions := if( IsPreScreen, risk_indicators.iid_constants.BSOptions.IncludePreScreen, 0 ) + 
if(FilterLiens, Risk_Indicators.iid_constants.BSOptions.FilterLiens, 0);

// per bug 36019, CapitalOne will be allowed to get the prescreen model and attributes together in one batch
// they currently want riskview attributes (which doesn't use adl based shell) and the RVP804 model (which needs the adl based shell)
// so we need 2 calls to the bocashell for them  (clam2 will always be the ADL based shell)
clam := Risk_Indicators.Boca_Shell_Function_FCRA(cleanIn, gateways, dppa, glba, isUtility, isLN, 
																								 require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
																								 suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
																								 ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
																								 bsVersion, isPreScreen, doScore, nugen, ADL_Based_Shell:=false,datarestriction:=DataRestriction,
																								 BSOptions:=BSOptions, datapermission:=DataPermission);

adl_clam := Risk_Indicators.Boca_Shell_Function_FCRA(cleanIn, gateways, dppa, glba, isUtility, isLN, 
																								 require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
																								 suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
																								 ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
																								 bsVersion, isPreScreen, doScore, nugen, ADL_Based_Shell:=true,datarestriction:=DataRestriction,
																								 BSOptions:=BSOptions, datapermission:=DataPermission);


Risk_Indicators.Layout_Bocashell_with_Custom getcustom(Risk_Indicators.Layout_Boca_Shell le, risk_indicators.Layout_Batch_In_Plus_Custom ri) := Transform
	Self := ri;
	Self := le;
End;

custom_adl_clam := group(join(adl_clam, batchinseq_temp, left.seq=right.seq, getcustom(left, right)),seq);

#if(VALIDATING)
// final := adl_clam;
// final := ungroup(Models.RVC1405_4_0(adl_clam, false)); // select correct clam here...adl_clam or clam.
final := ungroup(Models.RVC1805_1_0(adl_clam, false)); 
//OUTPUT(final, NAMED('Results'));
#else
attr := Models.getRVAttributes(clam, ''/*account_value*/, IsPreScreenTemp, false, DataRestriction);


checkBoolean(boolean x) := if(x, '1', '0');
cap1Byte := '9';
cap2Byte := '99';
cap3Byte := '999';
cap4Byte := '9998';	// real distances are capped at 9998, 9999 means can't calculate
cap6Byte := '999999';
cap8Byte := '99999999';
cap10Byte := '9999999999';
cap10ByteNeg := '-999999999';
cap13Byte := '9999999999999';
getMin(string l, string r) := IF((unsigned)l < (unsigned)r, TRIM(l), TRIM(r));	// get smaller number


Layout_working := RECORD
	unsigned seq;
	boolean suppress;
	models.Layout_RiskView_Batch_Out;
END;

Layout_working intoAttributes(attr le) := TRANSFORM
	self.seq := le.seq;
	
	// Version 1
	// Lifestyle
	self.index1 := if(doLifestyle, '0', '');
	self.dwelltype := if(doLifestyle, le.lifestyle.dwelltype, '');
	self.assessed_amount := if(doLifestyle, TRIM((string)le.lifestyle.assessed_amount), '');
	self.applicant_owned := if(doLifestyle, TRIM((string)le.lifestyle.applicant_owned), '');
	self.family_owned := if(doLifestyle, TRIM((string)le.lifestyle.family_owned), '');
	self.occupant_owned := if(doLifestyle, TRIM((string)le.lifestyle.occupant_owned), '');
	self.isbestmatch := if(doLifestyle, TRIM((string)le.lifestyle.isbestmatch), '');
	self.date_first_seen := if(doLifestyle, TRIM((string)le.lifestyle.date_first_seen), '');
	self.date_first_seen2 := if(doLifestyle, TRIM((string)le.lifestyle.date_first_seen2), '');
	self.date_first_seen3 := if(doLifestyle, TRIM((string)le.lifestyle.date_first_seen3), '');
	self.number_nonderogs := if(doLifestyle, le.lifestyle.number_nonderogs, '');
	self.date_last_seen := if(doLifestyle, TRIM((string)le.lifestyle.date_last_seen), '');
	self.recent_update := if(doLifestyle, TRIM((string)le.lifestyle.recent_update), '');
	self.license_type := '';//if(doLifestyle, le.lifestyle.license_type, '');

	// Demographic
	self.index2 := if(doDemographic, '1', '');
	self.age := '';//if(doDemographic, le.dems.age, '');
	self.ssn_issued := if(doDemographic, TRIM((string)le.dems.ssn_issued), '');
	self.low_issue_date := if(doDemographic, TRIM((string)le.dems.low_issue_date), '');
	self.high_issue_date := if(doDemographic, TRIM((string)le.dems.high_issue_date), '');
	self.nonUS_ssn := if(doDemographic, TRIM((string)le.dems.nonUS_ssn), '');
	self.ssn_issue_state := if(doDemographic, le.dems.ssn_issue_state, '');
	self.ssn_first_seen := if(doDemographic, TRIM((string)le.dems.ssn_first_seen[1..6]), '');	

	// Financial
	self.index3 := if(doFinancial, '2', '');
	self.phone_full_name_match := if(doFinancial, TRIM((string)le.finance.phone_full_name_match), '');
	self.phone_last_name_match := if(doFinancial, TRIM((string)le.finance.phone_last_name_match), '');
	self.nap_status := if(doFinancial, le.finance.nap_status, '');
	self.credit_first_seen := '';//if(doFinancial, (string)le.finance.credit_first_seen, '');		

	// Property
	self.index4 := if(doProperty, '3', '');
	self.property_owned_total := getMin(if(doProperty, (string)le.property.property_owned_total, ''),cap2Byte);
	self.property_owned_assessed_total := if(doProperty, TRIM((string)le.property.property_owned_assessed_total), '');
	self.property_historically_owned := getMin(if(doProperty, (string)le.property.property_historically_owned, ''),cap2Byte);
	self.date_most_recent_purchase := '';//if(doProperty, (string)le.property.date_most_recent_purchase, '');
	self.date_first_purchase := '';//if(doProperty, (string)le.property.date_first_purchase, '');

	// Derogatory
	self.index5 := if(doDerog, '4', '');
	self.criminal_count := getMin(if(doDerog, (string)le.derogs.criminal_count, ''),cap2Byte);
	self.filing_count := getMin(if(doDerog, (string)le.derogs.filing_count, ''),cap2Byte);
	self.date_last_seen2 := if(doDerog, TRIM((string)le.derogs.date_last_seen), '');
	self.disposition := if(doDerog, le.derogs.disposition, '');
	self.liens_historical_unreleased_count := getMin(if(doDerog, (string)le.derogs.liens_historical_unreleased_count, ''),cap2Byte);
	self.liens_recent_unreleased_count := getMin(if(doDerog, (string)le.derogs.liens_recent_unreleased_count, ''),cap2Byte);
	self.judgements_count := '';//if(doDerog, (string)le.derogs.judgements_count, '');
	self.evictions_count := '';//if(doDerog, (string)le.derogs.evictions_count, '');
	self.foreclosure_count := '';//if(doDerog, (string)le.derogs.foreclosure_count, '');
	self.total_number_derogs := getMin(if(doDerog, (string)le.derogs.total_number_derogs, ''),cap2Byte);
	self.date_last_derog := '';//if(doDerog, (string)le.derogs.date_last_derog, '');
	
	// Version2
	self.index11 := map(
											doVersion4 => '7',
											doVersion3 => '6',
											doVersion2 => '5', 
											'');
	self.SSNFirstSeen := getMin(if(doVersion2, (string)le.version2.SSNFirstSeen[1..6], ''), cap6Byte);
	self.DateLastSeen := getMin(if(doVersion2, (string)le.version2.DateLastSeen, ''), cap8Byte);
	self.isRecentUpdate := map(doVersion2 => checkBoolean(le.version2.isRecentUpdate),
														 doVersion3 => checkBoolean(le.version3.isRecentUpdate),
															'');
	self.NumSources := TRIM(map(doVersion2 => getMin((string)le.version2.NumSources,cap2Byte), 
																doVersion3 => (string)le.version3.NumSources,
																''));
	
	self.isPhoneFullNameMatch := map(doVersion2 => checkBoolean(le.version2.isPhoneFullNameMatch),
																	doVersion3 => le.version3.VerifiedPhoneFullName,																	
																	'');
	self.isPhoneLastNameMatch := map(doVersion2 => checkBoolean(le.version2.isPhoneLastNameMatch),
																	doVersion3 => le.version3.VerifiedPhoneLastName,																	
																	'');
	self.isSSNInvalid := map(doVersion2 => checkBoolean(le.version2.isSSNInvalid),
													 doVersion3 => le.version3.InvalidSSN, 
														'');
	self.isPhoneInvalid := map(doVersion2 => checkBoolean(le.version2.isPhoneInvalid), 
													 doVersion3 => le.version3.InvalidPhone, 
														'');
	self.isAddrInvalid := map(doVersion2 => checkBoolean(le.version2.isAddrInvalid), 
													  doVersion3 => le.version3.InvalidAddr, 
														'');
	self.isDLInvalid := map(doVersion2 => checkBoolean(le.version2.isDLInvalid),
												  doVersion3 => le.version3.InvalidDL, 
													'');
	self.isNoVer := map(doVersion2 => checkBoolean(le.version2.isNoVer),
											doVersion3 => checkBoolean(le.version3.isNoVer),
											'');
	
	self.isDeceased := map(doVersion2 => checkBoolean(le.version2.isDeceased),
												 doVersion3 => le.version3.SSNDeceased,
												 '');
	
	self.DeceasedDate := TRIM(map(doVersion2 => getMin((string)le.version2.DeceasedDate, cap8Byte),
																	doVersion3 => le.version3.DeceasedDate,
																	''));
	self.isSSNValid := map(doVersion2 => checkBoolean(le.version2.isSSNValid),
												 doVersion3 => le.version3.SSNValid,
												 '');
	self.isRecentIssue := map(doVersion2 => checkBoolean(le.version2.isRecentIssue),
													 doVersion3 => le.version3.RecentIssue,
													 '');
	self.LowIssueDate := TRIM(map(doVersion2 =>getMin((string)le.version2.LowIssueDate, cap8Byte), 
																	doVersion3 => le.version3.LowIssueDate,
																	''));
	self.HighIssueDate := TRIM(map(doVersion2 => getMin((string)le.version2.HighIssueDate, cap8Byte), 
																	 doVersion3 => le.version3.HighIssueDate, 
																	 ''));
	self.IssueState := map(doVersion2 => le.version2.IssueState, 
												 doVersion3 => le.version3.IssueState, 
												 '');
	self.isNonUS := map(doVersion2 => checkBoolean(le.version2.isNonUS), 
											doVersion3 => le.version3.NonUS, 
											'');
	self.isIssued3 := map(doVersion2 => checkBoolean(le.version2.isIssued3), 
											 doVersion3 => le.version3.Issued3, 
											 '');
	self.isIssuedAge5 := map(doVersion2 => checkBoolean(le.version2.isIssuedAge5), 
													 doVersion3 => le.version3.IssuedAge5, 
													 '');

	self.IADateFirstReported := getMin(if(doVersion2, (string)le.version2.IADateFirstReported[1..6], ''), cap6Byte);
	self.IADateLastReported := getMin(if(doVersion2, (string)le.version2.IADateLastReported[1..6], ''), cap6Byte);
	self.IALenOfRes := TRIM(map(doVersion2 => getMin((string)le.version2.IALenOfRes, cap3Byte), 
																doVersion3 => le.version3.IALenOfRes,
																''));
	self.IADwellType := map(doVersion2 => le.version2.IADwellType, 
												 doVersion3 => le.version3.IADwellType,
												 '');
	self.IALandUseCode := map(doVersion2 => le.version2.IALandUseCode, 
														doVersion3 => le.version3.IALandUseCode,
														'');
	self.IAAssessedValue := TRIM(map(doVersion2 => getMin((string)le.version2.IAAssessedValue, cap10Byte), 
																		 doVersion3 => le.version3.IAAssessedValue,
																		 ''));
	self.IAisOwnedBySubject := map(doVersion2 => checkBoolean(le.version2.IAisOwnedBySubject), 
																 doVersion3 => le.version3.IAOwnedBySubject,
																 '');
	self.IAisFamilyOwned := map(doVersion2 => checkBoolean(le.version2.IAisFamilyOwned), 
															doVersion3 => le.version3.IAFamilyOwned,
															'');
	self.IAisOccupantOwned := map(doVersion2 => checkBoolean(le.version2.IAisOccupantOwned), 
																doVersion3 => le.version3.IAOccupantOwned,
																'');
	self.IALastSaleDate := getMin(if(doVersion2, (string)le.version2.IALastSaleDate, ''), cap8Byte);
	self.IALastSaleAmount := TRIM(map(doVersion2 => getMin((string)le.version2.IALastSaleAmount, cap10Byte), 
																			doVersion3 => le.version3.IALastSaleAmount,
																			''));
	self.IAisNotPrimaryRes := map(doVersion2 => checkBoolean(le.version2.IAisNotPrimaryRes), 
																doVersion3 => le.version3.IANotPrimaryRes,
																'');
	self.IAPhoneListed := TRIM(map(doVersion2 => getMin((string)le.version2.IAPhoneListed,cap1Byte), 
																	 doVersion3 => le.version3.IAPhoneListed,
																	 ''));
	self.IAPhoneNumber := TRIM(map(doVersion2 => (string)le.version2.IAPhoneNumber, 
														doVersion3 => le.version3.IAPhoneNumber,
														''));

	self.CADateFirstReported := getMin(if(doVersion2, (string)le.version2.CADateFirstReported[1..6], ''), cap6Byte);
	self.CADateLastReported := getMin(if(doVersion2, (string)le.version2.CADateLastReported[1..6], ''), cap6Byte);
	self.CALenOfRes := TRIM(map(doVersion2 => getMin((string)le.version2.CALenOfRes, cap3Byte), 
																doVersion3 => le.version3.CALenOfRes,
																''));
	self.CADwellType := map(doVersion2 => le.version2.CADwellType, 
													doVersion3 => le.version3.CADwellType,
													'');
	self.CALandUseCode := map(doVersion2 => le.version2.CALandUseCode, 
														doVersion3 => le.version3.CALandUseCode,
														'');
	self.CAAssessedValue := TRIM(map(doVersion2 => getMin((string)le.version2.CAAssessedValue, cap10Byte), 
																		 doVersion3 => le.version3.CAAssessedValue,
																		 ''));
	self.CAisOwnedBySubject := map(doVersion2 => checkBoolean(le.version2.CAisOwnedBySubject), 
																 doVersion3 => le.version3.CAOwnedBySubject, 
																 '');
	self.CAisFamilyOwned := map(doVersion2 => checkBoolean(le.version2.CAisFamilyOwned), 
															doVersion3 => le.version3.CAFamilyOwned,
															'');
	self.CAisOccupantOwned := map(doVersion2 => checkBoolean(le.version2.CAisOccupantOwned), 
																doVersion3 => le.version3.CAOccupantOwned,
																'');
	self.CALastSaleDate := getMin(if(doVersion2,(string)le.version2.CALastSaleDate, ''), cap8Byte);
	self.CALastSaleAmount := TRIM(map(doVersion2 => getMin((string)le.version2.CALastSaleAmount, cap10Byte), 
																			doVersion3 => le.version3.CALastSaleAmount,
																			''));
	self.CAisNotPrimaryRes := map(doVersion2 => checkBoolean(le.version2.CAisNotPrimaryRes), 
																doVersion3 => le.version3.CANotPrimaryRes,
																'');
	self.CAPhoneListed := TRIM(map(doVersion2 => getMin((string)le.version2.CAPhoneListed,cap1Byte), 
																	 doVersion3 => le.version3.CAPhoneListed, 
																	 ''));
	self.CAPhoneNumber := TRIM(map(doVersion2 => (string)le.version2.CAPhoneNumber, 
														doVersion3 => le.version3.CAPhoneNumber, 
														''));
	
	self.PADateFirstReported := getMin(if(doVersion2, (string)le.version2.PADateFirstReported[1..6], ''), cap6Byte);
	self.PADateLastReported := getMin(if(doVersion2, (string)le.version2.PADateLastReported[1..6], ''), cap6Byte);
	self.PALenOfRes := TRIM(map(doVersion2 => getMin((string)le.version2.PALenOfRes, cap3Byte), 
																doVersion3 => le.version3.PALenOfRes, 
																''));
	self.PADwellType := map(doVersion2 => le.version2.PADwellType, 
													doVersion3 => le.version3.PADwellType,
													'');
	self.PALandUseCode := map(doVersion2 => le.version2.PALandUseCode, 
														doVersion3 => le.version3.PALandUseCode, 
														'');
	self.PAAssessedValue := TRIM(map(doVersion2 => getMin((string)le.version2.PAAssessedValue, cap10Byte), 
																		 doVersion3 => le.version3.PAAssessedValue, 
																		 ''));
	self.PAisOwnedBySubject := map(doVersion2 => checkBoolean(le.version2.PAisOwnedBySubject), 
																 doVersion3 => le.version3.PAOwnedBySubject, 
																 '');
	self.PAisFamilyOwned := map(doVersion2 => checkBoolean(le.version2.PAisFamilyOwned), 
															doVersion3 => le.version3.PAFamilyOwned, 
															'');
	self.PAisOccupantOwned := map(doVersion2 => checkBoolean(le.version2.PAisOccupantOwned), 
																doVersion3 => le.version3.PAOccupantOwned,
																'');
	self.PALastSaleDate := getMin(if(doVersion2,(string)le.version2.PALastSaleDate, ''), cap8Byte);
	self.PALastSaleAmount := TRIM(map(doVersion2 => getMin((string)le.version2.PALastSaleAmount, cap10Byte), 
																			doVersion3 => le.version3.PALastSaleAmount,
																			''));
	self.PAisNotPrimaryRes := if(doVersion2, checkBoolean(le.version2.PAisNotPrimaryRes), '');
	self.PAPhoneListed := TRIM(map(doVersion2 => getMin((string)le.version2.PAPhoneListed,cap1Byte), 
																	 doVersion3 => le.version3.PAPhoneListed,
																	 ''));
	self.PAPhoneNumber := TRIM(map(doVersion2 => (string)le.version2.PAPhoneNumber, 
														doVersion3 => le.version3.PAPhoneNumber, 
														''));
	
	distCap := 9999;
	
	self.isInputCurrMatch := map(doVersion2 => checkBoolean(le.version2.isInputCurrMatch), 
															 doVersion3 => le.version3.InputCurrMatch, 
															 '');
	self.DistInputCurr := if(map(doVersion2 => le.version2.DistInputCurr, 
															 doVersion3 => (integer)le.version3.DistInputCurr,
															 0) > distCap, 
													cap4Byte, 
													map(doVersion2 => TRIM((string)le.version2.DistInputCurr), 
															doVersion3 => le.version3.DistInputCurr, 
															''));
	self.isDiffState := map(doVersion2 => checkBoolean(le.version2.isDiffState), 
													doVersion3 => le.version3.DiffState,
													'');
	self.AssessedDiff := if(map(doVersion2 => le.version2.AssessedDiff, 
															doVersion3 => (integer)le.version3.AssessedDiff,
															0) < -999999999,
													cap10ByteNeg,
													map(doVersion2 => TRIM((string)le.version2.AssessedDiff), 
															doVersion3 => le.version3.AssessedDiff,
															''));
	self.EcoTrajectory := map(doVersion2 => le.version2.EcoTrajectory, 
														doVersion3 => le.version3.EcoTrajectory, 
														'');
	
	self.isInputPrevMatch := map(doVersion2 => checkBoolean(le.version2.isInputPrevMatch), 
															 doVersion3 => le.version3.InputPrevMatch,
															 '');
	self.DistCurrPrev := if(map(doVersion2 => le.version2.DistCurrPrev, 
														 doVersion3 => (integer)le.version3.DistCurrPrev,
														 0) > distCap, 
													cap4Byte,
													map(doVersion2 => TRIM((string)le.version2.DistCurrPrev), 
															doVersion3 => le.version3.DistCurrPrev, 
															''));
	self.isDiffState2 := map(doVersion2 => checkBoolean(le.version2.isDiffState2), 
													 doVersion3 => le.version3.DiffState2,
													 '');
	self.AssessedDiff2 := if(map(doVersion2 => le.version2.AssessedDiff2, 
															 doVersion3 => (integer)le.version3.AssessedDiff2,
															 0) < -999999999,
														cap10ByteNeg,
														map(doVersion2 => TRIM((string)le.version2.AssessedDiff2), 
																doVersion3 => le.version3.AssessedDiff2, 
																''));
	self.EcoTrajectory2 := map(doVersion2 => le.version2.EcoTrajectory2, 
														 doVersion3 => le.version3.EcoTrajectory2, 
														 '');
	
	self.mobility_indicator := map(doVersion2 => le.version2.mobility_indicator, 
																doVersion3 => le.version3.mobility_indicator,
																'');
	self.statusAddr := map(doVersion2 => le.version2.statusAddr, 
												doVersion3 => le.version3.statusAddr, 
												'');
	self.statusAddr2 := map(doVersion2 => le.version2.statusAddr2, 
												 doVersion3 => le.version3.statusAddr2, 
												 '');
	self.statusAddr3 := map(doVersion2 => le.version2.statusAddr3, 
												 doVersion3 => le.version3.statusAddr3, 
												 '');
	self.PADateFirstReported2 := getMin(if(doVersion2, (string)le.version2.PADateFirstReported2[1..6], ''), cap6Byte);
	self.NPADateFirstReported := getMin(if(doVersion2, (string)le.version2.NPADateFirstReported[1..6], ''), cap6Byte);
	self.addrChanges30 := TRIM(map(doVersion2 => getMin((string)le.version2.addrChanges30,cap2Byte), 
																	doVersion3 => (string)le.version3.addrChanges30, 
																	''));
	self.addrChanges90 :=TRIM( map(doVersion2 => getMin((string)le.version2.addrChanges90,cap2Byte), 
																	doVersion3 => (string)le.version3.addrChanges90, 
																	''));
	self.addrChanges180 := TRIM(map(doVersion2 => getMin((string)le.version2.addrChanges180,cap2Byte), 
																	 doVersion3 => (string)le.version3.addrChanges180, 
																	 ''));
	self.addrChanges12 := TRIM(map(doVersion2 => getMin((string)le.version2.addrChanges12,cap2Byte), 
																	doVersion3 => (string)le.version3.addrChanges12, 
																	''));
	self.addrChanges24 := TRIM(map(doVersion2 => getMin((string)le.version2.addrChanges24,cap2Byte), 
																	doVersion3 => (string)le.version3.addrChanges24,
																	''));
	self.addrChanges36 := TRIM(map(doVersion2 => getMin((string)le.version2.addrChanges36,cap2Byte), 
																	doVersion3 => (string)le.version3.addrChanges36,
																	''));
	self.addrChanges60 := TRIM(map(doVersion2 => getMin((string)le.version2.addrChanges60,cap2Byte), 
																	doVersion3 => (string)le.version3.addrChanges60,
																	''));
	
	self.property_owned_total_v2 := TRIM(map(doVersion2 => getMin((string)le.version2.property_owned_total,cap2Byte), 
																						doVersion3 => (string)le.version3.property_owned_total, 
																						''));
	self.property_owned_assessed_total_v2 := TRIM(map(doVersion2 => getMin((string)le.version2.property_owned_assessed_total, cap13Byte), 
																											doVersion3 => (string)le.version3.property_owned_assessed_total, 
																											''));
	self.property_historically_owned_v2 := TRIM(map(doVersion2 => getMin((string)le.version2.property_historically_owned,cap2Byte), 
																										doVersion3 => (string)le.version3.property_historically_owned, 
																										''));
	self.date_first_purchase_v2 := getMin(if(doVersion2, (string)le.version2.date_first_purchase, ''), cap8Byte);
	self.date_most_recent_purchase_v2 := getMin(if(doVersion2, (string)le.version2.date_most_recent_purchase, ''), cap8Byte);
	self.date_most_recent_sale := getMin(if(doVersion2, (string)le.version2.date_most_recent_sale, ''), cap8Byte);
	
	self.numPurchase30 := TRIM(map(doVersion2 => getMin((string)le.version2.numPurchase30,cap2Byte), 
																	 doVersion3 => (string)le.version3.numPurchase30,
																	 ''));
	self.numPurchase90 := TRIM(map(doVersion2 => getMin((string)le.version2.numPurchase90,cap2Byte), 
																	 doVersion3 => (string)le.version3.numPurchase90, 
																	 ''));
	self.numPurchase180 := TRIM(map(doVersion2 => getMin((string)le.version2.numPurchase180,cap2Byte), 
																		doVersion3 => (string)le.version3.numPurchase180,
																		''));
	self.numPurchase12 := TRIM(map(doVersion2 => getMin((string)le.version2.numPurchase12,cap2Byte), 
																	 doVersion3 => (string)le.version3.numPurchase12,
																	 ''));
	self.numPurchase24 := TRIM(map(doVersion2 => getMin((string)le.version2.numPurchase24,cap2Byte), 
																	 doVersion3 => (string)le.version3.numPurchase24,
																	 ''));
	self.numPurchase36 := TRIM(map(doVersion2 => getMin((string)le.version2.numPurchase36,cap2Byte), 
																	 doVersion3 => (string)le.version3.numPurchase36,
																	 ''));
	self.numPurchase60 := TRIM(map(doVersion2 => getMin((string)le.version2.numPurchase60,cap2Byte), 
																	 doVersion3 => (string)le.version3.numPurchase60,
																	 ''));
	self.numSold30 := TRIM(map(doVersion2 => getMin((string)le.version2.numSold30,cap2Byte), 
															 doVersion3 => (string)le.version3.numSold30, 
															 ''));
	self.numSold90 := TRIM(map(doVersion2 => getMin((string)le.version2.numSold90,cap2Byte), 
															 doVersion3 => (string)le.version3.numSold90, 
															 ''));
	self.numSold180 := TRIM(map(doVersion2 => getMin((string)le.version2.numSold180,cap2Byte), 
																doVersion3 => (string)le.version3.numSold180, 
																''));
	self.numSold12 := TRIM(map(doVersion2 => getMin((string)le.version2.numSold12,cap2Byte), 
															 doVersion3 => (string)le.version3.numSold12,
															 ''));
	self.numSold24 := TRIM(map(doVersion2 => getMin((string)le.version2.numSold24,cap2Byte), 
															 doVersion3 => (string)le.version3.numSold24, 
															 ''));
	self.numSold36 := TRIM(map(doVersion2 => getMin((string)le.version2.numSold36,cap2Byte), 
															 doVersion3 => (string)le.version3.numSold36, 
															 ''));
	self.numSold60 := TRIM(map(doVersion2 => getMin((string)le.version2.numSold60,cap2Byte), 
															 doVersion3 => (string)le.version3.numSold60, 
															 ''));
	self.numWatercraft := TRIM(map(doVersion2 => getMin((string)le.version2.numWatercraft,cap2Byte), 
																	 doVersion3 => (string)le.version3.numWatercraft, 
																	 ''));
	self.numWatercraft30 := TRIM(map(doVersion2 => getMin((string)le.version2.numWatercraft30,cap2Byte), 
																		 doVersion3 => (string)le.version3.numWatercraft30, 
																		 ''));
	self.numWatercraft90 := TRIM(map(doVersion2 => getMin((string)le.version2.numWatercraft90,cap2Byte), 
																		 doVersion3 => (string)le.version3.numWatercraft90, 
																		 ''));
	self.numWatercraft180 := TRIM(map(doVersion2 => getMin((string)le.version2.numWatercraft180,cap2Byte), 
																			doVersion3 => (string)le.version3.numWatercraft180, 
																			''));
	self.numWatercraft12 := TRIM(map(doVersion2 => getMin((string)le.version2.numWatercraft12,cap2Byte), 
																		 doVersion3 => (string)le.version3.numWatercraft12, 
																		 ''));
	self.numWatercraft24 := TRIM(map(doVersion2 => getMin((string)le.version2.numWatercraft24,cap2Byte), 
																		 doVersion3 => (string)le.version3.numWatercraft24,
																		 ''));
	self.numWatercraft36 := TRIM(map(doVersion2 => getMin((string)le.version2.numWatercraft36,cap2Byte), 
																		 doVersion3 => (string)le.version3.numWatercraft36, 
																		 ''));
	self.numWatercraft60 := TRIM(map(doVersion2 => getMin((string)le.version2.numWatercraft60,cap2Byte), 
																		 doVersion3 => (string)le.version3.numWatercraft60,
																		 ''));
	self.numAircraft := TRIM(map(doVersion2 => getMin((string)le.version2.numAircraft,cap2Byte),
																 doVersion3 => (string)le.version3.numAircraft,
																 ''));
	self.numAircraft30 := TRIM(map(doVersion2 => getMin((string)le.version2.numAircraft30,cap2Byte), 
																	 doVersion3 => (string)le.version3.numAircraft30, 
																	 ''));
	self.numAircraft90 := TRIM(map(doVersion2 => getMin((string)le.version2.numAircraft90,cap2Byte), 
																	 doVersion3 => (string)le.version3.numAircraft90, 
																	 ''));
	self.numAircraft180 := TRIM(map(doVersion2 => getMin((string)le.version2.numAircraft180,cap2Byte),
																		doVersion3 => (string)le.version3.numAircraft180,
																		''));
	self.numAircraft12 := TRIM(map(doVersion2 => getMin((string)le.version2.numAircraft12,cap2Byte), 
																	 doVersion3 => (string)le.version3.numAircraft12, 
																	 ''));
	self.numAircraft24 := TRIM(map(doVersion2 => getMin((string)le.version2.numAircraft24,cap2Byte), 
																	 doVersion3 => (string)le.version3.numAircraft24,
																	 ''));
	self.numAircraft36 := TRIM(map(doVersion2 => getMin((string)le.version2.numAircraft36,cap2Byte), 
																	 doVersion3 => (string)le.version3.numAircraft36, 
																	 ''));
	self.numAircraft60 := TRIM(map(doVersion2 => getMin((string)le.version2.numAircraft60,cap2Byte), 
																	 doVersion3 => (string)le.version3.numAircraft60,
																	 ''));
	self.wealth_indicator := map(doVersion2 => le.version2.wealth_indicator, 
															 doVersion3 => le.version3.wealth_indicator,
															 '');
	
	self.total_number_derogs_v2 := TRIM(map(doVersion2 => getMin((string)le.version2.total_number_derogs,cap2Byte), 
																						doVersion3 => (string)le.version3.total_number_derogs, 
																						''));
	self.date_last_derog_v2 := getMin(if(doVersion2, (string)le.version2.date_last_derog, ''), cap8Byte);
	self.felonies := TRIM(map(doVersion2 => getMin((string)le.version2.felonies,cap2Byte), 
															doVersion3 => (string)le.version3.felonies, 
															''));
	self.date_last_conviction := getMin(if(doVersion2, (string)le.version2.date_last_conviction, ''), cap8Byte);
	self.felonies30 := TRIM(map(doVersion2 => getMin((string)le.version2.felonies30,cap2Byte),
																doVersion3 => (string)le.version3.felonies30,
																''));
	self.felonies90 := TRIM(map(doVersion2 => getMin((string)le.version2.felonies90,cap2Byte), 
																doVersion3 => (string)le.version3.felonies90, 
																''));
	self.felonies180 := TRIM(map(doVersion2 => getMin((string)le.version2.felonies180,cap2Byte),
																 doVersion3 => (string)le.version3.felonies180,
																 ''));
	self.felonies12 := TRIM(map(doVersion2 => getMin((string)le.version2.felonies12,cap2Byte),
																doVersion3 => (string)le.version3.felonies12,
																''));
	self.felonies24 := TRIM(map(doVersion2 => getMin((string)le.version2.felonies24,cap2Byte),
																doVersion3 => (string)le.version3.felonies24,
																''));
	self.felonies36 := TRIM(map(doVersion2 => getMin((string)le.version2.felonies36,cap2Byte),
																doVersion3 => (string)le.version3.felonies36,
																''));
	self.felonies60 := TRIM(map(doVersion2 => getMin((string)le.version2.felonies60,cap2Byte),
																doVersion3 => (string)le.version3.felonies60,
																''));
	self.num_liens := TRIM(map(doVersion2 => getMin((string)le.version2.num_liens,cap2Byte),
															 doVersion3 => (string)le.version3.num_liens,
															 ''));
	self.num_unreleased_liens := TRIM(map(doVersion2 => getMin((string)le.version2.num_unreleased_liens,cap2Byte), 
																					doVersion3 => (string)le.version3.num_unreleased_liens, 
																					''));
	self.date_last_unreleased := getMin(if(doVersion2, (string)le.version2.date_last_unreleased, ''), cap8Byte);
	self.num_unreleased_liens30 := TRIM(map(doVersion2 => getMin((string)le.version2.num_unreleased_liens30,cap2Byte),
																						doVersion3 => (string)le.version3.num_unreleased_liens30,
																						''));
	self.num_unreleased_liens90 := TRIM(map(doVersion2 => getMin((string)le.version2.num_unreleased_liens90,cap2Byte), 
																						doVersion3 => (string)le.version3.num_unreleased_liens90, 
																						''));
	self.num_unreleased_liens180 := TRIM(map(doVersion2 => getMin((string)le.version2.num_unreleased_liens180,cap2Byte),
																						 doVersion3 => (string)le.version3.num_unreleased_liens180,
																						 ''));
	self.num_unreleased_liens12 := TRIM(map(doVersion2 => getMin((string)le.version2.num_unreleased_liens12,cap2Byte), 
																						doVersion3 => (string)le.version3.num_unreleased_liens12,
																						''));
	self.num_unreleased_liens24 := TRIM(map(doVersion2 => getMin((string)le.version2.num_unreleased_liens24,cap2Byte), 
																						doVersion3 => (string)le.version3.num_unreleased_liens24, 
																						''));
	self.num_unreleased_liens36 := TRIM(map(doVersion2 => getMin((string)le.version2.num_unreleased_liens36,cap2Byte),
																						doVersion3 => (string)le.version3.num_unreleased_liens36,
																						''));
	self.num_unreleased_liens60 := TRIM(map(doVersion2 => getMin((string)le.version2.num_unreleased_liens60,cap2Byte), 
																						doVersion3 => (string)le.version3.num_unreleased_liens60, 
																						''));
	self.num_released_liens := TRIM(map(doVersion2 => getMin((string)le.version2.num_released_liens,cap2Byte), 
																				doVersion3 => (string)le.version3.num_released_liens, 
																				''));
	self.date_last_released := getMin(if(doVersion2, (string)le.version2.date_last_released, ''), cap8Byte);
	self.num_released_liens30 := TRIM(map(doVersion2 => getMin((string)le.version2.num_released_liens30,cap2Byte),
																					doVersion3 => (string)le.version3.num_released_liens30,
																					''));
	self.num_released_liens90 := TRIM(map(doVersion2 => getMin((string)le.version2.num_released_liens90,cap2Byte), 
																					doVersion3 => (string)le.version3.num_released_liens90, 
																					''));
	self.num_released_liens180 := TRIM(map(doVersion2 => getMin((string)le.version2.num_released_liens180,cap2Byte),
																					 doVersion3 => (string)le.version3.num_released_liens180,
																					 ''));
	self.num_released_liens12 := TRIM(map(doVersion2 => getMin((string)le.version2.num_released_liens12,cap2Byte),
																					doVersion3 => (string)le.version3.num_released_liens12,
																					''));
	self.num_released_liens24 := TRIM(map(doVersion2 => getMin((string)le.version2.num_released_liens24,cap2Byte), 
																					doVersion3 => (string)le.version3.num_released_liens24, 
																					''));
	self.num_released_liens36 := TRIM(map(doVersion2 => getMin((string)le.version2.num_released_liens36,cap2Byte),
																					doVersion3 => (string)le.version3.num_released_liens36,
																					''));
	self.num_released_liens60 := TRIM(map(doVersion2 => getMin((string)le.version2.num_released_liens60,cap2Byte), 
																					doVersion3 => (string)le.version3.num_released_liens60, 
																					''));
	
	self.bankruptcy_count := TRIM(map(doVersion2 => getMin((string)le.version2.bankruptcy_count,cap2Byte), 
																			doVersion3 => (string)le.version3.bankruptcy_count, 
																			''));
	self.date_last_bankruptcy := getMin(if(doVersion2, (string)le.version2.date_last_bankruptcy, ''), cap8Byte);
	self.filing_type := map(doVersion2 => le.version2.filing_type, 
													doVersion3 => le.version3.filing_type, 
													'');
	self.disposition_v2 := map(doVersion2 => le.version2.disposition, 
														 doVersion3 => le.version3.disposition, 
														 '');
	self.bankruptcy_count30 := TRIM(map(doVersion2 => getMin((string)le.version2.bankruptcy_count30,cap2Byte), 
																				doVersion3 => (string)le.version3.bankruptcy_count30, 
																				''));
	self.bankruptcy_count90 := TRIM(map(doVersion2 => getMin((string)le.version2.bankruptcy_count90,cap2Byte), 
																				doVersion3 => (string)le.version3.bankruptcy_count90, 
																				''));
	self.bankruptcy_count180 := TRIM(map(doVersion2 => getMin((string)le.version2.bankruptcy_count180,cap2Byte), 
																				 doVersion3 => (string)le.version3.bankruptcy_count180, 
																				 ''));
	self.bankruptcy_count12 := TRIM(map(doVersion2 => getMin((string)le.version2.bankruptcy_count12,cap2Byte),
																				doVersion3 => (string)le.version3.bankruptcy_count12,
																				''));
	self.bankruptcy_count24 := TRIM(map(doVersion2 => getMin((string)le.version2.bankruptcy_count24,cap2Byte), 
																				doVersion3 => (string)le.version3.bankruptcy_count24, 
																				''));
	self.bankruptcy_count36 := TRIM(map(doVersion2 => getMin((string)le.version2.bankruptcy_count36,cap2Byte), 
																				doVersion3 => (string)le.version3.bankruptcy_count36, 
																				''));
	self.bankruptcy_count60 := TRIM(map(doVersion2 => getMin((string)le.version2.bankruptcy_count60,cap2Byte),
																				doVersion3 => (string)le.version3.bankruptcy_count60,
																				''));
	self.eviction_count := TRIM(map(doVersion2 => getMin((string)le.version2.eviction_count,cap2Byte),
																		doVersion3 => (string)le.version3.eviction_count,
																		''));
	self.date_last_eviction := getMin(if(doVersion2, (string)le.version2.date_last_eviction, ''), cap8Byte);
	self.eviction_count30 := TRIM(map(doVersion2 => getMin((string)le.version2.eviction_count30,cap2Byte), 
																			doVersion3 => (string)le.version3.eviction_count30, 
																			''));
	self.eviction_count90 := TRIM(map(doVersion2 => getMin((string)le.version2.eviction_count90,cap2Byte), 
																			doVersion3 => (string)le.version3.eviction_count90, 
																			''));
	self.eviction_count180 := TRIM(map(doVersion2 => getMin((string)le.version2.eviction_count180,cap2Byte), 
																			 doVersion3 => (string)le.version3.eviction_count180, 
																			 ''));
	self.eviction_count12 := TRIM(map(doVersion2 => getMin((string)le.version2.eviction_count12,cap2Byte),
																			doVersion3 => (string)le.version3.eviction_count12,
																			''));
	self.eviction_count24 := TRIM(map(doVersion2 => getMin((string)le.version2.eviction_count24,cap2Byte), 
																			doVersion3 => (string)le.version3.eviction_count24, 
																			''));
	self.eviction_count36 := TRIM(map(doVersion2 => getMin((string)le.version2.eviction_count36,cap2Byte),
																			doVersion3 => (string)le.version3.eviction_count36,
																			''));
	self.eviction_count60 := TRIM(map(doVersion2 => getMin((string)le.version2.eviction_count60,cap2Byte),
																			doVersion3 => (string)le.version3.eviction_count60,
																			''));

	self.num_nonderogs := TRIM(map(doVersion2 => getMin((string)le.version2.num_nonderogs, cap2Byte),
																	 doVersion3 => (string)le.version3.num_nonderogs,
																	 ''));
	self.num_nonderogs30 := TRIM(map(doVersion2 => getMin((string)le.version2.num_nonderogs30, cap2Byte), 
																		 doVersion3 => (string)le.version3.num_nonderogs30, 
																		 ''));
	self.num_nonderogs90 := TRIM(map(doVersion2 => getMin((string)le.version2.num_nonderogs90, cap2Byte), 
																		 doVersion3 => (string)le.version3.num_nonderogs90, 
																		 ''));
	self.num_nonderogs180 := TRIM(map(doVersion2 => getMin((string)le.version2.num_nonderogs180, cap2Byte), 
																			doVersion3 => (string)le.version3.num_nonderogs180, 
																			''));
	self.num_nonderogs12 := TRIM(map(doVersion2 => getMin((string)le.version2.num_nonderogs12, cap2Byte), 
																		 doVersion3 => (string)le.version3.num_nonderogs12, 
																		 ''));
	self.num_nonderogs24 := TRIM(map(doVersion2 => getMin((string)le.version2.num_nonderogs24, cap2Byte),
																		 doVersion3 => (string)le.version3.num_nonderogs24, 
																		 ''));
	self.num_nonderogs36 := TRIM(map(doVersion2 => getMin((string)le.version2.num_nonderogs36, cap2Byte), 
																		 doVersion3 => (string)le.version3.num_nonderogs36, 
																		 ''));
	self.num_nonderogs60 := TRIM(map(doVersion2 => getMin((string)le.version2.num_nonderogs60, cap2Byte), 
																		 doVersion3 => (string)le.version3.num_nonderogs60, 
																		 ''));
	self.num_proflic := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic, cap2Byte), 
																 doVersion3 => (string)le.version3.num_proflic, 
																 ''));
	self.date_last_proflic := getMin(if(doVersion2, (string)le.version2.date_last_proflic, ''), cap8Byte);
	self.proflic_type := map(doVersion2 => le.version2.proflic_type,
													 doVersion3 => le.version3.proflic_type,
													 '');
	self.expire_date_last_proflic := TRIM(map(doVersion2 => getMin((string)le.version2.expire_date_last_proflic, cap8Byte), 
																							doVersion3 => (string)le.version3.expire_date_last_proflic, 
																							''));
	self.num_proflic30 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic30,cap2Byte),
																	 doVersion3 => (string)le.version3.num_proflic30,
																	 ''));
	self.num_proflic90 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic90,cap2Byte),
																	 doVersion3 => (string)le.version3.num_proflic90,
																	 ''));
	self.num_proflic180 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic180,cap2Byte),
																		doVersion3 => (string)le.version3.num_proflic180,
																		''));
	self.num_proflic12 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic12,cap2Byte),
																	 doVersion3 => (string)le.version3.num_proflic12,
																	 ''));
	self.num_proflic24 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic24,cap2Byte), 
																	 doVersion3 => (string)le.version3.num_proflic24, 
																	 ''));
	self.num_proflic36 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic36,cap2Byte),
																	 doVersion3 => (string)le.version3.num_proflic36,
																	 ''));
	self.num_proflic60 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic60,cap2Byte), 
																	 doVersion3 => (string)le.version3.num_proflic60, 
																	 ''));
	self.num_proflic_exp30 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic_exp30,cap2Byte),
																			 doVersion3 => (string)le.version3.num_proflic_exp30,
																			 ''));
	self.num_proflic_exp90 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic_exp90,cap2Byte),
																			 doVersion3 => (string)le.version3.num_proflic_exp90,
																			 ''));
	self.num_proflic_exp180 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic_exp180,cap2Byte),
																				doVersion3 => (string)le.version3.num_proflic_exp180,
																				''));
	self.num_proflic_exp12 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic_exp12,cap2Byte), 
																			 doVersion3 => (string)le.version3.num_proflic_exp12, 
																			 ''));
	self.num_proflic_exp24 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic_exp24,cap2Byte), 
																			 doVersion3 => (string)le.version3.num_proflic_exp24, 
																			 ''));
	self.num_proflic_exp36 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic_exp36,cap2Byte), 
																			 doVersion3 => (string)le.version3.num_proflic_exp36, 
																			 ''));
	self.num_proflic_exp60 := TRIM(map(doVersion2 => getMin((string)le.version2.num_proflic_exp60,cap2Byte), 
																			 doVersion3 => (string)le.version3.num_proflic_exp60, 
																			 ''));
	
	
	self.isAddrHighRisk := TRIM(map(doVersion2 => checkBoolean(le.version2.isAddrHighRisk), 
														 doVersion3 => le.version3.AddrHighRisk,
														 ''));
	self.isPhoneHighRisk := TRIM(map(doVersion2 => checkBoolean(le.version2.isPhoneHighRisk),
															doVersion3 => le.version3.PhoneHighRisk,
															''));
	self.isAddrPrison := TRIM(map(doVersion2 => checkBoolean(le.version2.isAddrPrison),
													 doVersion3 => le.version3.AddrPrison,
													 ''));
	self.isZipPOBox := TRIM(map(doVersion2 => checkBoolean(le.version2.isZipPOBox), 
												 doVersion3 => le.version3.ZipPOBox, 
												 ''));
	self.isZipCorpMil := TRIM(map(doVersion2 => checkBoolean(le.version2.isZipCorpMil),
													 doVersion3 => le.version3.ZipCorpMil,
													 ''));
	self.phoneStatus := TRIM(map(doVersion2 => le.version2.phoneStatus, 
													doVersion3 => le.version3.phoneStatus, 
													''));
	self.isPhonePager := TRIM(map(doVersion2 => checkBoolean(le.version2.isPhonePager),
													 doVersion3 => le.version3.PhonePager,
													 ''));
	self.isPhoneMobile := TRIM(map(doVersion2 => checkBoolean(le.version2.isPhoneMobile),
														doVersion3 => le.version3.PhoneMobile,
														''));
	self.isPhoneZipMismatch := TRIM(map(doVersion2 => checkBoolean(le.version2.isPhoneZipMismatch), 
																 doVersion3 => le.version3.PhoneZipMismatch, 
																 ''));
	self.phoneAddrDist := if(map(doVersion2 => le.version2.phoneAddrDist, 
															 doVersion3 => (integer)le.version3.phoneAddrDist, 
															 0) > distCap, 
													 cap4Byte,
													 map(doVersion2 => TRIM((string)le.version2.phoneAddrDist), 
															 doVersion3 => le.version3.phoneAddrDist, 
															 ''));
	
	self.SecurityFreeze := map(doVersion2 => checkBoolean(le.version2.securityfreeze), 
														 doVersion3 => checkBoolean(le.version3.securityfreeze), 
														 doMoney OR doLifestyle OR doDemographic OR doFinancial OR doProperty OR doDerog => IF(le.version2.securityfreeze, '1', ''), // Need to carry a security freeze flag for the blankAttributes transform below.
														 '');
	self.SecurityAlert := map(doVersion2 => checkBoolean(le.version2.securityalert), 
														doVersion3 => checkBoolean(le.version3.securityalert), 
														'');
	self.IdTheftFlag := map(doVersion2 => checkBoolean(le.version2.idtheftflag), 
													doVersion3 => checkBoolean(le.version3.idtheftflag), 
													'');
	self.DisputeFlag := if(doVersion2, checkBoolean(le.version2.disputeflag), '');
	self.NegativeAlert := if(doVersion2, checkBoolean(le.version2.negativealert), '');
	self.CorrectedFlag := map(doVersion2 => checkBoolean(le.version2.correctedflag),
														doVersion3 => checkBoolean(le.version3.correctedflag),
														'');

	// Version3 only
	self.AgeOldestRecord := if(doVersion3, le.version3.AgeOldestRecord, ''); 
	self.AgeNewestRecord := if(doVersion3, le.version3.AgeNewestRecord, ''); 
	self.IAAgeOldestRecord := if(doVersion3, le.version3.IAAgeOldestRecord, '');
	self.IAAgeNewestRecord := if(doVersion3, le.version3.IAAgeNewestRecord, '');
	self.IAAgeLastSale := if(doVersion3, le.version3.IAAgeLastSale, '');
	self.CAAgeOldestRecord := if(doVersion3, le.version3.CAAgeOldestRecord, '');
	self.CAAgeNewestRecord := if(doVersion3, le.version3.CAAgeNewestRecord, '');
	self.CAAgeLastSale := if(doVersion3, le.version3.CAAgeLastSale, '');
	self.PAAgeOldestRecord := if(doVersion3, le.version3.PAAgeOldestRecord, '');
	self.PAAgeNewestRecord := if(doVersion3, le.version3.PAAgeNewestRecord, '');
	self.PAAgeLastSale := if(doVersion3, le.version3.PAAgeLastSale, '');
	self.PropAgeOldestPurchase := if(doVersion3, le.version3.PropAgeOldestPurchase, '');
	self.PropAgeNewestPurchase := if(doVersion3, le.version3.PropAgeNewestPurchase, '');
	self.PropAgeNewestSale := if(doVersion3, le.version3.PropAgeNewestSale, '');
	self.DerogAge := if(doVersion3, le.version3.DerogAge, '');
	self.FelonyAge := if(doVersion3, le.version3.FelonyAge, '');
	self.LienFiledAge := if(doVersion3, le.version3.LienFiledAge, '');
	self.LienReleasedAge := if(doVersion3, le.version3.LienReleasedAge, '');
	self.BankruptcyAge := if(doVersion3, le.version3.BankruptcyAge, '');
	self.EvictionAge := if(doVersion3, le.version3.EvictionAge, '');
	self.ProfLicAge := if(doVersion3, le.version3.ProfLicAge, '');

	self.SSNNotFound := if(doVersion3, le.version3.SSNNotFound, '');
	self.VerifiedName := if(doVersion3, TRIM((string)le.version3.VerifiedName), '');
	self.VerifiedSSN := if(doVersion3, TRIM((string)le.version3.VerifiedSSN), '');
	self.VerifiedPhone := if(doVersion3, TRIM((string)le.version3.VerifiedPhone), '');
	self.VerifiedAddress := if(doVersion3, TRIM((string)le.version3.VerifiedAddress), '');
	self.VerifiedDOB := if(doVersion3, TRIM((string)le.version3.VerifiedDOB), '');
	self.InferredMinimumAge := if(doVersion3, le.version3.InferredMinimumAge, '');
	self.BestReportedAge := if(doVersion3, le.version3.BestReportedAge, '');
	self.SubjectSSNCount := if(doVersion3, TRIM((string)le.version3.SubjectSSNCount), '');
	self.SubjectAddrCount := if(doVersion3, TRIM((string)le.version3.SubjectAddrCount), '');
	self.SubjectPhoneCount := if(doVersion3, TRIM((string)le.version3.SubjectPhoneCount), '');
	self.SubjectSSNRecentCount := if(doVersion3, TRIM((string)le.version3.SubjectSSNRecentCount), '');
	self.SubjectAddrRecentCount := if(doVersion3, TRIM((string)le.version3.SubjectAddrRecentCount), '');
	self.SubjectPhoneRecentCount := if(doVersion3, TRIM((string)le.version3.SubjectPhoneRecentCount), '');
	self.SSNIdentitiesCount := if(doVersion3, TRIM((string)le.version3.SSNIdentitiesCount), '');
	self.SSNAddrCount := if(doVersion3, TRIM((string)le.version3.SSNAddrCount), '');
	self.SSNIdentitiesRecentCount := if(doVersion3, TRIM((string)le.version3.SSNIdentitiesRecentCount), '');
	self.SSNAddrRecentCount := if(doVersion3, TRIM((string)le.version3.SSNAddrRecentCount), '');
	self.InputAddrIdentitiesCount := if(doVersion3, TRIM((string)le.version3.InputAddrIdentitiesCount), '');
	self.InputAddrSSNCount := if(doVersion3, TRIM((string)le.version3.InputAddrSSNCount), '');
	self.InputAddrPhoneCount := if(doVersion3, TRIM((string)le.version3.InputAddrPhoneCount), '');
	self.InputAddrIdentitiesRecentCount := if(doVersion3, TRIM((string)le.version3.InputAddrIdentitiesRecentCount), '');
	self.InputAddrSSNRecentCount := if(doVersion3, TRIM((string)le.version3.InputAddrSSNRecentCount), '');
	self.InputAddrPhoneRecentCount := if(doVersion3, TRIM((string)le.version3.InputAddrPhoneRecentCount), '');
	self.PhoneIdentitiesCount := if(doVersion3, TRIM((string)le.version3.PhoneIdentitiesCount), '');
	self.PhoneIdentitiesRecentCount := if(doVersion3, TRIM((string)le.version3.PhoneIdentitiesRecentCount), '');
	self.SSNIssuedPriorDOB := if(doVersion3, le.version3.SSNIssuedPriorDOB, '');
	
	self.InputAddrTaxYr := if(doVersion3, le.version3.InputAddrTaxYr, '');
	self.InputAddrTaxMarketValue := if(doVersion3, TRIM((string)le.version3.InputAddrTaxMarketValue), '');
	self.InputAddrAVMTax := if(doVersion3, TRIM((string)le.version3.InputAddrAVMTax), '');
	self.InputAddrAVMSalesPrice := if(doVersion3, TRIM((string)le.version3.InputAddrAVMSalesPrice), '');
	self.InputAddrAVMHedonic := if(doVersion3, TRIM((string)le.version3.InputAddrAVMHedonic), '');
	self.InputAddrAVMValue := if(doVersion3, TRIM((string)le.version3.InputAddrAVMValue), '');
	self.InputAddrAVMConfidence := if(doVersion3, TRIM((string)le.version3.InputAddrAVMConfidence), '');
	self.InputAddrCountyIndex := if(doVersion3, TRIM((string)le.version3.InputAddrCountyIndex), '');
	self.InputAddrTractIndex := if(doVersion3, TRIM((string)le.version3.InputAddrTractIndex), '');
	self.InputAddrBlockIndex := if(doVersion3, TRIM((string)le.version3.InputAddrBlockIndex), '');
	
	self.CurrAddrTaxYr := if(doVersion3, le.version3.CurrAddrTaxYr, '');
	self.CurrAddrTaxMarketValue := if(doVersion3, TRIM((string)le.version3.CurrAddrTaxMarketValue), '');
	self.CurrAddrAVMTax := if(doVersion3, TRIM((string)le.version3.CurrAddrAVMTax), '');
	self.CurrAddrAVMSalesPrice := if(doVersion3, TRIM((string)le.version3.CurrAddrAVMSalesPrice), '');
	self.CurrAddrAVMHedonic := if(doVersion3, TRIM((string)le.version3.CurrAddrAVMHedonic), '');
	self.CurrAddrAVMValue := if(doVersion3, TRIM((string)le.version3.CurrAddrAVMValue), '');
	self.CurrAddrAVMConfidence := if(doVersion3, TRIM((string)le.version3.CurrAddrAVMConfidence), '');
	self.CurrAddrCountyIndex := if(doVersion3, TRIM((string)le.version3.CurrAddrCountyIndex), '');
	self.CurrAddrTractIndex := if(doVersion3, TRIM((string)le.version3.CurrAddrTractIndex), '');
	self.CurrAddrBlockIndex := if(doVersion3, TRIM((string)le.version3.CurrAddrBlockIndex), '');
	
	self.PrevAddrTaxYr := if(doVersion3, le.version3.PrevAddrTaxYr, '');
	self.PrevAddrTaxMarketValue := if(doVersion3, TRIM((string)le.version3.PrevAddrTaxMarketValue), '');
	self.PrevAddrAVMTax := if(doVersion3, TRIM((string)le.version3.PrevAddrAVMTax), '');
	self.PrevAddrAVMSalesPrice := if(doVersion3, TRIM((string)le.version3.PrevAddrAVMSalesPrice), '');
	self.PrevAddrAVMHedonic := if(doVersion3, TRIM((string)le.version3.PrevAddrAVMHedonic), '');
	self.PrevAddrAVMValue := if(doVersion3, TRIM((string)le.version3.PrevAddrAVMValue), '');
	self.PrevAddrAVMConfidence := if(doVersion3, TRIM((string)le.version3.PrevAddrAVMConfidence), '');
	self.PrevAddrCountyIndex := if(doVersion3, TRIM((string)le.version3.PrevAddrCountyIndex), '');
	self.PrevAddrTractIndex := if(doVersion3, TRIM((string)le.version3.PrevAddrTractIndex), '');
	self.PrevAddrBlockIndex := if(doVersion3, TRIM((string)le.version3.PrevAddrBlockIndex), '');
	
	self.EducationAttendedCollege := if(doVersion3, le.version3.EducationAttendedCollege, '');
	self.EducationProgram2Yr := if(doVersion3, le.version3.EducationProgram2Yr, '');
	self.EducationProgram4Yr := if(doVersion3, le.version3.EducationProgram4Yr, '');
	self.EducationProgramGraduate := if(doVersion3, le.version3.EducationProgramGraduate, '');
	self.EducationInstitutionPrivate := if(doVersion3, le.version3.EducationInstitutionPrivate, '');
	self.EducationInstitutionRating := if(doVersion3, le.version3.EducationInstitutionRating, '');
	
	self.PredictedAnnualIncome := if(doVersion3, le.version3.PredictedAnnualIncome, '');
	
	self.PropNewestSalePrice := if(doVersion3, TRIM((string)le.version3.PropNewestSalePrice), '');
	self.PropNewestSalePurchaseIndex := if(doVersion3, TRIM((string)le.version3.PropNewestSalePurchaseIndex), '');
	self.PropNewestSaleTaxIndex := '';//if(doVersion3, (string)le.version3.PropNewestSaleTaxIndex, '');	these are not going to be output
	self.PropNewestSaleAVMIndex := '';//if(doVersion3, (string)le.version3.PropNewestSaleAVMIndex, '');
	
	self.SubPrimeSolicitedCount := if(doVersion3, TRIM((string)le.version3.SubPrimeSolicitedCount), '');
	self.SubPrimeSolicitedCount01 := if(doVersion3, TRIM((string)le.version3.SubPrimeSolicitedCount01), '');
	self.SubprimeSolicitedCount03 := if(doVersion3, TRIM((string)le.version3.SubprimeSolicitedCount03), '');
	self.SubprimeSolicitedCount06 := if(doVersion3, TRIM((string)le.version3.SubprimeSolicitedCount06), '');
	self.SubPrimeSolicitedCount12 := if(doVersion3, TRIM((string)le.version3.SubPrimeSolicitedCount12), '');
	self.SubPrimeSolicitedCount24 := if(doVersion3, TRIM((string)le.version3.SubPrimeSolicitedCount24), '');
	self.SubPrimeSolicitedCount36 := if(doVersion3, TRIM((string)le.version3.SubPrimeSolicitedCount36), '');
	self.SubPrimeSolicitedCount60 := if(doVersion3, TRIM((string)le.version3.SubPrimeSolicitedCount60), '');
	
	self.LienFederalTaxFiledTotal := if(doVersion3, TRIM((string)le.version3.LienFederalTaxFiledTotal), '');
	self.LienTaxOtherFiledTotal := if(doVersion3, TRIM((string)le.version3.LienTaxOtherFiledTotal), '');
	self.LienForeclosureFiledTotal := if(doVersion3, TRIM((string)le.version3.LienForeclosureFiledTotal), '');
	self.LienPreforeclosureFiledTotal := if(doVersion3, TRIM((string)le.version3.LienPreforeclosureFiledTotal), '');
	self.LienLandlordTenantFiledTotal := if(doVersion3, TRIM((string)le.version3.LienLandlordTenantFiledTotal), '');
	self.LienJudgmentFiledTotal := if(doVersion3, TRIM((string)le.version3.LienJudgmentFiledTotal), '');
	self.LienSmallClaimsFiledTotal := if(doVersion3, TRIM((string)le.version3.LienSmallClaimsFiledTotal), '');
	self.LienOtherFiledTotal := if(doVersion3, TRIM((string)le.version3.LienOtherFiledTotal), '');
	self.LienFederalTaxReleasedTotal := if(doVersion3, TRIM((string)le.version3.LienFederalTaxReleasedTotal), '');
	self.LienTaxOtherReleasedTotal := if(doVersion3, TRIM((string)le.version3.LienTaxOtherReleasedTotal), '');
	self.LienForeclosureReleasedTotal := if(doVersion3, TRIM((string)le.version3.LienForeclosureReleasedTotal), '');
	self.LienPreforeclosureReleasedTotal := if(doVersion3, TRIM((string)le.version3.LienPreforeclosureReleasedTotal), '');
	self.LienLandlordTenantReleasedTotal := if(doVersion3, TRIM((string)le.version3.LienLandlordTenantReleasedTotal), '');
	self.LienJudgmentReleasedTotal := if(doVersion3, TRIM((string)le.version3.LienJudgmentReleasedTotal), '');
	self.LienSmallClaimsReleasedTotal := if(doVersion3, TRIM((string)le.version3.LienSmallClaimsReleasedTotal), '');
	self.LienOtherReleasedTotal := if(doVersion3, TRIM((string)le.version3.LienOtherReleasedTotal), '');
	
	self.LienFederalTaxFiledCount := if(doVersion3, TRIM((string)le.version3.LienFederalTaxFiledCount), '');
	self.LienTaxOtherFiledCount := if(doVersion3, TRIM((string)le.version3.LienTaxOtherFiledCount), '');
	self.LienForeclosureFiledCount := if(doVersion3, TRIM((string)le.version3.LienForeclosureFiledCount), '');
	self.LienPreforeclosureFiledCount := if(doVersion3, TRIM((string)le.version3.LienPreforeclosureFiledCount), '');
	self.LienLandlordTenantFiledCount := if(doVersion3, TRIM((string)le.version3.LienLandlordTenantFiledCount), '');
	self.LienJudgmentFiledCount := if(doVersion3, TRIM((string)le.version3.LienJudgmentFiledCount), '');
	self.LienSmallClaimsFiledCount := if(doVersion3, TRIM((string)le.version3.LienSmallClaimsFiledCount), '');
	self.LienOtherFiledCount := if(doVersion3, TRIM((string)le.version3.LienOtherFiledCount), '');
	self.LienFederalTaxReleasedCount := if(doVersion3, TRIM((string)le.version3.LienFederalTaxReleasedCount), '');
	self.LienTaxOtherReleasedCount := if(doVersion3, TRIM((string)le.version3.LienTaxOtherReleasedCount), '');
	self.LienForeclosureReleasedCount := if(doVersion3, TRIM((string)le.version3.LienForeclosureReleasedCount), '');
	self.LienPreforeclosureReleasedCount := if(doVersion3, TRIM((string)le.version3.LienPreforeclosureReleasedCount), '');
	self.LienLandlordTenantReleasedCount := if(doVersion3, TRIM((string)le.version3.LienLandlordTenantReleasedCount), '');
	self.LienJudgmentReleasedCount := if(doVersion3, TRIM((string)le.version3.LienJudgmentReleasedCount), '');
	self.LienSmallClaimsReleasedCount := if(doVersion3, TRIM((string)le.version3.LienSmallClaimsReleasedCount), '');
	self.LienOtherReleasedCount := if(doVersion3, TRIM((string)le.version3.LienOtherReleasedCount), '');
	
	self.ProfLicTypeCategory := if(doVersion3, le.version3.ProfLicTypeCategory, '');
	
	self.PhoneEDAAgeOldestRecord := if(doVersion3, le.version3.PhoneEDAAgeOldestRecord, '');
	self.PhoneEDAAgeNewestRecord := if(doVersion3, le.version3.PhoneEDAAgeNewestRecord, '');
	self.PhoneOtherAgeOldestRecord := if(doVersion3, le.version3.PhoneOtherAgeOldestRecord, '');
	self.PhoneOtherAgeNewestRecord := if(doVersion3, le.version3.PhoneOtherAgeNewestRecord, '');
	
	self.PrescreenOptOut := if(doVersion3, le.version3.PrescreenOptOut, '');
	
	self.v4_AgeOldestRecord	:= if(doVersion4, le.v4_AgeOldestRecord	, '');
	self.v4_AgeNewestRecord	:= if(doVersion4, le.v4_AgeNewestRecord	, '');
	self.v4_RecentUpdate	:= if(doVersion4, le.v4_RecentUpdate	, '');
	self.v4_SrcsConfirmIDAddrCount	:= if(doVersion4, le.v4_SrcsConfirmIDAddrCount	, '');
	self.v4_InvalidDL	:= if(doVersion4, le.v4_InvalidDL	, '');
	self.v4_VerificationFailure	:= if(doVersion4, le.v4_VerificationFailure	, '');
	self.v4_SSNNotFound	:= if(doVersion4, le.v4_SSNNotFound	, '');
	self.v4_VerifiedName	:= if(doVersion4, le.v4_VerifiedName	, '');
	self.v4_VerifiedSSN	:= if(doVersion4, le.v4_VerifiedSSN	, '');
	self.v4_VerifiedPhone	:= if(doVersion4, le.v4_VerifiedPhone	, '');
	self.v4_VerifiedAddress	:= if(doVersion4, le.v4_VerifiedAddress	, '');
	self.v4_VerifiedDOB	:= if(doVersion4, le.v4_VerifiedDOB	, '');
	self.v4_InferredMinimumAge	:= if(doVersion4, le.v4_InferredMinimumAge	, '');
	self.v4_BestReportedAge	:= if(doVersion4, le.v4_BestReportedAge	, '');
	self.v4_SubjectSSNCount	:= if(doVersion4, le.v4_SubjectSSNCount	, '');
	self.v4_SubjectAddrCount	:= if(doVersion4, le.v4_SubjectAddrCount	, '');
	self.v4_SubjectPhoneCount	:= if(doVersion4, le.v4_SubjectPhoneCount	, '');
	self.v4_SubjectSSNRecentCount	:= if(doVersion4, le.v4_SubjectSSNRecentCount	, '');
	self.v4_SubjectAddrRecentCount	:= if(doVersion4, le.v4_SubjectAddrRecentCount	, '');
	self.v4_SubjectPhoneRecentCount	:= if(doVersion4, le.v4_SubjectPhoneRecentCount	, '');
	self.v4_SSNIdentitiesCount	:= if(doVersion4, le.v4_SSNIdentitiesCount	, '');
	self.v4_SSNAddrCount	:= if(doVersion4, le.v4_SSNAddrCount	, '');
	self.v4_SSNIdentitiesRecentCount	:= if(doVersion4, le.v4_SSNIdentitiesRecentCount	, '');
	self.v4_SSNAddrRecentCount	:= if(doVersion4, le.v4_SSNAddrRecentCount	, '');
	self.v4_InputAddrPhoneCount	:= if(doVersion4, le.v4_InputAddrPhoneCount	, '');
	self.v4_InputAddrPhoneRecentCount	:= if(doVersion4, le.v4_InputAddrPhoneRecentCount	, '');
	self.v4_PhoneIdentitiesCount	:= if(doVersion4, le.v4_PhoneIdentitiesCount	, '');
	self.v4_PhoneIdentitiesRecentCount	:= if(doVersion4, le.v4_PhoneIdentitiesRecentCount	, '');
	self.v4_SSNAgeDeceased	:= if(doVersion4, le.v4_SSNAgeDeceased	, '');
	self.v4_SSNRecent	:= if(doVersion4, le.v4_SSNRecent	, '');
	self.v4_SSNLowIssueAge	:= if(doVersion4, le.v4_SSNLowIssueAge	, '');
	self.v4_SSNHighIssueAge	:= if(doVersion4, le.v4_SSNHighIssueAge	, '');
	self.v4_SSNIssueState	:= if(doVersion4, le.v4_SSNIssueState	, '');
	self.v4_SSNNonUS	:= if(doVersion4, le.v4_SSNNonUS	, '');
	self.v4_SSN3Years	:= if(doVersion4, le.v4_SSN3Years	, '');
	self.v4_SSNAfter5 	:= if(doVersion4, le.v4_SSNAfter5 	, '');
	self.v4_SSNProblems	:= if(doVersion4, le.v4_SSNProblems	, '');
	self.v4_InputAddrAgeOldestRecord	:= if(doVersion4, le.v4_InputAddrAgeOldestRecord	, '');
	self.v4_InputAddrAgeNewestRecord	:= if(doVersion4, le.v4_InputAddrAgeNewestRecord	, '');
	self.v4_InputAddrHistoricalMatch	:= if(doVersion4, le.v4_InputAddrHistoricalMatch	, '');
	self.v4_InputAddrLenOfRes 	:= if(doVersion4, le.v4_InputAddrLenOfRes 	, '');
	self.v4_InputAddrDwellType 	:= if(doVersion4, le.v4_InputAddrDwellType 	, '');
	self.v4_InputAddrDelivery	:= if(doVersion4, le.v4_InputAddrDelivery	, '');
	self.v4_InputAddrApplicantOwned	:= if(doVersion4, le.v4_InputAddrApplicantOwned	, '');
	self.v4_InputAddrFamilyOwned	:= if(doVersion4, le.v4_InputAddrFamilyOwned	, '');
	self.v4_InputAddrOccupantOwned 	:= if(doVersion4, le.v4_InputAddrOccupantOwned 	, '');
	self.v4_InputAddrAgeLastSale	:= if(doVersion4, le.v4_InputAddrAgeLastSale	, '');
	self.v4_InputAddrLastSalesPrice	:= if(doVersion4, le.v4_InputAddrLastSalesPrice	, '');
	self.v4_InputAddrMortgageType	:= if(doVersion4, le.v4_InputAddrMortgageType	, '');
	self.v4_InputAddrNotPrimaryRes 	:= if(doVersion4, le.v4_InputAddrNotPrimaryRes 	, '');
	self.v4_InputAddrActivePhoneList 	:= if(doVersion4, le.v4_InputAddrActivePhoneList 	, '');
	self.v4_InputAddrTaxValue 	:= if(doVersion4, le.v4_InputAddrTaxValue 	, '');
	self.v4_InputAddrTaxYr	:= if(doVersion4, le.v4_InputAddrTaxYr	, '');
	self.v4_InputAddrTaxMarketValue	:= if(doVersion4, le.v4_InputAddrTaxMarketValue	, '');
	self.v4_InputAddrAVMValue	:= if(doVersion4, le.v4_InputAddrAVMValue	, '');
	self.v4_InputAddrAVMValue12	:= if(doVersion4, le.v4_InputAddrAVMValue12	, '');
	self.v4_InputAddrAVMValue60	:= if(doVersion4, le.v4_InputAddrAVMValue60	, '');
	self.v4_InputAddrCountyIndex	:= if(doVersion4, le.v4_InputAddrCountyIndex	, '');
	self.v4_InputAddrTractIndex	:= if(doVersion4, le.v4_InputAddrTractIndex	, '');
	self.v4_InputAddrBlockIndex	:= if(doVersion4, le.v4_InputAddrBlockIndex	, '');
	self.v4_CurrAddrAgeOldestRecord	:= if(doVersion4, le.v4_CurrAddrAgeOldestRecord	, '');
	self.v4_CurrAddrAgeNewestRecord	:= if(doVersion4, le.v4_CurrAddrAgeNewestRecord	, '');
	self.v4_CurrAddrLenOfRes 	:= if(doVersion4, le.v4_CurrAddrLenOfRes 	, '');
	self.v4_CurrAddrDwellType 	:= if(doVersion4, le.v4_CurrAddrDwellType 	, '');
	self.v4_CurrAddrApplicantOwned 	:= if(doVersion4, le.v4_CurrAddrApplicantOwned 	, '');
	self.v4_CurrAddrFamilyOwned 	:= if(doVersion4, le.v4_CurrAddrFamilyOwned 	, '');
	self.v4_CurrAddrOccupantOwned 	:= if(doVersion4, le.v4_CurrAddrOccupantOwned 	, '');
	self.v4_CurrAddrAgeLastSale	:= if(doVersion4, le.v4_CurrAddrAgeLastSale	, '');
	self.v4_CurrAddrLastSalesPrice	:= if(doVersion4, le.v4_CurrAddrLastSalesPrice	, '');
	self.v4_CurrAddrMortgageType	:= if(doVersion4, le.v4_CurrAddrMortgageType	, '');
	self.v4_CurrAddrActivePhoneList 	:= if(doVersion4, le.v4_CurrAddrActivePhoneList 	, '');
	self.v4_CurrAddrTaxValue 	:= if(doVersion4, le.v4_CurrAddrTaxValue 	, '');
	self.v4_CurrAddrTaxYr	:= if(doVersion4, le.v4_CurrAddrTaxYr	, '');
	self.v4_CurrAddrTaxMarketValue	:= if(doVersion4, le.v4_CurrAddrTaxMarketValue	, '');
	self.v4_CurrAddrAVMValue	:= if(doVersion4, le.v4_CurrAddrAVMValue	, '');
	self.v4_CurrAddrAVMValue12	:= if(doVersion4, le.v4_CurrAddrAVMValue12	, '');
	self.v4_CurrAddrAVMValue60	:= if(doVersion4, le.v4_CurrAddrAVMValue60	, '');
	self.v4_CurrAddrCountyIndex	:= if(doVersion4, le.v4_CurrAddrCountyIndex	, '');
	self.v4_CurrAddrTractIndex	:= if(doVersion4, le.v4_CurrAddrTractIndex	, '');
	self.v4_CurrAddrBlockIndex	:= if(doVersion4, le.v4_CurrAddrBlockIndex	, '');
	self.v4_PrevAddrAgeOldestRecord	:= if(doVersion4, le.v4_PrevAddrAgeOldestRecord	, '');
	self.v4_PrevAddrAgeNewestRecord	:= if(doVersion4, le.v4_PrevAddrAgeNewestRecord	, '');
	self.v4_PrevAddrLenOfRes 	:= if(doVersion4, le.v4_PrevAddrLenOfRes 	, '');
	self.v4_PrevAddrDwellType 	:= if(doVersion4, le.v4_PrevAddrDwellType 	, '');
	self.v4_PrevAddrApplicantOwned 	:= if(doVersion4, le.v4_PrevAddrApplicantOwned 	, '');
	self.v4_PrevAddrFamilyOwned 	:= if(doVersion4, le.v4_PrevAddrFamilyOwned 	, '');
	self.v4_PrevAddrOccupantOwned	:= if(doVersion4, le.v4_PrevAddrOccupantOwned	, '');
	self.v4_PrevAddrAgeLastSale	:= if(doVersion4, le.v4_PrevAddrAgeLastSale	, '');
	self.v4_PrevAddrLastSalesPrice	:= if(doVersion4, le.v4_PrevAddrLastSalesPrice	, '');
	self.v4_PrevAddrTaxValue	:= if(doVersion4, le.v4_PrevAddrTaxValue	, '');
	self.v4_PrevAddrTaxYr	:= if(doVersion4, le.v4_PrevAddrTaxYr	, '');
	self.v4_PrevAddrTaxMarketValue	:= if(doVersion4, le.v4_PrevAddrTaxMarketValue	, '');
	self.v4_PrevAddrAVMValue	:= if(doVersion4, le.v4_PrevAddrAVMValue	, '');
	self.v4_PrevAddrCountyIndex	:= if(doVersion4, le.v4_PrevAddrCountyIndex	, '');
	self.v4_PrevAddrTractIndex	:= if(doVersion4, le.v4_PrevAddrTractIndex	, '');
	self.v4_PrevAddrBlockIndex	:= if(doVersion4, le.v4_PrevAddrBlockIndex	, '');
	self.v4_AddrMostRecentDistance	:= if(doVersion4, le.v4_AddrMostRecentDistance	, '');
	self.v4_AddrMostRecentStateDiff	:= if(doVersion4, le.v4_AddrMostRecentStateDiff	, '');
	self.v4_AddrMostRecentTaxDiff	:= if(doVersion4, le.v4_AddrMostRecentTaxDiff	, '');
	self.v4_AddrMostRecentMoveAge	:= if(doVersion4, le.v4_AddrMostRecentMoveAge	, '');
	self.v4_AddrRecentEconTrajectory	:= if(doVersion4, le.v4_AddrRecentEconTrajectory	, '');
	self.v4_AddrRecentEconTrajectoryIndex	:= if(doVersion4, le.v4_AddrRecentEconTrajectoryIndex	, '');
	self.v4_EducationAttendedCollege	:= if(doVersion4, le.v4_EducationAttendedCollege	, '');
	self.v4_EducationProgram2Yr	:= if(doVersion4, le.v4_EducationProgram2Yr	, '');
	self.v4_EducationProgram4Yr	:= if(doVersion4, le.v4_EducationProgram4Yr	, '');
	self.v4_EducationProgramGraduate	:= if(doVersion4, le.v4_EducationProgramGraduate	, '');
	self.v4_EducationInstitutionPrivate	:= if(doVersion4, le.v4_EducationInstitutionPrivate	, '');
	self.v4_EducationFieldofStudyType	:= if(doVersion4, le.v4_EducationFieldofStudyType	, '');
	self.v4_EducationInstitutionRating	:= if(doVersion4, le.v4_EducationInstitutionRating	, '');
	self.v4_AddrStability 	:= if(doVersion4, le.v4_AddrStability 	, '');
	self.v4_StatusMostRecent 	:= if(doVersion4, le.v4_StatusMostRecent 	, '');
	self.v4_StatusPrevious 	:= if(doVersion4, le.v4_StatusPrevious 	, '');
	self.v4_StatusNextPrevious	:= if(doVersion4, le.v4_StatusNextPrevious	, '');
	self.v4_AddrChangeCount01	:= if(doVersion4, le.v4_AddrChangeCount01	, '');
	self.v4_AddrChangeCount03	:= if(doVersion4, le.v4_AddrChangeCount03	, '');
	self.v4_AddrChangeCount06	:= if(doVersion4, le.v4_AddrChangeCount06	, '');
	self.v4_AddrChangeCount12	:= if(doVersion4, le.v4_AddrChangeCount12	, '');
	self.v4_AddrChangeCount24 	:= if(doVersion4, le.v4_AddrChangeCount24 	, '');
	self.v4_AddrChangeCount60 	:= if(doVersion4, le.v4_AddrChangeCount60 	, '');
	self.v4_EstimatedAnnualIncome	:= if(doVersion4, le.v4_EstimatedAnnualIncome	, '');
	self.v4_PropertyOwner	:= if(doVersion4, le.v4_PropertyOwner	, '');
	self.v4_PropOwnedCount	:= if(doVersion4, le.v4_PropOwnedCount	, '');
	self.v4_PropOwnedTaxTotal	:= if(doVersion4, le.v4_PropOwnedTaxTotal	, '');
	self.v4_PropOwnedHistoricalCount	:= if(doVersion4, le.v4_PropOwnedHistoricalCount	, '');
	self.v4_PropAgeOldestPurchase	:= if(doVersion4, le.v4_PropAgeOldestPurchase	, '');
	self.v4_PropAgeNewestPurchase	:= if(doVersion4, le.v4_PropAgeNewestPurchase	, '');
	self.v4_PropAgeNewestSale	:= if(doVersion4, le.v4_PropAgeNewestSale	, '');
	self.v4_PropNewestSalePrice	:= if(doVersion4, le.v4_PropNewestSalePrice	, '');
	self.v4_PropNewestSalePurchaseIndex	:= if(doVersion4, le.v4_PropNewestSalePurchaseIndex	, '');
	self.v4_PropPurchasedCount01	:= if(doVersion4, le.v4_PropPurchasedCount01	, '');
	self.v4_PropPurchasedCount03	:= if(doVersion4, le.v4_PropPurchasedCount03	, '');
	self.v4_PropPurchasedCount06	:= if(doVersion4, le.v4_PropPurchasedCount06	, '');
	self.v4_PropPurchasedCount12	:= if(doVersion4, le.v4_PropPurchasedCount12	, '');
	self.v4_PropPurchasedCount24	:= if(doVersion4, le.v4_PropPurchasedCount24	, '');
	self.v4_PropPurchasedCount60	:= if(doVersion4, le.v4_PropPurchasedCount60	, '');
	self.v4_PropSoldCount01	:= if(doVersion4, le.v4_PropSoldCount01	, '');
	self.v4_PropSoldCount03	:= if(doVersion4, le.v4_PropSoldCount03	, '');
	self.v4_PropSoldCount06	:= if(doVersion4, le.v4_PropSoldCount06	, '');
	self.v4_PropSoldCount12	:= if(doVersion4, le.v4_PropSoldCount12	, '');
	self.v4_PropSoldCount24 	:= if(doVersion4, le.v4_PropSoldCount24 	, '');
	self.v4_PropSoldCount60 	:= if(doVersion4, le.v4_PropSoldCount60 	, '');
	self.v4_AssetOwner	:= if(doVersion4, le.v4_AssetOwner	, '');
	self.v4_WatercraftOwner	:= if(doVersion4, le.v4_WatercraftOwner	, '');
	self.v4_WatercraftCount	:= if(doVersion4, le.v4_WatercraftCount	, '');
	self.v4_WatercraftCount01	:= if(doVersion4, le.v4_WatercraftCount01	, '');
	self.v4_WatercraftCount03	:= if(doVersion4, le.v4_WatercraftCount03	, '');
	self.v4_WatercraftCount06	:= if(doVersion4, le.v4_WatercraftCount06	, '');
	self.v4_WatercraftCount12 	:= if(doVersion4, le.v4_WatercraftCount12 	, '');
	self.v4_WatercraftCount24	:= if(doVersion4, le.v4_WatercraftCount24	, '');
	self.v4_WatercraftCount60 	:= if(doVersion4, le.v4_WatercraftCount60 	, '');
	self.v4_AircraftOwner	:= if(doVersion4, le.v4_AircraftOwner	, '');
	self.v4_AircraftCount	:= if(doVersion4, le.v4_AircraftCount	, '');
	self.v4_AircraftCount01	:= if(doVersion4, le.v4_AircraftCount01	, '');
	self.v4_AircraftCount03	:= if(doVersion4, le.v4_AircraftCount03	, '');
	self.v4_AircraftCount06	:= if(doVersion4, le.v4_AircraftCount06	, '');
	self.v4_AircraftCount12 	:= if(doVersion4, le.v4_AircraftCount12 	, '');
	self.v4_AircraftCount24	:= if(doVersion4, le.v4_AircraftCount24	, '');
	self.v4_AircraftCount60 	:= if(doVersion4, le.v4_AircraftCount60 	, '');
	self.v4_WealthIndex 	:= if(doVersion4, le.v4_WealthIndex 	, '');
	self.v4_BusinessActiveAssociation	:= if(doVersion4, le.v4_BusinessActiveAssociation	, '');
	self.v4_BusinessInactiveAssociation	:= if(doVersion4, le.v4_BusinessInactiveAssociation	, '');
	self.v4_BusinessAssociationAge	:= if(doVersion4, le.v4_BusinessAssociationAge	, '');
	self.v4_BusinessTitle	:= if(doVersion4, le.v4_BusinessTitle	, '');
	self.v4_DerogSeverityIndex	:= if(doVersion4, le.v4_DerogSeverityIndex	, '');
	self.v4_DerogCount	:= if(doVersion4, le.v4_DerogCount	, '');
	self.v4_DerogRecentCount	:= if(doVersion4, le.v4_DerogRecentCount	, '');
	self.v4_DerogAge	:= if(doVersion4, le.v4_DerogAge	, '');
	self.v4_FelonyCount	:= if(doVersion4, le.v4_FelonyCount	, '');
	self.v4_FelonyAge	:= if(doVersion4, le.v4_FelonyAge	, '');
	self.v4_FelonyCount01	:= if(doVersion4, le.v4_FelonyCount01	, '');
	self.v4_FelonyCount03	:= if(doVersion4, le.v4_FelonyCount03	, '');
	self.v4_FelonyCount06	:= if(doVersion4, le.v4_FelonyCount06	, '');
	self.v4_FelonyCount12	:= if(doVersion4, le.v4_FelonyCount12	, '');
	self.v4_FelonyCount24	:= if(doVersion4, le.v4_FelonyCount24	, '');
	self.v4_FelonyCount60	:= if(doVersion4, le.v4_FelonyCount60	, '');
	self.v4_LienCount	:= if(doVersion4, le.v4_LienCount	, '');
	self.v4_LienFiledCount	:= if(doVersion4, le.v4_LienFiledCount	, '');
	self.v4_LienFiledAge	:= if(doVersion4, le.v4_LienFiledAge	, '');
	self.v4_LienFiledCount01	:= if(doVersion4, le.v4_LienFiledCount01	, '');
	self.v4_LienFiledCount03	:= if(doVersion4, le.v4_LienFiledCount03	, '');
	self.v4_LienFiledCount06	:= if(doVersion4, le.v4_LienFiledCount06	, '');
	self.v4_LienFiledCount12	:= if(doVersion4, le.v4_LienFiledCount12	, '');
	self.v4_LienFiledCount24	:= if(doVersion4, le.v4_LienFiledCount24	, '');
	self.v4_LienFiledCount60	:= if(doVersion4, le.v4_LienFiledCount60	, '');
	self.v4_LienReleasedCount	:= if(doVersion4, le.v4_LienReleasedCount	, '');
	self.v4_LienReleasedAge	:= if(doVersion4, le.v4_LienReleasedAge	, '');
	self.v4_LienReleasedCount01	:= if(doVersion4, le.v4_LienReleasedCount01	, '');
	self.v4_LienReleasedCount03	:= if(doVersion4, le.v4_LienReleasedCount03	, '');
	self.v4_LienReleasedCount06	:= if(doVersion4, le.v4_LienReleasedCount06	, '');
	self.v4_LienReleasedCount12	:= if(doVersion4, le.v4_LienReleasedCount12	, '');
	self.v4_LienReleasedCount24	:= if(doVersion4, le.v4_LienReleasedCount24	, '');
	self.v4_LienReleasedCount60	:= if(doVersion4, le.v4_LienReleasedCount60	, '');
	self.v4_LienFiledTotal	:= if(doVersion4, le.v4_LienFiledTotal	, '');
	self.v4_LienFederalTaxFiledTotal	:= if(doVersion4, le.v4_LienFederalTaxFiledTotal	, '');
	self.v4_LienTaxOtherFiledTotal	:= if(doVersion4, le.v4_LienTaxOtherFiledTotal	, '');
	self.v4_LienForeclosureFiledTotal	:= if(doVersion4, le.v4_LienForeclosureFiledTotal	, '');
	self.v4_LienLandlordTenantFiledTotal	:= if(doVersion4, le.v4_LienLandlordTenantFiledTotal	, '');
	self.v4_LienJudgmentFiledTotal	:= if(doVersion4, le.v4_LienJudgmentFiledTotal	, '');
	self.v4_LienSmallClaimsFiledTotal	:= if(doVersion4, le.v4_LienSmallClaimsFiledTotal	, '');
	self.v4_LienOtherFiledTotal	:= if(doVersion4, le.v4_LienOtherFiledTotal	, '');
	self.v4_LienReleasedTotal	:= if(doVersion4, le.v4_LienReleasedTotal	, '');
	self.v4_LienFederalTaxReleasedTotal	:= if(doVersion4, le.v4_LienFederalTaxReleasedTotal	, '');
	self.v4_LienTaxOtherReleasedTotal	:= if(doVersion4, le.v4_LienTaxOtherReleasedTotal	, '');
	self.v4_LienForeclosureReleasedTotal	:= if(doVersion4, le.v4_LienForeclosureReleasedTotal	, '');
	self.v4_LienLandlordTenantReleasedTotal	:= if(doVersion4, le.v4_LienLandlordTenantReleasedTotal	, '');
	self.v4_LienJudgmentReleasedTotal	:= if(doVersion4, le.v4_LienJudgmentReleasedTotal	, '');
	self.v4_LienSmallClaimsReleasedTotal	:= if(doVersion4, le.v4_LienSmallClaimsReleasedTotal	, '');
	self.v4_LienOtherReleasedTotal	:= if(doVersion4, le.v4_LienOtherReleasedTotal	, '');
	self.v4_LienFederalTaxFiledCount	:= if(doVersion4, le.v4_LienFederalTaxFiledCount	, '');
	self.v4_LienTaxOtherFiledCount	:= if(doVersion4, le.v4_LienTaxOtherFiledCount	, '');
	self.v4_LienForeclosureFiledCount	:= if(doVersion4, le.v4_LienForeclosureFiledCount	, '');
	self.v4_LienLandlordTenantFiledCount	:= if(doVersion4, le.v4_LienLandlordTenantFiledCount	, '');
	self.v4_LienJudgmentFiledCount	:= if(doVersion4, le.v4_LienJudgmentFiledCount	, '');
	self.v4_LienSmallClaimsFiledCount	:= if(doVersion4, le.v4_LienSmallClaimsFiledCount	, '');
	self.v4_LienOtherFiledCount	:= if(doVersion4, le.v4_LienOtherFiledCount	, '');
	self.v4_LienFederalTaxReleasedCount	:= if(doVersion4, le.v4_LienFederalTaxReleasedCount	, '');
	self.v4_LienTaxOtherReleasedCount	:= if(doVersion4, le.v4_LienTaxOtherReleasedCount	, '');
	self.v4_LienForeclosureReleasedCount	:= if(doVersion4, le.v4_LienForeclosureReleasedCount	, '');
	self.v4_LienLandlordTenantReleasedCount	:= if(doVersion4, le.v4_LienLandlordTenantReleasedCount	, '');
	self.v4_LienJudgmentReleasedCount	:= if(doVersion4, le.v4_LienJudgmentReleasedCount	, '');
	self.v4_LienSmallClaimsReleasedCount	:= if(doVersion4, le.v4_LienSmallClaimsReleasedCount	, '');
	self.v4_LienOtherReleasedCount	:= if(doVersion4, le.v4_LienOtherReleasedCount	, '');
	self.v4_BankruptcyCount	:= if(doVersion4, le.v4_BankruptcyCount	, '');
	self.v4_BankruptcyAge	:= if(doVersion4, le.v4_BankruptcyAge	, '');
	self.v4_BankruptcyType	:= if(doVersion4, le.v4_BankruptcyType	, '');
	self.v4_BankruptcyStatus	:= if(doVersion4, le.v4_BankruptcyStatus	, '');
	self.v4_BankruptcyCount01	:= if(doVersion4, le.v4_BankruptcyCount01	, '');
	self.v4_BankruptcyCount03	:= if(doVersion4, le.v4_BankruptcyCount03	, '');
	self.v4_BankruptcyCount06	:= if(doVersion4, le.v4_BankruptcyCount06	, '');
	self.v4_BankruptcyCount12	:= if(doVersion4, le.v4_BankruptcyCount12	, '');
	self.v4_BankruptcyCount24	:= if(doVersion4, le.v4_BankruptcyCount24	, '');
	self.v4_BankruptcyCount60	:= if(doVersion4, le.v4_BankruptcyCount60	, '');
	self.v4_EvictionCount	:= if(doVersion4, le.v4_EvictionCount	, '');
	self.v4_EvictionAge	:= if(doVersion4, le.v4_EvictionAge	, '');
	self.v4_EvictionCount01	:= if(doVersion4, le.v4_EvictionCount01	, '');
	self.v4_EvictionCount03	:= if(doVersion4, le.v4_EvictionCount03	, '');
	self.v4_EvictionCount06	:= if(doVersion4, le.v4_EvictionCount06	, '');
	self.v4_EvictionCount12 	:= if(doVersion4, le.v4_EvictionCount12 	, '');
	self.v4_EvictionCount24 	:= if(doVersion4, le.v4_EvictionCount24 	, '');
	self.v4_EvictionCount60 	:= if(doVersion4, le.v4_EvictionCount60 	, '');
	self.v4_RecentActivityIndex	:= if(doVersion4, le.v4_RecentActivityIndex	, '');
	self.v4_NonDerogCount	:= if(doVersion4, le.v4_NonDerogCount	, '');
	self.v4_NonDerogCount01	:= if(doVersion4, le.v4_NonDerogCount01	, '');
	self.v4_NonDerogCount03	:= if(doVersion4, le.v4_NonDerogCount03	, '');
	self.v4_NonDerogCount06	:= if(doVersion4, le.v4_NonDerogCount06	, '');
	self.v4_NonDerogCount12	:= if(doVersion4, le.v4_NonDerogCount12	, '');
	self.v4_NonDerogCount24	:= if(doVersion4, le.v4_NonDerogCount24	, '');
	self.v4_NonDerogCount60	:= if(doVersion4, le.v4_NonDerogCount60	, '');
	self.v4_VoterRegistrationRecord	:= if(doVersion4, le.v4_VoterRegistrationRecord	, '');
	self.v4_ProfLicCount	:= if(doVersion4, le.v4_ProfLicCount	, '');
	self.v4_ProfLicAge	:= if(doVersion4, le.v4_ProfLicAge	, '');
	self.v4_ProfLicType	:= if(doVersion4, le.v4_ProfLicType	, '');
	self.v4_ProfLicTypeCategory	:= if(doVersion4, le.v4_ProfLicTypeCategory	, '');
	self.v4_ProfLicExpired	:= if(doVersion4, le.v4_ProfLicExpired	, '');
	self.v4_ProfLicCount01	:= if(doVersion4, le.v4_ProfLicCount01	, '');
	self.v4_ProfLicCount03	:= if(doVersion4, le.v4_ProfLicCount03	, '');
	self.v4_ProfLicCount06	:= if(doVersion4, le.v4_ProfLicCount06	, '');
	self.v4_ProfLicCount12	:= if(doVersion4, le.v4_ProfLicCount12	, '');
	self.v4_ProfLicCount24	:= if(doVersion4, le.v4_ProfLicCount24	, '');
	self.v4_ProfLicCount60	:= if(doVersion4, le.v4_ProfLicCount60	, '');
	self.v4_InquiryCollectionsRecent	:= if(doVersion4, le.v4_InquiryCollectionsRecent	, '');
	self.v4_InquiryPersonalFinanceRecent	:= if(doVersion4, le.v4_InquiryPersonalFinanceRecent	, '');
	self.v4_InquiryOtherRecent	:= if(doVersion4, le.v4_InquiryOtherRecent	, '');
	self.v4_HighRiskCreditActivity	:= if(doVersion4, le.v4_HighRiskCreditActivity	, '');
	self.v4_SubPrimeOfferRequestCount	:= if(doVersion4, le.v4_SubPrimeOfferRequestCount	, '');
	self.v4_SubPrimeOfferRequestCount01	:= if(doVersion4, le.v4_SubPrimeOfferRequestCount01	, '');
	self.v4_SubPrimeOfferRequestCount03	:= if(doVersion4, le.v4_SubPrimeOfferRequestCount03	, '');
	self.v4_SubPrimeOfferRequestCount06	:= if(doVersion4, le.v4_SubPrimeOfferRequestCount06	, '');
	self.v4_SubPrimeOfferRequestCount12	:= if(doVersion4, le.v4_SubPrimeOfferRequestCount12	, '');
	self.v4_SubPrimeOfferRequestCount24	:= if(doVersion4, le.v4_SubPrimeOfferRequestCount24	, '');
	self.v4_SubPrimeOfferRequestCount60	:= if(doVersion4, le.v4_SubPrimeOfferRequestCount60	, '');
	self.v4_InputPhoneMobile 	:= if(doVersion4, le.v4_InputPhoneMobile 	, '');
	self.v4_PhoneEDAAgeOldestRecord	:= if(doVersion4, le.v4_PhoneEDAAgeOldestRecord	, '');
	self.v4_PhoneEDAAgeNewestRecord	:= if(doVersion4, le.v4_PhoneEDAAgeNewestRecord	, '');
	self.v4_PhoneOtherAgeOldestRecord	:= if(doVersion4, le.v4_PhoneOtherAgeOldestRecord	, '');
	self.v4_PhoneOtherAgeNewestRecord	:= if(doVersion4, le.v4_PhoneOtherAgeNewestRecord	, '');
	self.v4_InputPhoneHighRisk	:= if(doVersion4, le.v4_InputPhoneHighRisk	, '');
	self.v4_InputPhoneProblems	:= if(doVersion4, le.v4_InputPhoneProblems	, '');
	self.v4_EmailAddress	:= if(doVersion4, le.v4_EmailAddress	, '');
	self.v4_InputAddrHighRisk	:= if(doVersion4, le.v4_InputAddrHighRisk	, '');
	self.v4_CurrAddrCorrectional	:= if(doVersion4, le.v4_CurrAddrCorrectional	, '');
	self.v4_PrevAddrCorrectional	:= if(doVersion4, le.v4_PrevAddrCorrectional	, '');
	self.v4_HistoricalAddrCorrectional	:= if(doVersion4, le.v4_HistoricalAddrCorrectional	, '');
	self.v4_InputAddrProblems	:= if(doVersion4, le.v4_InputAddrProblems	, '');
	self.v4_SecurityFreeze	:= if(doVersion4, le.v4_SecurityFreeze	, '');
	self.v4_SecurityAlert	:= if(doVersion4, le.v4_SecurityAlert	, '');
	self.v4_IDTheftFlag	:= if(doVersion4, le.v4_IDTheftFlag	, '');
	self.v4_ConsumerStatement	:= if(doVersion4 OR le.v4_ConsumerStatement='1', le.v4_ConsumerStatement	, '');  // version 3 doesn't have consumer statement attribute, so re-use the version4 attribute to suppress version 3 attributes if consumer statement=1
	self.v4_PrescreenOptOut	:= if(doVersion4, le.v4_PrescreenOptOut	, '');

	self := [];
END;
attributes_temp := project(ungroup(attr), intoAttributes(left));

// determine if the transaction is coming from experian customer by checking the experian data restriction mask setting
// if the customer has access to see experian's fcra data, we know it's an experian customer
ExperianTransaction := DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]='0';	 

Layout_working blankAttributes(attributes_temp le) := TRANSFORM
	SELF.seq := le.seq;
	SELF.acctno := le.acctno;
	
	// For Experian Transactions the following waterfall blankout logic will apply (Currently only for Version 3 of the attributes):
	// * If there is a Verification Failure = '1', blank out everything except for Verification Failure since we can't confidently verify the subject using the custom Experian verification logic
	// * If there is no Verification Failure, but PreScreen Opt-Out = '1', blank out everything except for Verfication Failure and PreScreen Opt-Out
	// * If there is no Verification Failure, and no PreScreen Opt-Out, but Security Freeze = '1', blank out everything except for Verification Failure, PreScreen Opt-Out and Security Freeze
	
	// If we have an Experian V3 transaction and it fails the Experian Verification Logic blank out everything except the Verification Failure Attribute
	ExperianVerificationFailureBlankOut := doVersion3 AND ExperianTransaction AND le.isNoVer='1';
	SecurityFreezeTemp := IF((doMoney OR doLifestyle OR doDemographic OR doFinancial OR doProperty OR doDerog) AND
																	~doVersion2 AND ~doVersion3, '', le.SecurityFreeze); // Only Version2 and Version3 should return the SecurityFreeze flag, otherwise blank it out.
	SELF.SecurityFreeze := IF(ExperianVerificationFailureBlankOut = FALSE, SecurityFreezeTemp, '');
	SELF.PrescreenOptOut := IF(ExperianVerificationFailureBlankOut = FALSE, le.PrescreenOptOut, '');

	SELF.v4_SecurityFreeze := if(doVersion4, le.v4_SecurityFreeze, '');
	SELF.v4_ConsumerStatement := if(doVersion4, le.v4_ConsumerStatement, '');
	
	// indexes to always be populated
	self.index1 := le.index1;
	self.index2 := le.index2;
	self.index3 := le.index3;
	self.index4 := le.index4;
	self.index5 := le.index5;
	
	self.isNoVer := if(doVersion3, le.isNoVer, '');
	self.v4_VerificationFailure := if(doVersion4 and ExperianTransaction, le.v4_VerificationFailure, '');
	
	SELF := [];
END;

blank_attributes := PROJECT(attributes_temp (SecurityFreeze = '1'  or v4_ConsumerStatement = '1' or (ExperianTransaction and isNoVer='1') ), blankAttributes(LEFT));

attributes := attributes_temp (SecurityFreeze <> '1' and v4_ConsumerStatement <> '1' and ~(experianTransaction and isNoVer='1') ) + blank_attributes;


rvAuto := map(AlternateModel='rva707_0' => ungroup( Models.RVA707_0_0( clam,  false) ),
						  AlternateModel='rva1309_1' => ungroup( Models.RVA1309_1_0( clam,  false) ),
			IncludeAllScores or IncludeScoresAttributes or IncludeAuto => map(
				FlagshipVersion=4 =>  ungroup(Models.RVA1104_0_0(clam,false,false)),
				FlagshipVersion=3 =>  ungroup(Models.RVA1003_0_0(clam,false)),
				FlagshipVersion=2 =>  ungroup(Models.RVA711_0_0(clam,false)),
				ungroup(Models.RVA611_0_0(clam,  false))),
			dataset([],Models.Layout_ModelOut)
);
rvBankcard := map(
			AlternateModel='rvb1402_1' => ungroup(Models.RVB1402_1_0(clam,false)),
			IncludeAllScores or IncludeScoresAttributes or IncludeBankcard => map(
				FlagshipVersion=4 				 => ungroup(Models.RVB1104_0_0(clam,false,false)),
				FlagshipVersion=3					 => ungroup(Models.RVB1003_0_0(clam,false)),
				FlagshipVersion=2					 => ungroup(Models.RVB711_0_0(ungroup(clam),false,false)),
				ungroup(Models.RVB609_0_0(clam,  false))),
			dataset([],Models.Layout_ModelOut)
);


rvRetail := map(
	AlternateModel='rvr1104_2' => ungroup( Models.RVR1104_2_0( clam, false, false) ),
	AlternateModel='rvr1210_1' => ungroup( Models.RVR1210_1_0( clam) ),
	AlternateModel='ex89' => ungroup( Models.TRD605_0_0( clam,  false, false ) ),
	IncludeAllScores or IncludeScoresAttributes or IncludeRetail => map(
	FlagshipVersion=4 => ungroup(Models.RVR1103_0_0(clam, false, false)),
	FlagshipVersion=3 => ungroup(Models.RVR1003_0_0(clam)),
	FlagshipVersion=2 => ungroup(Models.RVR711_0_0(clam,  false)),
	ungroup(Models.RVR611_0_0(clam,  false))),
	dataset([],Models.Layout_ModelOut)
);
rvTelecom := map(
			AlternateModel='ex23' => ungroup( Models.AWD606_3_0( clam,  false, false ) ),
			IncludeAllScores or IncludeScoresAttributes or IncludeTelecom => map(
				FlagshipVersion=4 => ungroup(Models.RVT1104_0_0(clam,false,false)),
				FlagshipVersion=3 => ungroup(Models.RVT1003_0_0(clam)),
				FlagshipVersion=2 => ungroup(Models.RVT711_0_0(clam,false)),
				ungroup(Models.RVT612_0(clam,  false))),
			dataset([],Models.Layout_ModelOut)
);

rvPreScreen := map(
			IncludePreScreen => map(
        AlternateModel = 'rvp1012_1' => ungroup(models.RVP1012_1_0(adl_clam)),
        AlternateModel = 'rvp1208_1' => ungroup(models.RVP1208_1_0(adl_clam)),
				AlternateModel = 'rvp1401_1' => ungroup(models.RVP1401_1_0(adl_clam)),
				AlternateModel = 'rvp1401_2' => ungroup(models.RVP1401_2_0(adl_clam)),
				AlternateModel = 'rvp1503_1' => ungroup(models.RVP1503_1_0(adl_clam)),
				FlagshipVersion=4 => ungroup(Models.RVP1104_0_0(adl_clam,false,false)),
				FlagshipVersion=3 => ungroup(Models.RVP1003_0_0(adl_clam,false)),
				ungroup(Models.RVP804_0_0(adl_clam))),
			dataset([],Models.Layout_ModelOut)
);

rvMoney := map(
			IncludeAllScores or IncludeScoresAttributes or IncludeMoney => map(
				//Payment Score Model -- A custom flagship model, they don't care what field it returns in for batch, so I am choosing Money.
				AlternateModel = 'rvc1112_0' => UNGROUP(Models.RVC1112_0_0(adl_clam)),
				AlternateModel = 'rvc1110_1' => Models.RVC1110_1_0(UNGROUP(clam),false,false),
				AlternateModel = 'rvc1110_2' => Models.RVC1110_2_0(UNGROUP(clam),false,false),
				AlternateModel = 'rvc1208_1' => ungroup(Models.RVC1208_1_0(adl_clam,false,false)),  
				AlternateModel = 'rvc1301_1' => ungroup(Models.RVC1301_1_0(adl_clam)),  
				AlternateModel = 'rvc1307_1' => ungroup(Models.RVC1307_1_0(adl_clam, false)),  
				AlternateModel = 'rvc1405_1' => ungroup(Models.RVC1405_1_0(custom_adl_clam, false)),  
				AlternateModel = 'rvc1405_2' => ungroup(Models.RVC1405_2_0(custom_adl_clam, false)),  
				AlternateModel = 'rvc1405_3' => ungroup(Models.RVC1405_3_0(adl_clam, false)), 
				AlternateModel = 'rvc1405_4' => ungroup(Models.RVC1405_4_0(adl_clam, false)),
				AlternateModel = 'rvc1412_1' => ungroup(Models.RVC1412_1_0(adl_clam, false)),
				AlternateModel = 'ied1002_0' => ungroup(Models.IED1002_0_9(clam, false)),
				AlternateModel = 'rvc1412_2' => ungroup(Models.RVC1412_2_0(custom_adl_clam, false)),
				AlternateModel = 'rvc1703_1' => ungroup(Models.RVC1703_1_0(adl_clam, false)),
				AlternateModel = 'rvc1801_1' => ungroup(Models.RVC1801_1_0(adl_clam, false)),
        AlternateModel = 'rvc1805_1' => ungroup(Models.RVC1805_1_0(adl_clam, false)),
        AlternateModel = 'rvc1805_2' => ungroup(Models.RVC1805_2_0(clam, false)),
				FlagshipVersion=4 => ungroup(Models.RVG1103_0_0(clam,false,false)),
				FlagshipVersion=3 => ungroup(Models.RVG1003_0_0(clam)),
				ungroup(Models.RVG812_0_0(ungroup(clam),  false))),
			dataset([],Models.Layout_ModelOut)
);


Layout_working addScore(Layout_working le, Models.Layout_ModelOut ri, integer i) := transform
	// Auto
	self.index6 := if(i=1 and ri.score <> '', map(
		AlternateModel in AltAuto => CustomIndex,
		FlagshipVersion=4         => Risk_Indicators.BillingIndex.RVAuto_V4,
		FlagshipVersion=3         => Risk_Indicators.BillingIndex.RVAuto_V3,
		FlagshipVersion=2         => Risk_Indicators.BillingIndex.RVAuto_V2,
		                             Risk_Indicators.BillingIndex.RVAuto_V1),
		le.index6);
	self.modelname1 := if(i=1 and ri.score <> '', if(AlternateModel in AltAuto,'Custom','RiskView'), le.modelname1);
	self.score1 := if(i=1, ri.score, le.score1);
	self.scorename1 := if(i=1 and ri.score <> '', if(AlternateModel in AltAuto,CustomScoreName,'Auto'), le.scorename1);

  models36 := ['rvc1307_1','rvc1405_1','rvc1405_2','rvc1405_3', 'rvc1405_4', 'rvc1412_1', 'rvc1412_2', 'rvc1703_1','rvc1801_1','rvc1805_1','rvc1805_2'];  
	self.reason1 := if(i=1, if(ri.ri[1].hri='00', '36', ri.ri[1].hri), le.reason1);
	self.reason2 := map(
		i <> 1 => le.reason2,
		ri.ri[2].hri <> '00' => ri.ri[2].hri,
		AlternateModel NOT in models36 and self.reason1 NOT IN ['36', '35'] => '36',
		ri.ri[2].hri
		);
	self.reason3 := if(i=1, ri.ri[3].hri, le.reason3);
	self.reason4 := if(i=1, ri.ri[4].hri, le.reason4);

	// BankCard
	self.index7 := if(i=2 and ri.score <> '', map(
		AlternateModel='rvb1402_1' => Risk_Indicators.BillingIndex.RVB1402_1,
		FlagshipVersion=4          => Risk_Indicators.BillingIndex.RVBankcard_V4,
		FlagshipVersion=3          => Risk_Indicators.BillingIndex.RVBankcard_V3,
		FlagshipVersion=2          => Risk_Indicators.BillingIndex.RVBankcard_V2,
		                              Risk_Indicators.BillingIndex.RVBankcard_V1),
		le.index7);
	self.modelname2 := if(i=2 and ri.score <> '', 'RiskView', le.modelname2);
	self.score2 := if(i=2, ri.score, le.score2);
	self.scorename2 := if(i=2 and ri.score <> '', 'BankCard', le.scorename2);
	self.reason5 := if(i=2, if(ri.ri[1].hri='00', '36', ri.ri[1].hri), le.reason5);
	self.reason6 := map(
		i <> 2 => le.reason6,
		ri.ri[2].hri <> '00' => ri.ri[2].hri,
		AlternateModel NOT in models36 and self.reason5 NOT IN ['36', '35'] => '36',
		ri.ri[2].hri
		);	
	self.reason7 := if(i=2, ri.ri[3].hri, le.reason7);
	self.reason8 := if(i=2, ri.ri[4].hri, le.reason8);

	// Retail -- output when an alternate Retail model is used or no alt model is used
	self.index8 := if(i=3 and ri.score <> '', map(
		AlternateModel in AltRetails => CustomIndex,
		FlagshipVersion=4            => Risk_Indicators.BillingIndex.RVRetail_V4,
		FlagshipVersion=3            => Risk_Indicators.BillingIndex.RVRetail_V3,
		FlagshipVersion=2            => Risk_Indicators.BillingIndex.RVRetail_V2,
		                                Risk_Indicators.BillingIndex.RVRetail_V1),
		le.index8);
	self.modelname3 := if(i=3 and ri.score <> '', if(AlternateModel in AltRetails,'Custom','RiskView'), le.modelname3);
	self.score3 := if(i=3, ri.score, le.score3);
	self.scorename3 := if(i=3 and ri.score <> '', if(AlternateModel in AltRetails,CustomScoreName,'Retail'), le.scorename3);
	self.reason9 := if(i=3, if(ri.ri[1].hri='00', '36', ri.ri[1].hri), le.reason9);
	self.reason10 := map(
		i <> 3 => le.reason10,
		ri.ri[2].hri <> '00' => ri.ri[2].hri,
		AlternateModel NOT in models36 and self.reason9 NOT IN ['36', '35'] => '36',
		ri.ri[2].hri
		);	
	self.reason11 := if(i=3, ri.ri[3].hri, le.reason11);
	self.reason12 := if(i=3, ri.ri[4].hri, le.reason12);

	// Telecom -- output when an alternate Telecom model is used or no alt model is used
	self.index9 := if(i=4 and ri.score <> '', map(
		AlternateModel in AltTelecoms => CustomIndex,
		FlagshipVersion=4             => Risk_Indicators.BillingIndex.RVTelecom_v4,
		FlagshipVersion=3             => Risk_Indicators.BillingIndex.RVTelecom_v3,
		FlagshipVersion=2             => Risk_Indicators.BillingIndex.RVTelecom_v2,
		                                 Risk_Indicators.BillingIndex.RVTelecom_v1),
		le.index9);
	self.modelname4 := if(i=4 and ri.score <> '', if(AlternateModel in AltTelecoms,'Custom','RiskView'), le.modelname4);
	self.score4 := if(i=4, ri.score, le.score4);
	self.scorename4 := if(i=4 and ri.score <> '', if(AlternateModel in AltTelecoms,CustomScoreName,'Telecom'), le.scorename4);
	self.reason13 := if(i=4, if(ri.ri[1].hri='00', '36', ri.ri[1].hri), le.reason13);
	self.reason14 := map(
		i <> 4 => le.reason14,
		ri.ri[2].hri <> '00' => ri.ri[2].hri,
		AlternateModel NOT in models36 and self.reason13 NOT IN ['36', '35'] => '36',
		ri.ri[2].hri
		);	
	self.reason15 := if(i=4, ri.ri[3].hri, le.reason15);
	self.reason16 := if(i=4, ri.ri[4].hri, le.reason16);
	
	// Money
	self.index10 		:= if(i=5 and ri.score <> '', map(
		AlternateModel = 'rvc1112_0'  => Risk_Indicators.BillingIndex.RVC1112_0,
		AlternateModel = 'rvc1110_1'  => Risk_Indicators.BillingIndex.RVC1110_1,
		AlternateModel = 'rvc1110_2'  => Risk_Indicators.BillingIndex.RVC1110_2,
		AlternateModel = 'rvc1208_1'  => Risk_Indicators.BillingIndex.RVC1208_1,
		AlternateModel = 'rvc1301_1'  => Risk_Indicators.BillingIndex.RVC1301_1,
		AlternateModel = 'rvc1307_1'  => Risk_Indicators.BillingIndex.RVC1307_1,	
		AlternateModel = 'rvc1405_1'  => Risk_Indicators.BillingIndex.RVC1405_1,	
		AlternateModel = 'rvc1405_2'  => Risk_Indicators.BillingIndex.RVC1405_2,	
		AlternateModel = 'rvc1405_3'  => Risk_Indicators.BillingIndex.RVC1405_3,
		AlternateModel = 'rvc1405_4'  => Risk_Indicators.BillingIndex.RVC1405_4,
		AlternateModel = 'rvc1412_1'  => Risk_Indicators.BillingIndex.RVC1412_1,
		AlternateModel = 'ied1002_0'  => Risk_Indicators.BillingIndex.IED1002_0,
		AlternateModel = 'rvc1412_2'  => Risk_Indicators.BillingIndex.RVC1412_2,
		AlternateModel = 'rvc1703_1'  => Risk_Indicators.BillingIndex.RVC1703_1,
		AlternateModel = 'rvc1801_1'  => Risk_Indicators.BillingIndex.RVC1801_1,
    AlternateModel = 'rvc1805_1'  => Risk_Indicators.BillingIndex.RVC1805_1,
    AlternateModel = 'rvc1805_2'  => Risk_Indicators.BillingIndex.RVC1805_2,
		FlagshipVersion=4             => Risk_Indicators.BillingIndex.RVMoney_V4,
		FlagshipVersion=3             => Risk_Indicators.BillingIndex.RVMoney_V3,
		                                 Risk_Indicators.BillingIndex.RVMoney_v2),
		le.index10);
	self.modelname5 := if(i=5 and ri.score <> '', 'RiskView', le.modelname5);
	self.score5 		:= if(i=5, ri.score, le.score4);
	self.scorename5 := if(i=5 and ri.score <> '', MAP(AlternateModel = 'rvc1112_0' => 'Payment',
																										AlternateModel = 'rvc1110_1' => 'PaymentRVC11101',
																										AlternateModel = 'rvc1110_2' => 'ProbateRVC11102',
																										AlternateModel = 'rvc1208_1' => 'RVC12081',
																										AlternateModel = 'rvc1301_1' => 'RVC13011',
																										AlternateModel = 'rvc1307_1' => 'RVC13071',
																										AlternateModel = 'rvc1405_1' => 'RVC14051',
																										AlternateModel = 'rvc1405_2' => 'RVC14052',
																										AlternateModel = 'rvc1405_3' => 'RVC14053',
																										AlternateModel = 'rvc1405_4' => 'RVC14054',
																										AlternateModel = 'rvc1412_1' => 'RVC14121',
																										AlternateModel = 'ied1002_0' => 'IncomeIED10020',
																										AlternateModel = 'rvc1412_2' => 'RVC14122',
																										AlternateModel = 'rvc1703_1' => 'RVC17031',
																										AlternateModel = 'rvc1801_1' => 'RVC18011',
                                                    AlternateModel = 'rvc1805_1' => 'RVC18051',
                                                    AlternateModel = 'rvc1805_2' => 'RVC18052',
																																			'Money'), 
																								le.scorename5);
	self.reason17 	:= if(i=5, if(ri.ri[1].hri='00', '36', ri.ri[1].hri), le.reason17);
	self.reason18 := map(
		i <> 5 => le.reason18,
		ri.ri[2].hri <> '00' => ri.ri[2].hri,
		AlternateModel NOT in models36 and self.reason17 NOT IN ['36', '35'] => '36',
		ri.ri[2].hri
		);	
	self.reason19 	:= if(i=5, ri.ri[3].hri, le.reason19);
	self.reason20 	:= if(i=5, ri.ri[4].hri, le.reason20);		
	
	// rc5 for rv4 flagships
	self.reason21   := if(i=1 and FlagshipVersion >= 4, ri.ri[5].hri, le.reason21);
	self.reason22   := if(i=2 and FlagshipVersion >= 4, ri.ri[5].hri, le.reason22);
	self.reason23   := if(i=3 and FlagshipVersion >= 4, ri.ri[5].hri, le.reason23);
	self.reason24   := if(i=4 and FlagshipVersion >= 4, ri.ri[5].hri, le.reason24);
	// Turn on the 5th reason code for the Payment Score model as well...
	self.reason25   := if(i=5 and (FlagshipVersion >= 4 OR AlternateModel IN ['rvc1112_0', 'rvc1110_1', 'rvc1110_2', 'rvc1208_1', 'rvc1301_1','rvc1405_3','rvc1405_4','rvc1412_1', 'rvc1412_2', 'rvc1703_1','rvc1801_1','rvc1805_1','rvc1805_2']), ri.ri[5].hri, le.reason25);

	self := le;
	self := [];
END;


wAuto 			:= join(attributes, rvAuto, left.seq=right.seq, addScore(left,right,1), left outer);
wBank 			:= join(wAuto, rvBankcard, left.seq=right.seq, addScore(left,right,2), left outer);
wRetail 	  := join(wBank, rvRetail, left.seq=right.seq, addScore(left,right,3), left outer);
wTele 		  := join(wRetail, rvTelecom, left.seq=right.seq, addScore(left,right,4), left outer);
wMoney 		  := join(wTele, rvMoney, left.seq=right.seq, addScore(left,right,5), left outer);

Layout_working addScorePreScreen(Models.Layout_ModelOut le, attributes rt) := transform
	// PreScreen
	self.seq := le.seq;
	self.index10 := map(
    AlternateModel in AltPreScreens => CustomIndex,
		FlagshipVersion=4 => Risk_Indicators.BillingIndex.RVPreScreen_v4,
		FlagshipVersion=3 => Risk_Indicators.BillingIndex.RVPreScreen_v3,
		                     Risk_Indicators.BillingIndex.RVPreScreen_v1
	);
	self.modelname5 := 'RiskView';
	self.score5 := le.score;
	self.scorename5 := map(
    AlternateModel in AltPreScreens => CustomScoreName,
    'PreScreen'
  );

	self.reason17 := le.ri[1].hri;
	self.reason18 := le.ri[2].hri; // prescreen doesn't use reasons 2-5, but we're copying them over here nonetheless
	self.reason19 := le.ri[3].hri;
	self.reason20	:= le.ri[4].hri;
	self.reason25 := le.ri[5].hri;

	self := rt;
	self := [];
END;

wPreScreen  := join(rvPreScreen, wTele, left.seq=right.seq, addScorePreScreen(left, right), left outer);

wAll := if(IncludePreScreen, wPreScreen, wMoney);


// wAcctNo is the normal processing results
wAcctNo := join(wAll, batchinseq, left.seq=right.seq, transform(layout_working, self.acctno := right.acctno, self := left));

// use the fields in the clam as filters to suppress records for pre-screen product
// filtered_pre_screen_recs := join(wAcctNo, clam, left.seq=right.seq, transform(layout_working, self.acctno := left.acctno,
layout_working calculateSuppression( wAcctNo le, clam ri ) := TRANSFORM
	// only consider a score for threshold suppression if it was calculated.  If blank for that score, set 999
	opt_out_hit := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, ri.iid.iid_flags );

	minimum_score := if(IncludePreScreen, if(le.score5='', 999,(unsigned)le.score5),  
											ut.imin4( if(le.score1='', 999,(unsigned)le.score1), 
												if(le.score2='', 999,(unsigned)le.score2), 
												if(le.score3='', 999,(unsigned)le.score3), 
												if(le.score4='', 999,(unsigned)le.score4) ));

	today := ut.GetDate;
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);
	eighteen_months_ago := ut.DateFrom_DaysSince1900(today1900-548);

	self.suppress := isPrescreen and ( FlagshipVersion != 4 and ri.ssn_verification.validation.deceased or opt_out_hit );

	self.prescreenoptout := map(
		not isPreScreen => '',
		opt_out_hit => '1',
		'0'
	); // if(isPrescreen, if(opt_out_hit, '1', '0'), ''),
	self.v4_PrescreenOptOut := Models.Attributes_Master(ri,true).PrescreenOptOut(isPreScreen, opt_out_hit)	;
	self.did := (string12)ri.did;
  // if the transaction can't get a score, don't return the DID for logging the inquiry
  self.inquiry_lexid := if(riskview.constants.noscore(ri.iid.nas_summary,ri.iid.nap_summary, ri.address_verification.input_address_information.naprop, ri.truedid), 
  '', 
  (string12)ri.did);
	self := le;
end;
filtered_pre_screen_recs := join(wAcctNo, clam, left.seq=right.seq, calculateSuppression(left,right) );


// create dataset of suppressed output, to join back to only those records which pass the filters
acct_seq_only := project(batchinseq, transform(layout_working, self.seq := left.seq, self.acctno := left.acctno, self := []));

models.Layout_RiskView_Batch_Out applySuppression( filtered_pre_screen_recs le, acct_seq_only ri ) := TRANSFORM
		// If this is an Experian V3 transaction, and there was a verification failure, blank out the prescreen opt out attribute
		self.prescreenoptout := if(doVersion3 and ExperianTransaction AND le.isNoVer = '1', '', le.prescreenoptout);
		self.v4_prescreenoptout := le.v4_prescreenoptout;

		// copy over models
		blankAuto     := le.suppress and AlternateModel not in Newer_AltModels and ( FlagshipVersion < 4 or AlternateModel in AltAuto );
		blankBankCard := le.suppress and AlternateModel not in Newer_AltModels and ( FlagshipVersion < 4 );
		blankRetail   := le.suppress and AlternateModel not in Newer_AltModels and ( FlagshipVersion < 4 or AlternateModel in AltRetails );
		blankTelecoms := le.suppress and AlternateModel not in Newer_AltModels and ( FlagshipVersion < 4 or AlternateModel in AltTelecoms );
		blankMoney    := le.suppress and AlternateModel not in Newer_AltModels and ( FlagshipVersion < 4 );


		self.index1 := le.index1;
		self.index2 := le.index2;
		self.index3 := le.index3;
		self.index4 := le.index4;
		self.index5 := le.index5;

		self.index6           := le.index6;
		self.modelname1       := if( blankAuto, '', le.modelname1 );
		self.score1           := if( blankAuto, '', le.score1 );
		self.scorename1       := if( blankAuto, '', le.scorename1 );
		self.reason1          := if( blankAuto, '', le.reason1 );
		self.reason2          := if( blankAuto, '', le.reason2 );
		self.reason3          := if( blankAuto, '', le.reason3 );
		self.reason4          := if( blankAuto, '', le.reason4 );
		self.reason21         := if( blankAuto, '', le.reason21 );
		
		self.index7           := le.index7;
		self.modelname2       := if( blankBankCard, '', le.modelname2 );
		self.score2           := if( blankBankCard, '', le.score2 );
		self.scorename2       := if( blankBankCard, '', le.scorename2 );
		self.reason5          := if( blankBankCard, '', le.reason5 );
		self.reason6          := if( blankBankCard, '', le.reason6 );
		self.reason7          := if( blankBankCard, '', le.reason7 );
		self.reason8          := if( blankBankCard, '', le.reason8 );
		self.reason22         := if( blankBankCard, '', le.reason22 );
		
		self.index8           := le.index8;
		self.modelname3       := if( blankRetail, '', le.modelname3 );
		self.score3           := if( blankRetail, '', le.score3 );
		self.scorename3       := if( blankRetail, '', le.scorename3 );
		self.reason9          := if( blankRetail, '', le.reason9 );
		self.reason10         := if( blankRetail, '', le.reason10 );
		self.reason11         := if( blankRetail, '', le.reason11 );
		self.reason12         := if( blankRetail, '', le.reason12 );
		self.reason23         := if( blankRetail, '', le.reason23 );
		
		self.index9           := le.index9;
		self.modelname4       := if( blankTelecoms, '', le.modelname4 );
		self.score4           := if( blankTelecoms, '', le.score4 );
		self.scorename4       := if( blankTelecoms, '', le.scorename4 );
		self.reason13         := if( blankTelecoms, '', le.reason13 );
		self.reason14         := if( blankTelecoms, '', le.reason14 );
		self.reason15         := if( blankTelecoms, '', le.reason15 );
		self.reason16         := if( blankTelecoms, '', le.reason16 );
		self.reason24         := if( blankTelecoms, '', le.reason24 );
		
		self.index10          := le.index10;
		self.modelname5       := if( blankMoney, '', le.modelname5 );
		self.score5           := if( blankMoney, '', le.score5 );
		self.scorename5       := if( blankMoney, '', le.scorename5 );
		self.reason17         := if( blankMoney, '', le.reason17 );
		self.reason18         := if( blankMoney, '', le.reason18 );
		self.reason19         := if( blankMoney, '', le.reason19 );
		self.reason20         := if( blankMoney, '', le.reason20 );
		self.reason25         := if( blankMoney, '', le.reason25 );
		
		// If this is an Experian Transaction allow the Verification Failure flags to flow through.
		self.isNoVer := if(doVersion3 and ExperianTransaction, le.isNoVer, IF(le.suppress, ri.isNoVer, le.isNoVer));
		
		// If this is an Experian Transaction and is not a PreScreen suppression, allow the SSN Deceased flag to be output
		SELF.isDeceased := IF(doVersion3 AND ExperianTransaction AND le.prescreenoptout <> '1', le.isDeceased, IF(le.suppress, ri.isDeceased, le.isDeceased));

		self := if(le.suppress, ri, le);
END;

after_suppressions := join(filtered_pre_screen_recs, acct_seq_only, left.seq=right.seq, applySuppression(LEFT,RIGHT), keep(1) );


final := map(
	AlternateModel!='' AND CustomIndex='' => dataset( [], Models.Layout_RiskView_Batch_Out ), // When an alternate model (not flagship v2) is specified but is not valid, output a blank dataset.
	isPreScreen => after_suppressions,
	project(filtered_pre_screen_recs, models.Layout_RiskView_Batch_Out)
);
#end



// output(CustomIndex, named('CustomIndex'));
// output(CustomScoreName, named('CustomScoreName'));
// output(batchin, named('batchin'));
// output(batchinseq, named('batchinseq'));
// output(cleanin, named('cleanin'));
// output(clam, named('clam'));
// output(adl_clam, named('adl_clam'));
// output(rvPreScreen, named('rvPreScreen'));
// output(wPreScreen, named('wPreScreen'));
// output(wAll, named('wAll'));
// OUTPUT(rvMoney, NAMED('Results'));
// output(filtered_pre_screen_recs, named('filtered_pre_screen_recs'));
// output(after_suppressions, named('after_suppressions'));

OUTPUT(final, NAMED('Results'));

ConsumerStatementResults1 := project(clam.ConsumerStatements, 
	transform(FFD.layouts.ConsumerStatementBatchFull,
		self.UniqueId := (unsigned)left.uniqueId;
		
		self.dateAdded := // renamed timestamp to be dateAdded to match what krishna's team is doing
			intformat(left.timestamp.year, 4, 1) + 
			intformat(left.timestamp.month, 2, 1) + 
			intformat(left.timestamp.day, 2, 1) +
			' ' +
			intformat(left.timestamp.hour24, 2, 1) + 
			intformat(left.timestamp.minute, 2, 1) + 
			intformat(left.timestamp.second, 2, 1);
		self.recordtype := left.statementtype;	// renamed the statement type to be recordtype like krishna's team is doing instead to be more generic since it also includes disputes now as well
		self := left,
		self := []));

empty_ds := dataset([], FFD.layouts.ConsumerStatementBatchFull);

ConsumerStatementResults_temp := if(OutputConsumerStatements, ConsumerStatementResults1, empty_ds);
		
ConsumerStatementResults := join(final, ConsumerStatementResults_temp, (unsigned)left.did=right.uniqueid, 
			transform(FFD.layouts.ConsumerStatementBatchFull, 
			self.acctno := left.acctno, self := right));

			
output(ConsumerStatementResults, named('CSDResults'));  


ENDMACRO;

// Models.RiskView_Batch_Service();  