
/*--SOAP--
<message name="Premise Association Report">
	<part name="PremiseAssociationRequest" type="tns:XmlDataSet" cols="80" rows="50"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
 </message>
*/

IMPORT Address, AutoStandardI, iesp, Risk_indicators, Riskwise, ut, STD, Inquiry_AccLogs, Risk_Reporting;

EXPORT PAR_Search_Service() := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('OnlyReturnSuccessfullyCleanedAddresses',true);

	// Get XML input 
	requestIn   := dataset([], iesp.premiseassociation.t_PremiseAssociationRequest) : stored('PremiseAssociationRequest', few);
  firstRow 		:= requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	optionsIn 	:= GLOBAL(firstRow.options);
	userIn 			:= GLOBAL(firstRow.user);
	search 			:= GLOBAL(firstRow.SearchBy);
	
/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := if(userIn.CompanyId != '', userIn.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	string10 SSN_Mask                := if(userIn.SSNMask = '', 'none', userIn.SSNMask);
	outofbanddobmask                := '' : STORED('DOBMask');
	string10 DOB_Mask               := if(userIn.DOBMask != '', userIn.DOBMask, outofbanddobmask);
	BOOLEAN DL_Mask                 := userIn.DLMask;
	BOOLEAN ExcludeDMVPII           := userIn.ExcludeDMVPII;
	BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');
	
	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.VerificationOfOccupancy__PAR_Search_Service);
