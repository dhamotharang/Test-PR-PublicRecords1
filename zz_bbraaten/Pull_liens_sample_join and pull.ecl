// basefile: thor_data400::base::liens::main::Hogan

eyeball := 25;
eyeball_2 := 25;
orig_data_size := 100000;

full_lv2_key := choosen(LiensV2.key_liens_main_ID_FCRA, all);
output(choosen(full_lv2_key, eyeball), named('tmsid_rmsid_main_key'));
output(count(full_lv2_key), named('tmsid_rmsid_main_key_count'));

lv2_party_key := choosen(LiensV2.key_liens_party_ID, all);
output(choosen(lv2_party_key, eyeball), named('tmsid_rmsid_party_key'));
output(count(lv2_party_key), named('tmsid_rmsid_party_key_count'));

main_lay := recordof(full_lv2_key);

party_lay := record
  liensv2.layout_liens_party;
	BIPV2.IDlayouts.l_xlink_ids;
end;

add_field := record
		string filt_scenario;
		main_lay main;
		party_lay party;
end;

add_field append_all(main_lay le, party_lay ri) := transform
		self.main := le;
		self.party := ri;
		self.filt_scenario := [];
end;

full_lv2 := join(full_lv2_key, lv2_party_key, left.tmsid = right.tmsid and left.rmsid = right.rmsid, append_all(left, right) ) : persist('~nkoubsky::persist::lv2_full');
output(choosen(full_lv2, eyeball), named('tmsid_full_party_key'));
output(count(full_lv2), named('tmsid_rmsid_full_key_count'));

// /*
//**********************************************************************************************************************************

add_field append_filt(add_field le, string filter) := transform
		self.filt_scenario := filter;
		self := le;
end;


/*

// a1 
// a1 = Filter if Entity Type < > Individual **Don't know what field represents entity type

// a2
//Filter if file types =  {"AC", "AS", "BL", "BN", "BR", "BW", "CD", "DE", "DF", "FC", "FD", "FF", "FP", "GD", "GN", "GR", "HL", "HR", "HW", "KL", "KR", "KW", 
//"LP", "LR", "LW", "MC", "ML", "MM", "MO", "MW", "RD", "SZ", "TZ", "VF", "VG",“CE”, ”CR”, ”CT”, ”IE”, ”IL” or ”IR”}
a2_FileTypelist := ['AC','AS','BL','BN','BR','BW','CD','DE','DF','FC','FD','FF','FP','GD','GN','GR','HL','HR','HW','KL','KR','KW','LP','LR','LW','MC','ML','MM','MO','MW','RD','SZ','TZ','VF','VG','CE','CR','CT','IE','IL','IR'];
a2 := project(full_lv2(main.orig_filing_type in a2_FileTypelist), append_filt(left, 'a2'));
output(choosen(a2, eyeball), named('a2'));


// a3
//If Ffile type AJ/AR and not NY state court then set flag to false
a3_FileTypelist := ['AJ','AR'];
a3 := project(full_lv2(main.orig_filing_type in a3_FileTypelist and main.filing_jurisdiction <> 'NY'), append_filt(left, 'a3'));
output(choosen(a3, eyeball), named('a3'));


// a4
//Filter when State = “TX” and it is a civil file type and Plaintiff contains “ISD“, “SCHOOL DIST“ or “INDEPENDENT SCHOOL“
//interpreted civil file type = name_type = 'C'
// a4_PlaintiffList := ['ISD','SCHOOL DIST','INDEPENDENT SCHOOL']; //this is the code.
*/
ds_isn := full_lv2(Models.Common.Contains(party.orig_name, 'ISD'));
ds_school := full_lv2(Models.Common.Contains(party.orig_name, 'SCHOOL DIST'));
ds_indep := full_lv2(Models.Common.Contains(party.orig_name, 'INDEPENDENT SCHOOL'));

a4_PlaintiffList := ds_isn+ds_school+ds_indep;

// a4 := project(full_lv2(main.filing_jurisdiction = 'TX' and party.orig_name in a4_PlaintiffList and party.name_type = 'C'), append_filt(left, 'a4'));
a4 := project(a4_PlaintiffList(main.filing_jurisdiction = 'TX' and party.name_type = 'C'), append_filt(left, 'a4'));
output(choosen(a4, eyeball), named('a4'));

