/*2014-02-11T17:25:02Z (J Trost)

*/
/*2012-11-20T16:26:11Z (Michele Walklin)
check in for Jo
*/
import ut;  

 decimal6_2 network_degree_value                   := 1.75;

// Limit all transactions to post 2000.
dAddrFares := SNA.prop_transaction_owner_combinations(prim_name != '' and fares_unformatted_apn != '' and (unsigned8)recording_date > 20000000);

// join pre-calculated specialized indicators

// In Network Transfers
dAddrFaresInNetwork := join(dAddrFares, sna.file_property_innetwork_fares, 
                              left.ln_fares_id=right.ln_fares_id, 
															          transform({recordof(left), right.in_network, right.net_degree}, 
																				       self.net_degree := map(right.ln_fares_id != '' => right.net_degree, -1), self := left, self := right
																        ), left outer, hash);
 
// Sort and Distribute on geolink, apn
//dAddrFaresTransPrep := distribute(sort(dAddrFaresInNetwork, geolink, fares_unformatted_apn, recording_date), hash(geolink, fares_unformatted_apn)); 
dAddrFaresTransPrep := distribute(dAddrFaresInNetwork, hash(prim_name, prim_range, predir, suffix, sec_range, zip, st)); 


// Iterate events in recording date order.

rAddrIter := 
record
 recordof(dAddrFaresTransPrep);
 string8 last_ownership_change_date := '';
 integer4 days := 0;
 string8 last_default_date := '';
 string8 last_defaultcleared_date := ''; 
 string2 default_clearing_document_type_code := '';
 integer1 foreclosurestage := 0;
 boolean flip := false;
 boolean flop := false;
 boolean high_profit := false;
 boolean in_network_risk := false;
 boolean in_network_high_profit := false;
 boolean in_network_flip := false;
 boolean in_network_high_profit_flip := false;
 integer4 price_change_percent := 0;
 unsigned4 sales_count := 0;
 unsigned4 ownership_changes := 0;
 unsigned4 seq_count := 0;
 unsigned4 suspicious_deed_count := 0;
 unsigned4 flip_count := 0;
 unsigned4 flip_business_count := 0;
 unsigned4 flop_count := 0;
 unsigned4 in_network_count := 0;
 unsigned4 in_network_flip_business_count := 0;
 unsigned4 in_network_flip_count := 0;
 unsigned4 high_profit_count := 0;
 unsigned4 in_network_high_profit_count := 0;
 unsigned4 in_network_high_profit_flip_count := 0;
 unsigned4 high_profit_flip_count := 0;
 boolean ownership_change := false;
 // boolean deed_ownership_amend := false;
 boolean mortgage_default := false;
 boolean has_mortgage_default := false;
 boolean has_mortgage_default_preceeding_suspicious := false;
 boolean mortgage_foreclosure := false;
 boolean has_mortgage_foreclosure := false;
 boolean has_mortgage_foreclosure_preceeding_suspicious := false;
 boolean is_dupe := false;
 boolean is_refi := false;
 boolean apn_addr_mismatch := false;
 boolean has_apn_addr_mismatch := false;
 boolean ends_in_default_or_foreclosure := false;
 unsigned4 business_trans_count := 0;
end;

// Group on geolink, apn for the local iterate.

dGroupedAddrFares := group(sort(
										  project(dAddrFaresTransPrep, 
											  transform(rAddrIter, self := left), local), 
										prim_name, prim_range, predir, postdir, suffix, sec_range, zip, st, recording_date, dt_vendor_first_reported, -seller_id_combination, local), 
										prim_name, prim_range, predir, postdir, suffix, sec_range, zip, st, local);
										/*		
										geolink, fares_unformatted_apn, recording_date, local), 
									geolink, fares_unformatted_apn, local);
									  */

