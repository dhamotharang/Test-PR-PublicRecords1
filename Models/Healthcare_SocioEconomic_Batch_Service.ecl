/*--SOAP--
<message name="Healthcare_SocioEconomic_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="IndustryClass" type="xsd:string"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="Version" type="xsd:integer"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO-- Healthcare SocioEconomic Batch Service*/
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
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import risk_indicators, models, std;


export Healthcare_SocioEconomic_Batch_Service := MACRO

	batchin := dataset([],Models.Layouts_Healthcare.Layout_SocioEconomic_Batch_In) : stored('batch_in',few);
	gateways := Gateway.Constants.void_gateway;

	unsigned1 prep_dppa := Models.Healthcare_Constants.default_DPPA :		stored('DPPAPurpose');
	unsigned1 glb := Models.Healthcare_Constants.default_GLBA : stored('GLBPurpose');
	unsigned1 runtime_attributesVersion := 1 : stored('Version');//Default for integer fields is 0, so if the user does not supply default to 1
	unsigned1 attributesVersion := if(runtime_attributesVersion>0,runtime_attributesVersion,1);//If the input version is set (ie greater thant zero) take it otherwise default to 1
	string ModelName_in := '' : stored('ModelName');
	model_name := STD.Str.ToUpperCase(modelname_in);
	string5   industry_class_val := '';
	boolean   isUtility := false;
	boolean   ofac_Only := false;

	string IndustryClass := '' : stored('IndustryClass');
	string DataRestriction := Models.Healthcare_Constants.default_DataRestriction : stored('DataRestrictionMask');
	string50 DataPermission := Models.Healthcare_Constants.default_DataPermission : stored('DataPermissionMask');
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
	
    //CCPA fields
    unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
    string TransactionID := '' : stored ('_TransactionId');
    string BatchUID := '' : stored('_BatchUID');
    unsigned6 GlobalCompanyId := 0 : stored('_GCID');
    
	unsigned1 dppa := prep_dppa; //Remove DNC filter if(~DisableDoNotMailFilter, 0, prep_dppa);

	LeadIntegrityVersion := Models.Healthcare_Constants.default_LeadIntegrity_Version;//We want version 4
	bsVersion := Models.Healthcare_Constants.default_BocaShell_Version; //We want version 4.1

	batchin0 := project(batchin, Models.Healthcare_SocioEconomic_Transforms.AddSeq(left,counter,history_date));
	batchin12 := project(batchin, Models.Healthcare_SocioEconomic_Transforms.AddSeq(left,counter,history_date12));
	batchin24 := project(batchin, Models.Healthcare_SocioEconomic_Transforms.AddSeq(left,counter,history_date24));
	batchinseq := batchin0;
	batchinseqHist12 := batchin12;
	batchinseqHist24 := batchin24;

	cleanIn := project(batchinseq(Age>=18 and goodInput), Models.Healthcare_SocioEconomic_Transforms.CleanBatch(left,history_date));
	cleanInHist12 := project(batchinseqHist12(Age>=18 and goodInput), Models.Healthcare_SocioEconomic_Transforms.CleanBatch(left,history_date));
	cleanInHist24 := project(batchinseqHist24(Age>=18 and goodInput), Models.Healthcare_SocioEconomic_Transforms.CleanBatch(left,history_date));

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
	BOOLEAN ofacSearching := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	UNSIGNED1 ofacVersion := IF(LeadIntegrityVersion >= 4, 2, 1);
	BOOLEAN includeAdditionalWatchlists := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	BOOLEAN excludeWatchlists := IF(LeadIntegrityVersion >= 4, FALSE, TRUE); // Attributes 4.1 return a watchlist hit, so don't exclude watchlists
	// For ITA we can't use FARES Data
	BOOLEAN filterOutFares := TRUE;
	append_best := if( model_name = 'HCSE001_0' or LeadIntegrityVersion >= 4, 2, 0 );

	unsigned8 BSOptions := IF(LeadIntegrityVersion >= 4, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail + 
																											risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
																											risk_indicators.iid_constants.BSOptions.IncludeDoNotMail);

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
	iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID);
	iidHist12 := Risk_Indicators.InstantID_Function(cleanInHist12, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID);
	iidHist24 := Risk_Indicators.InstantID_Function(cleanInHist24, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID);

	clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission,
                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                            TransactionID := TransactionID, 
                                                                                            BatchUID := BatchUID, 
                                                                                            GlobalCompanyID := GlobalCompanyID);
	clamHist12 := Risk_Indicators.Boca_Shell_Function(iidHist12, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission,
                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                            TransactionID := TransactionID, 
                                                                                            BatchUID := BatchUID, 
                                                                                            GlobalCompanyID := GlobalCompanyID);
	clamHist24 := Risk_Indicators.Boca_Shell_Function(iidHist24, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission,
                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                            TransactionID := TransactionID, 
                                                                                            BatchUID := BatchUID, 
                                                                                            GlobalCompanyID := GlobalCompanyID);

	LeadIntegrity := Models.get_LeadIntegrity_Attributes(clam,LeadIntegrityVersion);
	LeadIntegrityHist12 := Models.get_LeadIntegrity_Attributes(clamHist12,LeadIntegrityVersion);
	LeadIntegrityHist24 := Models.get_LeadIntegrity_Attributes(clamHist24,LeadIntegrityVersion);

	rawResults := join(batchinseq, LeadIntegrity, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare.layout_SocioEconomic_attributes_combined,
					self.acctno := left.acctno;
					self.seq := if(right.seq <>'',right.seq,left.acctno);
					self.membergender := 0;
					self := right; self := left;),left outer, keep(1000), atmost(1));
	rawResults12 := join(batchinseqHist12, LeadIntegrityHist12, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare.layout_SocioEconomic_attributes_combined,
					self.acctno := left.acctno;
					self := right),keep(1000), atmost(1));
	rawResults24 := join(batchinseqHist24, LeadIntegrityHist24, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare.layout_SocioEconomic_attributes_combined,
					self.acctno := left.acctno;
					self := right),keep(1000), atmost(1));

	rawResults_appendInput := join(rawResults,batchinseq,(integer)left.seq=(integer)right.seq,
															transform(Models.Layouts_Healthcare.layout_SocioEconomic_attributes_combined,
																self.MemberAge := Models.Healthcare_SocioEconomic_Functions.calcAge(right.DOB);
																//Do other crosswalks.....
																gender:=STD.Str.ToUpperCase(right.MemberGender);
																self.MemberGender := map(gender='M'=>0,
																												 gender='F'=>1,(integer)gender);
																self.CrosswalkState := Models.Healthcare_SocioEconomic_Functions.CrosswalkState(right.St);
																self.CrosswalkAddrRecentEconTrajectory := Models.Healthcare_SocioEconomic_Functions.CrosswalkAddrRecentEconTrajectory(left.version4.AddrRecentEconTrajectory);
																self.CrosswalkBankruptcyStatus := Models.Healthcare_SocioEconomic_Functions.CrosswalkBankruptcyStatus(left.version4.BankruptcyStatus);
																self.CrosswalkBankruptcyType := Models.Healthcare_SocioEconomic_Functions.CrosswalkBankruptcyType(left.version4.BankruptcyType);
																self.CrosswalkCurrAddrDwellType := Models.Healthcare_SocioEconomic_Functions.CrosswalkCurrAddrDwellType(left.version4.CurrAddrDwellType);
																self.CrosswalkInputAddrDwellType := Models.Healthcare_SocioEconomic_Functions.CrosswalkInputAddrDwellType(left.version4.InputAddrDwellType);
																self.CrosswalkInputAddrValidation := Models.Healthcare_SocioEconomic_Functions.CrosswalkInputAddrValidation(left.version4.InputAddrValidation);
																self.CrosswalkInputPhoneType := Models.Healthcare_SocioEconomic_Functions.CrosswalkInputPhoneType(left.version4.InputPhoneType);
																self.CrosswalkPrevAddrDwellType := Models.Healthcare_SocioEconomic_Functions.CrosswalkPrevAddrDwellType(left.version4.PrevAddrDwellType);
																self.CrosswalkSsnIssueState := Models.Healthcare_SocioEconomic_Functions.CrosswalkSsnIssueState(left.version4.SSNIssueState);
																self.CrosswalkStatusMostRecent := Models.Healthcare_SocioEconomic_Functions.CrosswalkStatusMostRecent(left.version4.StatusMostRecent);
																self.CrosswalkStatusNextPrevious := Models.Healthcare_SocioEconomic_Functions.CrosswalkStatusNextPrevious(left.version4.StatusNextPrevious);
																self.CrosswalkStatusPrevious := Models.Healthcare_SocioEconomic_Functions.CrosswalkStatusPrevious(left.version4.StatusPrevious);
																self:=left;), 
															left outer, keep(1000), atmost(1));
	rawResults_append12 := join(rawResults_appendInput,rawResults12,(integer)left.seq=(integer)right.seq,
															transform(Models.Layouts_Healthcare.layout_SocioEconomic_attributes_combined,
																self.v4_CurrAddrBurglaryIndex12 := right.version4.CurrAddrBurglaryIndex;
																self.v4_EstimatedAnnualIncome12 := right.version4.EstimatedAnnualIncome;
																self.v4_PropOwnedTaxTotal12 := right.version4.PropOwnedTaxTotal;
																self.v4_SFDUAddrIdentitiesCount12 := right.version4.SFDUAddrIdentitiesCount;
																self:=left;), 
															left outer, keep(1000), atmost(1));
	rawResults_final := dedup(sort(join(rawResults_append12,rawResults24,(integer)left.seq=(integer)right.seq,
															transform(Models.Layouts_Healthcare.layout_SocioEconomic_attributes_combined,
																self.v4_CurrAddrBurglaryIndex24 := right.version4.CurrAddrBurglaryIndex;
																self.v4_EstimatedAnnualIncome24 := right.version4.EstimatedAnnualIncome;
																self.v4_PropOwnedTaxTotal24 := right.version4.PropOwnedTaxTotal;;
																self.v4_SFDUAddrIdentitiesCount24 := right.version4.SFDUAddrIdentitiesCount;
																self:=left;), 
															left outer, keep(1000), atmost(1)),record),record);


	model := case( STD.Str.ToUpperCase(trim(model_name)),
		'HCSE001_0' => Models.HCSE001_0.getScore(rawResults_final), //Healthcare V2 will implement a model
		''          => dataset( [], Models.Layouts_Healthcare.Layout_ModelDebugOut ),
		fail( Models.Layouts_Healthcare.Layout_ModelDebugOut, 'Invalid model name requested' )
	);

	with_model := join( rawResults_final, model, (integer)left.seq=right.seq, Models.Healthcare_SocioEconomic_Transforms.AddScore(left,right,model_name), left outer);
		
	flattened := project(sort(with_model,acctno,seq), Models.Healthcare_SocioEconomic_Transforms.FlattenOutput(LEFT) );
	// output(batchinseq, named('batchinseq'));
	// output(clam, named('clam'));
	// output(LeadIntegrity, named('LeadIntegrity'));
	// output(with_ACCTNO, named('with_ACCTNO'));
	// output(rawResults, named('rawResults'));
	// output(rawResults12, named('rawResults12'));
	// output(rawResults24, named('rawResults24'));
	// output(rawResults_appendInput, named('rawResults_appendInput'));
	// output(rawResults_append12, named('rawResults_append12'));
	// output(rawResults_final, named('rawResults_final'));
	// output(model, named('model'));//Use to get debug information
	// output(with_model, named('with_model'));
	output(flattened, named('Results'));

ENDMACRO;
