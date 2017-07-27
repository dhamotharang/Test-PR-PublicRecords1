import ut;

foreclosureIn := property.File_Foreclosure_In;
layout_foreclosureIn := recordof(foreclosureIn);
normalizeDIDLayout := recordof (Property.foreclosure_normalized);

layout_foreclosureIn denormalizeRecords(foreclosureIn l, normalizeDIDLayout r) := transform
	self.name1_did := if(r.name_indicator=1, intformat(r.did,12,1), l.name1_did);
	self.name1_did_score := if(r.name_indicator=1, (string)r.did_score, l.name1_did_score);
	self.name1_ssn := if(r.name_indicator=1, r.ssn, l.name1_ssn);
	self.name1_bdid := if(r.name_indicator=1, intformat(r.bdid,12,1), l.name1_bdid);
	self.name1_bdid_score := if(r.name_indicator=1, (string)r.bdid_score, l.name1_bdid_score);
	
	self.name2_did := if(r.name_indicator=2, intformat(r.did,12,1), l.name2_did);
	self.name2_did_score := if(r.name_indicator=2, (string)r.did_score, l.name2_did_score);
	self.name2_ssn := if(r.name_indicator=2, r.ssn, l.name2_ssn);
	self.name2_bdid := if(r.name_indicator=2, intformat(r.bdid,12,1), l.name2_bdid);
	self.name2_bdid_score := if(r.name_indicator=2, (string)r.bdid_score, l.name2_bdid_score);
	
	self.name3_did := if(r.name_indicator=3, intformat(r.did,12,1), l.name3_did);
	self.name3_did_score := if(r.name_indicator=3, (string)r.did_score, l.name3_did_score);
	self.name3_ssn := if(r.name_indicator=3, r.ssn, l.name3_ssn);
	self.name3_bdid := if(r.name_indicator=3, intformat(r.bdid,12,1), l.name3_bdid);
	self.name3_bdid_score := if(r.name_indicator=3, (string)r.bdid_score, l.name3_bdid_score);
	
	self.name4_did := if(r.name_indicator=4, intformat(r.did,12,1), l.name4_did);
	self.name4_did_score := if(r.name_indicator=4, (string)r.did_score, l.name4_did_score);
	self.name4_ssn := if(r.name_indicator=4, r.ssn, l.name4_ssn);
	self.name4_bdid := if(r.name_indicator=4, intformat(r.bdid,12,1), l.name4_bdid);
	self.name4_bdid_score := if(r.name_indicator=4, (string)r.bdid_score, l.name4_bdid_score);
	
	self := l;
end;

// foreclosureBaseSeq := project(foreclosureIn, property.Layout_Fares_Foreclosure);

foreclosureBase := denormalize(foreclosureIn, Property.foreclosure_normalized,
									left.sequence = right.sequence,
									denormalizeRecords(left,right));

// output(choosen(denormalizeForeclosure,100), named('DenormalizedForeclosureOutput'));
// output(count(denormalizeForeclosure), named('DenormalizedForeclosureCount'));


ut.mac_suppress_by_phonetype(foreclosureBase,attorney_phone_nbr,state,                   phone_out1);
ut.mac_suppress_by_phonetype(phone_out1,     lender_phone,      lender_beneficiary_state,phone_out2);
ut.mac_suppress_by_phonetype(phone_out2,     trustee_phone,     trustee_state,           phone_out3);

f1 := foreclosurebase(attorney_phone_nbr<>'' or lender_phone<>'' or trustee_phone<>'');

r1 := record
 f1.foreclosure_id;
 f1.attorney_phone_nbr;
 f1.lender_phone;
 f1.trustee_phone;
end;

ta1 := distribute(table(f1,r1),hash(foreclosure_id));
phone_out3_dist := distribute(phone_out3,hash(foreclosure_id));

r1 t1(ta1 le, phone_out3_dist ri) := transform
 self := le;
end;

j1 := join(ta1,phone_out3_dist,left.foreclosure_id=right.foreclosure_id and 
                               (left.attorney_phone_nbr<>right.attorney_phone_nbr or
							    left.lender_phone      <>right.lender_phone       or
								left.trustee_phone     <>right.trustee_phone
							   ),
							   t1(left,right),local);
							   
output(choosen(j1,100),named('phones_that_should_be_suppressed_in_the_output'));

export Foreclosure_DID := project(phone_out3,Property.Layout_Fares_Foreclosure_v2);