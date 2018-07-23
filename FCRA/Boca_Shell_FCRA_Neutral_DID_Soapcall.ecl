import _Control, doxie, risk_indicators, riskwisefcra, gateway;
onThor := _Control.Environment.OnThor;

export Boca_Shell_FCRA_Neutral_DID_Soapcall(DATASET(risk_indicators.layout_input) iid,
								DATASET(Gateway.Layouts.Config) gateways,
								UNSIGNED1	IN_DPPAPurpose,
								UNSIGNED1	IN_GLBPurpose,
								BOOLEAN	isutil = FALSE,
								BOOLEAN	IN_LNBranded = FALSE,
								BOOLEAN	includerel = FALSE,
								BOOLEAN	IN_Require2 = FALSE,
								BOOLEAN	IN_OFAC_Only = TRUE,
								BOOLEAN	IN_SuppressNearDups = FALSE,
								BOOLEAN	IN_From_BIID = FALSE,
								BOOLEAN	IN_ExcludeWatchLists = FALSE,
								BOOLEAN	IN_From_IT1O = FALSE,
								UNSIGNED1	IN_OFAC_Version = 1,
								BOOLEAN	IN_Include_OFAC = FALSE,
								BOOLEAN	IN_Include_additional_watchlists = FALSE,
								REAL		IN_Global_watchlist_threshold = 0.84,
								UNSIGNED1	IN_BSversion = 1, 
								boolean nugen=false,
								boolean ADL_Based_Shell=false,
								string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
								unsigned1 append_best=0, 
								unsigned8 BSOptions=0,
								string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) :=
FUNCTION

ret := risk_indicators.InstantID_Function(iid,
										gateways,
										IN_DPPAPurpose,
										IN_GLBPurpose,
										isUtil,
										IN_LNBranded, 
										IN_OFAC_Only,
										IN_SuppressNearDups,
										IN_Require2,
										IN_From_BIID,
										true, //in_isFCRA 
										IN_ExcludeWatchLists,
										IN_From_IT1O,
										IN_OFAC_Version,
										IN_Include_OFAC,
										IN_Include_additional_watchlists,
										IN_Global_watchlist_threshold,
										-1,
										IN_BSversion,
										in_DataRestriction := DataRestriction, 
										in_runDLverification := FALSE,
										in_append_best := append_best,
										in_BSOptions := BSOptions,
										in_DataPermission := DataPermission);
	
	iid_results_with_flags := risk_indicators.ADL_Based_Modeling_IID_Function(iid,
																																				gateways, 
																																				IN_DPPAPurpose, 
																																				IN_GLBPurpose, 
																																				true, //isFCRA,
																																				IN_BSversion,
																																				isUtil,
																																				IN_LNBranded,
																																				IN_OFAC_Only,
																																				IN_SuppressNearDups,
																																				IN_Require2,
																																				IN_From_BIID,
																																				IN_ExcludeWatchLists,
																																				IN_From_IT1O,
																																				IN_OFAC_Version,
																																				IN_Include_OFAC,
																																				IN_Include_additional_watchlists,
																																				IN_Global_watchlist_threshold,
																																				-1,
																																				DataRestriction,
																																				BSOptions,
																																				DataPermission);
										
	just_iid_results := project(iid_results_with_flags, risk_indicators.Layout_Output);
	
	iid_results := if(ADL_Based_Shell, just_iid_results, ret);
	
	outf_n := ungroup( risk_indicators.Boca_Shell_FCRA_Neutral_Function (iid_results, IN_DPPAPurpose, IN_GLBPurpose, isUtil, IN_LNBranded, includerel, TRUE, IN_BSversion, nugen := nugen, bsOptions := bsOptions) );
	
	with_adl_based_flags := join(outf_n, iid_results_with_flags, left.seq = right.seq, transform(risk_indicators.Layout_BocaShell_Neutral, 
													self.adl_shell_flags.in_addrpop	 := right.in_addrpop	 ;
													self.adl_shell_flags.in_hphnpop	 := right.in_hphnpop	 ;
													self.adl_shell_flags.in_ssnpop	 := right.in_ssnpop	 ;
													self.adl_shell_flags.in_dobpop	 := right.in_dobpop	 ;
													self.adl_shell_flags.adl_addr	 := right.adl_addr	 ;
													self.adl_shell_flags.adl_hphn	 := right.adl_hphn	 ;
													self.adl_shell_flags.adl_ssn	 := right.adl_ssn	 ;
													self.adl_shell_flags.adl_dob	 := right.adl_dob	 ;
													self.adl_shell_flags.in_addrpop_found	 := right.in_addrpop_found	 ;
													self.adl_shell_flags.in_hphnpop_found	 := right.in_hphnpop_found	 ;
													self := left	));

	outf := if(ADL_Based_Shell, with_adl_based_flags, outf_n);


esp_input := project(outf, transform(risk_indicators.layout_input, self.did := left.did, self.ssn := left.shell_input.ssn, self.lname := left.shell_input.lname, self := []));

