IMPORT STD, ADDRESS;
EXPORT saotDataSample() := FUNCTION

//src definition
//T1 = Business Credit Report
//T2 = Small Business Analytics
//T3 = Small Business Bip Combined Report 
//T4 = Small Business Risk
//T5 = Business Instant ID2
EndDate := STD.Date.CurrentDate(True);
BeginDate := EndDate - 10000;

infile1 := '~thor::bipheader::qa::SAOT::businesscreditreport_' + BeginDate + '-' + EndDate;
infile2 := '~thor::bipheader::qa::SAOT::smallbusinessanalytics_' + BeginDate + '-' + EndDate;
infile3 := '~thor::bipheader::qa::SAOT::smallbizbipcombinedrpt_' + BeginDate + '-' + EndDate;
infile4 := '~thor::bipheader::qa::SAOT::smallbusinessrisk_' + BeginDate + '-' + EndDate;
infile5 := '~thor::bipheader::qa::SAOT::business_instantid2_' + BeginDate + '-' + EndDate;

SAMPLER_LAYOUT := RECORD
	  STRING120 company_name,
	  STRING10 prim_range,
	  STRING28 prim_name,
	  STRING8 sec_range,
	  STRING25 city,
	  STRING2 state,
	  STRING5 zip5,
	  UNSIGNED3 zip_radius_miles := 0;
	  STRING10 phone10,
	  STRING9 fein,
	  STRING80 url,
	  STRING60 email,
	  STRING20 contact_fname,
	  STRING20 contact_mname,
	  STRING20 contact_lname,
	  STRING9 contact_ssn,
	  UNSIGNED6 contact_did,
	  STRING8 sic_code,
	  STRING2 source,
	  UNSIGNED8 source_record_id,
	  UNSIGNED6 proxid,
	  UNSIGNED6 seleid
 END;

//SAOT Business Credit Report Layout
 SAOT_BCR_LAYOUT := RECORD
  string transactionid;
  string20 login_id;
  string8 transactiondate;
  string incompanyname;
  string inalternatecompanyname;
  unsigned6 indotid;
  unsigned6 inempid;
  unsigned6 inpowid;
  unsigned6 inproxid;
  unsigned6 inseleid;
  unsigned6 inorgid;
  unsigned6 inultid;
  string incompanystreetnumber;
  string incompanystreetname;
  string incompanyunitnumber;
  string incompanystreetaddress1;
  string incompanystreetaddress2;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanystatecityzip;
  unsigned6 inzipradius;
  string incompanyphone;
  string incompanyfein;
  string inemail;
  string inrep1firstname;
  string inrep1lastname;
  string inrep1streetaddress1;
  string inrep1city;
  string inrep1state;
  string inrep1zip5;
  string inrep1ssn;
  string inrep1dob;
  string inrep1dl;
  string inrep1dlstate;
  string inrep1phone;
  unsigned6 bestdotid;
  unsigned6 bestempid;
  unsigned6 bestpowid;
  unsigned6 bestproxid;
  unsigned6 bestseleid;
  unsigned6 bestorgid;
  unsigned6 bestultid;
  string bestcompanyname;
  string bestcompanystreetnumber;
  string bestcompanystreetname;
  string bestcompanyunitnumber;
  string bestcompanystreetaddress1;
  string bestcompanystreetaddress2;
  string bestcompanycity;
  string bestcompanystate;
  string bestcompanyzip5;
  string bestcompanystatecityzip;
  string bestcompanyphone;
 END; 
 ds_bcr := dataset(infile1, SAOT_BCR_LAYOUT, THOR);
 
 pj_bcr_s := project(ds_bcr, transform(SAMPLER_LAYOUT, 
  self.proxid := left.inproxid;
  self.seleid := left.inseleid;
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.contact_fname := left.inrep1firstname;
  self.contact_lname :=left.inrep1lastname;
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress1);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.city:= TRIM(sAddress[65..89]);
  SELF.state:= TRIM(sAddress[115..116]);
  SELF.zip5:= TRIM(sAddress[117..121]);                                   
	self.source := 'T1';
  self.fein := left.incompanyfein;
  self.phone10 := left.incompanyphone;
  self := [];));	

