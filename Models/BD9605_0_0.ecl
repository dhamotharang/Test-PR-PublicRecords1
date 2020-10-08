import ut, risk_indicators, Business_Risk, Easi, RiskWise, std, AutoStandardI, doxie, Models;

export BD9605_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Business_Risk.Layout_Output) biid, dataset(riskwise.Layout_BusReasons_Input) orig_input,  
			 boolean OFAC, string tribcode='', boolean nugen=false, boolean other_watchlists = false) := FUNCTION

input_params := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

layout_prs2 := RECORD
	unsigned4  seq := 0;
	unsigned6 bdid := 0;
	Business_Risk.Layout_Profile_Risk_model;
END;

used_census_fields := record
	string12 geolink;
	string6 bigapt_p;
	string6 lowrent;
	string6 urban_p;
	string6 robbery;
	string6 easiqlife;
	string6 cpiall;
	string6 blue_empl;
	string6 old_homes;
	string6 retired2 ;
	string6 fammar_p;
	string6 fammar18_p;
	string6 hh7p_p;
	string6 cartheft;
	string6 ab_av_edu;
	string6 lar_fam;
	string6 many_cars;
	string6 trailer;
	string6 unattach;
	string6 very_rich;
	string6 low_hval;	
	string6 born_usa;
end;
	
working_layout := RECORD, maxlength(30000)
	unsigned seq;
	Risk_Indicators.Layout_Boca_Shell		bs;
	business_risk.layout_output			br;
	layout_prs2						prs;
	used_census_fields					easic;
	used_census_fields					easib;
	riskwise.Layout_BusReasons_Input orig_input;
	real score;
END;

// do multiple transforms to project them together
clambiid := join(biid, clam, left.seq=right.seq, transform(working_layout, self.seq := left.seq, self.bs := right, self.br := left, self := []), left outer,ATMOST(RiskWise.max_atmost),keep(1));
withPRS := join(clambiid, Business_Risk.getBDIDTable(biid, mod_access), left.seq=right.seq, transform(working_layout, self.prs := right, self := left), left outer,ATMOST(RiskWise.max_atmost),keep(1));
withCensusc := join(withPRS, Easi.Key_Easi_Census,
			     keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk),
			     /*left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk=right.geolink,*/
			     transform(working_layout, self.easic := right, self := left), left outer,
			     ATMOST(keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk),RiskWise.max_atmost)
			     ,keep(1));
withCensusb := join(withCensusC, Easi.Key_Easi_Census,
					keyed(right.geolink=left.br.st+left.br.county+left.br.geo_blk),
					/*left.br.st+left.br.county+left.br.geo_blk=right.geolink,*/ 
					transform(working_layout, self.easib := right, self := left), left outer,
					ATMOST(keyed(right.geolink=left.br.st+left.br.county+left.br.geo_blk),RiskWise.max_atmost),
					keep(1));


// business_risk instant id was designed differently, convert those levels to what riskwise customers are used to.  this conversion works for both bnap and bnat									
unsigned1 convertBusInstIDLevel(unsigned1 level) := map(level = 1 => 1,
											 level = 3 => 3,
											 level = 4 => 5,
											 level = 5 => 5,
											 level = 8 => 8,
											 0);   // 0,2,6,7 all translate into 0 on st. cloud platform

