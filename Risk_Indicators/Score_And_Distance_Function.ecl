import riskwise, address, ut, gong, gateway;

export Score_And_Distance_Function(grouped DATASET(Layout_CIID_BtSt_Output) indata, unsigned dppa, unsigned glb) := function;


boolean isFCRA := FALSE;
unsigned8 BSOptions := 0;
unsigned3 lastSeenThreshold := risk_indicators.iid_constants.oneyear;
string ExactMatchLevel := '';
string companyID := '';

chargeback := record
	unsigned4 seq := 0;
	string10 hphone := '';
	string10 hphone2 := '';
	string3 firstscore := '';
	string3 lastscore := '';
	string3 cmpyscore := '';
	string3 addrscore := '';
	string3 phonescore := '';
	string3 efirstscore := '';  // score the input email address up to the @ against the input first
	string3 elastscore := ''; // score the input email address up to the @ against the input last
	string3 elast2score := ''; // score the input email address up to the @ against the input last2
	string3 efirst2score := ''; // score the input email address up to the @ against the input first2
	
	//string3 ecmpyscore := ''; // may want to add this as a score of the last part of the email address against input cmpy
	//string3 ecmpy2score := ''; // may want to add this as a score of the last part of the email address against input cmpy
	
	string10 phoneLat := '';
	string11 phoneLong	:= '';
	string10 addrLat := '';
	string11 addrLong := '';
	string10 phoneLat2 := '';
	string11 phoneLong2 := '';
	string10 addrLat2 := '';
	string11 addrLong2	:= '';
	string8 dt_last_seen := '';
	string8 dt_last_seen2 := '';
	STRING6 distphoneaddr := '';
	STRING6 distphone2addr2 := '';
	STRING6 distphoneaddr2 := '';
	STRING6 distphonephone2 := '';
	STRING6 distaddraddr2 := '';
	STRING6 distaddrphone2 := '';
end;

chargeback add_scores(indata le) := transform
	self.seq := le.bill_to_output.seq;
	self.hphone := le.Bill_To_Output.phone10;
	self.hphone2 := le.ship_To_Output.phone10;
	self.firstscore := (string)risk_indicators.FnameScore(le.Bill_To_Output.fname, le.ship_To_Output.fname);
	self.lastscore := (string)risk_indicators.LnameScore(le.Bill_To_Output.lname, le.ship_To_Output.lname);
	cscore := ut.CompanySimilar100(le.Bill_To_Output.employer_name, le.ship_To_Output.employer_name);
	self.cmpyscore := if(cscore=250, '255', (string)(100-cscore));
	self.phonescore := (string)risk_indicators.PhoneScore(le.Bill_To_Output.phone10, le.ship_To_Output.phone10);	
	
	zip_score := Risk_Indicators.AddrScore.zip_score(le.Bill_To_Output.in_zipcode, le.ship_To_Output.in_zipcode);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(le.Bill_To_Output.in_city, le.Bill_To_Output.in_state, le.ship_To_Output.in_city, le.ship_To_Output.in_state, le.Bill_To_Output.cityzipflag);
	addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.Bill_To_Output.prim_range, le.Bill_To_Output.prim_name, le.Bill_To_Output.sec_range, 
																						le.ship_To_Output.prim_range, le.ship_To_Output.prim_name, le.ship_To_Output.sec_range,
																						zip_score, cityst_score);																						
	self.addrscore := (string)addrmatchscore;
					
	a := Stringlib.StringFind(le.Bill_To_Output.email_address, '@', 1);
	e_addr := le.Bill_To_Output.email_address[1..a-1];
	
	fname := Stringlib.StringFilterOut(le.Bill_To_Output.fname, ' ');
	lname := Stringlib.StringFilterOut(le.Bill_To_Output.lname, ' ');
	fname2 := Stringlib.StringFilterOut(le.ship_To_Output.fname, ' ');
	lname2 := Stringlib.StringFilterOut(le.ship_To_Output.lname, ' ');
					
	e_firstscore := risk_indicators.FnameScore(e_addr, fname);
	e_lastscore := risk_indicators.LnameScore(e_addr, lname);
	e_first2score := risk_indicators.FnameScore(e_addr, fname2);
	e_last2score := risk_indicators.LnameScore(e_addr, lname2);
			
	f_len := if(length(fname)<4, length(fname), 4);
	l_len := if(length(lname)<4, length(lname), 4);
	f2_len := if(length(fname2)<4, length(fname2), 4);
	l2_len := if(length(lname2)<4, length(lname2), 4);
	
	email_4bytefirst_flag := if(e_addr='' or fname='', '', if(Stringlib.StringFind(e_addr, fname[1..f_len],1)>0,'1', '0'));
	email_4bytelast_flag := if(e_addr='' or lname='', '', if(Stringlib.StringFind(e_addr, lname[1..l_len],1)>0, '1', '0'));
	email_4bytefirst2_flag := if(e_addr='' or fname2='', '', if(Stringlib.StringFind(e_addr, fname2[1..f2_len],1)>0, '1', '0'));
	email_4bytelast2_flag := if(e_addr='' or lname2='', '', if(Stringlib.StringFind(e_addr, lname2[1..l2_len],1)>0, '1', '0'));
	
	init_match1 := if(e_addr[1]=fname[1] and e_addr[2]=lname[1],'1', '0');
	init_match1b := if(e_addr[1]=fname[1] and e_addr[3]=lname[1],'1', '0');
	init_match2 := if(e_addr[1]=fname2[1] and e_addr[2]=lname2[1],'1', '0');
	init_match2b := if(e_addr[1]=fname2[1] and e_addr[3]=lname2[1],'1', '0');
	init_match_billto := if(init_match1='1' or init_match1b='1', '1', '0');
	init_match_shipto := if(init_match2='1' or init_match2b='1', '1', '0');
	
	self.efirstscore := map(email_4bytefirst_flag='' => '-1',
						e_firstscore > 79 => '1',
						email_4bytefirst_flag = '1' => '2',
						init_match_billto = '1' => '3', 
						e_firstscore < 80 and email_4bytefirst_flag != '1' and init_match_billto != '1' => '0',
						'-1');
						
	self.elastscore := map(email_4bytelast_flag='' => '-1',
						e_lastscore > 79 => '1',
						email_4bytelast_flag = '1' => '2',
						init_match_billto = '1' => '3', 
						e_lastscore < 80 and email_4bytelast_flag != '1' and init_match_billto != '1' => '0',
						'-1');
						
	self.efirst2score := map(email_4bytefirst2_flag='' => '-1',
						e_first2score > 79 => '1',
						email_4bytefirst2_flag = '1' => '2',
						init_match_shipto = '1' => '3', 
						e_first2score < 80 and email_4bytefirst2_flag != '1' and init_match_shipto != '1' => '0',
						'-1');
						
	self.elast2score := map(email_4bytelast2_flag='' => '-1',
						e_last2score > 79 => '1',
						email_4bytelast2_flag = '1' => '2',
						init_match_shipto = '1' => '3', 
						e_last2score < 80 and email_4bytelast2_flag != '1' and init_match_shipto != '1' => '0',
						'-1');
							
	self.addrlat := le.Bill_To_Output.lat;
	self.addrlong := le.Bill_To_Output.long;
	self.addrlat2 := le.ship_To_Output.lat;
	self.addrlong2 := le.ship_To_Output.long;