//Small Business Analytics			
SAOT_SBA_Layout := RECORD
  string transactionid;
  string20 login_id;
  string8 transactiondate;
  string incompanyname;
  string inalternatecompanyname;
  string incompanystreetaddress1;
  string incompanystreetaddress2;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanyphone;
  string incompanyfein;
  string incompanysic;
  string inrep1firstname;
  string inrep1lastname;
  string inrep1streetaddress1;
  string inrep1city;
  string inrep1state;
  string inrep1ssn;
  string inrep1dob;
  string inrep1dl;
  string inrep1dlstate;
  string inrep1phone;
 END;
ds_sba := dataset(infile2, SAOT_SBA_Layout, thor);

pj_sba_s := project(ds_sba, transform(	SAMPLER_LAYOUT,
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.contact_fname := left.inrep1firstname;
  self.contact_lname :=left.inrep1lastname;
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress1);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.city:= TRIM(sAddress[65..89]);
  SELF.state:= TRIM(sAddress[115..116]);
  SELF.zip5:= TRIM(sAddress[117..121]);                                   
	self.source := 'T2';
  self.fein := left.incompanyfein;
  self.phone10 := left.incompanyphone;
  self := [];));


//Small Business BIP Combined Report
SAOT_SBB_Layout := RECORD
  string transactionid;
  string20 login_id;
  string8 transactiondate;
  string incompanyname;
  string inalternatecompanyname;
  unsigned6 indotid;
  unsigned6 inempid;
  unsigned6 inpowid;
  unsigned6 inproxid;
  unsigned6 inseleid;
  unsigned6 inorgid;
  unsigned6 inultid;
  string incompanystreetnumber;
  string incompanystreetname;
  string incompanyunitnumber;
  string incompanystreetaddress1;
  string incompanystreetaddress2;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanystatecityzip;
  unsigned6 inzipradius;
  string incompanyphone;
  string incompanyfein;
  string incompanysic;
  string inemail;
  string inrep1firstname;
  string inrep1lastname;
  string inrep1streetaddress1;
  string inrep1city;
  string inrep1state;
  string inrep1zip5;
  string inrep1ssn;
  string inrep1dob;
  string inrep1dl;
  string inrep1dlstate;
  string inrep1phone;
  unsigned6 bestdotid;
  unsigned6 bestempid;
  unsigned6 bestpowid;
  unsigned6 bestproxid;
  unsigned6 bestseleid;
  unsigned6 bestorgid;
  unsigned6 bestultid;
  string bestcompanyname;
  string bestcompanystreetnumber;
  string bestcompanystreetname;
  string bestcompanyunitnumber;
  string bestcompanystreetaddress1;
  string bestcompanystreetaddress2;
  string bestcompanycity;
  string bestcompanystate;
  string bestcompanyzip5;
  string bestcompanystatecityzip;
  string bestcompanyphone;
 END;
 ds_sbbc := dataset(infile3, SAOT_SBB_Layout, thor);
 
  pj_sbbc_s := project(ds_sbbc, transform(SAMPLER_LAYOUT, 
  self.proxid := left.inproxid;
  self.seleid := left.inseleid;
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.contact_fname := left.inrep1firstname;
  self.contact_lname :=left.inrep1lastname;
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress1);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.city:= TRIM(sAddress[65..89]);
  SELF.state:= TRIM(sAddress[115..116]);
  SELF.zip5:= TRIM(sAddress[117..121]);                                   
	self.source := 'T3';
  self.fein := left.incompanyfein;
  self.phone10 := left.incompanyphone;
  self := [];));	


//Small Business Risk 
SAOT_SBR_Layout := RECORD
  string transactionid;
  string20 login_id;
  string8 transactiondate;
  string incompanyname;
  string inalternatecompanyname;
  string incompanystreetaddress1;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanyphone;
  string incompanyfein;
  string inrep1name;
  string inrep1ssn;
  string inrep1dob;
  string inrep1dl;
  string inrep1dlstate;
  string inrep1phone;
 END;
 
