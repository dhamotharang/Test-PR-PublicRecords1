/*--SOAP--
<message name="CDM_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO-- CDM Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
      &lt;ADL&gt;&lt;/ADL&gt;
      &lt;ADLScore&gt;&lt;/ADLScore&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
      &lt;Name_Company&gt;&lt;/Name_Company&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;street_addr_2&gt;&lt;/street_addr_2&gt;
      &lt;p_City_name&gt;&lt;/p_City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Zip&gt;&lt;/Zip&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;Service_Request&gt;&lt;/Service_Request&gt;
      &lt;Record_Type&gt;&lt;/Record_Type&gt;
      &lt;Phone_1&gt;&lt;/Phone_1&gt;
      &lt;Phone_2&gt;&lt;/Phone_2&gt;
      &lt;Phone_3&gt;&lt;/Phone_3&gt;
      &lt;Phone_4&gt;&lt;/Phone_4&gt;
      &lt;Phone_5&gt;&lt;/Phone_5&gt;
      &lt;HistoryDateYYYYMM&gt;&lt;/HistoryDateYYYYMM&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import address, risk_indicators, models, riskwise, ut, dma, doxie;


export CDM_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

batchin := dataset([],Models.layouts.Layout_CDM_Batch_In) 			: stored('batch_in',few);
//output(batchin,named('BatchIn'));
gateways := Gateway.Constants.void_gateway;

unsigned1 prep_dppa := 0 :		stored('DPPAPurpose');
unsigned1 glb := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
string5   industry_class_val := '';
boolean   isUtility := false;
boolean   ofac_Only := false;

string50 DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned3 history_date := 999999 		: stored('HistoryDateYYYYMM');

unsigned1 dppa := prep_dppa;

bsVersion := 41;

// add sequence to matchup later to add acctno to output
Models.layouts.Layout_CDM_Batch_In into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));


risk_indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
	self.did 	:= (integer)le.ADL;
	self.score := (integer)le.ADLScore; 

	// clean up input
	dob_val := riskwise.cleandob(le.dob);

	self.seq := le.seq;	
	self.ssn := IF(le.ssn='000000000','',le.ssn);	// blank out social if it is all 0's
	self.dob := dob_val;
	self.age := if ((integer)dob_val != 0,(STRING3)ut.Age((integer)dob_val), '');
	
	/* got 5 phones to deal with... for now dropping all but 1
	self.phone10 := le.Home_Phone;
	self.wphone10 := le.Work_Phone;
  */
	self.phone10 := le.phone_1;
	
	self.employer_name := le.name_company;
	
	// 4.3 req spreadsheet says if company name is populated then blank out the other name fields
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.fname := if(le.name_company <> '','',stringlib.stringtouppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First)));
	self.lname := if(le.name_company <> '','',stringlib.stringtouppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last)));
	self.mname := if(le.name_company <> '','',stringlib.stringtouppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle)));
	self.suffix := if(le.name_company <> '','',stringlib.stringtouppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix)));	
	self.title := if(le.name_company <> '','',stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],'')));

	street_address := trim(le.street_addr + ' ' + le.street_addr_2);
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Zip) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Zip;
		
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
	
	self.historydate := if(le.historydateYYYYMM=0, history_date, le.historydateYYYYMM);
	self := [];
END;
cleanIn := project(batchinseq, into_in(left));
//output(cleanIn,named('CleanIn'));

// set variables for passing to bocashell function
BOOLEAN includeDLverification := true;
boolean 	require2ele := false;
boolean   isLn := false;	// not needed anymore
boolean   doRelatives := true;
boolean   doDL := true; // n
boolean   doVehicle := true; // n
boolean   doDerogs := true;
boolean   suppressNearDups := false;
boolean   fromBIID := false;
boolean   isFCRA := false;
boolean   fromIT1O := false;
boolean   doScore := false;
boolean   nugen := true;	
BOOLEAN ofacSearching := false;
UNSIGNED1 ofacVersion := 0;
BOOLEAN includeAdditionalWatchlists := false;
BOOLEAN excludeWatchlists := true; 
BOOLEAN filterOutFares := TRUE;
append_best := 0;