rAddrIter tAddrIter(dGroupedAddrFares l, dGroupedAddrFares r, integer c) := 
transform
 
 boolean is_ownership_change := if(r.document_type_code='' or sna.functions.is_non_ownership_change_event(r.vendor_source_flag,r.document_type_code)=true,false,true);
 
 self.apn_addr_mismatch := false;
 /* 
 self.apn_addr_mismatch := map((l.prim_range != '' and r.prim_range != '' and l.prim_range != r.prim_range) or  
															 (l.prim_name != '' and r.prim_name != '' and l.prim_name != r.prim_name)	or
															 (l.sec_range != '' and r.sec_range != '' and l.sec_range != r.sec_range)	=> true, false);
 */
 self.net_degree := r.net_degree;
 self.has_apn_addr_mismatch := map(l.apn_addr_mismatch or self.apn_addr_mismatch => true, false);

 //boolean isDupeOwnership := map(l.buyer_id_combination = r.buyer_id_combination or (r.seller_id_combination = '' and r.first_td_loan_type_code = 'CNV') => true, false);

 self.last_ownership_change_date := map(NOT is_ownership_change and l.last_ownership_change_date != '' => l.last_ownership_change_date, r.recording_date);
 //self.last_ownership_change_date := map(isDupeOwnership and l.last_ownership_change_date != '' => l.last_ownership_change_date, r.recording_date);
 self.days := map(l.last_ownership_change_date != '' /*and l.buyer_id_combination != ''*/ => ut.DaysApart(l.last_ownership_change_date, self.last_ownership_change_date), -1);

 // If it is a grant deed and it's a short time after then exclude from suspicious indicators.
 // phase 2 we need to check the buyers and sellers to prove it's actually a dupe.
 //self.is_dupe := map(self.days < 10 and r.document_type_code = 'G' => true, false);

 // phase 2 we need to check the lender info to enhance cause it looks similar to Dupeowner
 self.is_refi := map(is_ownership_change=false and (unsigned8)l.sales_price < (unsigned8)r.sales_price
											and l.buyer_id_combination = r.buyer_id_combination 
											and (r.seller_id_combination = r.buyer_id_combination or r.seller_id_combination = '')
											=> true, false);

 //self.ownership_change := map(not self.apn_addr_mismatch and not isDupeOwnership => true, false);
 self.ownership_change := is_ownership_change;
														
 self.flip := map(self.ownership_change and self.days > -1 and self.days < 181 
									and l.buyer_id_combination != r.buyer_id_combination 
									and l.buyer_name_combination != r.buyer_name_combination
									and r.document_type_code != 'IT' and r.document_type_code != 'Q'
									and r.document_type_code != 'QC' => true, false);

 // if the left is the same as the right then dupe the recording date and other vars so they can be deduped out.
 
 // NOT including refi in suspcious indicators for now phase two need to count them and measure increase in price.
 self.in_network_risk := map(not self.is_refi and r.in_network and r.document_type_code != 'Q' 
                             and r.document_type_code != 'QC' and r.document_type_code != 'IT' and not (r.net_degree = 0 and r.buyer_id_combination = '')  => true, false);
	//todo remove before prod													 
 // self.deed_ownership_amend := r.deed_ownership_amend;
 
 self.seq_count := c;

 //self.foreclosurestage := (integer1)Address_Attributes.functions.getForeclosureStage(r.document_type_code[1]);
 self.foreclosurestage := (integer1) MAP(
									r.document_type_code[1] IN ['S','G','T','R'] 	=> '4', //sold or auctioned, and lis pendens released
									r.document_type_code[1] IN ['U'] 							=> '3', //Foreclosure
									r.document_type_code[1] IN ['Q','F'] 					=> '2', //quit claim, or legal affirmation of deficiency
									r.document_type_code[1] IN ['L','N'] 					=> '1', //notice of default or lis pendens filed
									'0');					
 
 self.last_default_date := MAP(self.foreclosurestage=1 => MAP(l.foreclosurestage=1 => l.last_default_date, r.recording_date), '');
 self.last_defaultcleared_date := MAP(l.foreclosurestage = 1 and self.foreclosurestage != 1 => r.recording_date, '');
 self.default_clearing_document_type_code := MAP(l.foreclosurestage = 1 and self.foreclosurestage != 1 => r.document_type_code, '');
 
 self.sales_count := l.sales_count + 1;
 self.sales_price := map(r.sales_price != '' => r.sales_price, l.sales_price);
 self.price_change_percent := MAP(self.ownership_change => (((unsigned6)self.sales_price - (unsigned8)l.sales_price) / (unsigned8)l.sales_price) * 100, 0);
 self.high_profit := map(( (self.days > -1 and self.days < 366 and self.price_change_percent > 10) or (self.days > 365 and self.days < 730 and self.price_change_percent > 20))
                 => true, false);
 
 self.flop := map(self.ownership_change and l.price_change_percent < -10 and l.document_type_code != 'F' 
									and ((self.days < 31 and self.price_change_percent > 9) 
											  or (self.days > 30 and self.days < 91 and self.price_change_percent > 19)
											  or (self.days > 90 and self.days < 181 and self.price_change_percent > 29)) => true, false);
 
 self.in_network_high_profit_flip :=  map(self.high_profit and (self.net_degree between 0 and  network_degree_value) and self.flip => true, false);
 self.in_network_high_profit := map(self.high_profit and (self.net_degree between 0 and network_degree_value) => true, false);
 self.in_network_flip := map((self.net_degree between 0 and network_degree_value) and self.flip => true, false);

 self := r;
