import ut, codes, address, business_risk, Risk_Indicators,gateway, Royalty, MDR;

export PB1O_Function(DATASET(Layout_PB1I) indata, dataset(Gateway.Layouts.Config) gateways, 
						unsigned1 glb, unsigned1 dppa, boolean isUtility=false, boolean ln_branded=false,
						string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
						string50 DataPermission=risk_indicators.iid_constants.default_DataPermission, OFACversion = 1) := function
	
// populate the input values to business instant id with the original input values
business_risk.Layout_Input into_bus_input(indata le) := transform
	self.seq := le.seq;
	self.historydate := le.historydate;
	clean_cmpy_addr := risk_indicators.MOD_AddressClean.clean_addr(le.cmpyaddr, le.cmpycity, le.cmpystate, le.cmpyzip) ;
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip) ;
	
	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.cmpyphone1 );
	dob_val := cleanDOB(le.dob);
	dl_num_clean := cleanDL_num( le.drlc );
	fein_val := cleanFEIN( le.fein );
		
	self.Account := le.account; 
	self.bdid	:= 0;  
	self.score := 0;  
	self.company_name := stringlib.stringtouppercase(le.cmpy);
	self.alt_company_name := stringlib.stringtouppercase(le.dbaname);
	self.prim_range := clean_cmpy_addr[1..10];
	self.predir := clean_cmpy_addr[11..12];
	self.prim_name := clean_cmpy_addr[13..40];
	self.addr_suffix := clean_cmpy_addr[41..44];
	self.postdir := clean_cmpy_addr[45..46];
	self.unit_desig := clean_cmpy_addr[47..56];
	self.sec_range := clean_cmpy_addr[57..64];
	self.p_city_name := clean_cmpy_addr[90..114];
	self.v_city_name := clean_cmpy_addr[65..89];
	self.st := clean_cmpy_addr[115..116];
	self.z5 := clean_cmpy_addr[117..121];
	self.zip4 := clean_cmpy_addr[122..125];
	self.orig_z5 := le.cmpyzip;
	self.lat := clean_cmpy_addr[146..155];
	self.long := clean_cmpy_addr[156..166];
	self.addr_type := clean_cmpy_addr[139];
	self.addr_status := clean_cmpy_addr[179..182];
	self.county := clean_cmpy_addr[143..145];
	self.geo_blk := clean_cmpy_addr[171..177];
	self.fein		 := fein_val;
	self.phone10    := wphone_val;
	self.ip_addr	 := le.website;
	self.rep_fname	 := stringlib.stringtouppercase(le.first);
	self.rep_mname  := ''; // don't have one on input
	self.rep_lname  := stringlib.stringtouppercase(le.last);
	self.rep_name_suffix := ''; // don't have one on input
	self.rep_alt_Lname := ''; // don't have one on input
	self.rep_prim_range := clean_addr[1..10];
	self.rep_predir := clean_addr[11..12];
	self.rep_prim_name := clean_addr[13..40];
	self.rep_addr_suffix := clean_addr[41..44];
	self.rep_postdir := clean_addr[45..46];
	self.rep_unit_desig := clean_addr[47..56];
	self.rep_sec_range := clean_addr[57..64];
	self.rep_p_city_name := clean_addr[90..114];
	self.rep_st := clean_addr[115..116];
	self.rep_z5 := clean_addr[117..121];
	self.rep_zip4 := clean_addr[122..125];
	self.rep_lat := clean_addr[146..155];
	self.rep_long := clean_addr[156..166];
	self.rep_addr_type := clean_addr[139];
	self.rep_addr_status := clean_addr[179..182];
	self.rep_county := clean_addr[143..145];
	self.rep_geo_blk := clean_addr[171..177];
	self.rep_orig_city := le.city;
	self.rep_orig_st := le.state;
	self.rep_orig_z5 := le.zip;
	self.rep_ssn		:= ssn_val;
	self.rep_dob		:= dob_val;
	self.rep_phone		:= hphone_val;
	//self.rep_age 	:= if(le.dob='', '', (STRING3)ut.GetAgeI((integer)le.dob), '');
	self.rep_age 		:= if((integer)dob_val != 0, (STRING3)(ut.GetAgeI((integer)dob_val)), '');
	self.rep_dl_num := stringlib.stringtouppercase(dl_num_clean);
	self.rep_dl_state := stringlib.stringtouppercase(le.drlcstate);
	self.rep_email		:= le.email;