unsigned8 BSOptions := risk_indicators.iid_constants.BSOptions.IncludeDoNotMail + 
											 risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity;

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																					suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																					in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);

clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																						doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																						BSOptions := BSOptions, DataPermission := DataPermission);
//output(clam,named('clam'));		

// this function is for correcting months of 00 in header dates.  										
unsigned3 fixYYYY00( unsigned YYYYMM ) := if( YYYYMM > 0 and YYYYMM % 100 = 0, YYYYMM + 1, YYYYMM );
// stolen from get leadintegrity attributes to calc months between dates
	months_apart(unsigned3 system_yearmonth, unsigned some_yearmonth) := function
	 //testdt := 20171030;
		days := ut.DaysApart((string)system_yearmonth + '01', (string)some_yearmonth + '01' );
		//days := ut.DaysApart((string)testdt, (string)some_yearmonth + '01' );
		days_in_a_month := 30.5;
		calculated_months := days/days_in_a_month;
		months := if(some_yearmonth=0, 0, calculated_months);
		return round(months);
	end;

models.layouts.layout_CDM_Batch_Out get_clam(clam le) := transform
self.seq := le.seq;

system_yearmonth := if(le.historydate = risk_indicators.iid_constants.default_history_date, (integer)(Std.Date.Today()[1..6]), le.historydate);

noAddrinput    := not le.input_validation.Address;
noSSNinput     := not le.input_validation.ssn;
noDOBinput     := not le.input_validation.dateofbirth;
noFNameInput   := not le.input_validation.firstname;

// source code lists from sheet provided by AJ
// these codes are used with the ver_x_sources part in the header_summary of the clam
credit_sources    := ['EQ', 'EN'];
credit_combo_srcs := ['TN', 'TS', 'TU']; // note that TN/TS/TU only count as 1 source if multiple of them are present

govt_sources      := ['AK', 'AM', 'AR', 'BA', 'CG', 'DA', 'D',
                      'DS', 'DE', 'EB', 'EM', 'E1', 'E2', 'E3', 'E4',
											           'FE', 'FF', 'FR', 'MW', 'NT', 'P', 
											           'V', 'VO', 'W'];
govt_combo_srcs   := ['L2','LI']; // note L2/LI count as 1
											
allDL_sources     := ['CY', 'D'];
govtDL_sources    := ['D'];
nongovtDL_sources := ['CY'];

voter_sources     := ['VO'];
vehicle_sources   := ['V'];
property_sources  := ['P'];

behav_sources     := ['CY', 'PL', 'SL', 'WP'];

ssn_dts   := models.common.zip2(le.header_summary.ver_ssn_sources, le.header_summary.ver_ssn_sources_first_seen_date,',',models.common.options.leftouter);
ssn_src_dts := sort(ssn_dts(str2 not in ['','0']),str2,str1) + sort(ssn_dts(str2 in ['','0']),str1);
addr_dts  := models.common.zip2(le.header_summary.ver_addr_sources, le.header_summary.ver_addr_sources_first_seen_date,',',models.common.options.leftouter);
addr_src_dts := sort(addr_dts(str2 not in ['','0']),str2,str1) + sort(addr_dts(str2 in ['','0']),str1);
dob_dts   := models.common.zip2(le.header_summary.ver_dob_sources, le.header_summary.ver_dob_sources_first_seen_date,',',models.common.options.leftouter);
dob_src_dts := sort(dob_dts(str2 not in ['','0']),str2,str1) + sort(dob_dts(str2 in ['','0']),str1);
fname_dts := models.common.zip2(le.header_summary.ver_fname_sources, le.header_summary.ver_fname_sources_first_seen_date,',',models.common.options.leftouter);
fname_src_dts := sort(fname_dts(str2 not in ['','0']),str2,str1) + sort(fname_dts(str2 in ['','0']),str1);

