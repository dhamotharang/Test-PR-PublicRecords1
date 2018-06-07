/*--SOAP--
<message name="RecoverScore Batch Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="Model" type="xsd:string"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="ExcludeWatchLists" type="xsd:boolean"/> <!-- For Testing Purposes Only -->
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
</message>
*/
/*--INFO--
Replacement for SureContact on Moxie calling 
Moxie_RecoverScore2_Server.RecoverScore2_Scores_Search on Roxie
*/
/*--HELP-- 
<pre>
&lt;batch_in&gt;
  &lt;Row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
      &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;p_City_name&gt;&lt;/p_City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
      &lt;Prim_Range&gt;&lt;/Prim_Range&gt;
      &lt;Predir&gt;&lt;/Predir&gt;
      &lt;Prim_Name&gt;&lt;/Prim_Name&gt;
      &lt;Suffix&gt;&lt;/Suffix&gt;
      &lt;Postdir&gt;&lt;/Postdir&gt;
      &lt;Unit_Desig&gt;&lt;/Unit_Desig&gt;
      &lt;Sec_Range&gt;&lt;/Sec_Range&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;Age&gt;&lt;/Age&gt;
      &lt;DL_Number&gt;&lt;/DL_Number&gt;
      &lt;DL_State&gt;&lt;/DL_State&gt;
      &lt;Home_Phone&gt;&lt;/Home_Phone&gt;
      &lt;Work_Phone&gt;&lt;/Work_Phone&gt;
      &lt;ip_addr&gt;&lt;/ip_addr&gt;
      &lt;address_type&gt;&lt;/address_type&gt;
      &lt;address_confidence&gt;&lt;/address_confidence&gt;
      &lt;phone_type&gt;&lt;/phone_type&gt;
      &lt;debt_type&gt;&lt;/debt_type&gt;
      &lt;debt_amount&gt;&lt;/debt_amount&gt;
      &lt;charge_off_date&gt;&lt;/charge_off_date&gt;
      &lt;open_date&gt;&lt;/open_date&gt;
      &lt;deceased&gt;&lt;/deceased&gt;
      &lt;bankruptcy&gt;&lt;/bankruptcy&gt;
      &lt;custom_input_1&gt;&lt;/custom_input_1&gt;
      &lt;custom_input_2&gt;&lt;/custom_input_2&gt;
      &lt;custom_input_3&gt;&lt;/custom_input_3&gt;
      &lt;custom_input_4&gt;&lt;/custom_input_4&gt;
      &lt;custom_input_5&gt;&lt;/custom_input_5&gt;
      &lt;custom_input_6&gt;&lt;/custom_input_6&gt;
  &lt;/Row&gt;
&lt;/batch_in&gt;
</pre>
*/

import address, risk_indicators, models, riskwise, ut,AutoStandardI, gateway;

export RecoverScore_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',0);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
#stored('DataPermissionMask',risk_indicators.iid_constants.default_DataPermission);

batchin := dataset([],Models.Layout_RecoverScore_Batch_Input) 			: stored('batch_in',few);
// per Brian Worley request, set permissible purpose on batch query to 0 and 0
unsigned1 DPPA_Purpose := 0									: stored('DPPAPurpose');
unsigned1 GLB_Purpose := 0 : stored('GLBPurpose');
string20 model_val := ''													: stored('Model');
unsigned1 ofac_version      := 1        : stored('OFACVersion');
boolean   excludewatchlists := false 		: stored('ExcludeWatchLists');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