end;

prep := project(indata,into_bus_input(LEFT));


boolean hasbdids := false;
boolean ExcludeWatchLists := false;
boolean OFAC := true; // ofac_only
Real Global_WatchList_Threshold := if(OFACversion = 4, 0.85, 0.84);
boolean include_ofac := if(OFACversion >= 2, True, False);
 
biid_results := business_risk.InstantID_Function(prep,gateways,hasbdids,dppa,glb,isUtility,ln_branded,'pb01',ExcludeWatchLists,ofac, ofac_version := OFACversion, include_ofac := include_ofac, Global_WatchList_Threshold := Global_WatchList_Threshold, dataRestriction:=DataRestriction, dataPermission:=dataPermission);

min2(integer L, integer R) :=  if (l < r , l, r);								
// business_risk instant id was designed differently, convert those levels to what riskwise customers are used to on the 0-6 scale for PB1O.									
UNSIGNED1 convertPhoneLevel(unsigned1 level) := MAP(level=1 => 2,
									level=2 => 1,
									level=3 => 3,
									level=4 or level=5 => 4,
									level=6 or level=7 => 5,
									level=8 => 6,
									0);									

// PB01 uses a businesslevel which is basically a phonelevel, and bumps a 4 or 5 to a 6 if the taxid is found. so i'm using a combination of bnap and bnat to calculate cmpyverlevel
UNSIGNED1 convertCmpyVerLevel(unsigned1 bnap, unsigned1 bnat) := 
								MAP( bnap in [6,7,8] and bnat=8 => 6, // company, address and fein match
									bnap=8 and bnat!=8 => 5,  // company, address and phone match, but not fein
								     bnap in [6,7] or bnat in [6,7] => 4,  // company and address match
									bnap in [4,5] => 3,	// company and phone match
									bnap=3 => 2, // address and phone match
									bnap=2 => 1, // address or company match, but not both together
									bnap=1 => 1,  // phone match only
									0);

layout_targus := RECORD
  unsigned2 royalty_type_code_targus := 0;
  string20  royalty_type_targus := '';
  unsigned2 royalty_count_targus := 0;
  unsigned2 non_royalty_count_targus := 0;
  string20  count_entity_targus := '';
END;

xlayout := record
	riskwise.layout_pb1o;
	
	// need these for calculations and reasoncodes
	string tribcode := '';
	dataset(Risk_Indicators.Layout_Desc) cmpy_ris;
	dataset(Risk_Indicators.Layout_Desc) rep_ris;
	dataset(Risk_Indicators.Layout_Desc) rep_fuas;
	string orig_addr := '';
	string orig_city := '';
	string orig_state := '';
	string orig_zip := '';
	string orig_cmpy := '';
	string orig_dba := '';
	string orig_cmpyphone1 := '';
	string orig_cmpyphone2 := '';
	string orig_cmpyphone3 := '';
	string orig_rep_addr :='';
	string orig_rep_city :='';
	string orig_rep_state :='';
	string orig_rep_zip :='';
	string orig_rep_hphone :='';
	string orig_rep_wphone :='';
	boolean bus_present := false;
	boolean rep_present := false;	
  layout_targus;
end;

