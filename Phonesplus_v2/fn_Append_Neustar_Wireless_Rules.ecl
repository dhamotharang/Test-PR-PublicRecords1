//Append Neustar Wireless Rules Jira: DF-24336
//Apply Neustar Wireless Source Specific Rules
IMPORT NeustarWireless, MDR;
EXPORT fn_Append_Neustar_Wireless_Rules(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

phplus_in_not_n2 := phplus_in(~PhonesPlus_V2.Translation_Codes.fFlagIsOn(src_all,phonesplus_V2.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_NeustarWireless)));
phplus_in_n2_d1	 := 	sort(distribute(phplus_in(PhonesPlus_V2.Translation_Codes.fFlagIsOn(src_all,phonesplus_V2.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_NeustarWireless))), hash(npa+phone7)), npa+phone7, local);

neustar_wireless_current := NeustarWireless.Files.Base.Main(current_rec=true);
neustar_wireless_dl_phone :=	dedup(sort(distribute(neustar_wireless_current, hash(phone)), phone, local), phone, local);
neustar_wireless_dl_phone_did :=	dedup(sort(distribute(neustar_wireless_current, hash(phone, did)), phone, did, local), phone, did, local);

recordof(phplus_in) t_append_neustar_phone_rules(phplus_in_n2_d1 le, neustar_wireless_dl_phone ri) := transform
	activity_status_rule := MAP
													(	ri.activity_status= 'A1' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A1'),
														ri.activity_status= 'A2' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A2'),
														ri.activity_status= 'A3' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A3'),
														ri.activity_status= 'A4' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A4'),
														ri.activity_status= 'A5' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A5'),
														ri.activity_status= 'A6' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A6'),
														ri.activity_status= 'A7' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A7'),
														ri.activity_status= 'I1' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I1'),
														ri.activity_status= 'I2' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I2'),
														ri.activity_status= 'I3' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I3'),
														ri.activity_status= 'I4' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I4'),
														ri.activity_status= 'I5' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I5'),
														ri.activity_status= 'I6' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I6'),
														ri.activity_status= 'I7' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I7'),
														ri.activity_status= 'U'  => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-U'),
														0b);

	prepaid_rule := MAP 
									( ri.prepaid= 'Y' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Prepaid-Y'),
										ri.prepaid= 'N' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Prepaid-N'),
										0b);

	self.rules := le.rules | activity_status_rule | prepaid_rule;
	self:= le;
end;

//match on phone only and pull back the phone-related flags
match_neustar_wireless_phone := join(phplus_in_n2_d1, 
				      neustar_wireless_dl_phone,
							left.npa+left.phone7 = right.phone,
							t_append_neustar_phone_rules(left, right),
							left outer,
							local);

match_neustar_wireless_phone_dl := sort(distribute(match_neustar_wireless_phone, hash(npa+phone7, did)), npa+phone7, did, local);

recordof(phplus_in) t_append_neustar_did_rules(match_neustar_wireless_phone_dl le, neustar_wireless_dl_phone_did ri) := transform
	verified_rule	:= MAP
									( ri.verified = 'A' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-A'),
										ri.verified = 'B' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-B'),
										ri.verified = 'C' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-C'),
										ri.verified = 'D' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-D'),
										ri.verified = 'E' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-E'),
										0b);

	cord_cutter_rule := MAP									
											( ri.cord_cutter= 'Y' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Cord-Cutter-Y'),
												ri.cord_cutter= 'N' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Cord-Cutter-N'),
												0b);	
	
	self.rules := le.rules | verified_rule | cord_cutter_rule;
	self:= le;
end;

//take the result of phone-only match and now match on phone and did and pull back the phone+did-related flags
match_neustar_wireless_phone_did := join(match_neustar_wireless_phone_dl, 
				      neustar_wireless_dl_phone_did,
							left.npa+left.phone7 = right.phone and 
							left.did = right.did,
							t_append_neustar_did_rules(left, right),
							left outer,
							local);


//append non-nuestar with neustar appended and return
return phplus_in_not_n2 + match_neustar_wireless_phone_did;

END;