model := trim(StringLib.StringToUpperCase(Model_val)) ;
valid_models := [
									'RSN1108_1_0', 'RSN1108_2_0', 'RSN1108_3_0', // unifund
									'RSN803_2_0', // AXIANT_CUSTOM
									'RSN807_0_0',  // RECOVER SCORE V3
									'RSN1010_1_0',	// UNIFUND
									'RSN1103_1_0',  // ASSET ACCEPTANCE
									'RSN1105_1_0',	// ACCOUNTS RECEIVABLE MANAGEMENT
									'RSN1105_2_0',	// ACCOUNTS RECEIVABLE MANAGEMENT
									'RSN1105_3_0',	// ACCOUNTS RECEIVABLE MANAGEMENT

									// the rest of these are all being migrated from Moxie_RecoverScore2_Server.RecoverScore2_Scores_Search
									'RSN508_1_0', // MANNBRACKEN
									'RECOVERSCORE2', // RCCUSTOM
									'RSN604_2_0', // ELTMAN (debt type=7)
									'RSN702_1_0', // PREMIERE
									'RSN704_1_0', // CBE
									'RSN607_0_0', // GENERIC_STUDENT (debt type=5)
									'RSN704_0_0', // GENERIC_CREDIT (debt type=6)
									'RSN607_1_0', // ACT
									'RSN802_1_0', // AXIANT (debt type=8)
									'RSN803_1_0', // AMSHER (debt type=9)
									'RSN810_1_0', // ACT_NONDOE (debt type=10)
									'RSN912_1_0',  // ARM
									'RSN1001_1_0', // GRC
									'RSN1009_1_0' // apex
									];

gateways_in := Gateway.Configuration.Get();

model_name := if(model in valid_models, model, ERROR(301,'Missing or Invalid Model Name') );

Gateway.Layouts.Config gw_switch(gateways_in le) := transform  
	self.servicename := if(le.servicename = 'bridgerwlc' and ofac_version = 4 and StringLib.StringToUpperCase(model_name) not in Risk_Indicators.iid_constants.RecoverScoreBatchWatchlistModels, '', le.servicename);
	self.url := if(le.servicename = 'bridgerwlc' and ofac_version = 4 and StringLib.StringToUpperCase(model_name) not in Risk_Indicators.iid_constants.RecoverScoreBatchWatchlistModels, '', le.url);
  self := le;																																								
end;
gateways := project(gateways_in, gw_switch(left));

if(ofac_version = 4 and StringLib.StringToUpperCase(model_name) in Risk_Indicators.iid_constants.RecoverScoreBatchWatchlistModels and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

// add sequence to matchup later to add acctno to output
Models.Layout_RecoverScore_Batch_Input into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));


risk_indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
	// clean up input
	// ssn_val := riskwise.cleanssn(le.ssn);								// I don't think we should be cleaning these for nugen
	// hphone_val := riskwise.cleanPhone(le.home_phone);
	// wphone_val := riskwise.cleanphone(le.work_phone);
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	self.historydate := if(le.historydateyyyymm=0, 999999, le.historydateyyyymm);
	self.seq := le.seq;
	self.ssn := le.ssn;
	self.dob := dob_val;
	self.age := if ((integer)le.age = 0 and (integer)le.dob != 0, (string3)ut.GetAgeI((integer)le.dob), (le.age));
	
	self.phone10 := le.home_phone;
	self.wphone10 := le.work_phone;
	
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
	
	self := [];
END;
prep := project(batchinseq, into_in(left));

skiptrace := riskwise.skip_trace(prep, DPPA_Purpose, glb_Purpose, datarestriction, appType, DataPermission);

boolean isUtility := false;
boolean ln_branded := false;
boolean ofac_only := true;
include_ofac := if(ofac_version = 1, false, true);
boolean suppressNearDups := true;
boolean require2Ele := false;
boolean fromBIID := false;
boolean isFCRA := false;
boolean from_IT1O := true;  // set to true so we get the same chrono phone information back from IID function 
														// that we would in it51 so that skiptrace works the same as it does in it51
boolean includeRelativeInfo := true;
boolean includeDLInfo       := false;
boolean includeVehInfo      := true;
boolean includeDerogInfo    := true;

integer bsVersion := map(
	model_name IN ['RSN1105_1_0', 'RSN1105_2_0', 'RSN1105_3_0',
		'RSN1108_1_0', 'RSN1108_2_0', 'RSN1108_3_0' ]	=> 4,
	model_name in ['RSN1001_1_0','RSN1009_1_0','RSN1010_1_0','RSN1103_1_0'] => 3,
	2
);
boolean doScore := false;
boolean nugen := true;
include_additional_watchlists := false;
watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);
dob_radius := -1;