end;

iAddrIter := iterate(dGroupedAddrFares, tAddrIter(left, right, counter));

// We might need to split this into two separate iterates if both document_number and recorder_book_number\page number are populated.

dDupDeedsOrder := group(sort(ungroup(iAddrIter), prim_name, prim_range, predir, suffix, sec_range, st, recording_date, recorder_book_number, recorder_page_number, document_number, seq_count, local), prim_name, prim_range, predir, suffix, sec_range, st, recording_date, recorder_book_number, recorder_page_number, document_number);

rAddrIter tDupDeedIter(iAddrIter l, iAddrIter r, integer c) := 
transform

  self.is_dupe := MAP(( l.recording_date = r.recording_date and l.recording_date != '') and 
                  ((l.document_number = r.document_number and l.document_number != '') OR 
                  ((l.recorder_book_number = r.recorder_book_number and l.recorder_book_number != '') and 
                  (l.recorder_page_number = r.recorder_page_number and l.recorder_page_number != '')))
									  => true, false);

  self.ownership_changes := l.ownership_changes + 1; 
	
  self.days := MAP(self.is_dupe 
                    => l.days, r.days
                   );
  self.price_change_percent := MAP(self.is_dupe 
                    => l.price_change_percent, r.price_change_percent);
  self.flip := MAP(self.is_dupe 
                    => l.flip, r.flip);										
  self.flop := MAP(self.is_dupe 
                    => l.flop, r.flop);										
  self.high_profit := MAP(self.is_dupe 
                    => l.high_profit, r.high_profit);		
  self.in_network_risk	:= MAP(self.is_dupe 
                    => l.in_network_risk, r.in_network_risk);		
  self.in_network_high_profit	:= MAP(self.is_dupe 
                    => l.in_network_high_profit, r.in_network_high_profit);		
  self.in_network_flip	:= MAP(self.is_dupe 
                    => l.in_network_flip, r.in_network_flip);		
  self.in_network_high_profit_flip := MAP(self.is_dupe 
                    => l.in_network_high_profit_flip, r.in_network_high_profit_flip);	
										
 self.flip_count := l.flip_count + map(NOT self.is_dupe and r.flip => 1, 0);
 self.flip_business_count := l.flip_business_count + map(NOT self.is_dupe and r.flip and r.business_transaction => 1, 0);
 self.flop_count := l.flop_count + map(NOT self.is_dupe and r.flop => 1, 0); // need to do a special calc for this, to exclude forclosures etc..
 self.in_network_count := l.in_network_count + map(NOT self.is_dupe and (r.net_degree between 0 and network_degree_value) => 1, 0);
 self.in_network_flip_business_count := l.in_network_flip_business_count + map(NOT self.is_dupe and r.business_transaction and self.flip and l.buyer_id_combination != r.buyer_id_combination and l.buyer_name_combination != r.buyer_name_combination => 1, 0);
 self.in_network_flip_count := l.in_network_flip_count + map(NOT self.is_dupe and (r.net_degree between 0 and network_degree_value) and self.flip => 1, 0);
 self.high_profit_count := l.high_profit_count + map(NOT self.is_dupe and self.high_profit => 1, 0);
 self.in_network_high_profit_count := l.in_network_high_profit_count + map(NOT self.is_dupe and self.in_network_high_profit=> 1, 0);
 self.in_network_high_profit_flip_count := l.in_network_high_profit_flip_count + map(NOT self.is_dupe and self.in_network_high_profit_flip => 1, 0);
 self.mortgage_default := map(r.document_type_code = 'L' => true, false);
 self.has_mortgage_default := map(l.has_mortgage_default or l.has_mortgage_default = false and r.document_type_code = 'L' => true, false);
 self.has_mortgage_default_preceeding_suspicious := map(l.has_mortgage_default_preceeding_suspicious or r.has_mortgage_default and r.suspicious_deed_count > 0 => true, false);
 self.mortgage_foreclosure := map(r.document_type_code in ['F', 'FC', 'U'] => true, false);
 self.has_mortgage_foreclosure := map(self.mortgage_foreclosure or l.has_mortgage_foreclosure => true, false);
 self.has_mortgage_foreclosure_preceeding_suspicious := map(l.has_mortgage_foreclosure_preceeding_suspicious or r.has_mortgage_foreclosure and r.suspicious_deed_count > 0 => true, false);
 boolean high_profit_flip := map(NOT self.is_dupe and self.high_profit and self.flip => true, false); 
 self.high_profit_flip_count := l.high_profit_flip_count + map(NOT self.is_dupe and high_profit_flip => 1, 0);
 self.business_trans_count := l.business_trans_count + map(NOT self.is_dupe and r.business_transaction => 1, 0);

 self.suspicious_deed_count := l.suspicious_deed_count + 
					map(NOT self.is_dupe and r.ownership_change and (r.in_network_risk  or 
								r.flip or r.high_profit)
								=> 1 , 0);
										
