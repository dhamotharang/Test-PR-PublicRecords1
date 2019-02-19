/*
Process to Verify Phone data agains insurance phone data and File One

===============================================================================================================
Requirements:
Data filters:
		-	Insurance: Last 3 years for landlines and all cellphones
		-	File One: Last 1 year for landlines only and all cellphones
GLB restrictions:
		-	Matches that change the status of a record from below to above the line will be flagged a GLB.
		-	All matches already above the line will be flagged as matches but the GLB flag will be left as is in the original record.  The usage of the match information will require GLB permissible use (something query will need to be aware if using the match information down the road to output data)
Changing Record status (above/below):
		-	Flag as a match everything in Phonesplus that matches Insurance data (LexId and phone) or File One (LexId and 3 digits of the phone) after applying the filters above and move above the line currently below the line.  When a match is found and that trigger a record to move above the line, if there are other records for the same phone and household, all will be moved above the line.
		-	When moving records from below the line to above, there will be cases with multiple households assigned to the same phone.  We will leave the multiple households associated to same phone above the line.

Implementation Plan:
After the current process has determined what is above and below the line, match to the Insurance and File One files
		o	Match insurance by DID and phone
						?	There is a file with only the insurance phone records we are allowed to use ready to be pulled from Boca
						?	If match is to a record above the line, update the rules field to indicate the record matched insurance.  
						?	If match is to a record below the line, set it above the line, set dppa_glb_flag = G, and update the rules field to indicate the record matched insurance
		o	Match File One by DID and 3 digits
						?	If match is to a record above the line, update the rules field to indicate the records matched File One
						?	If match is to a record below the line, set it above the line, set dppa_glb_flag = G, and update the rules field to indicate the records matched File One

-	For the records that were below the line and moved above, propagate above the line to other records for the same phone and household.
===============================================================================================================
*/
import Experian_Phones, ut, PhoneMart,_control;
EXPORT Fn_Phone_Verification(dataset(recordof(Layout_Phonesplus_Base)) phplus_in, string pversion) := function

// remote insurance verification file
iver_rec := RECORD
  unsigned8 did;
  string10 phone;
  string9 src;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  boolean is_latest;
 END;
//ins prod


ins := dataset('~foreign::' + _Control.IPAddress.aprod_thor_dali + '::thor_data400::base::insuranceheader::for_phone_verification', iver_rec , thor);
//ins dataland
//ins := dataset('~foreign::10.194.10.1::thor400_72::persist::for_phone_verification', iver_rec , thor);

//file1_ := pull(experian_phones.Key_Did);
file1_ := pull(PhoneMart.key_phonemart_did);
/*file1 := file1_(pin_did > 0 and 
								is_current and
								//only use cellphones and non-cellphones when the date_last_seen is within 1 year
								(phone_type = 'C' or
								(phone_type = 'N' and date_last_seen > (unsigned) ut.date_math (pversion, -((1 * 365.00) + 2.00)) )));*/
								
								
file1 := file1_(did > 0);
//Match to Insurance;
Layout_Phonesplus_Base t_ins_match (phplus_in le, ins ri) := transform
is_match := le.cellphone = ri.phone and le.did = ri.did and 
						//only use cellphones and non-cellphones when the date_last_seen is within 3 years
						(le.append_phone_type in Phonesplus_v2.Translation_Codes.cellphone_types or
						(ri.dt_last_seen  > (unsigned)ut.date_math (pversion, -((3 * 365.00) + 2.00))  and le.append_phone_type not in Phonesplus_v2.Translation_Codes.cellphone_types));


Ins_Verified_Above_rule := if(is_match and le.in_flag, true, false);
Ins_Verified_Below_rule := if(is_match and ~le.in_flag, true, false);

Ins_Verified_Above_caption := if(Ins_Verified_Above_rule,
								 Translation_Codes.rules_bitmap_code('Ins-Verified-Above'), 0b );	

Ins_Verified_Below_caption := if(Ins_Verified_Below_rule,
								 Translation_Codes.rules_bitmap_code('Ins-Verified-Below'), 0b );
										
self.rules := le.rules |
							Ins_Verified_Above_caption |
							Ins_Verified_Below_caption;
							
self.src_rule := self.rules;
self := le;							
end;


ins_match := join(distribute(phplus_in, hash(cellphone)),
								  dedup(sort(distribute(ins(did > 0 and is_latest), hash(phone)), phone, did, -dt_last_seen,local), phone, did, local),
									left.cellphone = right.phone and
									left.did = right.did,
									t_ins_match(left, right),
									local,
									left outer);

//Match to File One
Layout_Phonesplus_Base t_file1_match (ins_match le, file1 ri) := transform
/*is_match := le.cellphone = ri.phone and le.did = ri.did and
						//only use cellphones and non-cellphones when the date_last_seen is within 1 year
						(le.append_phone_type in Phonesplus_v2.Translation_Codes.cellphone_types or
						(ri.date_last_seen  > (unsigned) ut.date_math (pversion, -((1 * 365.00) + 2.00))  and le.append_phone_type not in Phonesplus_v2.Translation_Codes.cellphone_types));*/
						