working_layout doModel(withCensusb le, riskwise.Layout_BusReasons_Input rt) := transform

	// SDBO mappings from biid to sdbo, so that all of the sdbo fields don't have to be part of the working layout
	input2present := le.br.company_name<>'' or le.br.prim_name<>'' or le.br.phone10<>'';
	hriskhphoneflag2 := if(le.br.phone10='', '7', if(le.br.hriskphoneflag='U', '0',le.br.hriskphoneflag));
	hphonevalflag2 := if(le.br.phone10='', '4', le.br.phonevalidflag);
	hphonezipflag2 := if(le.br.phone10='' or le.br.orig_z5='', '2', if(le.br.phonezipmismatch, '1', '0'));
	dwelltypeflag2 := if(~input2present, '', le.br.BAddrType);
	socsverlevel2 := if(~input2present, '0', (string)convertBusInstIDLevel((integer)le.br.BNAT_Indicator));
	hphonecount2 := if(~input2present, 0, if(le.br.PhoneMatchflag = 'Y', 1, 0));
	addrcount2 := if(~input2present, 0, if(le.br.AddrMatchflag = 'Y', 1, 0));
	cmpycount2 := if(~input2present, 0, if(le.br.CnameMatchflag = 'Y', 1, 0));
	hriskaddrflag2 := if(le.br.prim_name='', '5', le.br.hriskaddrflag);

	sysyear := IF(le.bs.historydate <> 999999, (integer)((string)le.bs.historydate[1..4]), (integer)(ut.GetDate[1..4]));
	
	today := IF(le.bs.historydate <> 999999, ((string)le.bs.historydate)[1..6] + '01', (STRING)Std.Date.Today());
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);	
	
	
	// Creation of variables for Business Model
	
	lname_flag := if(trim(le.br.rep_lname) <> '', 1, 0);
	ssn_flag := if(trim(le.br.rep_ssn) <> '', 1, 0);
	addr1_flag := if(trim(le.br.rep_prim_name) <> '', 1, 0);
	
	flag_sum := lname_flag + ssn_flag + addr1_flag;
	
	rep := if(flag_sum = 3, 1, 0);
	
	
	dnb_i := if(le.prs.cnt_d > 0 and le.prs.prscore <> 0, 1, 0);
	

	dvfrt := (string)le.prs.dt_vendor_first_reported_min;
	
	/*handle year, but no month or day */
	dvfr :=if(dvfrt >'0' and dvfrt[5..6] <'01', dvfrt[1..4] + '0101',dvfrt);
	


	
	dt_first_reported_1900 := ut.DaysSince1900(dvfr[1..4],dvfr[5..6],dvfr[7..8]);
	dt_vendor_rptd_min := round((today1900 - dt_first_reported_1900)/365);			
	
	
	new_bus_liens := if(dt_vendor_rptd_min <= 3 and le.prs.cnt_lj > 5, 1, 0);
	prs_derogs1 := if((le.prs.cnt_b > 0 or le.prs.cnt_id > 0 or new_bus_liens > 0) and le.prs.prscore <> 0, 1, 0);
	

	prs_apts := map(le.prs.prscore = 0 => 0,
				 le.prs.apts <= 25 => 1,
				 le.prs.apts >= 26 and le.prs.apts <= 49 => 2,
				 le.prs.apts >= 50 and le.prs.apts <= 99 => 3,
				 4);
				 
	prs_b_phone_per_addr := map(le.prs.prscore = 0 => 0,
						   le.prs.b_phone_per_addr <= 25 => 1,
						   le.prs.b_phone_per_addr >= 26 and le.prs.b_phone_per_addr <= 49 => 2,
						   le.prs.b_phone_per_addr >= 50 and le.prs.b_phone_per_addr <= 99 => 3,
						   4);
						   
						   
	time_in_bus := map(le.prs.prscore = 0 or dvfr='0' => 0,
				    dt_vendor_rptd_min <= 2 => -1,
				    dt_vendor_rptd_min >= 8 => 1,
				    0);
				    
	
	
	bdid_prs_flag := if(le.prs.prscore <> 0, 1, 0);
	
	
	dist_BusPhone_BusAddr_i := if(le.br.dist_busphone_busaddr >= 0 and le.br.dist_busphone_busaddr <= 5, 1, 0);
	
	
	
	pri1 := trim(le.br.pri1);
	pri2 := trim(le.br.pri2);
	pri3 := trim(le.br.pri3);
	pri4 := trim(le.br.pri4);
	pri5 := trim(le.br.pri5);
	pri6 := trim(le.br.pri6);
	pri7 := trim(le.br.pri7);
	pri8 := trim(le.br.pri8);
	
	bus_pri_set := [pri1, pri2, pri3, pri4, pri5, pri6, pri7, pri8];
	
	rc_phnzip := if('16' in bus_pri_set, 1, 0);
	rc_disc  := if('7'  in bus_pri_set, 1, 0);
	rc_addrhrisk := if('14' in bus_pri_set, 1, 0);
	rc_prison := if('50' in bus_pri_set, 1, 0);
	rc_zippobox := if('12' in bus_pri_set, 1, 0);
	rc_zipcorp := if('40' in bus_pri_set, 1, 0);
		
	phntype := map(hriskhphoneflag2 in ['1','3','4'] => 3,
				hriskhphoneflag2 in ['5','6','7'] => 2,
				hriskhphoneflag2 in ['1','2'] and rc_phnzip = 1 => 1,
				0);
				
				
	phnval := map(hphonevalflag2 in ['','0','4'] => 3,
			    hphonevalflag2 in ['2','3','5','6','7'] => 2,
			    rc_phnzip = 1 or rc_disc = 1 => 1,
			    0);
			    
			    
	addrtype := map(dwelltypeflag2 = 'R' => 2,
				 dwelltypeflag2 = ' ' => 0,
				 1);
				 
				 
	addr_status_e := if(le.br.addr_status[1] in ['e','E'], 1, 0);
	
	
	addprob := map(dwelltypeflag2 = 'R' => 5,
				rc_addrhrisk = 1 or rc_prison = 1 => 4,
				addr_status_e = 1 => 3,
				rc_zippobox =1 or rc_zipcorp = 1 => 1,
				trim(dwelltypeflag2) = '' => 0,
				2);
				
				
	contrary_tin_bnat := if(le.br.bnat_indicator = '1', 1, 0);
	contrary_add_bnat := if(le.br.bnat_indicator = '2', 1, 0);
	contrary_nam_bnat := if(le.br.bnat_indicator = '3', 1, 0);
	
	addver_bnat := if(le.br.bnat_indicator in ['4','6','7','8'], 1, 0);
	tinver_bnat := if(le.br.bnat_indicator in ['4','5','8'], 1, 0);
	namver_bnat := if(le.br.bnat_indicator in ['5','6','7','8'], 1, 0);
	
	contrary_phn_bnap := if(le.br.bnap_indicator = '1', 1, 0);
	contrary_add_bnap := if(le.br.bnap_indicator = '2', 1, 0);
	contrary_nam_bnap := if(le.br.bnap_indicator = '3', 1, 0);
	
	addver_bnap := if(le.br.bnap_indicator in ['4','6','7','8'], 1, 0);
	phnver_bnap := if(le.br.bnap_indicator in ['4','5','8'], 1, 0);
	namver_bnap := if(le.br.bnap_indicator in ['5','6','7','8'], 1, 0);
	
	namver_bnas := if(le.br.bnas_indicator = '3', 1, 0);
	addver_bnas := namver_bnas;
	tinver_bnas := namver_bnas;
	
	
	namver_b2b := if(socsverlevel2 = '8', 1, 0);
	addver_b2b := namver_b2b;
	tinver_b2b := namver_b2b;
		
	b2b_phnlvl := map(hphonecount2 > 0 and addrcount2 > 0 and cmpycount2 > 0 => 8,
				   hphonecount2 = 0 and addrcount2 > 0 and cmpycount2 > 0 => 7,
				   hphonecount2 > 0 and addrcount2 = 0 and cmpycount2 > 0 => 5,
				   hphonecount2 > 0 and addrcount2 > 0 and cmpycount2 = 0 => 4,
				   hphonecount2 > 0 and addrcount2 = 0 and cmpycount2 = 0 => 1,
				   0);
				   
	namver_b2b_p := if(b2b_phnlvl in [8,7,5], 1, 0);
	addver_b2b_p := if(b2b_phnlvl in [8,7,4], 1, 0);
	phnver_b2b_p := if(b2b_phnlvl in [8,5,4], 1, 0);
	contrary_phn_b2b := if(b2b_phnlvl = 1, 1, 0);
	
	namver_tot := map(namver_bnat >= namver_bnap and namver_bnat >= namver_bnas and namver_bnat >= namver_b2b_p => namver_bnat,
				   namver_bnap >= namver_bnat and namver_bnap >= namver_bnas and namver_bnap >= namver_b2b_p => namver_bnap,
				   namver_bnas >= namver_bnat and namver_bnas >= namver_bnap and namver_bnas >= namver_b2b_p => namver_bnas,
				   namver_b2b_p);
				   
	addver_tot := map(addver_bnat >= addver_bnap and addver_bnat >= addver_bnas and addver_bnat >= addver_b2b_p => addver_bnat,
				   addver_bnap >= addver_bnat and addver_bnap >= addver_bnas and addver_bnap >= addver_b2b_p => addver_bnap,
				   addver_bnas >= addver_bnat and addver_bnas >= addver_bnap and addver_bnas >= addver_b2b_p => addver_bnas,
				   addver_b2b_p);
				   
	phnver_tot := if(phnver_bnap >= phnver_b2b_p, phnver_bnap, phnver_b2b_p);
	
	tinver_tot := map(tinver_bnat >= tinver_bnas and tinver_bnat >= tinver_b2b => tinver_bnat,
				   tinver_bnas >= tinver_bnat and tinver_bnas >= tinver_b2b => tinver_bnas,
				   tinver_b2b);
	
	versummary := namver_tot + addver_tot + phnver_tot + tinver_tot;
	
	ver_phn_addr := if(addver_tot = 1 and phnver_tot = 1, 1, 0);
	
	bnat_bnap := map((namver_bnat + addver_bnat + namver_bnap + addver_bnap) = 4 => 4,
				  (namver_bnap + addver_bnap) = 2 => 3,
				  (namver_bnat + addver_bnat) = 2 => 2,
				  0);
				  
	verx_b := map(versummary = 0 and contrary_add_bnap = 0 => 17,
			    versummary = 0 => 25,
			    versummary = 2 and ver_phn_addr = 1 => 15,
			    versummary = 2 and contrary_tin_bnat = 1 => 25,
			    versummary = 2 and namver_bnap = 1 => 20,
			    versummary = 2 => 23,
			    versummary = 4 and bnat_bnap = 4 => 7,
			    versummary = 4 and bnat_bnap = 3 => 9,
			    versummary = 4 and bnat_bnap = 2 => 17,
			    versummary = 4 => 17,
			    (namver_tot + addver_tot + phnver_tot) = 3 and contrary_add_bnat > 0 => 17,
			    (namver_tot + addver_tot + phnver_tot) = 3 and contrary_add_bnat = 0 and bnat_bnap = 4 and le.br.bvi = '50' => 9,
			    (namver_tot + addver_tot + phnver_tot) = 3 and contrary_add_bnat = 0 and bnat_bnap = 4 => 10,
			    (namver_tot + addver_tot + phnver_tot) = 3 and contrary_add_bnat = 0 and bnat_bnap = 3 => 12,
			    (namver_tot + addver_tot + phnver_tot) = 3 and contrary_add_bnat = 0 and bnat_bnap = 2 => 19,
			    12);
	addr1 :=Risk_Indicators.MOD_AddressClean.street_address('',le.br.prim_range, le.br.predir, le.br.prim_name, le.br.addr_suffix, le.br.postdir, le.br.unit_desig, le.br.sec_range);
	
	addrmatch_flag := if(le.br.addrmatchflag = 'Y', 1, 0);
	feinmatchaddr1_flag := if(le.br.feinmatchaddr1 = addr1, 1, 0);
	bestaddr_flag := if(le.br.bestaddr = addr1, 1, 0);
	phonematchaddr_flag := if(le.br.phonematchaddr = addr1, 1, 0);
	bestcompanyname_flag := if(le.br.bestcompanyname = le.br.company_name, 1, 0);
	cnamematch_flag := if(le.br.cnamematchflag = 'Y', 1, 0);
	feinmatchcompany1_flag := if(le.br.feinmatchcompany1 = le.br.company_name, 1, 0);
	phonematchcompany_flag := if(le.br.phonematchcompany = le.br.company_name, 1, 0);
	
	sum_bname1 := bestcompanyname_flag + cnamematch_flag + feinmatchcompany1_flag + phonematchcompany_flag;
	sum_addr1 := Min((addrmatch_flag + feinmatchaddr1_flag + bestaddr_flag + phonematchaddr_flag), 3);
	sum_addr := if(sum_addr1 = 1, 2, sum_addr1);
	sum_bname := if(sum_bname1 = 1, 2, sum_bname1);
	
	sum_ver := map(sum_addr = 0 => 0,
				sum_addr <= 2 => map(sum_bname = 0 => 1,
								 sum_bname <= 2 => 2,
								 3),
				map(sum_bname = 0 => 3,
				    sum_bname <= 2 => 4,
				    5));
	
	b_urban_p := if(le.easib.urban_p='-1', '0', le.easib.urban_p);
	b_bigapt_p := if(le.easib.bigapt_p='-1', '0', le.easib.bigapt_p);
	b_lowrent := if(le.easib.lowrent='-1', '0', le.easib.lowrent);
	b_robbery := if(le.easib.robbery='-1', '0', le.easib.robbery);
	b_easiqlife := if(le.easib.easiqlife='-1', '0', le.easib.easiqlife);
	b_cpiall := if(le.easib.cpiall='-1', '0', le.easib.cpiall);
	b_blue_empl := if(le.easib.blue_empl='-1', '0', le.easib.blue_empl);
	b_born_usa := if(le.easib.born_usa='-1', '0', le.easib.born_usa);
	b_old_homes := if(le.easib.old_homes='-1', '0', le.easib.old_homes);
	b_retired2 := if(le.easib.retired2='-1', '0', le.easib.retired2);
	
	
	cen_bus_mod := 0.0604474333
				   + (real)b_urban_p * 0.000911291
				   + (real)b_bigapt_p  * 0.0043967675
				   + (real)b_lowrent  * -0.002131284
				   + (real)b_robbery  * 0.000913666
				   + (real)b_easiqlife  * 0.0011542449
				   + (real)b_cpiall  * -0.01045089
				   + (real)b_blue_empl  * -0.001163842
				   + (real)b_born_usa  * -0.000548424
				   + (real)b_old_homes  * -0.00067784
				   + (real)b_retired2  * -0.001029407;

     cen_bus_mod1 := (exp(cen_bus_mod)) / (1+exp(cen_bus_mod));
     cen_bus_mod3 := round(1000 * cen_bus_mod1);				// I think this needs some fixing with the rounding
     cen_bus_mod2 := if(trim(le.easib.geolink) = '', 13.5, cen_bus_mod3/10);

	// end of Business model
	
	// start of consumer model, personal guarantor is present
	
	prs_derogs2 := map(le.prs.cnt_lj > 2 => 2,
				    le.prs.cnt_b > 0 or le.prs.cnt_id > 0 or le.prs.cnt_lj in [1,2] => 1,
				    0);
				    
	bdid_per_addr_risk := if(/*le.prs.bdid_per_addr <> '****' and*/ le.prs.bdid_per_addr >= 100, 1, 0);		// is this correct to look at '****'
	
	prs_apts_c := if(le.prs.apts > 100, 1, 0);
	/* 255 is the default for missing values */
 	prs_flag := if(le.prs.company_name_score = 0 or le.prs.company_name_score = 255, 0, 1);
		
	con_prs_mod := -1.187638829
					+ le.prs.ucc_flag  * -0.223328626
					+ prs_derogs2  * 0.5067376558
					+ bdid_per_addr_risk  * 0.403261494
					+ prs_apts_c  * 0.3600972297;

     con_prs_mod2 := (exp(con_prs_mod)) / (1+exp(con_prs_mod));
     con_prs_mod3 := round((1000 * con_prs_mod2));			

     con_prs_mod1 := if(prs_flag = 0, 19.21, con_prs_mod3/10);
	
	
	
	rc_secstbad := if('A4' in bus_pri_set, 1, 0);
	rc_secstinc := if('A6'  in bus_pri_set, 1, 0);
	//rc_prison := if('50' in bus_pri_set, 1, 0);
	rc_phninv := if('8' in bus_pri_set, 1, 0);
	rc_difftin := if('54' in bus_pri_set, 1, 0);
	rc_diffbname := if('88' in bus_pri_set, 1, 0);
	
	
	secst_prob := if(rc_secstbad = 1 or rc_secstinc = 1, 1, 0);
	mfamdwell := if(dwelltypeflag2 = ' ', 0, 1);
	b2b_hirisk_add := if(hriskaddrflag2 = '4' or rc_prison = 1, 1, 0);
	b2b_disconnect := if(hriskhphoneflag2 = '5', 1, 0);
	b2b_phninvalid := if(hphonevalflag2 = '0', 1, 0);
	
	con_fp_mod := -1.473542473
				+ secst_prob  * 0.2168144316
				+ mfamdwell  * 0.484759947
				+ b2b_hirisk_add  * 0.6979407025
				+ rc_phnzip  * 0.1559581294
				+ rc_phninv  * 0.2274592404
				+ b2b_disconnect  * 0.4076292143
				+ b2b_phninvalid  * 0.5120122305;

     con_fp_mod2 := (exp(con_fp_mod)) / (1+exp(con_fp_mod));
     con_fp_mod3 := round(1000 * con_fp_mod2);		
	con_fp_mod1 := con_fp_mod3/10;
	
	
	
	namver_tot_c := map(namver_bnat >= namver_bnap and namver_bnat >= namver_bnas => namver_bnat,
				     namver_bnap >= namver_bnat and namver_bnap >= namver_bnas => namver_bnap,
				     namver_bnas);   
	addver_tot_c := map(addver_bnat >= addver_bnap and addver_bnat >= addver_bnas => addver_bnat,
					addver_bnap >= addver_bnat and addver_bnap >= addver_bnas => addver_bnap,
					addver_bnas);		   
	phnver_tot_c := phnver_bnap;
	tinver_tot_c := if(tinver_bnat >= tinver_bnas, tinver_bnat, tinver_bnas);
	
	versummary_c := namver_tot_c + addver_tot_c + phnver_tot_c + tinver_tot_c;

	contrary_bnap_max := map(contrary_nam_bnap >= contrary_add_bnap and contrary_nam_bnap >= contrary_phn_bnap => contrary_nam_bnap,
						contrary_add_bnap >= contrary_nam_bnap and contrary_add_bnap >= contrary_phn_bnap => contrary_add_bnap,
						contrary_phn_bnap);
						
						
     vertree_c := map(namver_tot_c > 0 and tinver_tot_c > 0 and le.br.bnas_indicator = '3' => 10.2,
				  namver_tot_c > 0 and tinver_tot_c > 0 => 22.8,
				  contrary_add_bnap = 1 => 29.3,
				  versummary_c = 0 and contrary_tin_bnat = 1 => 22.8,
				  versummary_c = 0 and contrary_bnap_max = 1 => 26.1,
				  versummary_c = 0 and (integer)le.br.bnas_indicator > 0 => 15,
				  versummary_c = 0 => 19.4,
				  namver_tot_c > 0 and addver_tot_c > 0 and (rc_difftin = 1 or rc_diffbname = 1) => 26.1,
				  namver_tot_c > 0 and addver_tot_c > 0 => 24,
				  namver_tot_c > 0 and phnver_tot_c > 0 => 26.1,
				  29.3);
	
	
	boca_verssn := if(le.bs.iid.nas_summary in [4,6,7,9,10,11,12], 1, 0);
	boca_verlst_p := if(le.bs.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
	boca_verlst_s := if(le.bs.iid.nas_summary in [2,5,7,8,9,11,12], 1,0);
	boca_veradd_p := if(le.bs.iid.nap_summary in [3,5,6,8,10,11,12], 1, 0);
	boca_veradd_s := if(le.bs.iid.nas_summary in [3,5,6,8,10,11,12], 1, 0);
	boca_verphn := if(le.bs.iid.nap_summary in [4,6,7,9,10,11,12], 1, 0);

	boca_contrary_phone := if(le.bs.iid.nap_summary = 1, 1, 0);
	
	
	boca_verlst := if(boca_verlst_p >= boca_verlst_s, boca_verlst_p, boca_verlst_s);
	boca_veradd := if(boca_veradd_p >= boca_veradd_s, boca_veradd_p, boca_veradd_s);
	
	boca_versum4 := boca_verlst + boca_veradd + boca_verphn + boca_verssn;
	
	
	boca_verx := map(boca_verssn = 1 and boca_versum4 = 4 and le.bs.address_verification.input_address_information.isbestmatch => 6,
				  boca_verssn = 1 and boca_versum4 = 4 => 5,
				  boca_verssn = 1 and boca_versum4 = 3 and boca_contrary_phone = 1 => 2,
				  boca_verssn = 1 and boca_versum4 = 3 and le.bs.address_verification.input_address_information.isbestmatch => 4,
				  boca_verssn = 1 and boca_versum4 = 3 => 3,
				  boca_verssn = 1 and boca_versum4 = 2 => 2,
				  boca_verssn = 1 => 1,
				  boca_verssn = 0 and boca_versum4 = 3 => 1,
				  0);
				  
				  
	high_risk_address_boca := if(le.bs.address_verification.input_address_information.hr_address or le.bs.address_verification.address_history_1.hr_address or le.bs.address_verification.address_history_2.hr_address, 1, 0);
	risky_address_boca := if(high_risk_address_boca = 1 or le.bs.address_validation.hr_address, 1, 0);
	not_deliverable_boca := if(~le.bs.address_validation.usps_deliverable, 1, 0);
	addprob_boca := map(risky_address_boca = 1 => 2,
					not_deliverable_boca = 1 => 1,
					0);
					
					
	
	ssninval_boca := if(~le.bs.ssn_verification.validation.valid, 1, 0);
	ssnprob_boca := if(ssninval_boca = 1 or le.bs.ssn_verification.validation.deceased, 1, 0);
	
	boca_criminal_flag := if(le.bs.bjl.criminal_count > 0, 1, 0);
	
	naprop_ver := map(le.bs.address_verification.input_address_information.naprop = 4 => 2,
				   le.bs.address_verification.input_address_information.naprop = 3 => 1,
				   0);
				   
     dob_m := (integer)(le.bs.shell_input.dob[5..6]);
     dob_d := (integer)(le.bs.shell_input.dob[7..8]);
	input_dob := if(dob_m > 0 and dob_d > 0, ut.DaysSince1900(le.bs.shell_input.dob[1..4], le.bs.shell_input.dob[5..6], le.bs.shell_input.dob[7..8]), -99);
	
	age_years1 := if(input_dob = -99, -99, round((today1900-input_dob)/365.25));
     age_years := if(age_years1 <= 0, -99, age_years1);

     age_combo := if(age_years = -99, if(le.bs.name_verification.age<0, 46, le.bs.name_verification.age), age_years);

     boca_xx_age_combo := age_combo * age_combo;

	
	
	b_fammar_p := if(le.easib.fammar_p='-1', '0',	le.easib.fammar_p);
	b_fammar18_p := if(le.easib.fammar18_p='-1', '0', le.easib.fammar18_p);
	b_hh7p_p := if(le.easib.hh7p_p='-1', '0', 		le.easib.hh7p_p);
	b_low_hval := if(le.easib.low_hval='-1', '0',	le.easib.low_hval);
	b_cartheft := if(le.easib.cartheft='-1', '0', 	le.easib.cartheft);
	b_ab_av_edu := if(le.easib.ab_av_edu='-1', '0', 	le.easib.ab_av_edu);
	b_lar_fam := if(le.easib.lar_fam='-1', '0', 		le.easib.lar_fam);
	b_many_cars := if(le.easib.many_cars='-1', '0', 	le.easib.many_cars);
	b_trailer := if(le.easib.trailer='-1', '0', 		le.easib.trailer);
	b_unattach := if(le.easib.unattach='-1', '0', 	le.easib.unattach);
	b_very_rich := if(le.easib.very_rich='-1', '0', 	le.easib.very_rich);
	
	
	
	
	cen_con_modb := 2.1753278213 
				   + (real)b_urban_p  * 0.0011345702
				   + (real)b_fammar_p  * -0.002642938
				   + (real)b_fammar18_p  * -0.003904444
				   + (real)b_hh7p_p  * 0.0167349016
				   + (real)b_bigapt_p  * 0.0034752491
				   + (real)b_lowrent  * -0.002753158
				   + (real)b_low_hval  * 0.0023458993
				   + (real)b_cartheft  * 0.0017192346
				   + (real)b_cpiall  * -0.015877982
				   + (real)b_ab_av_edu  * -0.001212433
				   + (real)b_born_usa  * -0.00142034
				   + (real)b_lar_fam  * 0.0018886807
				   + (real)b_many_cars  * -0.001226914
				   + (real)b_trailer  * -0.001094437
				   + (real)b_unattach  * 0.001352741
				   + (real)b_very_rich  * -0.000693021;

     cen_con_modb2 := (exp(cen_con_modb)) / (1+exp(cen_con_modb));
     cen_con_modb3 := round(1000 * cen_con_modb2);				
     cen_con_modb1 := if(trim(le.easib.geolink) = '', 19.5, cen_con_modb3/10);

	c_fammar_p := if(le.easic.fammar_p='-1', '0', le.easic.fammar_p);
	c_hh7p_p := if(le.easic.hh7p_p='-1', '0',	 le.easic.hh7p_p);
	c_bigapt_p := if(le.easic.bigapt_p='-1', '0', le.easic.bigapt_p);
	c_lowrent := if(le.easic.lowrent='-1', '0', 	 le.easic.lowrent);
	c_low_hval := if(le.easic.low_hval='-1', '0', le.easic.low_hval);
	c_cartheft := if(le.easic.cartheft='-1', '0', le.easic.cartheft);
	c_cpiall := if(le.easic.cpiall='-1', '0',	 le.easic.cpiall);
	c_ab_av_edu := if(le.easic.ab_av_edu='-1', '0', le.easic.ab_av_edu);
	c_born_usa := if(le.easic.born_usa='-1', '0',	le.easic.born_usa);
	c_many_cars := if(le.easic.many_cars='-1', '0', le.easic.many_cars);
	c_old_homes := if(le.easic.old_homes='-1', '0', le.easic.old_homes);
	c_trailer := if(le.easic.trailer='-1', '0',	 le.easic.trailer);
	
	

	cen_con_modc := 3.2050646445
				   + (real)c_fammar_p  * -0.011687415
				   + (real)c_hh7p_p  * 0.024370331
				   + (real)c_bigapt_p  * 0.0056756767
				   + (real)c_lowrent  * -0.002861534
				   + (real)c_low_hval  * 0.0039832226
				   + (real)c_cartheft  * 0.0018016433
				   + (real)c_cpiall  * -0.015889807
				   + (real)c_ab_av_edu  * -0.001052235
				   + (real)c_born_usa  * -0.002028031
				   + (real)c_many_cars  * -0.000942875
				   + (real)c_old_homes  * -0.000915438
				   + (real)c_trailer  * -0.001407099;

     cen_con_modc3 := (exp(cen_con_modc)) / (1+exp(cen_con_modc));
     cen_con_modc4 := round(1000 * cen_con_modc3);				
     cen_con_modc2 := if(trim(le.easic.geolink) = '', 18.1, cen_con_modc4/10);
	
	
	
	dist_busphone_busaddr_x := if(le.br.dist_busphone_busaddr > 25/* or le.br.dist_busphone_busaddr = ''*/, 1, 0);
	dist_homeaddr_busaddr_x := if(le.br.dist_homeaddr_busaddr > 10/* or le.br.dist_homeaddr_busaddr = ''*/, 1, 0);
	dist_homeaddr_busphone_x := if(le.br.dist_homeaddr_busphone > 10/* or le.br.dist_homeaddr_busphone = ''*/, 1, 0);

	dist_homephone_busaddr_x := if(le.br.dist_homephone_busaddr > 10/* or le.br.dist_homephone_busaddr = ''*/, 1, 0);
	dist_homephone_busphone_x := if(le.br.dist_homephone_busphone > 25/* or le.br.dist_homephone_busphone = ''*/, 1, 0);
	dist_homephone_homeaddr_x := if(le.br.dist_homephone_homeaddr > 10/* or le.br.dist_homephone_homeaddr = ''*/, 1, 0);
	
	
	max_dist := map(dist_busphone_busaddr_x >= dist_homeaddr_busaddr_x and dist_busphone_busaddr_x >= dist_homeaddr_busphone_x and dist_busphone_busaddr_x >= dist_homephone_busaddr_x and
						dist_busphone_busaddr_x >= dist_homephone_busphone_x and dist_busphone_busaddr_x >= dist_homephone_homeaddr_x => dist_busphone_busaddr_x,
				 dist_homeaddr_busaddr_x >= dist_busphone_busaddr_x and dist_homeaddr_busaddr_x >= dist_homeaddr_busphone_x and dist_homeaddr_busaddr_x >= dist_homephone_busaddr_x and
						dist_homeaddr_busaddr_x >= dist_homephone_busphone_x and dist_homeaddr_busaddr_x >= dist_homephone_homeaddr_x => dist_homeaddr_busaddr_x,
				 dist_homeaddr_busphone_x >= dist_homeaddr_busaddr_x and dist_homeaddr_busphone_x >= dist_busphone_busaddr_x and dist_homeaddr_busphone_x >= dist_homephone_busaddr_x and
						dist_homeaddr_busphone_x >= dist_homephone_busphone_x and dist_homeaddr_busphone_x >= dist_homephone_homeaddr_x => dist_homeaddr_busphone_x,
				 dist_homephone_busaddr_x >= dist_homeaddr_busaddr_x and dist_homephone_busaddr_x >= dist_homeaddr_busphone_x and dist_homephone_busaddr_x >= dist_busphone_busaddr_x and
						dist_homephone_busaddr_x >= dist_homephone_busphone_x and dist_homephone_busaddr_x >= dist_homephone_homeaddr_x => dist_homephone_busaddr_x,
				 dist_homephone_busphone_x >= dist_homeaddr_busaddr_x and dist_homephone_busphone_x >= dist_homeaddr_busphone_x and dist_homephone_busphone_x >= dist_homephone_busaddr_x and
						dist_homephone_busphone_x >= dist_busphone_busaddr_x and dist_homephone_busphone_x >= dist_homephone_homeaddr_x => dist_homephone_busphone_x,
				 dist_homephone_homeaddr_x);
				 
				 
	ar2bi_x := if((integer)le.br.ar2bi > 0, 1, 0);
	
	

//**************************************************************************;
//* final business only model *;
//**************************************************************************;
     pkmod := -3.141327133
                  + DNB_I  * -0.201739113
                  + PRS_DEROGS1  * 0.2640154258
                  + PRS_APTS  * 0.3007234875
                  + PRS_B_PHONE_PER_ADDR  * 0.0885821036
                  + TIME_IN_BUS  * -0.356122025
                  + bdid_prs_flag  * -0.268797008
                  + DIST_BUSPHONE_BUSADDR_I  * -0.091770137
                  + PHNTYPE  * 0.0796368235
                  + PHNVAL  * 0.1600829518
                  + ADDRTYPE  * 0.1833280499
                  + ADDPROB  * 0.0973544039
                  + TINVER_BNAS  * -0.472360067
                  + VERX_B  * 0.0431105022
                  + SUM_VER  * -0.075145632
                  + CEN_BUS_MOD2  * 0.0488604162;

     pkmod3 := (exp(pkmod)) / (1+exp(pkmod));
     pkmod4 := round(1000 * pkmod3);			
	pkmod2 := pkmod4/10;



//**************************************************************************;
//* final business and consumer model *;
//**************************************************************************;
	con_mod := -4.750531633
                  +CON_PRS_MOD1                    *  0.021884473
                  +CON_FP_MOD1                     *  0.0267723649
                  +VERTREE_C                       *  0.038572215
                  +BOCA_VERX                       *  0.0283942148
                  +ADDPROB_BOCA                    *  0.0689513532
                  +SSNPROB_BOCA                    *  0.4424022517
                  +BOCA_CRIMINAL_FLAG              *  0.2038308701
                  +NAPROP_VER                	 *  -0.134515864
                  +BOCA_XX_AGE_COMBO               *  -0.000087209
                  +CEN_CON_MODB1                   *  0.0189858136
                  +CEN_CON_MODC2                   *  0.0274065119
                  +MAX_DIST                        *  0.1946183999
                  +AR2BI_X                         *  -0.108258914;

     con_mod2 := (exp(con_mod)) / (1+exp(con_mod));
     con_mod3 := round(1000 * con_mod2);    				       
	con_mod6 := con_mod3/10;

// end of Consumer model;

	phat6 := if(rep=1, con_mod6/100, pkmod2/100);

	base := 700;
	odds := 0.0531 / 0.9469;
	point := -20;

	newscore5 := round((point*(log(phat6/(1-phat6)) - log(odds))/log(2) + base) * 10);		
	rawscore := newscore5/10;
	
	
		// ==========================================
	// overrides to model now are to be applied across the board to everything that uses business defender
	
	
	// add overrides
	deceased_rep := Risk_Indicators.rcSet.isCode02(le.bs.iid.decsflag);
	unverified_name := 
				 Risk_Indicators.rcSet.isCode19(le.bs.iid.combo_lastcount, le.bs.iid.combo_addrcount, le.bs.iid.combo_hphonecount, le.bs.iid.combo_ssncount)
			or Risk_Indicators.rcSet.isCode20(le.bs.iid.combo_lastcount, le.bs.iid.combo_addrcount, le.bs.iid.combo_hphonecount, le.bs.iid.combo_ssncount)
			or Risk_Indicators.rcSet.isCode21(le.bs.shell_input.lname, le.bs.shell_input.phone10, le.bs.iid.combo_lastcount, le.bs.iid.combo_addrcount, le.bs.iid.combo_hphonecount)
			or Risk_Indicators.rcSet.isCode22(le.bs.shell_input.lname, le.bs.shell_input.in_streetAddress, le.bs.iid.combo_lastcount, le.bs.iid.combo_addrcount, le.bs.iid.combo_hphonecount)
			or Risk_Indicators.rcSet.isCode23(le.bs.shell_input.ssn, le.bs.shell_input.lname, le.bs.iid.combo_lastcount, le.bs.iid.combo_addrcount, le.bs.iid.combo_hphonecount, le.bs.iid.combo_ssncount)
			or Risk_Indicators.rcSet.isCode37(le.bs.shell_input.lname, le.bs.iid.combo_lastcount, le.bs.iid.combo_addrcount, le.bs.iid.combo_hphonecount, le.bs.iid.combo_ssncount);
	
	ssn_belongs_to_someone_else := Risk_Indicators.rcSet.isCode72((string)le.bs.iid.socsverlevel, le.bs.shell_input.ssn, le.bs.iid.ssnexists, le.bs.iid.lastssnmatch2)
															 and unverified_name;
	
	ssn_dob_mismatch := Risk_Indicators.rcSet.isCode03(le.bs.iid.socsdobflag);
	
	rep_address_invalid := Risk_Indicators.rcSet.isCode11(le.bs.iid.addrvalflag, le.bs.shell_input.in_streetAddress, le.bs.shell_input.in_city, le.bs.shell_input.in_state, le.bs.shell_input.in_zipCode)
											and unverified_name;
	
	rep_ssn_invalid := Risk_Indicators.rcSet.isCode06(le.bs.iid.socsvalflag, le.bs.shell_input.ssn)
									and unverified_name;
	
	rep_phone_invalid := (Risk_Indicators.rcSet.isCode07(le.bs.iid.hriskphoneflag) or Risk_Indicators.rcSet.isCode08(le.bs.iid.phonetype,le.bs.shell_input.phone10) )
										and unverified_name;
										
	rep_age := (integer)le.bs.shell_input.age;
	rep_under_18 := rep_age<>0 and rep_age < 18;
		
	cmpy_not_good_standing := Risk_Indicators.rcSet.isCodeA4(le.br.bdid, le.br.goodstanding);
	
	cmpy_not_active := Risk_Indicators.rcSet.isCodeA6(le.br.bdid, le.br.goodstanding);
	
	unverified_company := 
			Risk_Indicators.rcSet.isCode60(le.br.cmpycount, le.br.addrcount, le.br.wphonecount, rt.orig_cmpy, rt.orig_addr, rt.orig_wphone) or
			Risk_Indicators.rcSet.isCode61(le.br.cmpycount, le.br.addrcount, le.br.wphonecount, rt.orig_cmpy, rt.orig_addr, rt.orig_wphone) or
			Risk_Indicators.rcSet.isCode62(le.br.cmpycount, le.br.addrcount, le.br.wphonecount, rt.orig_cmpy, rt.orig_addr, rt.orig_wphone) ;
	
	cmpy_phone_disconnected := Risk_Indicators.rcSet.isCode07(le.br.hriskphoneflag) 
								and unverified_company;
	
	cmpy_address_invalid := Risk_Indicators.rcSet.isCode11(le.br.addrvalidflag, rt.orig_addr, rt.orig_city, rt.orig_state, rt.orig_zip)
								and unverified_company;
								
	cmpy_phone_invalid := Risk_Indicators.rcSet.isCode08(rt.telcophonetype, rt.orig_wphone)
								and unverified_company;
	
	// apply override conditions to the 3 digit score
	override_score_pre_cap := map(
			rawscore > 620 and         
			(deceased_rep or ssn_belongs_to_someone_else or ssn_dob_mismatch or rep_under_18)	=> 620,
									
			rawscore > 640 and
			(rep_address_invalid or rep_ssn_invalid or rep_phone_invalid or
			 cmpy_not_good_standing or cmpy_not_active or cmpy_phone_disconnected or
			 cmpy_address_invalid or cmpy_phone_invalid) => 640,
									
			rawscore);
			
  // Apply model cap per bug 36144
	override_score := Map(override_score_pre_cap < 250 => 250,
												override_score_pre_cap > 999 => 999,
												override_score_pre_cap);
												
	
	self.seq := le.seq;
	self.bs := le.bs;
	self.br := le.br;
	self.prs := le.prs;
	self.easic := le.easic;
	self.easib := le.easib;
	self.orig_input := rt;
	self.score := override_score;
	
	// self := [];
END;

with_score := join(withCensusb, orig_input, left.seq=right.seq, doModel(LEFT, right));

layout_iid_and_orig_input := RECORD
	Risk_Indicators.Layout_Output iid;
	riskwise.Layout_BusReasons_Input orig;
END;

layout_iid_and_orig_input into_iid_orig(working_layout le) := TRANSFORM
	self.iid.seq := le.bs.seq;
	self.iid.socllowissue := (string)le.bs.SSN_Verification.Validation.low_issue_date;
	self.iid.soclhighissue := (string)le.bs.SSN_Verification.Validation.high_issue_date;
	self.iid.socsverlevel := le.bs.iid.NAS_summary;
	self.iid.nxx_type := le.bs.phone_verification.telcordia_type;
	self.iid := le.bs.iid;
	self.iid := le.bs.shell_input;
	self.iid := le.bs;

	self.orig := le.orig_input;
	self := [];

END;

iid_orig := project(with_score, into_iid_orig(left));


Models.Layout_ModelOut getReasons(biid le, iid_orig ri) := TRANSFORM
	// self.ri := RiskWise.Bus_reasonCodes(ri, le, 4, OFAC, tribcode);
	self.ri := if( ~nugen,
		RiskWise.Bus_reasonCodes(ri.orig, le, 4, OFAC, tribcode),
		RiskWise.getFourReasons(
			RiskWise.bdReasonCodesBusiness(ri.orig, le, 4, OFAC, other_watchlists),
			RiskWise.bdReasonCodesConsumer(ri.iid, 4, OFAC, other_watchlists)
		)
	);
	self.seq := le.seq;
	self := [];
END;
withReasons := JOIN(biid, iid_orig, left.seq = right.orig.seq, getReasons(left, right), left outer);

Models.Layout_ModelOut scoreandreasons(with_score le, withReasons rt) := transform
	SELF.ri := rt.ri;
	self.score := (string)le.score;
	
	SELF := le;
END;
final := JOIN(with_score, withReasons, left.seq = right.seq, scoreandreasons(LEFT,RIGHT), left outer);

RETURN final;


END;

