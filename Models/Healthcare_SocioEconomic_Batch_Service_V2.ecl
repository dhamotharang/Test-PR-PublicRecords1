/*--SOAP--
<message name="Healthcare_SocioEconomic_Batch_Service_V2">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="IndustryClass" type="xsd:string"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="AttributesOnly" type="xsd:string"/>
	<part name="Version" type="xsd:integer"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/> 
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO-- Healthcare SocioEconomic Batch Service V2*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
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
      &lt;MemberGENDer&gt;&lt;/MemberGENDer&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import risk_indicators, models, std, Profilebooster;
IMPORT LUCI, ut, STD;
IMPORT HCSE_GE_18_LUCI_MODEL;
IMPORT HCSE_LT_18_LUCI_MODEL;


export Healthcare_SocioEconomic_Batch_Service_V2 := MACRO

	batchin := dataset([],Models.Layouts_Healthcare_V2.Layout_SocioEconomic_Batch_In) : stored('batch_in',few);
	gateways_in := Gateway.Configuration.Get();

	unsigned1 prep_dppa := 1 : stored('DPPAPurpose');
	unsigned1 glb := 0 : stored('GLBPurpose');

	IF(prep_dppa <> Models.Healthcare_Constants_V2.authorized_DPPA OR glb <> Models.Healthcare_Constants_V2.authorized_GLBA, FAIL('Supplied Permissible Purpose Settings (GLBPurpose and/or DPPAPurpose) are invalid'));
	
	unsigned1 runtime_attributesVersion := 1 : stored('Version');//Default for integer fields is 0, so if the user does not supply default to 1
	unsigned1 attributesVersion := if(runtime_attributesVersion>0,runtime_attributesVersion,1);//If the input version is set (ie greater thant zero) take it otherwise default to 1
	string ModelName_in := '' : stored('ModelName');
	model_name := STD.Str.ToUpperCase(modelname_in);
	string5   industry_class_val := '';
	boolean   isUtility := false;
	boolean   ofac_Only := false;
  unsigned1 ofac_version_      := 1        : stored('OFACVersion');

	string IndustryClass := '' : stored('IndustryClass');

	string DataRestriction := '' : stored('DataRestrictionMask');
	string50 DataPermission := '' : stored('DataPermissionMask');
	
	unsigned3 history_date := 999999 		: stored('HistoryDateYYYYMM');
	useSystemDate := history_date=999999;
	myCustomYear := (string)history_date[1..4];
	myCustomMonth := (string)history_date[5..6];
	myCustomYear12 := (string)((unsigned3)myCustomYear-1);
	myCustomYear24 := (string)((unsigned3)myCustomYear-2);
	myDate := (integer)ut.GetDate;
	myYear12 := (string)(STD.Date.Year(myDate)-1);
	myYear24 := (string)(STD.Date.Year(myDate)-2);
	myMonth := (string)INTFORMAT(STD.Date.Month(myDate),2,1);
	myNewDate12 := (Integer)if(useSystemDate,myYear12+myMonth,myCustomYear12+myCustomMonth);
	myNewDate24 := (Integer)if(useSystemDate,myYear24+myMonth,myCustomYear24+myCustomMonth);
	unsigned3 history_date12 := myNewDate12;//To be used to accomodate the need to collect 12 month history on certain fields that the core does not support
	unsigned3 history_date24 := myNewDate24;//To be used to accomodate the need to collect 24 month history on certain fields that the core does not support
	
	mySystemYear := (string)(STD.Date.Year(myDate));
	preProcRefYear := if(myCustomYear = '9999',mySystemYear, myCustomYear);
	
	unsigned1 dppa := prep_dppa; //Remove DNC filter if(~DisableDoNotMailFilter, 0, prep_dppa);

	LeadIntegrityVersion := Models.Healthcare_Constants_V2.default_LeadIntegrity_Version;//We want version 4
	bsVersion := Models.Healthcare_Constants_V2.default_BocaShell_Version; //We want version 4.1

	batchin0 := project(batchin, Models.Healthcare_SocioEconomic_Transforms_V2.AddSeq(left,counter,history_date));
	batchin12 := project(batchin, Models.Healthcare_SocioEconomic_Transforms_V2.AddSeq(left,counter,history_date12));
	batchin24 := project(batchin, Models.Healthcare_SocioEconomic_Transforms_V2.AddSeq(left,counter,history_date24));
	batchinseq := batchin0;
	batchinseqHist12 := batchin12;
	batchinseqHist24 := batchin24;

	cleanIn := project(batchinseq(goodInput), Models.Healthcare_SocioEconomic_Transforms_V2.CleanBatch(left,history_date));
	cleanInHist12 := project(batchinseqHist12(goodInput), Models.Healthcare_SocioEconomic_Transforms_V2.CleanBatch(left,history_date));
	cleanInHist24 := project(batchinseqHist24(goodInput), Models.Healthcare_SocioEconomic_Transforms_V2.CleanBatch(left,history_date));
  
  Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := if(ofac_version_ = 4 and LeadIntegrityVersion >= 4 and le.servicename = 'bridgerwlc', le.servicename, '');
	self.url := if(ofac_version_ = 4 and LeadIntegrityVersion >= 4 and le.servicename = 'bridgerwlc', le.url, ''); 		
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

	// set variables for passing to bocashell function
	BOOLEAN includeDLverification := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
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
	BOOLEAN include_ofac := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	UNSIGNED1 ofacVersion := map(LeadIntegrityVersion >= 4 and ofac_version_ = 4 => 4,
                               LeadIntegrityVersion >= 4 => 2, 
                                                            1);
	BOOLEAN includeAdditionalWatchlists := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
  REAL    global_watchlist_threshold := if(ofacVersion in [1, 2, 3], 0.84, 0.85);
	BOOLEAN excludeWatchlists := IF(LeadIntegrityVersion >= 4, FALSE, TRUE); // Attributes 4.1 return a watchlist hit, so don't exclude watchlists
	// For ITA we can't use FARES Data
	BOOLEAN filterOutFares := TRUE;
	append_best := if( model_name = 'HCSE002_0' or LeadIntegrityVersion >= 4, 2, 0 );

	unsigned8 BSOptions := IF(LeadIntegrityVersion >= 4, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail + 
																											risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
																											risk_indicators.iid_constants.BSOptions.IncludeDoNotMail);
                                                      
if(ofacVersion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
	iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, include_ofac, includeAdditionalWatchlists, global_watchlist_threshold,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);
	iidHist12 := Risk_Indicators.InstantID_Function(cleanInHist12, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, include_ofac, includeAdditionalWatchlists, global_watchlist_threshold,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);
	iidHist24 := Risk_Indicators.InstantID_Function(cleanInHist24, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, include_ofac, includeAdditionalWatchlists, global_watchlist_threshold,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);

	clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission);
	clamHist12 := Risk_Indicators.Boca_Shell_Function(iidHist12, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission);
	clamHist24 := Risk_Indicators.Boca_Shell_Function(iidHist24, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission);

	LeadIntegrity := Models.get_LeadIntegrity_Attributes(clam,LeadIntegrityVersion);
	LeadIntegrityHist12 := Models.get_LeadIntegrity_Attributes(clamHist12,LeadIntegrityVersion);
	LeadIntegrityHist24 := Models.get_LeadIntegrity_Attributes(clamHist24,LeadIntegrityVersion);

	rawResults := join(batchinseq, LeadIntegrity, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_V2.layout_SocioEconomic_attributes_combined,
					self.acctno := left.acctno;
					self.seq := if(right.seq <>'',right.seq,left.acctno);
					self.membergender := 0;
					self := right; self := left;),left outer, keep(1000), atmost(1));
	rawResults12 := join(batchinseqHist12, LeadIntegrityHist12, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_V2.layout_SocioEconomic_attributes_combined,
					self.acctno := left.acctno;
					self := right),keep(1000), atmost(1));
	rawResults24 := join(batchinseqHist24, LeadIntegrityHist24, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_V2.layout_SocioEconomic_attributes_combined,
					self.acctno := left.acctno;
					self := right),keep(1000), atmost(1));

	rawResults_appendInput := join(rawResults,batchinseq,(integer)left.seq=(integer)right.seq,
															transform(Models.Layouts_Healthcare_V2.layout_SocioEconomic_attributes_combined,
																ageRefYYYYMMDD := if((string)history_date = '999999', (string)Std.Date.Today(), (string)history_date+(string2)Models.Healthcare_SocioEconomic_Functions_V2.calcDaysInMonth((string)history_date));
																self.MemberAge := Models.Healthcare_SocioEconomic_Functions_V2.calcAgeInYears(right.DOB,(string)ageRefYYYYMMDD);
																//Do other crosswalks.....
																gender:=STD.Str.ToUpperCase(right.MemberGender);
																self.GenderStr := gender; //Needed for Model  as Gender attribute
																self.MemberGender := map(gender='M'=>0,
																												 gender='F'=>1,(integer)gender);
																self.CrosswalkState := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkState(right.St);
																self.CrosswalkAddrRecentEconTrajectory := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkAddrRecentEconTrajectory(left.version4.AddrRecentEconTrajectory);
																self.CrosswalkBankruptcyStatus := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkBankruptcyStatus(left.version4.BankruptcyStatus);
																self.CrosswalkBankruptcyType := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkBankruptcyType(left.version4.BankruptcyType);
																self.CrosswalkCurrAddrDwellType := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkCurrAddrDwellType(left.version4.CurrAddrDwellType);
																self.CrosswalkInputAddrDwellType := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkInputAddrDwellType(left.version4.InputAddrDwellType);
																self.CrosswalkInputAddrValidation := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkInputAddrValidation(left.version4.InputAddrValidation);
																self.CrosswalkInputPhoneType := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkInputPhoneType(left.version4.InputPhoneType);
																self.CrosswalkPrevAddrDwellType := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkPrevAddrDwellType(left.version4.PrevAddrDwellType);
																self.CrosswalkSsnIssueState := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkSsnIssueState(left.version4.SSNIssueState);
																self.CrosswalkStatusMostRecent := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkStatusMostRecent(left.version4.StatusMostRecent);
																self.CrosswalkStatusNextPrevious := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkStatusNextPrevious(left.version4.StatusNextPrevious);
																self.CrosswalkStatusPrevious := Models.Healthcare_SocioEconomic_Functions_V2.CrosswalkStatusPrevious(left.version4.StatusPrevious);
																self:=left;), 
															left outer, keep(1000), atmost(1));
	rawResults_append12 := join(rawResults_appendInput,rawResults12,(integer)left.seq=(integer)right.seq,
															transform(Models.Layouts_Healthcare_V2.layout_SocioEconomic_attributes_combined,
																self.v4_CurrAddrBurglaryIndex12 := right.version4.CurrAddrBurglaryIndex;
																self.v4_EstimatedAnnualIncome12 := right.version4.EstimatedAnnualIncome;
																self.v4_PropOwnedTaxTotal12 := right.version4.PropOwnedTaxTotal;
																self.v4_SFDUAddrIdentitiesCount12 := right.version4.SFDUAddrIdentitiesCount;
																self:=left;), 
															left outer, keep(1000), atmost(1));
	rawResults_final := dedup(sort(join(rawResults_append12,rawResults24,(integer)left.seq=(integer)right.seq,
															transform(Models.Layouts_Healthcare_V2.layout_SocioEconomic_attributes_combined,
																self.v4_CurrAddrBurglaryIndex24 := right.version4.CurrAddrBurglaryIndex;
																self.v4_EstimatedAnnualIncome24 := right.version4.EstimatedAnnualIncome;
																self.v4_PropOwnedTaxTotal24 := right.version4.PropOwnedTaxTotal;;
																self.v4_SFDUAddrIdentitiesCount24 := right.version4.SFDUAddrIdentitiesCount;
																self:=left;), 
															left outer, keep(1000), atmost(1)),record),record);

	//Preparing Profile Booster Input with LexID
	Profilebooster_Input := project(batchin, Models.Healthcare_SocioEconomic_Transforms_V2.AddSeq_ProfileBooster(left,counter,history_date));
	Profilebooster_In_Join_LexID := join(Profilebooster_Input, clam, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_V2.Layout_SocioEconomic_Batch_PB_In,
					self.acctno := left.acctno;
					self.LexID := right.did;
					self := left; self := [];),left outer, keep(1000), atmost(1));
	Profilebooster_In_With_LexID := project(Profilebooster_In_Join_LexID, TRANSFORM(Profilebooster.Layouts.Layout_PB_In,SELF := LEFT));
 	
 	//Profile Booster Search Function Contants
	Profilebooster_AttributesVersionRequest := Models.Healthcare_Constants_V2.default_Profilebooster_AttributesVersionRequest;

	//Calling Profile Booster Search Function and fetching the attributes
	pb_attributes := ProfileBooster.Search_Function(Profilebooster_In_With_LexID, DataRestriction, DataPermission, Profilebooster_AttributesVersionRequest);  
	//output(	pb_attributes, named('pb_attributes') );
	//Combining Lead Integrity and Profile Booster attributes
	Combined_LI_PB_Attributes := 	Join(rawResults_final, pb_attributes, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_V2.layout_SocioEconomic_LI_PB_combined,
					self.acctno := left.acctno;
					self.pb_attributes := right.attributes;
					self := left; self := right;),left outer, keep(1000), atmost(1));
	//output(	Combined_LI_PB_Attributes, named('Combined_LI_PB_Attributes') );
	
	/********Flattening the combined Lead Integrity and Profile Booster attributes*********/
	Combined_LI_PB_Attributes_flat := project(Combined_LI_PB_Attributes, Models.Healthcare_SocioEconomic_Transforms_V2.FlattenLIPB(LEFT));
	//output(Combined_LI_PB_Attributes_flat, NAMED('Combined_LI_PB_Attributes_flat'));

	//Preparing the data for Pre Processing i.e. substituting crosswalk values, history attributes etc.
	Combined_LI_PB_Prep_Pre_Proc := project(Combined_LI_PB_Attributes_flat, Models.Healthcare_SocioEconomic_Transforms_V2.Prep_For_Pre_Processing_Xform(LEFT));
	//output(Combined_LI_PB_Prep_Pre_Proc, NAMED('Combined_LI_PB_Prep_Pre_Proc'));
	
	//Run Pre Processing Transform to generate derived attributes
	Pre_Proc_Out := Project(Combined_LI_PB_Prep_Pre_Proc, Models.Healthcare_SocioEconomic_Transforms_V2.Pre_Processing_Xform(LEFT));
	// output(Pre_Proc_Out, NAMED('Pre_Proc_Out'));
	
	//Run Patterns Transforms for both GE_18 and LT_18 Datasets while splitting the datasets based on Age_In_Years
	Patterns_Applied_GE_18 := Models.Healthcare_SocioEconomic_Transforms_V2.GE_18_Patterns(Pre_Proc_Out(AGE_IN_YEARS >= 18), Models.Layouts_Healthcare_V2.layout_SocioEconomic_LI_PB_flat_typed, (integer)preProcRefYear);
	// output(Patterns_Applied_GE_18, NAMED('Patterns_Applied_GE_18'));
	Patterns_Applied_LT_18 := Models.Healthcare_SocioEconomic_Transforms_V2.LT_18_Patterns0(Pre_Proc_Out(AGE_IN_YEARS < 18 AND ProfileBooster_missing=0 ), Models.Layouts_Healthcare_V2.layout_SocioEconomic_LI_PB_flat_typed,(integer)preProcRefYear)
													+ Models.Healthcare_SocioEconomic_Transforms_V2.LT_18_Patterns1(Pre_Proc_Out(AGE_IN_YEARS < 18 AND ProfileBooster_missing=1), Models.Layouts_Healthcare_V2.layout_SocioEconomic_LI_PB_flat_typed, (integer)preProcRefYear);
	// output(Patterns_Applied_LT_18, NAMED('Patterns_Applied_LT_18'));
	
	//Run Mapper provided by Modelers to shift base values etc.
	Patterns_Applied_Mapped_GE_18 := Models.Healthcare_SocioEconomic_Transforms_V2.GE_18_doMapping(Patterns_Applied_GE_18,Models.Layouts_Healthcare_V2.layout_SocioEconomic_LI_PB_flat_typed);
	// output(Patterns_Applied_Mapped_GE_18, NAMED('Patterns_Applied_Mapped_GE_18'));
	Patterns_Applied_Mapped_LT_18 := Models.Healthcare_SocioEconomic_Transforms_V2.LT_18_doMapping(Patterns_Applied_LT_18,Models.Layouts_Healthcare_V2.layout_SocioEconomic_LI_PB_flat_typed);
	// output(Patterns_Applied_Mapped_LT_18, NAMED('Patterns_Applied_Mapped_LT_18'));
	
	//Run LUCI Models on transform data that contains do_Model1 and TransactionID, which are needed by the LUCI model to run
	Patterns_Applied_Mapped_GE_18_Model_Input := PROJECT(Patterns_Applied_Mapped_GE_18, TRANSFORM(Models.Layouts_Healthcare_V2.Model_Input_Layout, SELF.do_Model1 := TRUE,SELF.TransactionID := (string)LEFT.SEQ, SELF := LEFT));
	GE_18_LUCI_results_base := HCSE_GE_18_LUCI_MODEL.AsResults(Patterns_Applied_Mapped_GE_18_Model_Input).Base();
	// OUTPUT(GE_18_LUCI_results_base, NAMED('GE_18_LUCI_results_base'));
	Patterns_Applied_Mapped_LT_18_Model_Input := PROJECT(Patterns_Applied_Mapped_LT_18, TRANSFORM(Models.Layouts_Healthcare_V2.Model_Input_Layout, SELF.do_Model1 := TRUE,SELF.TransactionID := (string)LEFT.SEQ, SELF := LEFT));
	LT_18_LUCI_results_base := HCSE_LT_18_LUCI_MODEL.AsResults(Patterns_Applied_Mapped_LT_18_Model_Input).Base();
	// OUTPUT(LT_18_LUCI_results_base, NAMED('LT_18_LUCI_results_base'));
	
	//If Model Name check is needed
	// GE_18_LUCI_results_base := case( STD.Str.ToUpperCase(trim(model_name)),
	// 	'HCSE002_0' => HCSE_GE_18_LUCI_MODEL.AsResults(Patterns_Applied_Mapped_GE_18_Model_Input).Base(),
	// 	fail(Need layout here,'Invalid model name requested' )
	// 	);
		
	// LT_18_LUCI_results_base :=  case( STD.Str.ToUpperCase(trim(model_name)),
	// 	'HCSE002_0' => HCSE_LT_18_LUCI_MODEL.AsResults(Patterns_Applied_Mapped_LT_18_Model_Input).Base(),
	// 	fail(Need layout here,'Invalid model name requested' )
	// 	);


	//Run Post Processing transform to adjust the predicted score
	GE_18_Prediction_Post_Proc := Join(Patterns_Applied_GE_18, GE_18_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_V2.PostProcessing_Layout_LUCI_Model,
		self.Score := MAX((Real8)right.Score, left.PMPM_13_05K_AGPred * 0.2);
		self.seq := (integer)right.TransactionID;
		self := right;),left outer, keep(1000), atmost(1));
	// OUTPUT(GE_18_Prediction_Post_Proc, NAMED('GE_18_Prediction_Post_Proc'));
	LT_18_Prediction_Post_Proc := Join(Patterns_Applied_LT_18, LT_18_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_V2.PostProcessing_Layout_LUCI_Model,
		self.Score := MAX((Real8)right.Score, left.AG_Pred_5K_under18 * 0.2);
		self.seq := (integer)right.TransactionID;
		self := right;),left outer, keep(1000), atmost(1));
	// OUTPUT(LT_18_Prediction_Post_Proc, NAMED('LT_18_Prediction_Post_Proc'));
	
	//Join the Model Prediction back to the un-crosswalked flattened attributes and also include custom attributes/history attributes in the result	
	Attributes_Prediction := Join(Combined_LI_PB_Attributes_flat, GE_18_Prediction_Post_Proc+LT_18_Prediction_Post_Proc, left.seq=right.seq, transform(Models.Layouts_Healthcare_V2.Attributes_Prediction_Layout,
		self.Score := right.Score;
		self := left;),left outer, keep(1000), atmost(1));
	// OUTPUT(Attributes_Prediction, NAMED('Attributes_Prediction'));	

	//Transforming the result to final layout and output as strings
	Results_Attributes_Prediction := project(Attributes_Prediction, Models.Healthcare_SocioEconomic_Transforms_V2.Final_Output_Result(LEFT));
	//output(Results_Attributes_Prediction, NAMED('Results_Attributes_Prediction'));				
	
	Results_Attributes_Only := project(Combined_LI_PB_Attributes_flat, Models.Healthcare_SocioEconomic_Transforms_V2.Attributes_Only(LEFT));					
	//output(Results_Attributes_Only, NAMED('Results_Attributes_Only'));				

	Results_Attributes_Prediction_ADL := Join(Results_Attributes_Prediction, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_V2.Final_Output_Layout_ADL,
					self.ADLScore := (string)right.score;
					self := left;),left outer, keep(1000), atmost(1));

	Results_Attributes_Only_ADL := Join(Results_Attributes_Only, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_V2.Final_Output_Layout_ADL,
					self.ADLScore := (string)right.score;
					self := left;),left outer, keep(1000), atmost(1));
	
	String AttributesOnly := 'N' : stored('AttributesOnly');
  outResults := if (AttributesOnly='Y', Results_Attributes_Only_ADL, Results_Attributes_Prediction_ADL);
  output(outResults, NAMED('Results'));


ENDMACRO;
