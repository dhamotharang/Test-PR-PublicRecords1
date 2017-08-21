#stored('DataRestrictionMask','00000000');
#stored('LnBranded','1');
unsigned1 version := 1					: stored('BSVersion');	// version 1 is the original, 2 would add BS 2 fields and 3 will add BS 3 fields
unsigned3 history_date := 200912 	: stored('HistoryDateYYYYMM');
boolean   isFCRA := true 				: stored('IsFCRA');
boolean   suppressNearDups := false: stored('SuppressNearDups');
boolean   Count_RelsAtAddrs := true	: stored('CountRelsAtAddrs');
string30  Account 		 := '1'	: stored('Account');
integer did_value := 2691013576;
unsigned1 DPPA_Purpose := 1;
unsigned1 GLB_Purpose := 1;
string ssn_mask_value := '';
boolean probation_override_value := false;
dids := dataset([{did_value}], doxie.layout_references);

results := AMEX.getAdditionalData(dids, 
															Account,	
															DPPA_Purpose,
															GLB_Purpose, 
															history_date, 
															isFCRA,
															AutoStandardI.GlobalModule().DataRestrictionMask,
															ssn_mask_value, 
															probation_override_value,
															AutoStandardI.GlobalModule().lnbranded,
															version,
															suppressNearDups,
															Count_RelsAtAddrs
														 ).results;
														 
output(results, named('Results'));