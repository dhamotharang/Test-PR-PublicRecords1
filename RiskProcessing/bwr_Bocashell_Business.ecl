#workunit('name','Business Bocashell Process');
#option ('hthorMemoryLimit', 1000)


import business_risk;

bus_in := record
     string30  AccountNumber := '';
	 string100 CompanyName := '';
	 string100 AlternateCompanyName := '';
     string50  Addr := '';
     string30  City := '';
     string2   State := '';
     string9   Zip := '';
     string10  BusinessPhone := '';
     string9   TaxIdNumber := '';
	 string16  BusinessIPAddress := '';
     string15  Representativefirstname := '';
	 string15  RepresentativeMiddleName := '';
     string20  Representativelastname := '';
	 string5   RepresentativeNameSuffix := '';
     string50  RepresentativeAddr := '';
     string30  RepresentativeCity := '';
     string2   RepresentativeState := '';
     string9   RepresentativeZip := '';
     string9   RepresentativeSSN := '';
     string8   RepresentativeDOB := '';
	 string3   RepresentativeAge := '';
     string20  RepresentativeDLNumber := '';
     string2   RepresentativeDLState := '';
	 string10  RepresentativeHomePhone := '';
     string50  RepresentativeEmailAddress := '';
	 string20  RepresentativeFormerLastName := '';
	 integer   historydateyyyymm;
end;

// f := dataset('~tfuerstenberg::in::wells_busdiradd_bus_in', bus_in, csv(quote('"')));
f := choosen(dataset('~tfuerstenberg::in::wells_busdir_bus_in', bus_in, csv(quote('"'))),5);
output(f);

Layout_Business_Shell_Input := record
	unsigned  seq;
	string	AccountNumber;
	string	BDID;
	string	CompanyName;
	string	AlternateCompanyName;
	string	Addr;
	string	City;
	string	State;
	string	Zip;
	string	BusinessPhone;
	string	TaxIdNumber;
	string	BusinessIPAddress;
	string	RepresentativeFirstName;
	string	RepresentativeMiddleName;
	string	RepresentativeLastName;
	string	RepresentativeNameSuffix;
	string	RepresentativeAddr;
	string	RepresentativeCity;
	string	RepresentativeState;
	string	RepresentativeZip;
	string	RepresentativeSSN;
	string	RepresentativeDOB;
	string	RepresentativeAge;
	string	RepresentativeDLNumber;
	string	RepresentativeDLState;
	string	RepresentativeHomePhone;
	string	RepresentativeEmailAddress;
	string 	RepresentativeFormerLastName;
	unsigned1	DPPAPurpose;
	unsigned1	GLBPurpose;
	integer historydateyyyymm;
end;
// populate the input values to business instant id with the original input values
Layout_Business_Shell_Input into_bus_input(f le, integer C) := transform
	self.seq := C;
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.historydateyyyymm := le.historydateyyyymm;
	// self.historydateyyyymm := 999999;
	self := le;
	self := [];
end;

indata := project(f,into_bus_input(LEFT, counter));
output(indata);

roxieIP :='http://roxiethorvip.hpcc.risk.regn.net:9856';  // roxiebatch

business_risk.Layout_Business_Shell myFail(indata le) :=	TRANSFORM
	self.biid.seq := le.seq;
	self.biid.account := le.accountnumber;
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := [];
END;

resu := soapcall(indata, roxieIP,
			  'Business_Risk.Business_Shell', {indata},
			  DATASET(business_risk.Layout_Business_Shell),
			  PARALLEL(30), onFail(myFail(LEFT)));