/*
// a5
//Should we add wildcard"%" for items that contain "city of" etc.
//Filter if State = “OH” and File Type = "CJ”, “CS”, “RL”, “RM”, “RS”, “SC” or “VJ" and Plaintiff contains "CITY CARLISLE", "CITY OF", "CITY SPRINGFILED", 
//"COUNTY OF", "DEPARTMENT OF TRANS", "DEPT OF TRANS" or "DOT"
a5_PlaintiffList := ['CITY CARLISLE', 'CITY OF', 'CITY SPRINGFILED', 'COUNTY OF', 'DEPARTMENT OF TRANS', 'DEPT OF TRANS','DOT'];
a5_FileTypelist:= ['CJ','CS','RL','RM','RS','SC','VJ'];
a5 := project(full_lv2(main.filing_jurisdiction = 'OH' and party.orig_name in a5_PlaintiffList and main.orig_filing_type in a5_FileTypelist), append_filt(left, 'a5'));
output(choosen(a5, eyeball), named('a5'));


// a6
//Filter when State = “OH” and File Type = “CJ” or “RL” and Plaintiff contains “TREASURER”
a6_FileTypelist:= ['CJ','RL'];
a6 := project(full_lv2(main.filing_jurisdiction = 'OH' and party.orig_name ='TREASURER' and main.orig_filing_type in a6_FileTypelist), append_filt(left, 'a6'));
output(choosen(a6, eyeball), named('a6'));


// a7
//Filter when Plaintiff  contains “BAIL BOND“
a7 := project(full_lv2(party.orig_name ='BAILBOND'), append_filt(left, 'a7'));
output(choosen(a7, eyeball), named('a7'));


// a8
//Filter if File Type = ‘CJ”, “RL”, “RS” or “SC” and Plaintiff contains “SLC CORP“ or “SALT LAKE CITY CORP “
a8_PlaintiffList := ['SLC CORP','SALT LAKE CITY CORP'];
a8_FileTypelist:= ['CJ','RL','RS','SC'];
a8 := project(full_lv2( main.orig_filing_type in a8_FileTypelist and party.orig_name in a8_PlaintiffList), append_filt(left, 'a8'));
output(choosen(a8, eyeball), named('a8'));


// a9
//Filter for MNHEND1 and File Type = ‘CJ”, “RL”, “RS” or “SC” and Plaintiff contains “GOLDBERG BONDING“
a9_FileTypelist := ['CJ','RL','RS','SC'];
a9 := project(full_lv2(main.filing_jurisdiction = 'MNHEND1' and party.orig_name ='GOLDBERG BONDING' and main.orig_filing_type in a9_FileTypelist), append_filt(left, 'a9'));
output(choosen(a9, eyeball), named('a9'));


// a10
//Filter if Street Name contains "GENERAL DELIVERY", "GENERAL POST" or if Street Name is blank or “NA”
a10_StreetAddressList := ['GENERAL DELIVERY','GENERAL POST','','NA'];
a10 := project(full_lv2(party.orig_address1 in a10_StreetAddressList or party.orig_address2 in a10_StreetAddressList), append_filt(left, 'a10'));
output(choosen(a10, eyeball), named('a10'));


// a11
//Filter if Address Number is blank and Street Name doesn't contain "BOX" or "DRAWER"
//Need help identifying Blank and NA values
a11_StreetAddressList := ['BOX','DRAWER'];
a11 := project(full_lv2(party.orig_address1 not in a11_StreetAddressList or party.orig_address2 not in a11_StreetAddressList), append_filt(left, 'a11'));
output(choosen(a11, eyeball), named('a11'));


// a12
//Filter if City is blank or “NA”
a12 := project(full_lv2(party.orig_city = '' or party.orig_city = 'NA'), append_filt(left, 'a12'));
output(choosen(a12, eyeball), named('a12'));


//a14
//Filter if Action Date < 81 months or Filing Date < 81 months for TaxLienRelease or JudgmentRelease
//Need to update for proper date filtering yet.
a14_TodaysDate := ut.GetDate;
a14_FilingMonthsApart := ut.MonthsApart(a14_TodaysDate,full_lv2(main.filing_date));
a14_ReleaseMonthsApart := ut.MonthsApart(a14_TodaysDate,full_lv2(main.release_date));
a14 := project(full_lv2(a14_FilingMonthsApart < 81 or a14_ReleaseMonthsApart < 81), append_filt(left, 'a14'));
output(choosen(a14, eyeball), named('a14'));


// a14
// Filter if Action Date < 81 months or Filing Date < 81 months for TaxLienRelease or JudgmentRelease
// Need to update for proper date filtering yet.
// a14_TodaysDate := ut.GetDate;
// a14 := project(full_lv2(ut.MonthsApart(a14_TodaysDate,main.filing_date) < 81 or ut.MonthsApart(a14_TodaysDate,main.release_date) < 81), append_filt(left, 'a14'));
// output(choosen(a14, eyeball), named('a14'));

// b1
//Filter if Cause of Action “LANDLORD_TENANT_DISPUTE“ or EvictionIndicator is set to True
//Not sure what "Cause of Action field would be".  EvictionIndicator = eviction field
b1 := project(full_lv2(main.eviction = 'Y'), append_filt(left, 'b1'));
output(choosen(b1, eyeball), named('b1'));


// b2
//Filter if File Type = “CJ”, ”RL”, ”RS”, ”SC” or ”VJ” and Cause of Action = “TRAFFIC”
b2_FileTypelist:= ['CJ','RL','RS','SC','VJ'];
b2 := project(full_lv2(main.orig_filing_type in b2_FileTypelist), append_filt(left, 'b2'));
output(choosen(b2, eyeball), named('b2'));


// b3
//Filter civil cases when State = “TX” and Cause of Action = “TAX_JUDGEMENT“
b3 := project(full_lv2(main.filing_jurisdiction = 'TX'), append_filt(left, 'b3'));
output(choosen(b3, eyeball), named('b3'));


// b4
//Filter for "AJ,AR,CF,CJ,CS,FR,FT,RL,RM,RS,SC,SR,ST,TW,WR" file types with amount < 50 except for Satisfactions 
//and Releases that update previously reported Judgments and Tax Lien Records (AR, FR, RL, RM, RS, SR, WR)
b4_FileTypelist:= ['AJ','AR','CF','CJ','CS','FR','FT','RL','RM','RS','SC','SR','ST','TW','WR'];
b4 := project(full_lv2(main.orig_filing_type in b4_FileTypelist and main.amount <'50'), append_filt(left, 'b4'));
output(choosen(b4, eyeball), named('b4'));


// b5
// Filter if Cause of Action = “COSTS_ONLY“

// tbl_lay := record
		// full_lv2.main.filing_type_desc;
		// _count := count(group);
// end;

// tbl := table(full_lv2, tbl_lay, main.filing_type_desc);
// output(tbl);

// 

*/