xlayout filloutput(biid_results le, indata rt) := transform
	// hang onto these fields from original input to help in calculations for output
	self.acctno := rt.acctno;
	self.tribCode := rt.tribcode;
	self.orig_cmpy := rt.cmpy;
	self.orig_dba := rt.dbaname;
	self.orig_addr := rt.cmpyaddr;
	self.orig_city := rt.cmpycity;
	self.orig_state := rt.cmpystate;
	self.orig_zip := rt.cmpyzip;
	self.orig_rep_addr := rt.addr;
	self.orig_rep_city := rt.city;
	self.orig_rep_state := rt.state;
	self.orig_rep_zip := rt.zip;
	self.orig_cmpyphone1 := rt.cmpyphone1;
	self.orig_cmpyphone2 := rt.cmpyphone2;
	self.orig_cmpyphone3 := rt.cmpyphone3;
	self.orig_rep_hphone := rt.hphone;
	self.orig_rep_wphone := rt.wphone;
	self.bus_present := (rt.cmpy<>'' and rt.cmpyaddr<>'') or (rt.cmpy<>'' and rt.cmpyphone1<>'') or (rt.cmpyaddr<>'' and rt.cmpyphone1<>'') ;
	self.rep_present := rt.last<>'' and rt.addr<>'';
	// end of original input
	
	self.account := le.account;
	self.riskwiseid := (string)le.bdid; // for testing
	self.cmpyverlevel := (string)convertCmpyVerLevel((integer)le.BNAP_Indicator, (integer)le.BNAT_Indicator);
	self.cmpyphoneverlevel := (string)(convertPhoneLevel((integer)le.BNAP_Indicator));
	code32 := Risk_Indicators.rcSet.isCode32(le.watchlist_table, le.watchlist_record_number);
	self.score := RiskWise.bviScore((integer)self.cmpyverlevel, (integer)self.cmpyphoneverlevel, code32);
	self.score2 := ''; // not populated
	self.score3 := ''; // not populated
	self.cmpy_ris := RiskWise.Bus_patriotBusinessReasonCodes(self, le, 8, ofac); 
	self.reason1 := self.cmpy_ris[1].hri;
	self.reason2 := self.cmpy_ris[2].hri;
	self.reason3 := self.cmpy_ris[3].hri;
	self.reason4 := self.cmpy_ris[4].hri;
	self.reason5 := self.cmpy_ris[5].hri;
	self.reason6 := self.cmpy_ris[6].hri;
	self.reason7 := self.cmpy_ris[7].hri;
	self.reason8 := self.cmpy_ris[8].hri;
	self.action1 := ''; // not populated
	self.action2 := ''; // not populated
	self.action3 := ''; // not populated
	self.action4 := ''; // not populated

	clean_vaddr := Risk_Indicators.MOD_AddressClean.clean_addr(le.veraddr, le.vercity, le.verstate, le.verzip);
						
	self.correctcmpyname := if(le.cmpyMiskeyFlag, le.vercmpy, '');
	self.correctcmpyaddr := if(le.addrMiskeyFlag, le.veraddr, '');
	self.correctcmpyphone := if(le.phonemiskeyflag, le.verphone, '');
	
	self.fein := le.verfein;
	self.cmpydirsfirst := le.PhoneMatchFirst; 
	self.cmpydirslast := if(le.PhoneMatchLast='', le.PhoneMatchCompany, le.PhoneMatchLast); // company name is populated with the full listing name... 
																			 // if that's populated and last name isn't, use the company listing
	self.cmpydirsaddr := le.PhoneMatchAddr;
	self.cmpydirscity := le.PhoneMatchCity;
	self.cmpydirsstate := le.PhoneMatchState;
	self.cmpydirszip := le.PhoneMatchZip;
	self.cmpynameaddrphone := le.CmpyPhoneFromAddr;
	self.cmpyphoneflag1 := if(rt.cmpyphone1='', 'B', RiskWise.patriotPhoneTypeFlag(rt.cmpyphone1));
	self.cmpyphoneflag2 := if(rt.cmpyphone2='', 'B', RiskWise.patriotPhoneTypeFlag(rt.cmpyphone2));
	self.cmpyphoneflag3 := if(rt.cmpyphone3='', 'B', RiskWise.patriotPhoneTypeFlag(rt.cmpyphone3));
	bans_current := IF(((INTEGER)(ut.GetDate[1..6]) - (INTEGER)(le.RecentBkDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	lien_current := IF(((INTEGER)(ut.GetDate[1..6]) - (INTEGER)(le.RecentLienDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	self.cmpybansflag := MAP(le.bkfeinflag and bans_current => '1',  
						le.bkbdidflag and bans_current => '2',
						'0'); 								
	self.cmpylienamtflag := map(le.UnreleasedLienCount=0 and le.ReleasedLienCount=0 => '0',
						   le.lien_total < 10000 => '1', 
						   le.lien_total > 10000 => '2',
						   '0');
	lienTotal := le.UnreleasedLienCount + le.ReleasedLienCount;
	self.cmpynumliens := if(lienTotal=0, '', (string)lienTotal);
	cassed_input_addr := Risk_Indicators.MOD_AddressClean.street_address('',le.prim_range, le.predir, le.prim_name, le.addr_suffix,
											le.postdir, le.unit_desig, le.sec_range);				
	self.cmpylientypeflag := map(le.lienbdidflag and lien_current and le.veraddr <> cassed_input_addr => '1',  	// if veraddr address doesn't match the input address, we got this bdid by fein,
							le.lienbdidflag and lien_current => '2',  								// otherwise it was a company name and address search that got us the bdid
							'0');
	self.numucc := if(le.numucc=0,'',(string)le.numucc); // belongs up here with this stuff, even though it's at the bottom of the layout
		
	// if dba name is blank, these are all empty, otherwise populate with cmpyflags if dbaname is the same as the verfied cmpyname
	dbascore := if(le.alt_company_name='', 0, (100-(ut.CompanySimilar100(le.alt_company_name, le.vercmpy))));
	self.dbabansflag := if(dbascore>80, self.cmpybansflag, '');
	self.dbalienamtflag := if(dbascore>80, self.cmpylienamtflag, '');
	self.dbanumliens := if(dbascore>80, self.cmpynumliens, '');
	self.dbalientypeflag := if(dbascore>80, self.cmpylientypeflag, '');
	
	self.cmpyaddrtype := le.BAddrType;
	
	exec := if(le.bdid<>0, RiskWise.getExecutive(le.bdid, glb));
	self.execlast := if(le.bdid<>0, exec[1].lname, '');   				// these are the only 3 fields that 
	self.exectitle := if(le.bdid<>0, exec[1].company_title, ''); 		// are currently being populated from 	
	self.sic := if(le.bdid<>0, exec[1].sic_code[1..6], '');			// the executive contact search
	self.cmpyyear := '';  // not populated in st. cloud	
	self.cmpyhriskalerttable := if(le.watchlist_table!='', 'OFC', '');
	self.cmpyhriskalertnum := if(le.watchlist_table='', '', le.watchlist_record_number[5..10]);
	self.cmpyalertfirst := le.watchlist_fname;
	self.cmpyalertlast := le.watchlist_lname;
	self.cmpyalertaddr := le.watchlist_address;
	self.cmpyalertcity := le.watchlist_city;
	self.cmpyalertstate := le.watchlist_state;
	self.cmpyalertzip := le.watchlist_zip;
	self.cmpyalertentity := le.watchlist_cmpy;
	self.socsverlevel := le.RepNAS_Score;
	self.phoneverlevel := le.RepNAP_Score;
	self.authreplinkflag := '';  // could use AR2BI here, but in st. cloud, it isn't populated, so we need to leave it blank
	self.score4 := intformat((integer)le.RepCVI,2,1); 
	self.score5 := ''; // blank
	self.score6 := ''; // blank
	
	self.correctlast := le.rep_correctlast;
	self.correctaddr := le.rep_correctaddr;
	self.correctphone := le.rep_correcthphone;
	self.correctsocs := le.rep_correctssn;
	self.correctdob := le.rep_correctdob;
	self.dirsfirst := le.repphonefname;
	self.dirslast := le.repphonelname;
	self.dirsaddr := le.repphoneaddr1;
	self.dirscity := le.repphonecity;
	self.dirsstate := le.repphonestate;
	self.dirszip := le.repphonezip + le.repphonezip4;
	self.nameaddrphone := le.repphonefromaddr;
	self.hphonetypeflag := ''; //if(rt.hphone='', 'B', RiskWise.patriotPhoneTypeFlag(rt.hphone));  not output in st. cloud pb01 or pb02
	self.wphonetypeflag := ''; //if(rt.wphone='', 'B', RiskWise.patriotPhoneTypeFlag(rt.wphone));
	self.socllowissue := le.repssnearlydate;
	self.soclhighissue := le.repssnlatedate;
	self.soclstate := le.repssnissuestate;
	self.eqfsfirst := le.RepFNameVerify;  // use verfirst and verlast for now because the chronology dataset doesn't have first and last
	self.eqfslast := le.RepLNameVerify;   // it looks like that's the one we want anyway.
	self.eqfsaddr := le.hist_addr_1;  // use chronology data from instantid as the eqfs history records
	self.eqfscity := le.hist_city_1;
	self.eqfsstate := le.hist_state_1;
	self.eqfszip := le.hist_zip_1 + le.hist_zip4_1;
	self.eqfsphone := le.hist_phone_1;
	self.eqfsaddr2 := le.hist_addr_2;
	self.eqfscity2 := le.hist_city_2;
	self.eqfsstate2 := le.hist_state_2;
	self.eqfszip2 := le.hist_zip_2 + le.hist_zip4_2;
	self.eqfsphone2 := le.hist_phone_2;
	self.eqfsaddr3 := le.hist_addr_3;
	self.eqfscity3 := le.hist_city_3;
	self.eqfsstate3 := le.hist_state_3;
	self.eqfszip3 := le.hist_zip_3 + le.hist_zip4_3;
	self.eqfsphone3 := le.hist_phone_3;
	self.altlast := le.alt_lname_1;
	self.altlast2 := le.alt_lname_2;
	self.dist1 := if(le.dist_homephone_homeaddr=9999, '',(string)le.dist_homephone_homeaddr);
	self.dist2 := if(le.dist_busphone_busaddr=9999, '',(string)le.dist_busphone_busaddr);
	self.dist3 := if(le.dist_homephone_busaddr=9999, '',(string)le.dist_homephone_busaddr);
	self.dist4 := if(le.dist_homephone_busphone=9999, '',(string)le.dist_homephone_busphone);
	self.dist5 := if(le.dist_homeaddr_busphone=9999, '',(string)le.dist_homeaddr_busphone);
	self.hriskalerttable := if(le.repwatchlist_table!='', 'OFC', '');
	self.hriskalertnum := if(le.repwatchlist_table='', '', le.repwatchlist_record_number[5..10]);
	self.alertfirst := le.repwatchlist_fname;
	self.alertlast := le.repwatchlist_lname;
	self.alertaddr := le.repwatchlist_address;
	self.alertcity := le.repwatchlist_city;
	self.alertstate := le.repwatchlist_state;
	self.alertzip := le.repwatchlist_zip;
	self.alertentity := le.repwatchlist_entity_name;
	
	self.rep_ris := RiskWise.Bus_patriotReasonCodes(self, le, 6, ofac); 	
	self.reason9 := self.rep_ris[1].hri;	
	self.reason10 := self.rep_ris[2].hri;	
	self.reason11 := self.rep_ris[3].hri;	
	self.reason12 := self.rep_ris[4].hri;	
	self.reason13 := self.rep_ris[5].hri;	
	self.reason14 := self.rep_ris[6].hri;	
	self.reason15 := self.rep_ris[7].hri;	
	self.reason16 := self.rep_ris[8].hri;	
	
	nas := (integer)le.RepNAS_Score;
	nap := (integer)le.RepNAP_Score;
	self.rep_fuas := RiskWise.Bus_getActionCodes(self, le, 4, ofac, nas, nap); 	
	self.action5 := self.rep_fuas[1].hri;	
	self.action6 := self.rep_fuas[2].hri;
	self.action7 := self.rep_fuas[3].hri;
	self.action8 := self.rep_fuas[4].hri;
  self.royalty_type_code_targus := le.royalty_type_code_targus;
  self.royalty_type_targus := le.royalty_type_targus;
  self.royalty_count_targus := le.royalty_count_targus;
  self.non_royalty_count_targus := le.non_royalty_count_targus;
  self.count_entity_targus := le.count_entity_targus;
end;

biid_ret := join(biid_results, indata, left.seq = right.seq, filloutput(left, right), left outer);
	
// add this transform to blank out the section(s) that were blank on input like it works in st. cloud
layout_pb1o_w_targus := RECORD
  riskwise.layout_pb1o;
  layout_targus;
END;

layout_pb1o_w_targus fillempty(biid_ret le) := transform
	self.acctno := le.acctno;
	self.account := le.account;
	self.riskwiseid := le.riskwiseid;
	
	self.cmpyverlevel := if(le.bus_present, le.cmpyverlevel, '');
	self.cmpyphoneverlevel := if(le.bus_present, le.cmpyphoneverlevel, '');
	self.score := if(le.bus_present, le.score, '');
	self.score2 := if(le.bus_present, le.score2, '');
	self.score3 := if(le.bus_present, le.score3, '');
	self.reason1 := if(le.bus_present, le.reason1, '');
	self.reason2 := if(le.bus_present, le.reason2, '');
	self.reason3 := if(le.bus_present, le.reason3, '');
	self.reason4 := if(le.bus_present, le.reason4, '');
	self.reason5 := if(le.bus_present, le.reason5, '');
	self.reason6 := if(le.bus_present, le.reason6, '');
	self.reason7 := if(le.bus_present, le.reason7, '');
	self.reason8 := if(le.bus_present, le.reason8, '');
	self.action1 := if(le.bus_present, le.action1, '');
	self.action2 := if(le.bus_present, le.action2, '');
	self.action3 := if(le.bus_present, le.action3, '');
	self.action4 := if(le.bus_present, le.action4, '');
	self.correctcmpyname := if(le.bus_present, le.correctcmpyname, '');
	self.correctcmpyaddr := if(le.bus_present, le.correctcmpyaddr, '');
	self.correctcmpyphone := if(le.bus_present, le.correctcmpyphone, '');
	self.fein := if(le.bus_present, le.fein, '');
	self.cmpydirsfirst := if(le.bus_present, le.cmpydirsfirst, '');
	self.cmpydirslast := if(le.bus_present, le.cmpydirslast, '');
	self.cmpydirsaddr := if(le.bus_present, le.cmpydirsaddr, '');
	self.cmpydirscity := if(le.bus_present, le.cmpydirscity, '');
	self.cmpydirsstate := if(le.bus_present, le.cmpydirsstate, '');
	self.cmpydirszip := if(le.bus_present, le.cmpydirszip, '');
	self.cmpynameaddrphone := if(le.bus_present, le.cmpynameaddrphone, '');
	self.cmpyphoneflag1 := if(le.bus_present, le.cmpyphoneflag1, '');
	self.cmpyphoneflag2 := if(le.bus_present, le.cmpyphoneflag2, '');
	self.cmpyphoneflag3 := if(le.bus_present, le.cmpyphoneflag3, '');
	
	// these fields are the only difference between pb01 and pb02.  pb02 returns them all blank because they come from smartlynx in st. cloud
	self.cmpybansflag := if(le.bus_present, if(le.tribcode='pb02','',le.cmpybansflag), '');
	self.dbabansflag := if(le.bus_present, if(le.tribcode='pb02','',le.dbabansflag), '');
	self.cmpylienamtflag := if(le.bus_present, if(le.tribcode='pb02','',le.cmpylienamtflag), '');
	self.cmpynumliens := if(le.bus_present, if(le.tribcode='pb02','',le.cmpynumliens), '');
	self.cmpylientypeflag := if(le.bus_present, if(le.tribcode='pb02','',le.cmpylientypeflag), '');
	self.numucc := if(le.bus_present, if(le.tribcode='pb02','',le.numucc), '');
	self.dbalienamtflag := if(le.bus_present, if(le.tribcode='pb02','',le.dbalienamtflag), '');
	self.dbanumliens := if(le.bus_present, if(le.tribcode='pb02','', le.dbanumliens), '');
	self.dbalientypeflag := if(le.bus_present,  if(le.tribcode='pb02','',le.dbalientypeflag), '');
	
	self.cmpyaddrtype := if(le.bus_present, le.cmpyaddrtype, '');
	self.sic := if(le.bus_present, le.sic, '');
	self.execlast := if(le.bus_present, le.execlast, '');
	self.exectitle := if(le.bus_present, le.exectitle, '');
	self.cmpyyear := if(le.bus_present, le.cmpyyear, '');
	self.cmpyhriskalerttable := if(le.bus_present, le.cmpyhriskalerttable, '');
	self.cmpyhriskalertnum := if(le.bus_present, le.cmpyhriskalertnum, '');
	self.cmpyalertfirst := if(le.bus_present, le.cmpyalertfirst, '');
	self.cmpyalertlast := if(le.bus_present, le.cmpyalertlast, '');
	self.cmpyalertaddr := if(le.bus_present, le.cmpyalertaddr, '');
	self.cmpyalertcity := if(le.bus_present, le.cmpyalertcity, '');
	self.cmpyalertstate := if(le.bus_present, le.cmpyalertstate, '');
	self.cmpyalertzip := if(le.bus_present, le.cmpyalertzip, '');
	self.cmpyalertentity := if(le.bus_present, le.cmpyalertentity, '');
	
	self.socsverlevel := if(le.rep_present, le.socsverlevel, '');
	self.phoneverlevel := if(le.rep_present, le.phoneverlevel, '');
	self.authreplinkflag := if(le.rep_present, le.authreplinkflag, '');
	self.score4 := if(le.rep_present, le.score4, '');
	self.score5 := if(le.rep_present, le.score5, '');
	self.score6 := if(le.rep_present, le.score6, '');
	self.reason9 := if(le.rep_present, le.reason9, '');
	self.reason10 := if(le.rep_present, le.reason10, '');
	self.reason11 := if(le.rep_present, le.reason11, '');
	self.reason12 := if(le.rep_present, le.reason12, '');
	self.reason13 := if(le.rep_present, le.reason13, '');
	self.reason14 := if(le.rep_present, le.reason14, '');
	self.reason15 := if(le.rep_present, le.reason15, '');
	self.reason16 := if(le.rep_present, le.reason16, '');
	self.action5 := if(le.rep_present, le.action5, '');
	self.action6 := if(le.rep_present, le.action6, '');
	self.action7 := if(le.rep_present, le.action7, '');
	self.action8 := if(le.rep_present, le.action8, '');
	self.correctlast := if(le.rep_present, le.correctlast, '');
	self.correctaddr := if(le.rep_present, le.correctaddr, '');
	self.correctphone := if(le.rep_present, le.correctphone, '');
	self.correctsocs := if(le.rep_present, le.correctsocs, '');
	self.correctdob := if(le.rep_present, le.correctdob, '');
	self.dirsfirst := if(le.rep_present, le.dirsfirst, '');
	self.dirslast := if(le.rep_present, le.dirslast, '');
	self.dirsaddr := if(le.rep_present, le.dirsaddr, '');
	self.dirscity := if(le.rep_present, le.dirscity, '');
	self.dirsstate := if(le.rep_present, le.dirsstate, '');
	self.dirszip := if(le.rep_present, le.dirszip, '');
	self.nameaddrphone := if(le.rep_present, le.nameaddrphone, '');
	self.hphonetypeflag := if(le.rep_present, le.hphonetypeflag, '');
	self.wphonetypeflag := if(le.rep_present, le.wphonetypeflag, '');
	self.socllowissue := if(le.rep_present, le.socllowissue, '');
	self.soclhighissue := if(le.rep_present, le.soclhighissue, '');
	self.soclstate := if(le.rep_present, le.soclstate, '');
	self.eqfsfirst := if(le.rep_present, le.eqfsfirst, '');
	self.eqfslast := if(le.rep_present, le.eqfslast, '');
	self.eqfsaddr := if(le.rep_present, le.eqfsaddr, '');
	self.eqfscity := if(le.rep_present, le.eqfscity, '');
	self.eqfsstate := if(le.rep_present, le.eqfsstate, '');
	self.eqfszip := if(le.rep_present, le.eqfszip, '');
	self.eqfsphone := if(le.rep_present, le.eqfsphone, '');
	self.eqfsaddr2 := if(le.rep_present, le.eqfsaddr2, '');
	self.eqfscity2 := if(le.rep_present, le.eqfscity2, '');
	self.eqfsstate2 := if(le.rep_present, le.eqfsstate2, '');
	self.eqfszip2 := if(le.rep_present, le.eqfszip2, '');
	self.eqfsphone2 := if(le.rep_present, le.eqfsphone2, '');
	self.eqfsaddr3 := if(le.rep_present, le.eqfsaddr3, '');
	self.eqfscity3 := if(le.rep_present, le.eqfscity3, '');
	self.eqfsstate3 := if(le.rep_present, le.eqfsstate3, '');
	self.eqfszip3 := if(le.rep_present, le.eqfszip3, '');
	self.eqfsphone3 := if(le.rep_present, le.eqfsphone3, '');
	self.altlast := if((integer)le.socsverlevel IN [4,7,9,10,11,12], if(le.rep_present, le.altlast, ''), '');
	self.altlast2 := if((integer)le.socsverlevel IN [4,7,9,10,11,12], if(le.rep_present, le.altlast2, ''), '');
	self.dist1 := if(le.rep_present, le.dist1, ''); //homephone to homeaddr
	self.dist2 := if(le.bus_present, le.dist2, ''); //busphone to busaddr
	self.dist3 := if(le.rep_present and le.bus_present, le.dist3, ''); // homephone to busaddr
	self.dist4 := if(le.rep_present and le.bus_present, le.dist4, ''); // homephone to busphone
	self.dist5 := if(le.rep_present and le.bus_present, le.dist5, ''); // homeaddr to busphone
	self.hriskalerttable := if(le.rep_present, le.hriskalerttable, '');
	self.hriskalertnum := if(le.rep_present, le.hriskalertnum, '');
	self.alertfirst := if(le.rep_present, le.alertfirst, '');
	self.alertlast := if(le.rep_present, le.alertlast, '');
	self.alertaddr := if(le.rep_present, le.alertaddr, '');
	self.alertcity := if(le.rep_present, le.alertcity, '');
	self.alertstate := if(le.rep_present, le.alertstate, '');
	self.alertzip := if(le.rep_present, le.alertzip, '');
	self.alertentity := if(le.rep_present, le.alertentity, '');
  self.royalty_type_code_targus := le.royalty_type_code_targus;
  self.royalty_type_targus := le.royalty_type_targus;
  self.royalty_count_targus := le.royalty_count_targus;
  self.non_royalty_count_targus := le.non_royalty_count_targus;
  self.count_entity_targus := le.count_entity_targus;
end;

res := project(biid_ret, fillempty(left));

return res;

end;