is_match := le.cellphone = ri.phone and le.did = ri.did and
						//only use cellphones and non-cellphones when the date_last_seen is within 1 year
						(le.append_phone_type in Phonesplus_v2.Translation_Codes.cellphone_types or
						(ri.dt_last_seen  > (unsigned) ut.date_math (pversion, -((1 * 365.00) + 2.00))  and le.append_phone_type not in Phonesplus_v2.Translation_Codes.cellphone_types));

FileOne_Verified_Above_rule := if(is_match and le.in_flag, true, false);
FileOne_Verified_Below_rule := if(is_match and ~le.in_flag, true, false);

FileOne_Verified_Above_caption := if(FileOne_Verified_Above_rule,
								 Translation_Codes.rules_bitmap_code('FileOne-Verified-Above'), 0b );	

FileOne_Verified_Below_caption := if(FileOne_Verified_Below_rule,
								 Translation_Codes.rules_bitmap_code('FileOne-Verified-Below'), 0b );
										
self.rules := le.rules |
							FileOne_Verified_Above_caption |
							FileOne_Verified_Below_caption;

self.src_rule := self.rules;
self := le;
end;


/*file1_match_ := join(distribute(ins_match (did > 0), hash(did)),
								  dedup(sort(distribute(file1, hash(pin_did)), pin_did, phone_digits, -date_last_seen, local), pin_did, phone_digits, local),
									left.cellphone[8..10] = right.phone_digits and
									left.did = right.pin_did,
									t_file1_match(left, right),
									local,
									left outer);*/

file1_match_ := join(distribute(ins_match (did > 0), hash(did)),
								  dedup(sort(distribute(file1, hash(did)), did, phone, -dt_last_seen, local), did, phone, local),
									left.cellphone = right.phone and
									left.did = right.did,
									t_file1_match(left, right),
									local,
									left outer);
file1_match := file1_match_ + ins_match(did = 0);

match_ai (unsigned rules):= phonesplus_v2.Translation_Codes.fFlagIsOn(rules, phonesplus_v2.Translation_Codes.rules_bitmap_code('Ins-Verified-Above'));
match_a1 (unsigned rules):= phonesplus_v2.Translation_Codes.fFlagIsOn(rules, phonesplus_v2.Translation_Codes.rules_bitmap_code('FileOne-Verified-Above'));
match_bi (unsigned rules):= phonesplus_v2.Translation_Codes.fFlagIsOn(rules, phonesplus_v2.Translation_Codes.rules_bitmap_code('Ins-Verified-Below'));
match_b1 (unsigned rules):= phonesplus_v2.Translation_Codes.fFlagIsOn(rules, phonesplus_v2.Translation_Codes.rules_bitmap_code('FileOne-Verified-Below'));
match_f (unsigned rules):= match_ai(rules) or match_a1(rules) or match_bi(rules) or match_b1(rules);

set_confidence_score := project(file1_match, transform(Layout_Phonesplus_Base,
																						 self.glb_dppa_flag := if(match_f(left.rules) and
																																			~left.in_flag and
																																			left.glb_dppa_flag not in['G' ,'D', 'B'],
																																			 'G',
																																			left.glb_dppa_flag);
																						 self.confidencescore := if(match_f(left.rules),
																																				11,
																																				left.confidencescore),

																						 self.in_flag := if(match_f(left.rules),
																																				true,
																																				left.in_flag),
																						 self := left));

//propagate to household
phplus_in_rules := dedup(sort(distribute(set_confidence_score(in_flag and match_f(rules)), hash(npa+phone7)), npa+phone7, if(pdid = 0,1,2), -confidencescore,local),npa+phone7,local) ;
Layout_Phonesplus_Base t_propagate(set_confidence_score le, phplus_in_rules ri) := transform 
	
	related_below := if(le.in_flag =  false and
											 le.npa+le.phone7 = ri.npa+ri.phone7 and
											 (le.did = ri.did or
											  le.hhid = ri.hhid or
												(ut.StringSimilar(le.lname ,ri.lname) < 3 or
												le.prim_range = ri.prim_range and
												 le.prim_name = ri.prim_name and
												 le.sec_range = ri.sec_range and
												 le.zip5 = ri.zip5)),
												 true,
												 false);
												 
	self.glb_dppa_flag := if(related_below and
												le.glb_dppa_flag not in['G' , 'D', 'B'],
												'G',
												le.glb_dppa_flag);
	self.in_flag 	:= if(related_below,
												 true,
												 le.in_flag);
												 
  self.confidencescore 	:= if(related_below,
												 11,
												 le.confidencescore);											 
	self.rules 	:= if(related_below,
										le.rules | ri.rules,
										le.rules);
	
	self.src_rule := self.rules;
							
  self := le;
end;


propagate_f := join(distribute(set_confidence_score, hash(npa+phone7)), 
							 distribute(phplus_in_rules, hash(npa+phone7)), 
							 left.npa+left.phone7 = right.npa+right.phone7,
							 t_propagate(left, right), 
							  left outer,
							 local);																						 
																						 

return propagate_f;

end;