prep_from_skiptrace := project(ungroup(skiptrace), transform(risk_indicators.layout_input, self:=left));


migrated_models := ['RSN508_1_0', // MANNBRACKEN
									'RSN604_2_0', // ELTMAN (debt type=7)
									'RSN702_1_0', // PREMIERE
									'RSN704_1_0', // CBE
									'RSN607_0_0', // GENERIC_STUDENT (debt type=5)
									'RSN704_0_0', // GENERIC_CREDIT (debt type=6)
									'RSN607_1_0', // ACT
									'RSN802_1_0', // AXIANT (debt type=8)
									'RSN803_1_0', // AMSHER (debt type=9)
									'RSN810_1_0'  // ACT_NONDOE (debt type=10)
									];

// run all of the migrated models through skiptrace instead of waterfall phones and bestaddress plugins in Kettle like we originally discussed									
iid_prep := if(model_name in migrated_models, prep_from_skiptrace, prep);

// use normal prep data to pass to IID function. 
// for RSN803_2_0 they want IID and the shell run on the original input
// instead of using the skiptrace results as input
iid_results := Risk_Indicators.InstantID_Function(iid_prep, gateways, DPPA_Purpose, GLB_Purpose, 
																									isUtility, ln_branded, 
																									ofac_only, suppressNearDups, require2ele, 
																									fromBIID, isFCRA, excludeWatchLists, 
																									from_IT1O, in_BSversion:=bsVersion, in_DataRestriction := DataRestriction,
																									in_DataPermission := DataPermission);

riskwise.Layout_SkipTrace get_confidence(skiptrace le, iid_results rt) := transform	
	self.addr_confidence_a := map(le.addr_type_a='X' => '',
	
							le.addr_type_a in ['U','C'] and rt.chronophone<>'' and
								risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
													    rt.chronoprim_range, rt.chronoprim_name, rt.chronosec_range)) => 'A',
								
							le.addr_type_a in ['U','C'] and rt.chronophone='' and
								risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
													    rt.chronoprim_range, rt.chronoprim_name, rt.chronosec_range)) => 'B',
								
							risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
													    rt.chronoprim_range2, rt.chronoprim_name2, rt.chronosec_range2)) => 'B',
							
							risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range,
													    rt.chronoprim_range3, rt.chronoprim_name3, rt.chronosec_range3)) => 'C',
							'');						
	self := le;		
end;

full_skip_trace := join(skiptrace, iid_results, left.seq=right.seq, 
					get_confidence(left,right));

skip_trace_results_mapped_to_batchin := join(batchinseq, full_skip_trace, left.seq=right.seq,
									transform(Models.Layout_RecoverScore_Batch_Input, 
														self.address_type := right.addr_type_a;
														self.address_confidence := right.addr_confidence_a;
														self.phone_type := right.phone_type_a;
														self := left));
									

clam := Risk_Indicators.Boca_Shell_Function(iid_results, gateways, DPPA_Purpose, GLB_Purpose, isUtility,ln_branded ,
							includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo,
							bsVersion, doScore, nugen,DataRestriction := DataRestriction, DataPermission := DataPermission);


