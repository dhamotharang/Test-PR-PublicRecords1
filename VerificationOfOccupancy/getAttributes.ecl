import Risk_Indicators, Models, iesp, doxie, ut;

EXPORT getAttributes(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) VOOShell, 
																						string50 DataRestrictionMask, 
																						boolean glb_ok,  
																						boolean dppa_ok) := FUNCTION

VerificationOfOccupancy.Layouts.Layout_VOOBatchOut getAttr(VOOShell le) := transform
	validInput := trim(le.in_streetAddress) <> '' and trim(le.in_city) <> '' and trim(le.in_state) <> '' and trim(le.fname) <> '' and trim(le.lname) <> ''; 
	bureaus_seen := sum(le.Transunion_seen, le.Equifax_seen, le.Experian_seen);
	self.seq																									:= le.seq;
	self.AcctNo																								:= le.AcctNo;
	self.LexID																								:= le.did;
	self.attributes.version1.AddressReportingSourceIndex			:= if(validInput, 
																																	map(le.did = 0																			=> '-1',
																																			le.pub_src_seen > 0 and bureaus_seen > 2				=> '5',
																																	    le.pub_src_seen > 0 and bureaus_seen > 0				=> '4',
																																	    le.pub_src_seen = 0 and bureaus_seen > 2				=> '3',
																																	    le.pub_src_seen = 0 and bureaus_seen > 0				=> '2',
																																	    le.pub_src_seen > 0 														=> '1',
																																																												 '0'),
																																	'');
																																	
	self.attributes.version1.AddressReportingHistoryIndex			:= if(validInput,
																																	map(le.did = 0																=> '-1',
																																			le.target_addr = 2 and le.other_addr < 2 	=> '6',
																																	    le.target_addr = 2 and le.other_addr > 1	=> '5',
																																	    le.target_addr = 0 and le.other_addr < 2	=> '4',
																																	    le.target_addr = 1 and le.other_addr < 2	=> '3',
																																			le.target_addr = 0 and le.other_addr = 2	=> '2',
																																	    le.target_addr = 1 and le.other_addr = 2	=> '1',
																																																									 '-1'),
																																	'');
																																	
	self.attributes.version1.AddressSearchHistoryIndex				:= if(validInput, 
																																	map(le.did = 0							=> '-1',
																																			le.srchconfaddr3mos > 0 => '6',
																																			le.srchconfaddr1yr > 0 	=> '5',
																																			le.srchprevaddr3mos > 0 => '3',
																																			le.srchprevaddr1yr > 0 	=> '4',
																																			le.srchdiffaddr3mos > 0 => '1',
																																			le.srchdiffaddr1yr > 0 	=> '2',
																																																 '0'),
																																	'');
																																	
	self.attributes.version1.AddressUtilityHistoryIndex				:= if(validInput,
																																	map(le.did = 0																																=> '-1',
																																			le.util_target_addr > 1 and le.util_other_addr = 1 and le.util_disconnect	=> '7',
																																	    le.util_target_addr > 1 and le.util_other_addr = 0												=> '6',
																																	    le.util_target_addr = 1 and le.util_other_addr = 1 and le.util_disconnect	=> '5',
																																	    le.util_target_addr = 1 and le.util_other_addr = 0												=> '4',
																																	    le.util_target_addr > 0 and le.util_other_addr > 0												=> '3',
																																	    le.util_target_addr = 0 and le.util_other_addr = 1												=> '2',
																																	    le.util_target_addr = 0 and le.util_other_addr > 1												=> '1',
																																	    le.util_target_addr = 0 and le.util_other_addr = 0												=> '0',
																																																																									 '-1'),
																																	'');

	self.attributes.version1.AddressOwnershipHistoryIndex			:= if(validInput, 
																																	map(le.did = 0 																											=> '-1',
																																			le.addr_type = 'P'																							=> '0', //if addr is PO Box, return 0 
																																			((le.target_addr_owned = '1' AND le.target_addr_sold <> '1') OR
																																			  le.target_owned_spouse = '1') AND 
																																				le.other_owned_spouse <> '1' AND
																																				~(le.other_prox_owned = '1' AND le.other_prox_sold <> '1')			=> '5', //subject or spouse own target and no other properties
																																			((le.target_addr_owned = '1' AND le.target_addr_sold <> '1') OR
																																			  le.target_owned_spouse = '1') AND 
																																			 (le.other_owned_spouse = '1' OR
																																			 (le.other_prox_owned = '1' AND le.other_prox_sold <> '1'))			=> '4', //subject or spouse own target and other properties
																																			le.target_addr_sold = '1' OR le.target_owned_spouse = '2'				=> '3', //subject or spouse owned target but sold it
																																			le.target_addr_owned <> '1' AND le.target_owned_spouse = '0'	AND		
																																				le.target_addr_other = 1 AND le.SubjectPropertyIndicator = 2	=> '2',
																																			le.target_addr_owned <> '1' AND le.target_owned_spouse = '0'	AND		
																																				le.target_addr_other = 1 AND le.SubjectPropertyIndicator = 1	=> '1',
																																																																				 '0'), 
																																	'');
	
	self.attributes.version1.AddressPropertyTypeIndex					:= if(validInput, 
																																	map(le.DID = 0												=> '-1',
																																			le.addr_type = 'S'								=> '5',
																																			le.addr_type = 'H'								=> '4',
																																			le.addr_type = 'P'								=> '3',
																																			le.addr_type = 'F'								=> '2',
																																			le.addr_type in ['G','M','R','U']	=> '1',
																																																					'-1'), 
																																	'');
	
	self.attributes.version1.AddressValidityIndex							:= if(validInput,
																																	map(le.DID = 0																	=> '-1',
																																			le.addr_status[1..1] = 'E'									=> '1',
																																			le.ADVO.Address_Vacancy_Indicator = 'Y' or 
																																			le.ADVO.Residential_or_Business_Ind = 'B' or
																																			le.sic_code = '2225'												=> '2', 
																																			le.ADVO.Seasonal_Delivery_Indicator = 'Y' 	=> '3',
																																			le.addr_status[1..1] = 'S'									=> '4', 
																																																										 '-1'), 
																																	'');
																																	
	self.attributes.version1.RelativesConfirmingAddressIndex	:= if(validInput,
																																	map(le.did = 0																										=> '-1',
																																			le.target_addr_relatives = 2																	=> '4',
																																			le.target_addr_relatives = 1 AND le.other_addr_relatives < 2	=> '3',
																																			le.target_addr_relatives = 1 AND le.other_addr_relatives = 2	=> '2',
																																			le.target_addr_relatives = 0																	=> '1',
																																			le.target_addr_relatives = -1																	=> '0',
																																																																			'-1'),
																																	'');
																																	
	self.attributes.version1.AddressOwnerMailingAddressIndex	:= if(validInput, 
																																	map(le.DID = 0					=> '-1',
																																														 (string)le.Fares_mail_addr_flag), //values 0 - 6
																																	'');	
																																	
	self.attributes.version1.PriorAddressMoveIndex						:= if(validInput,
																																	map(le.did = 0 																										=> '-1',
																																			le.prior_addr_sold ='1' 																			=> '8',
																																			le.prior_addr_owned <>'1' and 
																																				le.prior_addr_rpting_subject = false and 
																																				le.prior_addr_rpting_newID 																	=> '7',
																																			le.prior_addr_owned='1' and
																																				le.prior_addr_sold <>'1' and
																																				le.prior_addr_rpting_subject = false and 
																																				le.prior_addr_rpting_newID																	=> '6',
																																			le.prior_addr_owned <> '1' and 
																																				le.prior_addr_rpting_subject = false and
																																				le.prior_addr_rpting_newID = false													=> '5',
																																			le.prior_addr_owned <> '1' and 
																																				le.prior_addr_rpting_subject and
																																				le.prior_addr_rpting_newID 																	=> '4',
																																			le.prior_addr_owned <> '1' and 
																																				le.prior_addr_rpting_subject and
																																				le.prior_addr_rpting_newID = false 													=> '3',
																																			le.prior_addr_owned ='1' and 
																																				le.prior_addr_sold <> '1' and
																																				le.prior_addr_rpting_subject and
																																				le.prior_addr_rpting_newID																	=> '2',
																																			le.prior_addr_owned ='1' and
																																				le.prior_addr_sold <> '1' and
																																				le.prior_addr_rpting_subject and 
																																				le.prior_addr_rpting_newID = false													=> '1',
																																			le.prior_addr_address_history_seq = 0													=> '0',  //no prior address found
																																																																			 '0'),
																																	'');

	self.attributes.version1.PriorResidentMoveIndex						:= if(validInput,	
																																	map(le.did = 0																											=> '-1',
																																			le.prior_res_did = 0																						=> '0',
																																			le.prior_res_sold_target='1' and le.prior_res_owned_newer 			=> '7',
																																			le.prior_res_sold_target='1' and 
																																				(le.prior_res_new_addr or	le.prior_res_acct_open)							=> '6',
																																			le.prior_res_sold_target='1' and 
																																				not le.prior_res_new_addr and not le.prior_res_acct_open			=> '5',
																																			le.prior_res_owned_target='1' and le.prior_res_sold_target<>'1' and 
																																				(le.prior_res_new_addr or	le.prior_res_acct_open)							=> '4',
																																			le.prior_res_owned_target<>'1' and
																																				(le.prior_res_new_addr or	le.prior_res_acct_open)							=> '3',
																																			le.prior_res_owned_target<>'1' and not
																																				 le.prior_res_new_addr and not le.prior_res_acct_open					=> '2',
																																			le.prior_res_owned_target='1' and le.prior_res_sold_target<>'1' and 
																																				 not le.prior_res_new_addr and not le.prior_res_acct_open			=> '1',
																																																																				 '0'),
																																	'');
																																	
	self.attributes.version1.AddressDateFirstSeen							:= if(validInput, 
																																	map(le.DID = 0					=> '-1',
																																	    le.target_addr = 0	=> '0',  
																																														 (string)le.h.dt_first_seen), 
																																	'');
																																	
	self.attributes.version1.AddressDateLastSeen							:= if(validInput, 
																																	map(le.DID = 0					=> '-1',
																																	    le.target_addr = 0	=> '0',
																																	    (string)le.h.dt_last_seen = '0' and (string)le.h.dt_first_seen <> '0'	=> (string)le.h.dt_first_seen, //if last seen is zero and first seen is populated, set last to first
																																														 (string)le.h.dt_last_seen), 
																																	'');
																																	
	self.attributes.version1.OccupancyOverride								:= if(validInput, 
																																	map(le.DID = 0																																=> '-1',
																																			le.incarc_Offenders or 
																																			le.incarc_Offenses or 
																																			le.incarc_Punishments																											=> '2', 
																																			le.DIDdeceasedDate <> 0 and le.DIDdeceasedDate <= (le.historydate * 100)	=> '1',
																																																																									 '0'),
																																	'');
																																	
	self.attributes.version1.OtherOwnedPropertyProximity			:= if(validInput,
																																	map(le.did = 0 													=> '-1',
																																			le.other_prox_distance = 9999999	 	=> '0',  //subject doesn't own target or owns no other properties
																																			le.other_prox_distance < 10					=> '1-9',		
																																			le.other_prox_distance < 50					=> '10-49',		
																																			le.other_prox_distance < 100				=> '50-99',		
																																			le.other_prox_distance >= 100 			=> '100+',		
																																																						 '-1'),
																																	'');	
																																	
	self.attributes.version1.InferredOwnershipTypeIndex				:= '';  //this and the score are computed in the 'getScore' function

	self.attributes.version1.VerificationOfOccupancyScore			:= '';
end;

attr := project(VOOShell, getAttr(left)); 
																						
return attr;	
	
END;