/* ************* End Scout Fields **************/
	
	string6  outOfBandHistoryDate := '' : STORED('HistoryDateYYYYMM');
	string8  OOBHistoryDate := if(outOfBandHistoryDate <> '', outOfBandHistoryDate + '01', '');
	
	asOf 				:= search.AsOf.year
								 + intformat((integer1)search.AsOf.month, 2, 1)
								 + intformat((integer1)search.AsOf.day,   2, 1);
	
	integer asOfDate    			:=  MAP((integer)asOf <> 0  						=> (Integer)asOf,
																		 TRIM(OOBHistoryDate)  <> ''  	=> (integer)OOBHistoryDate,
																																				999999);

  STRING50 outOfBandDataRestriction   := AutoStandardI.GlobalModule().DataRestrictionMask;
	// Check to see if the default from GlobalModule() is used, if so overwrite it to our default data restriction.  Our default doesn't include spaces.
  STRING50 DataRestriction := MAP(TRIM(userIn.DataRestrictionMask) <> '' 								=> userIn.DataRestrictionMask,
                                  TRIM(outOfBandDataRestriction) not in ['', '1    0'] 	=> outOfBandDataRestriction, //only use the OOB DRM if it's actually been provided (not the default)
																																													 Risk_Indicators.iid_constants.default_DataRestriction);

  STRING50 outOfBandDataPermission := AutoStandardI.GlobalModule().DataPermissionMask;
  STRING50 DataPermission := MAP(TRIM(userIn.DataPermissionMask) <> '' => userIn.DataPermissionMask,
                                 TRIM(outOfBandDataPermission) <> ''   => outOfBandDataPermission,
																																						Risk_Indicators.iid_constants.default_DataPermission);

	TestDataEnabled 			:= userIn.TestDataEnabled;
	TestDataTableName 		:= Trim(userIn.TestDataTableName);
	attributesVersion 		:= StringLib.StringToUpperCase(optionsIn.AttributesVersionRequest);
	IncludeModel 					:= optionsIn.IncludeModel;
	IncludeReport 				:= optionsIn.IncludeReport;
	
	DPPA 									:= (unsigned1)userIn.DLPurpose;
	GLBA 									:= (unsigned1)userIn.GLBPurpose;
	industry_class_val 		:= (string)userIn.IndustryClass;
	isUtility 						:= StringLib.StringToUpperCase(industry_class_val) = 'UTILI';

	fullname 							:= trim(search.name.full);
	cleanname 						:= address.CleanPerson73( fullname );
	title  								:= if(search.name.prefix='' and fullname!='', trim((cleanname[1..5]))  , trim(search.name.prefix));
	fname  								:= if(search.name.first ='' and fullname!='', trim((cleanname[6..25])) , trim(search.name.first));
	mname  								:= if(search.name.middle='' and fullname!='', trim((cleanname[26..45])), trim(search.name.middle));
	lname  								:= if(search.name.last  ='' and fullname!='', trim((cleanname[46..65])), trim(search.name.last));
	suffix 								:= if(search.name.suffix='' and fullname!='', trim((cleanname[66..70])), trim(search.name.suffix));

	streetName 						:= TRIM(search.Address.StreetName);
	streetNumber 					:= TRIM(search.Address.StreetNumber);
	streetPreDirection 		:= TRIM(search.Address.StreetPreDirection);
	streetPostDirection 	:= TRIM(search.Address.StreetPostDirection);
	streetSuffix 					:= TRIM(search.Address.StreetSuffix);
	UnitNumber 						:= TRIM(search.Address.UnitNumber);
	UnitDesig 						:= TRIM(search.Address.UnitDesignation);
	tempStreetAddr 				:= Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
	in_streetAddress1 		:= IF(search.Address.StreetAddress1='', TRIM(tempStreetAddr), TRIM(search.Address.StreetAddress1));
	in_streetAddress2 		:= TRIM(search.Address.StreetAddress2);
	streetAddr 						:= TRIM(in_streetAddress1 + ' ' + in_streetAddress2);

	boolean NameCheck		  := fname <> '' and lname <> '';
	boolean AddrCheck		  := in_streetAddress1 <> '';
	boolean CityCheck		  := TRIM(search.address.city) <>'';
	boolean StateCheck		:= TRIM(search.address.state) <>'';
	boolean DPPAMissing	  := TRIM(userIn.DLPurpose) = '';
	boolean DPPAValid		  := TRIM(userIn.DLPurpose)<>'' and ((integer)(userIn.DLPurpose) >= 0 and (integer)(userIn.DLPurpose) < 8);
	boolean GLBMissing	  := TRIM(userIn.GLBPurpose) in ['','0'];
	boolean GLBValid		  := TRIM(userIn.GLBPurpose)<>'' and ((integer)(userIn.GLBPurpose) > 0 and (integer)(userIn.GLBPurpose) < 8 or (integer)(userIn.GLBPurpose)=11 or (integer)(userIn.GLBPurpose)=12);
	boolean InputValid 		:= NameCheck and AddrCheck and CityCheck and StateCheck;
	boolean RequestValid 	:= attributesVersion in ['PARATTRV1'];  //version 1 is the initial version

	layout_acctseq := record
		integer4 seq;
		requestIn;
	end;
	
	wseq := project( requestIn, transform( layout_acctseq, self.seq := counter, self := left ) );

	VerificationOfOccupancy.Layouts.Layout_VOOIn into(wseq l) := TRANSFORM
		self.LexID 								:= (integer)l.searchby.UniqueId;
		self.seq 									:= l.seq;
		self.AsOf 								:= (string)asOfDate;
		self.ssn 									:= l.searchby.ssn;
		self.dob 									:= l.searchby.dob.year + intformat((integer1)l.searchby.dob.month, 2, 1) + intformat((integer1)l.searchby.dob.day, 2, 1);
		self.Name_Full 						:= fullname;
		self.Name_Title  					:= title;
		self.Name_First  					:= fname;
		self.Name_Middle 					:= mname;
		self.Name_Last  					:= lname;
		self.Name_Suffix 					:= suffix;
		self.street_addr					:= streetAddr;
		self.streetnumber					:= streetnumber;
		self.streetpredirection		:= streetpredirection;
		self.streetname						:= streetname;
		self.streetsuffix					:= streetsuffix;
		self.streetpostdirection	:= streetpostdirection;
		self.unitdesignation			:= unitdesig;
		self.unitnumber						:= unitnumber;
		self.City_name         		:= search.address.city;
		self.st        						:= search.address.state;
		self.z5      							:= search.address.zip5;	
		self.phone10 			   			:= search.Phone;
		self.acctno 							:= userIn.AccountNumber;
		self											:= [];
	END;
	
	PAR_Input := PROJECT(wseq, into(left));	

	Risk_Indicators.Layout_Input intoLayoutInput(ut.ds_oneRecord le, INTEGER c) := TRANSFORM
		SELF.seq 				:= c;
		SELF.fname 			:= trim(stringlib.stringtouppercase(fname));
		SELF.lname 			:= trim(stringlib.stringtouppercase(lname));
		SELF.ssn 				:= trim(search.SSN);
		SELF.in_zipCode := trim(search.address.zip5);
		SELF.phone10 		:= trim(search.Phone);
		SELF 						:= [];
	END;

	packagedTestseedInput := PROJECT(ut.ds_oneRecord, intoLayoutInput(LEFT, COUNTER));	

	searchResults := IF(TestDataEnabled, 
		PROJECT(VerificationOfOccupancy.TestSeed_Function(packagedTestseedInput, TestDataTableName,IncludeModel,IncludeReport), TRANSFORM(VerificationOfOccupancy.Layouts.Layout_PARBatchOutReport, SELF := LEFT; SELF := [])),	// TestSeed Values
		VerificationOfOccupancy.Search_Function(PAR_Input, DataRestriction, glba, dppa, isUtility, AttributesVersion, IncludeModel, DataPermission, IncludeReport, PAR_request := true).PARReport // Realtime Values
	);

	iesp.share.t_NameValuePair createrec(searchResults le, integer C) := TRANSFORM
				self.Name:= case( C,
					1 	=> 'AddressReportingSourceIndex' ,
					2 	=> 'AddressReportingHistoryIndex' ,
					3 	=> 'AddressSearchHistoryIndex' ,
					4 	=> 'AddressUtilityHistoryIndex',
					5 	=> 'AddressPropertyTypeIndex', 
					6 	=> 'AddressValidityIndex', 
					7 	=> 'RelativesConfirmingAddressIndex', 
					8 	=> 'AddressDateFirstSeen',  
					9 	=> 'AddressDateLastSeen',  
					10 	=> 'OccupancyOverride',  
					11 	=> 'PremiseAssociationScore',  
								 'Invalid');
				self.Value:=  case(C,
					1 	=> le.attributes.version1.AddressReportingSourceIndex ,
					2 	=> le.attributes.version1.AddressReportingHistoryIndex ,
					3 	=> le.attributes.version1.AddressSearchHistoryIndex ,
					4 	=> le.attributes.version1.AddressUtilityHistoryIndex,
					5 	=> le.attributes.version1.AddressPropertyTypeIndex ,
					6 	=> le.attributes.version1.AddressValidityIndex ,
					7 	=> le.attributes.version1.RelativesConfirmingAddressIndex ,
					8 	=> le.attributes.version1.AddressDateFirstSeen ,
					9 	=> le.attributes.version1.AddressDateLastSeen ,
					10 	=> le.attributes.version1.OccupancyOverride ,
					11 	=> le.attributes.version1.VerificationOfOccupancyScore,
								 'Invalid');			
		END;
 	
	IndIndex := normalize(ungroup(searchResults), 11, createrec(LEFT,COUNTER ));
	
	iesp.premiseassociation.t_PremiseAssociationResponse IntoResults(wseq le, searchResults ri ) := Transform
			self.Result.InputEcho := le.searchby;      
			SELF.Result.AttributeGroup.attributes :=  IndIndex;
			self.Result.UniqueId := (string)ri.LexID;
			self.Result.AttributeGroup.Name := attributesVersion;  
			self.Result.Report := ri.Report;
			self := le;
			self := [];
	END;
	
	PARResults := join(wseq, searchResults,
	                     right.seq = left.seq,
											 IntoResults(LEFT, RIGHT));

	if(~InputValid and ~TestDataEnabled, FAIL( 'Insufficient input criteria supplied.'));
	if(~RequestValid, FAIL('Invalid attributes version requested - eg PARATTRV1.'));
	if(GLBMissing, FAIL('GLBA permissible purpose is required.'));
	if(~GLBValid, FAIL('Invalid GLB permissible purpose.'));
	if(DPPAMissing, FAIL('DPPA permissible purpose is required.'));
	if(~DPPAValid, FAIL('Invalid DPPA permissible purpose.'));
	
	//Log to Deltabase
	Deltabase_Logging_prep := project(PARResults, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																									 self.company_id := (Integer)CompanyID,
																									 self.login_id := _LoginID,
																									 self.product_id := Risk_Reporting.ProductID.VerificationOfOccupancy__PAR_Search_Service,
																									 self.function_name := FunctionName,
																									 self.esp_method := ESPMethod,
																									 self.interface_version := InterfaceVersion,
																									 self.delivery_method := DeliveryMethod,
																									 self.date_added := (STRING8)Std.Date.Today(),
																									 self.death_master_purpose := DeathMasterPurpose,
																									 self.ssn_mask := SSN_Mask,
																									 self.dob_mask := DOB_Mask,
																									 self.dl_mask := (String)(Integer)DL_Mask,
																									 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																									 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																									 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                   self.glb := GLBA,
                                                   self.dppa := DPPA,
																									 self.data_restriction_mask := DataRestriction,
																									 self.data_permission_mask := DataPermission,
																									 self.industry := Industry_Search[1].Industry,
																									 self.i_attributes_name := attributesVersion,
																									 self.i_ssn := search.SSN,
                                                   self.i_dob := search.dob.year +
                                                                 intformat((integer1)search.dob.month, 2, 1) +
                                                                 intformat((integer1)search.dob.day, 2, 1),
                                                   self.i_name_full := search.name.Full,
																									 self.i_name_first := search.name.first,
																									 self.i_name_last := search.name.last,
																									 self.i_lexid := (Integer)search.UniqueId, 
																									 self.i_address := streetAddr,
																									 self.i_city := search.address.City,
																									 self.i_state := search.address.State,
																									 self.i_zip := search.address.Zip5,
                                                   self.i_home_phone := search.Phone,
																									 self.o_lexid := (Integer)left.Result.UniqueId,
																									 self := left,
																									 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);
	
	//Improved Scout Logging
	IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
	
	OUTPUT(PARResults, NAMED('Results'));
	