end;

wScores := project(indata, add_scores(left));

Risk_Indicators.Layouts.Layout_Input_Plus_Overrides into_in(wScores le) := transform
	self.phone10 := le.hphone;
	self.historydate := risk_indicators.iid_constants.default_history_date;
	self := [];
end;
Risk_Indicators.Layouts.Layout_Input_Plus_Overrides into_in2(wScores le) := transform
	self.phone10 := le.hphone2;
	self.historydate := risk_indicators.iid_constants.default_history_date;
	self := [];
end;

hp := project(wScores, into_in(left));
hp2 := project(wScores, into_in2(left));
phones_in := group(sort(hp + hp2, phone10));
phone_prep := dedup(phones_in, phone10);;

dirs := riskwise.getDirsByPhone(phone_prep, Gateway.Constants.void_gateway, dppa, glb, isFCRA, BSOptions, lastSeenThreshold, ExactMatchLevel, companyID);

chargeback tf(chargeback le, dirs rt) := transform
	self.dt_last_seen := rt.dt_last_seen;
	self.phonelat := rt.geo_lat;
	self.phonelong := rt.geo_long;
	self := le;
end;

wDirs1 := join(wScores, dirs,
			left.hphone!='' and right.phone10=left.hphone,
			tf(left,right), left outer, lookup);
			
sDirs1 := sort(wDirs1, seq, -dt_last_seen); 
rDirs1 := dedup(sDirs1, seq);

chargeback tf2(chargeback le, dirs rt) := transform
	self.dt_last_seen2 := rt.dt_last_seen;
	self.phonelat2 := rt.geo_lat;
	self.phonelong2 := rt.geo_long;
	self := le;
end;

wDirs2 := join(rDirs1, dirs,
			left.hphone2!='' and right.phone10=left.hphone2,
			tf2(left,right), left outer, lookup);

sDirs2 := sort(wDirs2, seq, -dt_last_seen2); 
rDirs2 := dedup(sDirs2, seq);


chargeback add_distances(rDirs2 le) := transform
	self.distphoneaddr := if(le.phoneLat != '' and le.addrLat != '', 
						(string)round(ut.ll_dist((REAL)le.phoneLat,(REAL)le.phoneLong,(REAL)le.addrLat,(REAL)le.addrLong)),
						'');
	self.distphone2addr2 := if(le.phoneLat2 != '' and le.addrLat2 != '',
						 (string)round(ut.ll_dist((REAL)le.phoneLat2,(REAL)le.phoneLong2,(REAL)le.addrLat2,(REAL)le.addrLong2)),
						 '');
	self.distphoneaddr2 := if(le.phoneLat != '' and le.addrLat2 != '',
						(string)round(ut.ll_dist((REAL)le.phoneLat,(REAL)le.phoneLong,(REAL)le.addrLat2,(REAL)le.addrLong2)),
						'');
	self.distphonephone2 := if(le.phoneLat != '' and le.phoneLat2 != '',
						 (string)round(ut.ll_dist((REAL)le.phoneLat,(REAL)le.phoneLong,(REAL)le.phoneLat2,(REAL)le.phoneLong2)), 
						 '');
	self.distaddraddr2 := if(le.addrLat != '' and le.addrLat2 != '',
						(string)round(ut.ll_dist((REAL)le.addrLat,(REAL)le.addrLong,(REAL)le.addrLat2,(REAL)le.addrLong2)), 
						'');
	self.distaddrphone2 := if(le.addrLat != '' and le.phoneLat2 != '',
						(string)round(ut.ll_dist((REAL)le.addrLat,(REAL)le.addrLong,(REAL)le.phoneLat2,(REAL)le.phoneLong2)),
						'');

	self := le;
end;

wDistances := project(rDirs2, add_distances(left));

final := project(wDistances, transform(layout_eddo, self := left));

return final;

end;