ds_sbr := dataset(infile4, SAOT_SBR_Layout, thor);

pj_sbr_s := project(ds_sbr, transform(SAMPLER_LAYOUT,
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress1);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.city:= TRIM(sAddress[65..89]);
  SELF.state:= TRIM(sAddress[115..116]);
  SELF.zip5:= TRIM(sAddress[117..121]);                                   
	self.source := 'T4';
  self.fein := left.incompanyfein;
  self.phone10 := left.incompanyphone;
  self := [];));

//BIID2
SAOT_BIID2_Layout := RECORD
  string transactionid;
  string10 accountid;
  string20 login_id;
  string8 transactiondate;
  string endusercompanyname;
  string referencecode;
  string biid20producttype;
  string globalwatchlistthreshold;
  string watchlistsrequested;
  string dobradius;
  string exactaddrmatch;
  string exactdobmatch;
  string exactdriverlicensematch;
  string exactfirstnamematch;
  string exactfirstnamematchallownicknames;
  string exactlastnamematch;
  string exactphonematch;
  string exactssnmatch;
  string excludewatchlists;
  string includeadditionalwatchlists;
  string includecloverride;
  string includedlverification;
  string includedobincvi;
  string includedpbc;
  string includedriverlicenseincvi;
  string includemioverride;
  string includemsoverride;
  string includeofac;
  string lastseenthreshold;
  string nameinputorder;
  string poboxcompliance;
  string usedobfilter;
  string incompanyname;
  string inalternatecompanyname;
  string incompanystreetaddress;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanyphone;
  string incompanyfein;
  string inrep1firstname;
  string inrep1lastname;
  string inrep1streetaddress;
  string inrep1city;
  string inrep1state;
  string inrep1zip5;
  string inrep1ssn;
  string inrep1dob;
  string inrep1phone;
  string inrep1dl;
  string inrep1dlstate;
  string inrep2firstname;
  string inrep2lastname;
  string inrep2streetaddress;
  string inrep2city;
  string inrep2state;
  string inrep2zip5;
  string inrep2ssn;
  string inrep2dob;
  string inrep2phone;
  string inrep2dl;
  string inrep2dlstate;
  string inrep3firstname;
  string inrep3lastname;
  string inrep3streetaddress;
  string inrep3city;
  string inrep3state;
  string inrep3zip5;
  string inrep3ssn;
  string inrep3dob;
  string inrep3phone;
  string inrep3dl;
  string inrep3dlstate;
  string inrep4firstname;
  string inrep4lastname;
  string inrep4streetaddress;
  string inrep4city;
  string inrep4state;
  string inrep4zip5;
  string inrep4ssn;
  string inrep4dob;
  string inrep4phone;
  string inrep4dl;
  string inrep4dlstate;
  string inrep5firstname;
  string inrep5lastname;
  string inrep5streetaddress;
  string inrep5city;
  string inrep5state;
  string inrep5zip5;
  string inrep5ssn;
  string inrep5dob;
  string inrep5phone;
  string inrep5dl;
  string inrep5dlstate;
  string numbervalidauthrepsinput;
  string companyseleid;
  string vercompanyname;
  string vercompanyaddr;
  string vercompanycity;
  string vercompanystate;
  string vercompanyzip;
  string vercompanyphone;
  string vercompanyfein;
  string companybusinessverificationindex;
  string companybusinessverificationdesc;
  string companypri_seq1;
  string companypri_code1;
  string companypri_desc1;
  string companypri_seq2;
  string companypri_code2;
  string companypri_desc2;
  string companypri_seq3;
  string companypri_code3;
  string companypri_desc3;
  string companypri_seq4;
  string companypri_code4;
  string companypri_desc4;
  string companypri_seq5;
  string companypri_code5;
  string companypri_desc5;
  string companypri_seq6;
  string companypri_code6;
  string companypri_desc6;
  string companypri_seq7;
  string companypri_code7;
  string companypri_desc7;
  string companypri_seq8;
  string companypri_code8;
  string companypri_desc8;
  string companyresidentialdesc;
  string companyverisummary_type1;
  string companyverisummary_index1;
  string companyverisummary_desc1;
  string companyverisummary_type2;
  string companyverisummary_index2;
  string companyverisummary_desc2;
  string companyverisummary_type3;
  string companyverisummary_index3;
  string companyverisummary_desc3;
  string companyverisummary_type4;
  string companyverisummary_index4;
  string companyverisummary_desc4;
  string companyverisummary_type5;
  string companyverisummary_index5;
  string companyverisummary_desc5;
  string bustoexexindex_rep1;
  string bustoexexindex_index1;
  string bustoexexindex_desc1;
  string bustoexexindex_rep2;
  string bustoexexindex_index2;
  string bustoexexindex_desc2;
  string bustoexexindex_rep3;
  string bustoexexindex_index3;
  string bustoexexindex_desc3;
  string bustoexexindex_rep4;
  string bustoexexindex_index4;
  string bustoexexindex_desc4;
  string bustoexexindex_rep5;
  string bustoexexindex_index5;
  string bustoexexindex_desc5;
  string rep1uniqueid;
  string rep1cvi;
  string rep1nap;
  string rep1nas;
  string rep1ri_seq1;
  string rep1ri_code1;
  string rep1ri_desc1;
  string rep1ri_seq2;
  string rep1ri_code2;
  string rep1ri_desc2;
  string rep1ri_seq3;
  string rep1ri_code3;
  string rep1ri_desc3;
  string rep1ri_seq4;
  string rep1ri_code4;
  string rep1ri_desc4;
  string rep1ri_seq5;
  string rep1ri_code5;
  string rep1ri_desc5;
  string rep1ri_seq6;
  string rep1ri_code6;
  string rep1ri_desc6;
  string rep1ri_seq7;
  string rep1ri_code7;
  string rep1ri_desc7;
  string rep1ri_seq8;
  string rep1ri_code8;
  string rep1ri_desc8;
  string rep1ri_seq9;
  string rep1ri_code9;
  string rep1ri_desc9;
  string rep1ri_seq10;
  string rep1ri_code10;
  string rep1ri_desc10;
  string rep2uniqueid;
  string rep2cvi;
  string rep2nap;
  string rep2nas;
  string rep2ri_seq1;
  string rep2ri_code1;
  string rep2ri_desc1;
  string rep2ri_seq2;
  string rep2ri_code2;
  string rep2ri_desc2;
  string rep2ri_seq3;
  string rep2ri_code3;
  string rep2ri_desc3;
  string rep2ri_seq4;
  string rep2ri_code4;
  string rep2ri_desc4;
  string rep2ri_seq5;
  string rep2ri_code5;
  string rep2ri_desc5;
  string rep2ri_seq6;
  string rep2ri_code6;
  string rep2ri_desc6;
  string rep2ri_seq7;
  string rep2ri_code7;
  string rep2ri_desc7;
  string rep2ri_seq8;
  string rep2ri_code8;
  string rep2ri_desc8;
  string rep2ri_seq9;
  string rep2ri_code9;
  string rep2ri_desc9;
  string rep2ri_seq10;
  string rep2ri_code10;
  string rep2ri_desc10;
  string rep3uniqueid;
  string rep3cvi;
  string rep3nap;
  string rep3nas;
  string rep3ri_seq1;
  string rep3ri_code1;
  string rep3ri_desc1;
  string rep3ri_seq2;
  string rep3ri_code2;
  string rep3ri_desc2;
  string rep3ri_seq3;
  string rep3ri_code3;
  string rep3ri_desc3;
  string rep3ri_seq4;
  string rep3ri_code4;
  string rep3ri_desc4;
  string rep3ri_seq5;
  string rep3ri_code5;
  string rep3ri_desc5;
  string rep3ri_seq6;
  string rep3ri_code6;
  string rep3ri_desc6;
  string rep3ri_seq7;
  string rep3ri_code7;
  string rep3ri_desc7;
  string rep3ri_seq8;
  string rep3ri_code8;
  string rep3ri_desc8;
  string rep3ri_seq9;
  string rep3ri_code9;
  string rep3ri_desc9;
  string rep3ri_seq10;
  string rep3ri_code10;
  string rep3ri_desc10;
  string rep4uniqueid;
  string rep4cvi;
  string rep4nap;
  string rep4nas;
  string rep4ri_seq1;
  string rep4ri_code1;
  string rep4ri_desc1;
  string rep4ri_seq2;
  string rep4ri_code2;
  string rep4ri_desc2;
  string rep4ri_seq3;
  string rep4ri_code3;
  string rep4ri_desc3;
  string rep4ri_seq4;
  string rep4ri_code4;
  string rep4ri_desc4;
  string rep4ri_seq5;
  string rep4ri_code5;
  string rep4ri_desc5;
  string rep4ri_seq6;
  string rep4ri_code6;
  string rep4ri_desc6;
  string rep4ri_seq7;
  string rep4ri_code7;
  string rep4ri_desc7;
  string rep4ri_seq8;
  string rep4ri_code8;
  string rep4ri_desc8;
  string rep4ri_seq9;
  string rep4ri_code9;
  string rep4ri_desc9;
  string rep4ri_seq10;
  string rep4ri_code10;
  string rep4ri_desc10;
  string rep5uniqueid;
  string rep5cvi;
  string rep5nap;
  string rep5nas;
  string rep5ri_seq1;
  string rep5ri_code1;
  string rep5ri_desc1;
  string rep5ri_seq2;
  string rep5ri_code2;
  string rep5ri_desc2;
  string rep5ri_seq3;
  string rep5ri_code3;
  string rep5ri_desc3;
  string rep5ri_seq4;
  string rep5ri_code4;
  string rep5ri_desc4;
  string rep5ri_seq5;
  string rep5ri_code5;
  string rep5ri_desc5;
  string rep5ri_seq6;
  string rep5ri_code6;
  string rep5ri_desc6;
  string rep5ri_seq7;
  string rep5ri_code7;
  string rep5ri_desc7;
  string rep5ri_seq8;
  string rep5ri_code8;
  string rep5ri_desc8;
  string rep5ri_seq9;
  string rep5ri_code9;
  string rep5ri_desc9;
  string rep5ri_seq10;
  string rep5ri_code10;
  string rep5ri_desc10;
 END;
 
 ds_biid2 := dataset(infile5, SAOT_BIID2_Layout, thor);
  pj_biid2_s := project(ds_biid2, transform(SAMPLER_LAYOUT, 
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.contact_fname := left.inrep1firstname;
  self.contact_lname :=left.inrep1lastname;
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.city:= TRIM(sAddress[65..89]);
  SELF.state:= TRIM(sAddress[115..116]);
  SELF.zip5:= TRIM(sAddress[117..121]);                                   
	self.source := 'T5';
  self.fein := left.incompanyfein;
  self.phone10 := left.incompanyphone;
  self := [];));	

SAOT_data := ENTH(pj_bcr_s,10000) + ENTH(pj_sba_s,10000) + ENTH(pj_sbbc_s,10000) + ENTH(pj_sbr_s,10000) + ENTH(pj_biid2_s,10000);

RETURN SEQUENTIAL(PARALLEL(  
											BizLinkFull_QA.smallBusinessRisk(),
											BizLinkFull_QA.smallBusinessAnalytics(), 
											BizLinkFull_QA.smallBizBIPCombinedRpt(), 
											BizLinkFull_QA.businessCreditReport(), 
											BizLinkFull_QA.businessInstantID2()
													),
										OUTPUT(SAOT_data,, '~thor::bipheader::qa::saotDataSample', THOR, OVERWRITE, COMPRESSED)
									);

END;