ENDMACRO;

/*--HELP-- 
<pre>
&lt;PARRequest&gt;
 &lt;Row&gt;
  &lt;User&gt;
   &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt; 
   &lt;DLPurpose&gt;&lt;/DLPurpose&gt; 
   &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
   &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt; 
   &lt;IndustryClass&gt;&lt;/IndustryClass&gt; 
   &lt;TestDataEnabled&gt;false&lt;/TestDataEnabled&gt;
   &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt;
  &lt;/User&gt; 
  &lt;Options&gt;
   &lt;AttributesVersionRequest&gt;&lt;/AttributesVersionRequest&gt;
   &lt;IncludeModel&gt;&lt;/IncludeModel&gt;
   &lt;IncludeReport&gt;&lt;/IncludeReport&gt;
  &lt;/Options&gt;
  &lt;SearchBy&gt;
	 &lt;UniqueId&gt;&lt;/UniqueId&gt;
	 &lt;Name&gt;
    &lt;Full&gt;&lt;/Full&gt; 
    &lt;First&gt;&lt;/First&gt; 
    &lt;Middle&gt;&lt;/Middle&gt; 
    &lt;Last&gt;&lt;/Last&gt; 
    &lt;Suffix&gt;&lt;/Suffix&gt; 
    &lt;Prefix&gt;&lt;/Prefix&gt; 
   &lt;/Name&gt;
   &lt;Address&gt;
    &lt;StreetNumber&gt;&lt;/StreetNumber&gt; 
    &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt; 
    &lt;StreetName&gt;&lt;/StreetName&gt; 
    &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt; 
    &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt; 
    &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt; 
    &lt;UnitNumber&gt;&lt;/UnitNumber&gt; 
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt; 
    &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt; 
    &lt;City&gt;&lt;/City&gt; 
    &lt;State&gt;&lt;/State&gt; 
    &lt;Zip5&gt;&lt;/Zip5&gt;
    &lt;Zip4&gt;&lt;/Zip4&gt; 
    &lt;County&gt;&lt;/County&gt; 
    &lt;PostalCode&gt;&lt;/PostalCode&gt; 
    &lt;StateCityZip&gt;&lt;/StateCityZip&gt; 
   &lt;/Address&gt;
   &lt;Phone&gt;&lt;/Phone&gt;
   &lt;DOB&gt;
    &lt;Year&gt;0&lt;/Year&gt; 
    &lt;Month&gt;0&lt;/Month&gt; 
    &lt;Day&gt;0&lt;/Day&gt; 
   &lt;/DOB&gt;
   &lt;SSN&gt;&lt;/SSN&gt;
   &lt;AsOf&gt;
    &lt;Year&gt;0&lt;/Year&gt; 
    &lt;Month&gt;0&lt;/Month&gt; 
    &lt;Day&gt;0&lt;/Day&gt;
	 &lt;/AsOf&gt;
  &lt;/SearchBy&gt;
 &lt;/Row&gt;
&lt;/PARRequest&gt;
</pre>
*/