clam_adl := risk_indicators.ADL_Based_Modeling_Function(prep,
																		gateways, 
																		dppa_purpose, 
																		glb_purpose, 
																		isFCRA,
																		bsversion, 
																		isUtility,
																		ln_branded,
																		ofac_only,
																		suppressNearDups,
																		require2ele,
																		fromBIID,
																		excludeWatchLists,
																		from_IT1O,
																		ofac_version,
																		include_ofac,
																		include_additional_watchlists,
																		watchlist_threshold,
																		dob_radius,
																		includeRelativeInfo,
																		includeDLInfo,
																		includeVehInfo, 
																		includeDerogInfo, 
																		doScore, 
																		nugen,
																		DataRestriction := DataRestriction,
																		DataPermission := DataPermission);	
																		
   	score := map( model_name='RSN803_2_0' => models.RSN803_2_0(clam, full_skip_trace),  // axiant   
   								model_name='RSN807_0_0' => models.RSN807_0_0(clam_adl), // Use ADL append boca shell
   								model_name='RSN912_1_0' => Models.RSN912_1_0(clam_adl, batchinseq),
									model_name='RSN1103_1_0' => Models.RSN1103_1_0(clam_adl), // ASSET ACCEPTANCE - Use ADL Append Boca Shell
									model_name='RSN1105_1_0' => UNGROUP(Models.RSN1105_1_0(clam_adl)),	// ACCOUNTS RECEIVABLE MANAGEMENT - Use ADL Append Boca Shell 4.0
									model_name='RSN1105_2_0' => UNGROUP(Models.RSN1105_2_0(clam_adl)),	// ACCOUNTS RECEIVABLE MANAGEMENT - Use ADL Append Boca Shell 4.0
									model_name='RSN1105_3_0' => UNGROUP(Models.RSN1105_3_0(clam_adl)),	// ACCOUNTS RECEIVABLE MANAGEMENT - Use ADL Append Boca Shell 4.0
   											
   							// the rest of these are all being migrated from Moxie_RecoverScore2_Server.RecoverScore2_Scores_Search to Kettle Batch
   							model_name='RSN508_1_0' => Models.RSN508_1_0(clam, skip_trace_results_mapped_to_batchin), // MANNBRACKEN									
   							model_name='RSN604_2_0' => Models.RSN604_2_0(clam, skip_trace_results_mapped_to_batchin), // ELTMAN (debt type=7)
   							model_name='RSN702_1_0' => Models.RSN702_1_0(clam, skip_trace_results_mapped_to_batchin), // PREMIERE
   							model_name='RSN704_1_0' => Models.RSN704_1_0(clam, skip_trace_results_mapped_to_batchin), // CBE
   							model_name='RSN607_0_0' => Models.RSN607_0_0(clam, skip_trace_results_mapped_to_batchin), // GENERIC_STUDENT (debt type=5)
   							model_name='RSN704_0_0' => Models.RSN704_0_0(clam, skip_trace_results_mapped_to_batchin), // GENERIC_CREDIT (debt type=6)
   							model_name='RSN607_1_0' => Models.RSN607_1_0(clam, skip_trace_results_mapped_to_batchin), // ACT
   							model_name='RSN802_1_0' => Models.RSN802_1_0(clam, skip_trace_results_mapped_to_batchin), // AXIANT (debt type=8)
   							model_name='RSN803_1_0' => Models.RSN803_1_0(clam, skip_trace_results_mapped_to_batchin), // AMSHER (debt type=9)
   							model_name='RSN810_1_0' => Models.RSN810_1_0(clam, skip_trace_results_mapped_to_batchin),  // ACT_NONDOE (debt type=10)
								model_name='RSN1010_1_0' => Models.RSN1010_1_0(clam, skip_trace_results_mapped_to_batchin), // Unifund
   							model_name='RECOVERSCORE2' => Models.RecoverScore2(clam, batchinseq, returnAll:=TRUE), // RCCUSTOM, always return all and let kettle decide which score to output
   							model_name='RSN1001_1_0'   => ungroup(Models.RSN1001_1_0(clam_adl)),
   							model_name='RSN1009_1_0'   => ungroup(Models.RSN1009_1_0(clam_adl)),
								
								model_name='RSN1108_1_0'   => ungroup(Models.RSN1108_1_0(clam)),
								model_name='RSN1108_2_0'   => ungroup(Models.RSN1108_2_0(clam)),
								model_name='RSN1108_3_0'   => ungroup(Models.RSN1108_3_0(clam)),
								
   							dataset([], Models.layout_recoverscore ));

							
	score_grouped := 	group(sort(score,seq),seq);

recoverscore_batch_output := record
	string30 acctno;
	models.Layout_RecoverScore;
end;

result := join(batchinseq, score, left.seq=(UNSIGNED)right.seq, 
					transform(recoverscore_batch_output, self.acctno := left.acctno,
										self := right));

output(result, named('Results'));

ENDMACRO;

// models.RecoverScore_Batch_Service();