// ssn - credit bureau
t_ssn_src := if(count(ssn_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
self.IDVerSSNCreditBureauCount     := if(noSSNinput, '-1', (string)min(9, count(ssn_src_dts(str1 in credit_sources))+t_ssn_src) );
self.IDVerSSNCreditBureauMonthsSeen := map(le.did=0 => '-1', 
                                        self.IDVerSSNCreditBureauCount = '0' => '-2',
																				(integer)trim(ssn_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																				(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(ssn_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																				);
// ssn - government
g_ssn_src := if(count(ssn_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
self.IDVerSSNGovernmentCount     := if(noSSNinput, '-1', (string)min(255, count(ssn_src_dts(str1 in govt_sources))+g_ssn_src) );
self.IDVerSSNGovernmentMonthsSeen := map(le.did=0 => '-1',
                                      self.IDVerSSNGovernmentCount = '0' => '-2',
																			(integer)trim(ssn_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																			(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(ssn_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																			);
   // no ver ssn last seen dates
self.IDVerSSNDriversLicense := map(le.did=0 or noSSNinput                                        => '-1',
                                   (count(ssn_src_dts(str1 in govtDL_sources)) > 0
																			    and count(ssn_src_dts(str1 in nongovtDL_sources)) > 0) => '3',
																		count(ssn_src_dts(str1 in govtDL_sources)) > 0               => '2',
																		count(ssn_src_dts(str1 in nongovtDL_sources)) > 0            => '1',
																					                                                          '0');
self.IDVerSSNDriversLicenseMonthsSeen := map(le.did=0 => '-1',
                                            count(ssn_src_dts(str1 in allDL_sources)) = 0 => '-2',
																						(integer)trim(ssn_src_dts(str1 in allDL_sources)[1].str2) = 0 => '-3',
																						(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(ssn_src_dts(str1 in allDL_sources)[1].str2))))
																						);
   // no ver ssn last seen dates
// ssn - behavioral
self.IDVerSSNBehavioralCount     := if(noSSNinput, '-1', (string)min(255, count(ssn_src_dts(str1 in behav_sources))) );
self.IDVerSSNBehavioralMonthsSeen := map(le.did=0 => '-1',
                                      self.IDVerSSNBehavioralCount = '0' => '-2',
																			(integer)trim(ssn_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																			(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(ssn_src_dts(str1 in behav_sources)[1].str2))))
																			);
   // no ver ssn last seen dates

self.IDVerAddrMatchesCurrent := map(le.did=0 or noAddrinput => '-1',
																		le.Address_Verification.Address_History_1.address_score >= 80 => '1',
																									'0');

// addr - credit bureau
t_addr_src := if(count(addr_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
self.IDVerAddrCreditBureauCount     := if(noaddrinput, '-1', (string)min(9, count(addr_src_dts(str1 in credit_sources))+t_addr_src) );
self.IDVerAddrCreditBureauMonthsSeen := map(le.did=0 => '-1',
                                            self.IDVerAddrCreditBureauCount = '0' => '-2',
																						(integer)trim(addr_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																						(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																						);
   // no ver addr last seen dates
// addr - government
g_addr_src := if(count(addr_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
self.IDVerAddrGovernmentCount     := if(noaddrinput, '-1', (string)min(255, count(addr_src_dts(str1 in govt_sources))+g_addr_src) );
self.IDVerAddrGovernmentMonthsSeen := map(le.did=0 => '-1',
                                       self.IDVerAddrGovernmentCount = '0' => '-2',
																			 (integer)trim(addr_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																			 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																			 );
   // no ver addr last seen dates
// addr - drivers license
self.IDVerAddrDriversLicense          := map(le.did=0 or noAddrinput                              => '-1',
                                             (count(addr_src_dts(str1 in govtDL_sources)) > 0
																          and count(addr_src_dts(str1 in nongovtDL_sources)) > 0) => '3',
																             count(addr_src_dts(str1 in govtDL_sources)) > 0      => '2',
																		         count(addr_src_dts(str1 in nongovtDL_sources)) > 0   => '1',
																		                                                                 '0');
self.IDVerAddrDriversLicenseMonthsSeen := map(le.did=0 => '-1',
                                           count(addr_src_dts(str1 in allDL_sources)) = 0 => '-2',
																					 (integer)trim(addr_src_dts(str1 in allDL_sources)[1].str2) = 0 => '-3',
																					 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in allDL_sources)[1].str2))))
																					 );
   // no ver addr last seen dates
// addr - voter
self.IDVerAddrVoterRegistration := map(le.did=0 or noAddrinput                        => '-1',
                                       count(addr_src_dts(str1 in voter_sources)) > 0 => '1',
																			                                                   '0');
self.IDVerAddrVoterRegMonthsSeen := map(le.did=0 => '-1',
                                     count(addr_src_dts(str1 in voter_sources)) = 0 => '-2',
																		 (integer)trim(addr_src_dts(str1 in voter_sources)[1].str2) = 0 => '-3',
																		 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in voter_sources)[1].str2))))
																		 );
   // no ver addr last seen dates
// addr - vehicle reg
self.IDVerAddrVehicleRegistration := map(le.did=0 or noAddrinput                          => '-1',
                                         count(addr_src_dts(str1 in vehicle_sources)) > 0 => '1',
																				                                                     '0');
self.IDVerAddrVehicleRegMonthsSeen := map(le.did=0 => '-1',
                                       count(addr_src_dts(str1 in vehicle_sources)) = 0 => '-2',
																			 (integer)trim(addr_src_dts(str1 in vehicle_sources)[1].str2) = 0 => '-3',
																			 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in vehicle_sources)[1].str2))))
																			 );
   // no ver addr last seen dates