self := r;
end;

iDupDeedsIter := iterate(dDupDeedsOrder, tDupDeedIter(left, right, counter));

dOwnershipOrder := group(sort(ungroup(iDupDeedsIter), prim_name, prim_range, predir, suffix, sec_range, st, seq_count, local), prim_name, prim_range, predir, suffix, sec_range, st);

rAddrIter tOwnershipIter(iAddrIter l, iAddrIter r, integer c) := 
transform
  self.ownership_changes := l.ownership_changes + MAP(r.is_dupe or NOT r.ownership_change => 0, 1); 
  self := r;
END;

iOwnershipIter := iterate(dOwnershipOrder, tOwnershipIter(left, right, counter));

dFinalAddrFaresReverse := group(sort(ungroup(iOwnershipIter), prim_name, prim_range, predir, suffix, sec_range, st, -recording_date, local),  prim_name, prim_range, predir, suffix, sec_range, st, local);

rAddrIter tAddrRevIter(dFinalAddrFaresReverse l, dFinalAddrFaresReverse r, integer c) := 
transform
self.ends_in_default_or_foreclosure := 
                                                map((l.mortgage_default or l.mortgage_foreclosure) or (l.ends_in_default_or_foreclosure and not l.ownership_change)
                                                                                                => true, false);
self := r;
end;

// Reverse through and flag certain transactions that preceed default\foreclosure.
iAddrRevIter := iterate(dFinalAddrFaresReverse, tAddrRevIter(left, right, counter));

// re-sort so everything is in original recording date order...
dFinalAddrFares := sort(ungroup(iAddrRevIter),	prim_name, prim_range, predir, suffix, sec_range, st, recording_date, local);

export file_prop_transaction_stats := ungroup(dFinalAddrFares) : persist('~thor_data400::persist::property_ownership_stats');