output(resu);

	  
business_risk.Layout_Business_Shell_Flat flatten(resu le) := transform
	self.biid.seq := (string)le.biid.seq;
	self.biid.bdid := (string)le.biid.bdid;
	self.biid.score := (string)le.biid.score;
	self.biid.vernotrecentflag := if(le.biid.vernotrecentflag, '1', '0');
	self.biid.feinscore := (string)le.biid.feinscore ;
	self.biid.addrscore := (string)le.biid.addrscore ;
	self.biid.phonescore := (string)le.biid.phonescore ;
	self.biid.cnamescore := (string)le.biid.cnamescore ;
	self.biid.addrmiskeyflag := if(le.biid.addrmiskeyflag, '1', '0');
	self.biid.cmpymiskeyflag := if(le.biid.cmpymiskeyflag, '1', '0') ;
	self.biid.cmpyfound := (string)le.biid.cmpyfound ;
	self.biid.addrfound := (string)le.biid.addrfound ;
	self.biid.phonefound := (string)le.biid.phonefound ;
	self.biid.phonecmpycount := (string)le.biid.phonecmpycount ;
	self.biid.phoneaddrcount := (string)le.biid.phoneaddrcount ;
	self.biid.cmpyaddrcount := (string)le.biid.cmpyaddrcount ;
	self.biid.phonecmpyaddrcount := (string)le.biid.phonecmpyaddrcount ;
	self.biid.phonemiskeyflag := if(le.biid.phonemiskeyflag, '1', '0') ;
	self.biid.feinmiskeyflag := if(le.biid.feinmiskeyflag, '1', '0') ;
	self.biid.multisrcaddr := if(le.biid.multisrcaddr, '1', '0') ;
	self.biid.multisrcaddrp := if(le.biid.multisrcaddrp, '1', '0') ;
	self.biid.multisrccmpy := if(le.biid.multisrccmpy, '1', '0') ;
	self.biid.multisrccmpyp := if(le.biid.multisrccmpyp, '1', '0') ;
	self.biid.bestcompanynamescore := (string)le.biid.bestcompanynamescore ;
	self.biid.bestaddrscore := (string)le.biid.bestaddrscore ;
	self.biid.bestfeinscore := (string)le.biid.bestfeinscore ;
	self.biid.bestphonescore := (string)le.biid.bestphonescore ;
	self.biid.phonedisflag := if(le.biid.phonedisflag, '1', '0') ;
	self.biid.phonezipmismatch := if(le.biid.phonezipmismatch , '1', '0');
	self.biid.bkfeinflag := if(le.biid.bkfeinflag, '1', '0') ;
	self.biid.bkbdidflag := if(le.biid.bkbdidflag, '1', '0') ;
	self.biid.bankruptcy_count := (string)le.biid.bankruptcy_count ;
	self.biid.lienbdidflag := if(le.biid.lienbdidflag, '1', '0') ;
	self.biid.unreleasedliencount  := (string)le.biid.unreleasedliencount ;
	self.biid.releasedliencount := (string)le.biid.releasedliencount ;
	self.biid.numucc := (string)le.biid.numucc ;
	self.biid.lien_total := (string)le.biid.lien_total ;
	self.biid.dt_first_seen_min := (string)le.biid.dt_first_seen_min ;
	self.biid.dt_last_seen_max := (string)le.biid.dt_last_seen_max ;
	self.biid.repdid := (string)le.biid.repdid ;
	self.biid.dist_homeaddr_busaddr := (string)le.biid.dist_homeaddr_busaddr ;
	self.biid.dist_homephone_busphone := (string)le.biid.dist_homephone_busphone ;
	self.biid.dist_homeaddr_busphone := (string)le.biid.dist_homeaddr_busphone ;
	self.biid.dist_homephone_busaddr := (string)le.biid.dist_homephone_busaddr ;
	self.biid.dist_homephone_homeaddr := (string)le.biid.dist_homephone_homeaddr ;
	self.biid.dist_busphone_busaddr := (string)le.biid.dist_busphone_busaddr ;
	self.biid.hist_date_last_seen_1 := (string)le.biid.hist_date_last_seen_1 ;
	self.biid.hist_date_last_seen_2 := (string)le.biid.hist_date_last_seen_2 ;
	self.biid.hist_date_last_seen_3 := (string)le.biid.hist_date_last_seen_3 ;
	self.biid.rep_socsmiskeyflag := if(le.biid.rep_socsmiskeyflag, '1', '0');
	self.biid.rep_phonemiskeyflag := if(le.biid.rep_phonemiskeyflag, '1', '0');
	self.biid.rep_addrmiskeyflag := if(le.biid.rep_addrmiskeyflag, '1', '0');
	self.biid.rep_firstcount := (string)le.biid.rep_firstcount;
	self.biid.rep_lastcount := (string)le.biid.rep_lastcount;
	self.biid.rep_addrcount := (string)le.biid.rep_addrcount;
	self.biid.rep_hphonecount := (string)le.biid.rep_hphonecount;
	self.biid.rep_ssncount := (string)le.biid.rep_ssncount;
	self.biid.rep_dobcount := (string)le.biid.rep_dobcount;
	self.biid.rep_numelever := (string)le.biid.rep_numelever ;
	self.biid.rep_header_firstcount := (string)le.biid.rep_header_firstcount ;
	self.biid.rep_header_lastcount := (string)le.biid.rep_header_lastcount ;
	self.biid.rep_header_addrcount := (string)le.biid.rep_header_addrcount ;
	self.biid.rep_header_ssncount := (string)le.biid.rep_header_ssncount ;
	self.biid.addrcount := (string)le.biid.addrcount ;
	self.biid.cmpycount := (string)le.biid.cmpycount ;
	self.biid.feincount := (string)le.biid.feincount ;
	self.biid.wphonecount := (string)le.biid.wphonecount ;
	self.biid.rep_dirsaddr_lastscore := (string)le.biid.rep_dirsaddr_lastscore ;
	self.biid.rep_firstscore := (string)le.biid.rep_firstscore ;
	self.biid.rep_lastscore := (string)le.biid.rep_lastscore ;
	self.biid.rep_addrscore := (string)le.biid.rep_addrscore ;
	self.biid.rep_phonescore := (string)le.biid.rep_phonescore ;
	self.biid.rep_socsscore := (string)le.biid.rep_socsscore ;
	self.biid.rep_dobscore := (string)le.biid.rep_dobscore ;
	self.biid.rep_phonedissflag := if(le.biid.rep_phonedissflag, '1', '0') ;
	self.biid.bestfein_flag := if(le.biid.bestfein_flag, '1', '0') ;
	self.biid.repbestssn_flag := if(le.biid.repbestssn_flag, '1', '0');
	self.biid.repbestlname_flag := if(le.biid.repbestlname_flag, '1', '0');
	self.biid.repbestlname_alt_flag := if(le.biid.repbestlname_alt_flag, '1', '0');
	self.biid.repssnexists := if(le.biid.repssnexists, '1', '0');
	self.biid.rep_inputAddrNotMostRecent := if(le.biid.rep_inputAddrNotMostRecent, '1', '0');		
	
	self.prs.bdid_per_addr := (string)le.prs.bdid_per_addr;
	self.prs.apts := (string)le.prs.apts;
	self.prs.ppl := (string)le.prs.ppl;
	self.prs.r_phone_per_addr := (string)le.prs.r_phone_per_addr;
	self.prs.b_phone_per_addr := (string)le.prs.b_phone_per_addr;
	self.prs.dnb_emps := (string)le.prs.dnb_emps;
	self.prs.irs5500_emps := (string)le.prs.irs5500_emps;
	self.prs.domainss := (string)le.prs.domainss;
	// self.prs.sources := (string)le.prs.sources;
	// self.prs.company_name_score := (string)le.prs.company_name_score;
	// self.prs.combined_score := (string)le.prs.combined_score;
	// self.prs.gong_yp_cnt := (string)le.prs.gong_yp_cnt;
	// self.prs.current_corp_cnt := (string)le.prs.current_corp_cnt;
	self.prs.dt_first_seen_min := (string)le.prs.dt_first_seen_min;   // min for all base records
	self.prs.dt_last_seen_max := (string)le.prs.dt_last_seen_max;    // max for all base records
	self.prs.dt_vendor_first_reported_min := (string)le.prs.dt_vendor_first_reported_min; // min for all base records
	self.prs.dt_first_seen_Y := (string)le.prs.dt_first_seen_Y; // min for a current YP record
	self.prs.dt_last_seen_Y := (string)le.prs.dt_last_seen_Y; // max for a current YP record
	self.prs.dt_first_seen_G := (string)le.prs.dt_first_seen_G;// min for a current Gong record
	self.prs.dt_last_seen_G := (string)le.prs.dt_last_seen_G;// max for a current Gong record
	self.prs.dt_first_seen_C := (string)le.prs.dt_first_seen_C;// min for a Corporate record
	self.prs.dt_last_seen_C := (string)le.prs.dt_last_seen_C;// max for a Corporate record
	self.prs.dt_first_seen_BR := (string)le.prs.dt_first_seen_BR;// min for a Business Registration record
	self.prs.dt_last_seen_BR := (string)le.prs.dt_last_seen_BR;// max for a Business Registration record
	self.prs.dt_first_seen_UCC := (string)le.prs.dt_first_seen_UCC;// min for a UCC record
	self.prs.dt_last_seen_UCC := (string)le.prs.dt_last_seen_UCC;// max for a UCC record
	self.prs.dt_first_seen_D := (string)le.prs.dt_first_seen_D;// min for a D&B record
	self.prs.dt_last_seen_D := (string)le.prs.dt_last_seen_D;// max for a D&B record
	self.prs.dt_first_seen_I := (string)le.prs.dt_first_seen_I;// min for a IRS5500 record
	self.prs.dt_last_seen_I := (string)le.prs.dt_last_seen_I;// max for a IRS5500 record
	self.prs.dt_first_seen_ST := (string)le.prs.dt_first_seen_ST;// min for a Sales Tax record
	self.prs.dt_last_seen_ST := (string)le.prs.dt_last_seen_ST;// max for a Sales Tax record
	self.prs.dt_last_seen_B := (string)le.prs.dt_last_seen_B;// max for a Bankruptcy record
	self.prs.dt_last_seen_LJ := (string)le.prs.dt_last_seen_LJ;// max for a Liens Judgment record
	self.prs.dt_first_seen_BM := (string)le.prs.dt_first_seen_BM;// min for a BBB member record
	self.prs.dt_last_seen_BM := (string)le.prs.dt_last_seen_BM;// max for a BBB member record
	self.prs.dt_first_seen_BN := (string)le.prs.dt_first_seen_BN;// min for a BBB non-member record
	self.prs.dt_last_seen_BN := (string)le.prs.dt_last_seen_BN;// max for a BBB non-member record
	self.prs.dt_first_seen_IA := (string)le.prs.dt_first_seen_IA;// min for a InfoUSA record
	self.prs.dt_last_seen_IA := (string)le.prs.dt_last_seen_IA;// max for a InfoUSA record
	self.prs.dt_first_seen_DC := (string)le.prs.dt_first_seen_DC;// min for a DCA record
	self.prs.dt_last_seen_DC := (string)le.prs.dt_last_seen_DC;// max for a DCA record
	self.prs.dt_first_seen_EB := (string)le.prs.dt_first_seen_EB;// min for a Experian Business Header record
	self.prs.dt_last_seen_EB := (string)le.prs.dt_last_seen_EB;// max for a Experian Business Header record

	self.prs.gong_deletion_date := (string)le.prs.gong_deletion_date;
	self.prs.gong_disc_cnt6 := (string)le.prs.gong_disc_cnt6;
	self.prs.gong_disc_cnt12 := (string)le.prs.gong_disc_cnt12;
	self.prs.gong_disc_cnt18 := (string)le.prs.gong_disc_cnt18;
	// source record counts
	self.prs.cnt_base := (string)le.prs.cnt_base; // base record count
	self.prs.cnt_AE := (string)le.prs.cnt_AE; // Experian Vehicles
	self.prs.cnt_AF := (string)le.prs.cnt_AF; // ATF Firearms and Explosives
	self.prs.cnt_AT := (string)le.prs.cnt_AT; // Accurint Trade Show
	self.prs.cnt_AW := (string)le.prs.cnt_AW; // Watercraft
	self.prs.cnt_B  := (string)le.prs.cnt_B; // Bankruptcy
	self.prs.cnt_BM := (string)le.prs.cnt_BM; // BBBB Members
	self.prs.cnt_BN := (string)le.prs.cnt_BN; // BBB Non-Members
	self.prs.cnt_BR := (string)le.prs.cnt_BR; // Business Registration
	self.prs.cnt_C  := (string)le.prs.cnt_C; // Corporate
	self.prs.cnt_CU := (string)le.prs.cnt_CU; // Credit Unions
	self.prs.cnt_D  := (string)le.prs.cnt_D; // Dun & Bradstreet
	self.prs.cnt_DC := (string)le.prs.cnt_DC; // DCA - Directory of Corporate Affiliations
	self.prs.cnt_DE := (string)le.prs.cnt_DE; // DEA
	self.prs.cnt_E  := (string)le.prs.cnt_E; // Edgar
	self.prs.cnt_EB := (string)le.prs.cnt_EB; // Experian Business Header
	self.prs.cnt_ED := (string)le.prs.cnt_ED; // Employee Directories
	self.prs.cnt_F  := (string)le.prs.cnt_F; // Fictitious Business Names
	self.prs.cnt_FA := (string)le.prs.cnt_FA; // FAA Aircraft Registrations
	self.prs.cnt_FC := (string)le.prs.cnt_FC; // FCC Radio Licenses
	self.prs.cnt_FD := (string)le.prs.cnt_FD; // FDIC
	self.prs.cnt_FF := (string)le.prs.cnt_FF; // Florida FBN
	self.prs.cnt_FN := (string)le.prs.cnt_FN; // Florida Non-Profit
	self.prs.cnt_GB := (string)le.prs.cnt_GB; // Gong Business
	self.prs.cnt_GG := (string)le.prs.cnt_GG; // Gong Government
	self.prs.cnt_I  := (string)le.prs.cnt_I; // IRS 5500
	self.prs.cnt_IA := (string)le.prs.cnt_IA; // INFOUSA ABIUS(USABIZ)
	self.prs.cnt_ID := (string)le.prs.cnt_ID; // INFOUSA DEAD COMPANIES
	self.prs.cnt_IF := (string)le.prs.cnt_IF; // INFOUSA FBNS
	self.prs.cnt_II := (string)le.prs.cnt_II; // INFOUSA IDEXEC
	self.prs.cnt_IN := (string)le.prs.cnt_IN; // IRS Non-Profit
	self.prs.cnt_LJ := (string)le.prs.cnt_LJ; // Liens and Judgments
	self.prs.cnt_LB := (string)le.prs.cnt_LB; // Lobbyists
	self.prs.cnt_LP := (string)le.prs.cnt_LP; // LN Property
	self.prs.cnt_MD := (string)le.prs.cnt_MD; // Medical Information Directory
	self.prs.cnt_MV := (string)le.prs.cnt_MV; // Motor Vehicles
	self.prs.cnt_PL := (string)le.prs.cnt_PL; // Professional Licenses
	self.prs.cnt_PR := (string)le.prs.cnt_PR; // Property File
	self.prs.cnt_SB := (string)le.prs.cnt_SB; // SEC Broker/Dealer
	self.prs.cnt_SK := (string)le.prs.cnt_SK; // SK&A Medical Professionals
	self.prs.cnt_ST := (string)le.prs.cnt_ST; // State Sales Tax
	self.prs.cnt_U  := (string)le.prs.cnt_U; // UCC
	self.prs.cnt_V  := (string)le.prs.cnt_V; // Vickers
	self.prs.cnt_W  := (string)le.prs.cnt_W; // Domain Registrations (WHOIS)
	self.prs.cnt_WC := (string)le.prs.cnt_WC; // State Workers Comp
	self.prs.cnt_WT := (string)le.prs.cnt_WT; // Wither and Die
	self.prs.cnt_Y  := (string)le.prs.cnt_Y; // Yellow Pages
	self.prs.PRScore := (string)le.prs.PRScore;
	self.prs.PRScore_date := (string)le.prs.PRScore_date;
	self.prs.busreg_flag := (string)le.prs.busreg_flag;
	self.prs.corp_flag := (string)le.prs.corp_flag;
	self.prs.dnb_flag := (string)le.prs.dnb_flag;
	self.prs.irs5500_flag := (string)le.prs.irs5500_flag;
	self.prs.st_flag := (string)le.prs.st_flag;
	self.prs.ucc_flag := (string)le.prs.ucc_flag;
	self.prs.yp_flag := (string)le.prs.yp_flag;
	self.prs.tier1srcs := (string)le.prs.tier1srcs;
	self.prs.t1scr5 := (string)le.prs.t1scr5;
	self.prs.currphn := (string)le.prs.currphn;
	self.prs.currcorp := (string)le.prs.currcorp;
	self.prs.currbr := (string)le.prs.currbr;
	self.prs.currdnb := (string)le.prs.currdnb;
	self.prs.currucc := (string)le.prs.currucc;
	self.prs.curry := (string)le.prs.curry;
	self.prs.currt1cnt := (string)le.prs.currt1cnt;
	self.prs.currt1src4 := (string)le.prs.currt1src4;
	self.prs.year_lj := (string)le.prs.year_lj;
	self.prs.lj := (string)le.prs.lj;
	self.prs.ustic := (string)le.prs.ustic;
	self.prs.t1x := (string)le.prs.t1x;
	// self.prs.OFAC_cnt := (string)le.prs.OFAC_cnt;
	self.history_date := (string)le.history_date;
	
	self.biid.repFNameVerFlag	:= if(le.biid.repfnameverify<>'', 'Y', 'N');
	self.biid.repLNameVerFlag	:= if(le.biid.repLnameverify<>'', 'Y', 'N');
		
	self.biid := le.biid;
	self.prs := le.prs;
//	self.lf := '\n';
end;

final := project(resu, flatten(left));
output(final);
output(final,, '~tfuerstenberg::out::wells_busdiradd_bus_out',CSV(QUOTE('"')), overwrite);


err := record
	unsigned seq;
	string errorcode;
end;

errors := project(resu(errorcode<>''), transform(err, self.seq := left.biid.seq, self := left));
output(errors(errorcode<>''), named('errors'));