// addr - property
self.IDVerAddrProperty := map(le.did=0 or noAddrinput                           => '-1',
                              count(addr_src_dts(str1 in property_sources)) > 0 => '1',
															                                                     '0');
self.IDVerAddrPropertyMonthsSeen := map(le.did=0 => '-1',
                                     count(addr_src_dts(str1 in property_sources)) = 0 => '-2',
																		 (integer)trim(addr_src_dts(str1 in property_sources)[1].str2) = 0 => '-3',
																		 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in property_sources)[1].str2))))
																		 );
   // no ver addr last seen dates
// addr - behavioral
self.IDVerAddrBehavioralCount     := if(noAddrinput, '-1', (string)min(255, count(addr_src_dts(str1 in behav_sources))) );
self.IDVerAddrBehavioralMonthsSeen := map(le.did=0 => '-1',
                                       self.IDVerAddrBehavioralCount = '0' => '-2',
																			 (integer)trim(addr_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																			 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in behav_sources)[1].str2))))
																			 );
   // no ver addr last seen dates

// dob - credit bureau
t_dob_src := if(count(dob_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
self.IDVerDOBCreditBureauCount := if(noDOBinput, '-1', (string)min(9, count(dob_src_dts(str1 in credit_sources))+t_dob_src) );
self.IDVerDOBCreditBureauMonthsSeen := map(le.did=0 => '-1',
                                        self.IDVerDOBCreditBureauCount = '0' => '-2',
																				(integer)trim(dob_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																				(string)min(9999, months_apart(system_yearmonth,fixYYYY00((integer)trim(dob_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																				);
   // no ver dob last seen dates
// dob - government
g_dob_src := if(count(dob_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
self.IDVerDOBGovernmentCount := if(noDOBinput, '-1', (string)min(255, count(dob_src_dts(str1 in govt_sources))+g_dob_src) );
self.IDVerDOBGovernmentMonthsSeen := map(le.did=0 => '-1',
                                      self.IDVerDOBGovernmentCount = '0' => '-2',
																			(integer)trim(dob_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																			(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																			);
   // no ver dob last seen dates
// dob - drivers license
self.IDVerDOBDriversLicense := map(le.did=0 or noDOBinput                              => '-1',
                                   (count(dob_src_dts(str1 in govtDL_sources)) > 0
																and count(dob_src_dts(str1 in nongovtDL_sources)) > 0) => '3',
																   count(dob_src_dts(str1 in govtDL_sources)) > 0      => '2',
																	 count(dob_src_dts(str1 in nongovtDL_sources)) > 0   => '1',
																		                                                      '0');
self.IDVerDOBDriversLicenseMonthsSeen := map(le.did=0 => '-1',
                                          count(dob_src_dts(str1 in allDL_sources)) = 0 => '-2',
																					(integer)trim(dob_src_dts(str1 in allDL_sources)[1].str2) = 0 => '-3',
																					(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in allDL_sources)[1].str2))))
																					);
   // no ver dob last seen dates
// dob - voter
self.IDVerDOBVoterRegistration := map(le.did=0 or noDOBinput => '-1',
                                      count(dob_src_dts(str1 in voter_sources)) > 0 => '1',
																			'0');
self.IDVerDOBVoterRegMonthsSeen := map(le.did=0 => '-1',
                                    count(dob_src_dts(str1 in voter_sources)) = 0 => '-2',
																		(integer)trim(dob_src_dts(str1 in voter_sources)[1].str2) = 0 => '-3',
																		(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in voter_sources)[1].str2))))
																		);
   // no ver dob last seen dates
// dob - vehicle
self.IDVerDOBVehicleRegistration := map(le.did=0 or noDOBinput => '-1',
                                        count(dob_src_dts(str1 in vehicle_sources)) > 0 => '1',
																				'0');
self.IDVerDOBVehicleRegMonthsSeen := map(le.did=0 => '-1',
                                      count(dob_src_dts(str1 in vehicle_sources)) = 0 => '-2',
																			(integer)trim(dob_src_dts(str1 in vehicle_sources)[1].str2) = 0 => '-3',
																			(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in vehicle_sources)[1].str2))))
																			);
   // no ver dob last seen dates