// mbs_gateway_url := 'http://rw_score_dev:[PASSWORD_REDACTED]@espdev.br.seisint.com:9999/WsDbHandler';
mbs_gateway_url := gateways(servicename='mbs_dost')[1].url;

esp_response := Gateway.Soapcall_DOST_ConsumerFlags(esp_input, mbs_gateway_url );
esp_response_failed := trim(esp_response[1].responseheader.errormessage)<>'';

// Add PCR
layout_pcr := RECORD
	unsigned4 seq;
	unsigned6 date_created;
	risk_indicators.Layout_BocaShell_Neutral.ConsumerFlags ConsumerFlags;
END;

// for realtime XML customers, use the ESP response instead of the keys on roxie (info needs to be more current than the daily roxie keys)
esp_response_mapped := join(outf, esp_response, 
	left.did=(unsigned)right.dbrecords[1].lexid,
transform(layout_pcr, 
	self.seq := left.seq;
	SELF.ConsumerFlags.corrected_flag := right.RecordCount>0;
	SELF.ConsumerFlags.consumer_statement_flag := (right.dbrecords[1].consumer_statement_flag=1);
	SELF.ConsumerFlags.dispute_flag := (right.dbrecords[1].dispute_flag=1);
	SELF.ConsumerFlags.security_freeze := (right.dbrecords[1].security_freeze=1);
	SELF.ConsumerFlags.security_alert := (right.dbrecords[1].security_fraud_alert=1);
	SELF.ConsumerFlags.negative_alert := (right.dbrecords[1].negative_alert=1);
	SELF.ConsumerFlags.id_theft_flag := (right.dbrecords[1].id_theft_flag=1);
	SELF.date_created := (unsigned)(stringlib.stringfilterout((right.dbrecords[1].date_added[1..10]), '-')) ) );



layout_pcr add_flags_by_did(risk_indicators.Layout_BocaShell_Neutral le, fcra.Key_Override_PCR_DID ri) := TRANSFORM
	SELF.ConsumerFlags.corrected_flag := true;
	SELF.ConsumerFlags.consumer_statement_flag := (ri.consumer_statement_flag='1');
	SELF.ConsumerFlags.dispute_flag := (ri.dispute_flag='1');
	SELF.ConsumerFlags.security_freeze := (ri.security_freeze='1');
	SELF.ConsumerFlags.security_alert := (ri.security_alert='1');
	SELF.ConsumerFlags.negative_alert := (ri.negative_alert='1');
	SELF.ConsumerFlags.id_theft_flag := (ri.id_theft_flag='1');
	SELF.date_created := (unsigned)ri.date_created;
	SELF := le;
END;
j1_roxie := JOIN (outf, fcra.Key_Override_PCR_DID, 
            keyed(LEFT.did=RIGHT.s_did),
            add_flags_by_did(LEFT,RIGHT),
            LIMIT(10,SKIP), KEEP(1));

j1_thor := JOIN (distribute(outf, hash64(did)),
						distribute(pull(fcra.Key_Override_PCR_DID), hash64(s_did)), 
            (LEFT.did=RIGHT.s_did),
            add_flags_by_did(LEFT,RIGHT),
            LIMIT(10,SKIP), KEEP(1), LOCAL);

#IF(onThor)
  j1 := j1_thor;
#ELSE
  j1 := j1_roxie;
#END

layout_pcr add_flags_by_ssn(risk_indicators.Layout_BocaShell_Neutral le, fcra.Key_Override_PCR_SSN ri) := TRANSFORM
	SELF.ConsumerFlags.corrected_flag := true;
	SELF.ConsumerFlags.consumer_statement_flag := (ri.consumer_statement_flag='1');
	SELF.ConsumerFlags.dispute_flag := (ri.dispute_flag='1');
	SELF.ConsumerFlags.security_freeze := (ri.security_freeze='1');
	SELF.ConsumerFlags.security_alert := (ri.security_alert='1');
	SELF.ConsumerFlags.negative_alert := (ri.negative_alert='1');
	SELF.ConsumerFlags.id_theft_flag := (ri.id_theft_flag='1');
	SELF.date_created := (unsigned)ri.date_created;
	SELF := le;
END;

j2_roxie := JOIN (outf, fcra.Key_Override_PCR_SSN, 
            keyed(LEFT.Shell_Input.ssn=RIGHT.ssn) AND 
            datalib.NameMatch(LEFT.Shell_Input.fname,LEFT.Shell_Input.mname, LEFT.Shell_Input.lname,
                              RIGHT.fname, RIGHT.mname, RIGHT.lname)<3,
            add_flags_by_ssn(LEFT,RIGHT),
            LIMIT(10,SKIP), KEEP(1));

