//Append Neustar Wireless Rules Jira: DF-24336
//Apply Neustar Wireless Source Specific Rules
IMPORT NeustarWireless;
EXPORT fn_Append_Neustar_Wireless_Rules(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

phplus_in_d1		 		:= 	sort(distribute(phplus_in, hash(npa, phone7, did)), npa, phone7, did, local);
neustar_wireless_dl :=	sort(distribute(NeustarWireless.Files.Base.Main(current_rec=true), hash(phone, did)), phone, did, local);

recordof(phplus_in) t_append_neustar_rules(phplus_in_d1 le, neustar_wireless_dl ri) := transform
	verified_rule	:= MAP
									( ri.verified = 'A' => Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-A'),
										ri.verified = 'B' => Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-B'),
										ri.verified = 'C' => Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-C'),
										ri.verified = 'D' => Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-D'),
										ri.verified = 'E' => Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-E'),
										0b);

	activity_status_rule := MAP
													(	ri.activity_status= 'A1' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A1'),
														ri.activity_status= 'A2' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A2'),
														ri.activity_status= 'A3' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A3'),
														ri.activity_status= 'A4' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A4'),
														ri.activity_status= 'A5' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A5'),
														ri.activity_status= 'A6' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A6'),
														ri.activity_status= 'A7' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A7'),
														ri.activity_status= 'I1' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I1'),
														ri.activity_status= 'I2' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I2'),
														ri.activity_status= 'I3' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I3'),
														ri.activity_status= 'I4' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I4'),
														ri.activity_status= 'I5' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I5'),
														ri.activity_status= 'I6' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I6'),
														ri.activity_status= 'I7' => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I7'),
														ri.activity_status= 'U'  => Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-U'),
														0b);

	prepaid_rule := MAP 
									( ri.prepaid= 'Y' => Translation_Codes.rules_bitmap_code('NeustarWireless-Prepaid-Y'),
										ri.prepaid= 'N' => Translation_Codes.rules_bitmap_code('NeustarWireless-Prepaid-N'),
										0b);

	cord_cutter_rule := MAP									
											( ri.cord_cutter= 'Y' => Translation_Codes.rules_bitmap_code('NeustarWireless-Cord-Cutter-Y'),
												ri.cord_cutter= 'N' => Translation_Codes.rules_bitmap_code('NeustarWireless-Cord-Cutter-N'),
												0b);	
	
	self.rules := le.rules | verified_rule | activity_status_rule | prepaid_rule | cord_cutter_rule;
	self:= le;
end;

match_neustar_wireless := join(phplus_in_d1, 
				      neustar_wireless_dl,
							left.npa+left.phone7 = right.phone and 
							left.did = right.did,
							t_append_neustar_rules(left, right),
							left outer,
							local);

return match_neustar_wireless;

END;