// dob - behavioral
self.IDVerDOBBehavioralCount     := if(noDOBinput, '-1', (string)min(255, count(dob_src_dts(str1 in behav_sources))) );
self.IDVerDOBBehavioralMonthsSeen := map(le.did=0 => '-1',
                                      self.IDVerDOBBehavioralCount = '0' => '-2',
																			(integer)trim(dob_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																			(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in behav_sources)[1].str2))))
																			);
   // no ver dob last seen dates

// fname - credit bureau
t_fnm_src := if(count(fname_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
self.IDVerFirstNameCreditBureauCount     := if(noFNameinput, '-1', (string)min(9, count(fname_src_dts(str1 in credit_sources))+t_fnm_src) );
self.IDVerFirstNameCreditBureauMonthsSeen := map(le.did=0 => '-1',
                                              self.IDVerFirstNameCreditBureauCount = '0' => '-2',
																							(integer)trim(fname_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																							(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(fname_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																							);
   // no ver fname last seen dates
// fname - government
g_fnm_src := if(count(fname_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
self.IDVerFirstNameGovernmentCount     := if(noFNameinput, '-1', (string)min(255, count(fname_src_dts(str1 in govt_sources))+g_fnm_src) );
self.IDVerFirstNameGovernmentMonthsSeen := map(le.did=0 => '-1',
                                            self.IDVerFirstNameGovernmentCount = '0' => '-2',
																						(integer)trim(fname_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																						(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(fname_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																						);
   // no ver fname last seen dates
// fname - behavioral
self.IDVerFirstNameBehavioralCount     := if(noFNameinput, '-1', (string)min(255, count(fname_src_dts(str1 in behav_sources))) );
self.IDVerFirstNameBehavioralMonthsSeen := map(le.did=0 => '-1',
                                            self.IDVerFirstNameBehavioralCount = '0' => '-2',
																						(integer)trim(fname_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																						(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(fname_src_dts(str1 in behav_sources)[1].str2))))
																						);
   // no ver fname last seen dates

self := le;
self := [];
end;

clam_attrib := project( clam, get_clam(LEFT) );
clam_plus_acct := join( clam_attrib, batchinseq, 
                        left.seq=right.seq, 
												transform(models.layouts.layout_CDM_Batch_Out,self.acctno := right.acctno; self := left),
												left outer
											);
// output(clam_attrib,named('Results'));
output(clam_plus_acct,named('Results'));

ENDMACRO;

//Models.CDM_Batch_Service();