j2_thor := JOIN (distribute(outf, hash64(Shell_Input.ssn)), 
						distribute(pull(fcra.Key_Override_PCR_SSN), hash64(ssn)), 
            (LEFT.Shell_Input.ssn=RIGHT.ssn) AND 
            datalib.NameMatch(LEFT.Shell_Input.fname,LEFT.Shell_Input.mname, LEFT.Shell_Input.lname,
                              RIGHT.fname, RIGHT.mname, RIGHT.lname)<3,
            add_flags_by_ssn(LEFT,RIGHT),
            LIMIT(10,SKIP), KEEP(1), LOCAL);
						
#IF(onThor)
  j2 := j2_thor;
#ELSE
  j2 := j2_roxie;
#END

pcr_on_roxie := DEDUP(SORT(GROUP(j1)+GROUP(j2),seq,-(unsigned)date_created),seq);


// if the gateway is populated, we know this transaction is from the ESP, use the esp_response_mapped
// if the gateway isn't populated, we know the transaction is from Batch, use the PCR_on_roxie
pcr_final := if(trim(mbs_gateway_url)='' or esp_response_failed, pcr_on_roxie, esp_response_mapped);


risk_indicators.Layout_BocaShell_Neutral add_flags(risk_indicators.Layout_BocaShell_Neutral le, pcr_final ri) := TRANSFORM
	SELF.ConsumerFlags.corrected_flag := le.ConsumerFlags.corrected_flag OR ri.ConsumerFlags.corrected_flag;
	
	SELF.ConsumerFlags.consumer_statement_flag := le.ConsumerFlags.consumer_statement_flag or ri.ConsumerFlags.consumer_statement_flag;
	SELF.ConsumerFlags.dispute_flag := le.ConsumerFlags.dispute_flag or ri.ConsumerFlags.dispute_flag;
	SELF.ConsumerFlags.security_freeze := le.ConsumerFlags.security_freeze or ri.ConsumerFlags.security_freeze;
	SELF.ConsumerFlags.security_alert := le.ConsumerFlags.security_alert or ri.ConsumerFlags.security_alert;
	SELF.ConsumerFlags.negative_alert := le.ConsumerFlags.negative_alert or ri.ConsumerFlags.negative_alert;
	SELF.ConsumerFlags.id_theft_flag := le.ConsumerFlags.id_theft_flag or ri.ConsumerFlags.id_theft_flag;
	SELF.ConsumerStatements := le.ConsumerStatements;  // these always come from PersonContext, searched earlier within Risk_Indicators.checkPersonContext
	
	self.seq := le.seq;
	
	myGetDate 				:= risk_indicators.iid_constants.myGetDate(le.historydate);
	todaysdate 				:= (string) risk_indicators.iid_constants.todaydate;
	runningAsCurrent  := myGetDate[1..6] >= todaysdate[1..6]; //if history date is current year/month

	year							:= if((integer)myGetDate[5..6] > 6, (integer)myGetDate[1..4] + 1, (integer)myGetDate[1..4]);
	month							:= if((integer)myGetDate[5..6] > 6, (integer)myGetDate[5..6] - 6, (integer)myGetDate[5..6] + 6);
	ahead_6mo  				:= min(todaysdate,(string)year + intformat(month,2,1) + myGetDate[7..8]);			//history date plus 6 months
	ahead_12mo 				:= min(todaysdate,(string)((integer)myGetDate[1..4] + 1) + myGetDate[5..8]);	//history date plus 12 months
	ahead_24mo 				:= min(todaysdate,(string)((integer)myGetDate[1..4] + 2) + myGetDate[5..8]);  //history date plus 24 months
	//the new offset archive date count fields added in 5.3 are for running in archive mode only, so set to all nines if running in current mode
	self.archive_date_6mo  := if(runningAsCurrent or le.DID = 0, '99999999', ahead_6mo);  
	self.archive_date_12mo := if(runningAsCurrent or le.DID = 0, '99999999', ahead_12mo);
	self.archive_date_24mo := if(runningAsCurrent or le.DID = 0 or ahead_12mo[1..6] >= todaysdate[1..6], '99999999', ahead_24mo);
	
	SELF := ri;
	SELF := le;
END;
with_flags_thor := JOIN(distribute(outf, hash64(seq, did)), pcr_final, LEFT.seq=RIGHT.seq, add_flags(LEFT,RIGHT), LOOKUP, LEFT OUTER) : PERSIST('~BOCASHELLFCRA::iid_results');
with_flags_roxie := JOIN(outf, pcr_final, LEFT.seq=RIGHT.seq, add_flags(LEFT,RIGHT), LOOKUP, LEFT OUTER);

#IF(onThor)
  with_flags := with_flags_thor;
#ELSE
  with_flags := with_flags_roxie;
#END

// output(esp_input, named('esp_input'));
// output(esp_response, named('esp_response'));
// output(esp_response_failed, named('esp_response_failed'));
// output(esp_response_mapped, named('esp_response_mapped'));
// output(pcr_on_roxie, named('pcr_on_roxie'));
// output(with_flags, named('with_flags'));

return with_flags;

end;