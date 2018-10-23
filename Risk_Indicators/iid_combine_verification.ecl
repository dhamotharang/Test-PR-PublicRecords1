import _Control, ut, did_add, address, risk_indicators, census_data, riskwise, USPIS_HotList, ADVO, DOXIE, MDR;
onThor := _Control.Environment.OnThor;

export iid_combine_verification(grouped dataset(risk_indicators.Layout_Output) ssnrecs, 
								grouped dataset(risk_indicators.Layout_Output) pphonerecs,
								boolean from_IT1O=false, string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel,
								boolean isFCRA, unsigned8 BSOptions,
								integer bsVersion, string50 DataPermission=iid_constants.default_DataPermission, 
								string50 DataRestriction=iid_constants.default_DataRestriction) := function	
								

ExactAddrRequired := ExactMatchLevel[iid_constants.posExactAddrMatch]=iid_constants.sTrue;								
ExactAddrZip5andPrimRange := ExactMatchLevel[iid_constants.posExactAddrZip5andPrimRange]=iid_constants.sTrue;

nonblank(f) := MACRO
	SELF.f := IF(le.f='',ri.f,le.f)
ENDMACRO;

nonzero(f) := MACRO
	SELF.f := IF(le.f=0,ri.f,le.f)
ENDMACRO;

nonfalse(f) := MACRO
	SELF.f := ri.f OR le.f
ENDMACRO;

temp := record
	integer version;
	risk_indicators.Layout_Output;
end;

temp combo(temp le, temp ri) := TRANSFORM
	// these couple fields always need to be set from the result of the ssnrecs
	self.did := le.did;
  self.truedid := le.truedid;
	self.firstscore := le.firstscore;
	self.lastscore := le.lastscore;
	self.addrscore := le.addrscore;
	self.citystatescore := le.citystatescore;
	self.zipscore := le.zipscore;
	self.socsscore := le.socsscore;
	// choose the higher of header dob or inquiry dob
	self.dobscore := if(iid_constants.tscore(le.dobscore)>=iid_constants.tscore(ri.inquiryNAPdobScore), le.dobscore, ri.inquiryNAPdobScore);
	self.verfirst := 	le.verfirst;
	self.verlast := 	le.verlast;
	self.vercmpy := 	le.vercmpy;
	self.verprim_range := 	le.verprim_range;
	self.verpredir := 	le.verpredir;
	self.verprim_name := 	le.verprim_name;
	self.versuffix := 	le.versuffix;
	self.verpostdir := 	le.verpostdir;
	self.verunit_desig := 	le.verunit_desig;
	self.versec_range := 	le.versec_range;
	self.vercity := 	le.vercity;
	self.verstate := 	le.verstate;
	self.verzip := 	le.verzip;
	self.vercounty := 	le.vercounty;
	self.vergeo_blk := 	le.vergeo_blk;
	self.verhphone := 	le.verhphone;
	self.verwphone := 	le.verwphone;
	self.versocs := 	le.versocs;
	self.verdob := if(iid_constants.tscore(le.dobscore)>=iid_constants.tscore(ri.inquiryNAPdobScore), le.verdob, ri.inquiryNAPdob);
	self.pullidflag := le.pullidflag;
	self.watchlists := le.watchlists;
	
	// fyi... these 3 scores aren't ever used
	self.hphonescore := le.hphonescore;
	self.wphonescore := le.wphonescore; 
	self.cmpyscore := le.cmpyscore;	 
	
	nonblank(riskwiseid);
	nonblank(hriskphoneflag);
	nonblank(hphonetypeflag);
	nonblank(wphonetypeflag);
	nonblank(phonevalflag);
	nonblank(hphonevalflag);
	nonblank(wphonevalflag);
	nonblank(phonezipflag);
	nonblank(PWphonezipflag);
	nonfalse(phonedissflag);
	nonfalse(wphonedissflag);
	nonzero(phoneverlevel);
	nonblank(hriskaddrflag);
	nonblank(decsflag);
	nonzero(deceasedDate);
	nonzero(deceasedDOB);
	nonblank(deceasedfirst);
	nonblank(deceasedlast);
	nonblank(nap_type);
	nonblank(nap_status);
	nonblank(socsdobflag);
	nonblank(PWsocsdobflag);
	nonblank(socsvalflag);
	nonblank(PWsocsvalflag);
	nonblank(socllowissue);
	nonblank(soclhighissue);
	nonblank(soclstate);
	nonzero(socsverlevel);
	nonblank(areacodesplitflag);
	nonblank(areacodesplitdate);
	nonblank(altareacode);
	nonblank(reverse_areacodesplitflag);
	nonblank(addrvalflag);
	nonblank(dwelltype);
	nonblank(src);
	nonzero(dt_last_seen);
	nonblank(bansflag);
	nonblank(phonetype);
	
	nonfalse(coaalertflag);
	nonblank(coafirst);
	nonblank(coalast);
	nonblank(coaprim_range);
	nonblank(coapredir);
	nonblank(coaprim_name);
	nonblank(coasuffix);
	nonblank(coapostdir);
	nonblank(coaunit_desig);
	nonblank(coasec_range);
	nonblank(coacity);
	nonblank(coastate);
	nonblank(coazip);
	
// This section purely support Boca Shell
	nonblank(sources);
	nonblank(firstnamesources);
	nonblank(lastnamesources);
	nonblank(addrsources);
	nonblank(socssources);
	nonzero(firstcount);
	nonzero(lastcount);
	nonzero(addrcount);	
	nonzero(hphonecount);
	nonzero(wphonecount);
	nonzero(socscount);
	// add the inquiry nap dob count to the header dob count (inquiry dob count is always an exact match check)
	self.dobcount := le.dobcount + if(ri.inquiryNAPdobcount>0, 1, 0);
	nonzero(cmpycount);
	self.dobsources := TRIM(le.dobsources) + if(ri.inquiryNAPdobcount>0, 'S ,','');
	
	// num_nonderogs are calculated in both the NAP side and the NAS side,  we should be adding them together instead of just picking a non-zero result
		nonzero(num_nonderogs);
		nonzero(num_nonderogs30);
		nonzero(num_nonderogs90);
		nonzero(num_nonderogs180);
		nonzero(num_nonderogs12);
		nonzero(num_nonderogs24);
		nonzero(num_nonderogs36);
		nonzero(num_nonderogs60);
		
	
	//nonzero(numelever);
	nonzero(numsource);
	nonfalse(eqfsfirstcount);
	nonfalse(eqfslastcount);
	nonfalse(eqfsaddrcount);
	nonfalse(eqfssocscount);
	nonfalse(tufirstcount);
	nonfalse(tulastcount);
	nonfalse(tuaddrcount);
	nonfalse(tusocscount);
	nonfalse(dlfirstcount);
	nonfalse(dllastcount);
	nonfalse(dladdrcount);
	nonfalse(dlsocscount);
	nonfalse(emfirstcount);
	nonfalse(emlastcount);
	nonfalse(emaddrcount);
	nonfalse(emsocscount);
	nonfalse(bkfirstcount);
	nonfalse(bklastcount);
	nonfalse(bkaddrcount);
	nonfalse(bksocscount);
	nonzero(adl_eqfs_first_seen);
	nonzero(adl_eqfs_last_seen);
	nonzero(adl_other_first_seen);
	nonzero(adl_other_last_seen);
// End Boca Shell Section
	
	nonzero(phonefirstcount);
	nonzero(phonelastcount);
	nonzero(phoneaddrcount);
	nonzero(phonephonecount);
	nonzero(phonecmpycount);
	
	nonfalse(veraddr_isBest);
	nonblank(addrcommflag);
	nonblank(hriskcmpy);
	nonblank(hrisksic);
	nonblank(hriskphone);
	nonblank(hriskaddr);
	nonblank(hriskcity);
	nonblank(hriskstate);
	nonblank(hriskzip);
	
	nonblank(hriskcmpyphone);
	nonblank(hrisksicphone);
	nonblank(hriskphonephone);
	nonblank(hriskaddrphone);
	nonblank(hriskcityphone);
	nonblank(hriskstatephone);
	nonblank(hriskzipphone);
	
	nonzero(disthphoneaddr);
	nonzero(disthphonewphone);
	nonzero(distwphoneaddr);
	
	nonblank(wphonename);
	nonblank(wphoneaddr);
	nonblank(wphonecity);
	nonblank(wphonestate);
	nonblank(wphonezip);
	
	nonzero(wphonewphonecount);
	nonzero(wphonewphonescore);
	
	nonzero(numfraud);
	
	nonblank(formerfirst);
	nonblank(formerlast);
	nonblank(formeraddr);
	nonblank(formercity);
	nonblank(formerstate);
	nonblank(formerzip);
	nonblank(formerfirst2);
	nonblank(formerlast2);
	nonblank(formeraddr2);
	nonblank(formercity2);
	nonblank(formerstate2);
	nonblank(formerzip2);
	
	nonblank(dirsfirst);
	nonblank(dirslast);
	nonblank(dirs_prim_range);
	nonblank(dirs_predir);
	nonblank(dirs_prim_name);
	nonblank(dirs_suffix);
	nonblank(dirs_postdir);
	nonblank(dirs_unit_desig);
	nonblank(dirs_sec_range);
	nonblank(dirscity);
	nonblank(dirsstate);
	nonblank(dirszip);
	nonblank(dirscmpy);
	nonzero(dirs_firstscore);
	nonzero(dirs_lastscore);
	nonzero(dirs_addrscore);
	// these fields come from the phone side, the rest of them should also be changed when we get a chance instead of using nonzero
	self.dirs_citystatescore := ri.dirs_citystatescore;
	self.dirs_zipscore := ri.dirs_zipscore;
	nonzero(dirs_phonescore);
	nonzero(dirs_cmpyscore);
	nonzero(phone_date_last_seen);
	
	nonblank(dirsaddr_first);
	nonblank(dirsaddr_last);
	nonblank(dirsaddr_prim_range);
	nonblank(dirsaddr_predir);
	nonblank(dirsaddr_prim_name);
	nonblank(dirsaddr_suffix);
	nonblank(dirsaddr_postdir);
	nonblank(dirsaddr_unit_desig);
	nonblank(dirsaddr_sec_range);
	nonblank(dirsaddr_city);
	nonblank(dirsaddr_state);
	nonblank(dirsaddr_zip);
	nonblank(dirsaddr_cmpy);
	nonzero(dirsaddr_firstscore);
	nonzero(dirsaddr_lastscore);
	nonzero(dirsaddr_addrscore);
	self.dirsaddr_citystatescore := ri.dirsaddr_citystatescore;
	self.dirsaddr_zipscore := ri.dirsaddr_zipscore;
	nonzero(dirsaddr_phonescore);
	nonzero(dirsaddr_cmpyscore);
	nonzero(phoneaddr_date_last_seen);
	
	nonblank(utilifirst);
	nonblank(utililast);
	nonblank(utili_prim_range);
	nonblank(utili_predir);
	nonblank(utili_prim_name);
	nonblank(utili_suffix);
	nonblank(utili_postdir);
	nonblank(utili_unit_desig);
	nonblank(utili_sec_range);
	nonblank(utilicity);
	nonblank(utilistate);
	nonblank(utilizip);
	nonblank(utiliphone);
	nonzero(utili_firstscore);
	nonzero(utili_lastscore);
	nonzero(utili_addrscore);
	self.utili_citystatescore := ri.utili_citystatescore;
	self.utili_zipscore := ri.utili_zipscore;
	nonzero(utili_phonescore);
	
	self.inquiryNAPfirstcount := ri.inquiryNAPfirstcount; 
	self.inquiryNAPlastcount := ri.inquiryNAPlastcount; 
	self.inquiryNAPaddrcount := ri.inquiryNAPaddrcount;  
	self.inquiryNAPphonecount := ri.inquiryNAPphonecount;
	self.inquiryNAPssncount := ri.inquiryNAPssncount;
	self.inquiryNAPdobcount := ri.inquiryNAPdobcount;
	self.InquiryNAPprim_range := ri.inquiryNAPprim_range;
	self.InquiryNAPpredir := ri.inquiryNAPpredir;
	self.InquiryNAPprim_name := ri.inquiryNAPprim_name;
	self.InquiryNAPsuffix := ri.inquiryNAPsuffix;
	self.InquiryNAPpostdir := ri.inquiryNAPpostdir;
	self.InquiryNAPunit_desig := ri.inquiryNAPunit_desig;
	self.InquiryNAPsec_range := ri.inquiryNAPsec_range;
	self.InquiryNAPcity := ri.inquiryNAPcity;
	self.InquiryNAPst := ri.inquiryNAPst;
	self.InquiryNAPz5 := ri.inquiryNAPz5;
	self.InquiryNAPfname := ri.inquiryNAPfname;
	self.InquiryNAPlname := ri.inquiryNAPlname;
	self.InquiryNAPssn := ri.inquiryNAPssn;
	self.InquiryNAPdob := ri.inquiryNAPdob;
	self.InquiryNAPphone := ri.inquiryNAPphone;
	self.InquiryNAPaddrScore := ri.inquiryNAPaddrScore;
	self.InquiryNAPfnameScore := ri.inquiryNAPfnameScore;
	self.InquiryNAPlnameScore := ri.inquiryNAPlnameScore;
	self.InquiryNAPssnScore := ri.inquiryNAPssnScore;
	self.InquiryNAPdobScore := ri.inquiryNAPdobScore;
	self.InquiryNAPphoneScore := ri.inquiryNAPphoneScore;
	
	nonblank(nxx_type);
	nonblank(nxx_type2);
	
	nonblank(ziptypeflag);
	nonblank(zipclass);
	nonblank(zipcity);
	nonblank(drlcvalflag);
	nonblank(drlcsoundx);
	nonblank(drlcfirst);
	nonblank(drlclast);
	nonblank(drlcmiddle);
	nonblank(drlcsocs);
	nonblank(drlcdob);
	nonblank(drlcgender);
	nonblank(statezipflag);
	nonblank(cityzipflag);
	nonblank(hphonestateflag);
	
	nonfalse(chronoaddr_isBest);

	nonblank(chronoprim_range);
	nonblank(chronopredir);
	nonblank(chronoprim_name);
	nonblank(chronosuffix);
	nonblank(chronopostdir);
	nonblank(chronounit_desig);
	nonblank(chronosec_range);
	nonblank(chronocity);
	nonblank(chronostate);
	nonblank(chronozip);
	nonblank(chronozip4);
	nonblank(chronocounty);
	nonblank(chronogeo_blk);
	nonblank(chronophone);
	self.chronoaddrscore := if(from_IT1O, if(le.chronoaddrscore between 0 and 6, le.chronoaddrscore, ri.chronoaddrscore), le.chronoaddrscore);
	self.chronofirst := if(from_IT1O, if(le.chronoaddrscore between 0 and 6, le.chronofirst, ri.chronofirst), le.chronofirst);
	self.chronolast := if(from_IT1O, if(le.chronoaddrscore between 0 and 6, le.chronolast, ri.chronolast), le.chronolast);
	nonzero(chronodate_first);
	nonzero(chronodate_last);
	nonzero(chronoMatchLevel);
	nonzero(chronoActivePhone);
	
	nonfalse(chronoaddr_isBest2);
	nonblank(chronoprim_range2);
	nonblank(chronopredir2);
	nonblank(chronoprim_name2);
	nonblank(chronosuffix2);
	nonblank(chronopostdir2);
	nonblank(chronounit_desig2);
	nonblank(chronosec_range2);
	nonblank(chronocity2);
	nonblank(chronostate2);
	nonblank(chronozip2);
	nonblank(chronozip4_2);
	nonblank(chronocounty2);
	nonblank(chronogeo_blk2);
	nonblank(chronophone2);
	self.chronoaddrscore2 := if(from_IT1O, if(le.chronoaddrscore2 between 0 and 6, le.chronoaddrscore2, ri.chronoaddrscore2), le.chronoaddrscore2);
	self.chronofirst2 := if(from_IT1O, if(le.chronoaddrscore2 between 0 and 6, le.chronofirst2, ri.chronofirst2), le.chronofirst2);
	self.chronolast2 := if(from_IT1O, if(le.chronoaddrscore2 between 0 and 6, le.chronolast2, ri.chronolast2), le.chronolast2);
	nonzero(chronodate_first2);
	nonzero(chronodate_last2);
	nonzero(chronoMatchLevel2);
	nonzero(chronoActivePhone2);
	
	nonfalse(chronoaddr_isBest3);
	nonblank(chronoprim_range3);
	nonblank(chronopredir3);
	nonblank(chronoprim_name3);
	nonblank(chronosuffix3);
	nonblank(chronopostdir3);
	nonblank(chronounit_desig3);
	nonblank(chronosec_range3);
	nonblank(chronocity3);
	nonblank(chronostate3);
	nonblank(chronozip3);
	nonblank(chronozip4_3);
	nonblank(chronocounty3);
	nonblank(chronogeo_blk3);
	nonblank(chronophone3);
	self.chronoaddrscore3 := if(from_IT1O, if(le.chronoaddrscore3 between 0 and 6, le.chronoaddrscore3, ri.chronoaddrscore3), le.chronoaddrscore3);
	self.chronofirst3 := if(from_IT1O, if(le.chronoaddrscore3 between 0 and 6, le.chronofirst3, ri.chronofirst3), le.chronofirst3);
	self.chronolast3 := if(from_IT1O, if(le.chronoaddrscore3 between 0 and 6, le.chronolast3, ri.chronolast3), le.chronolast3);
	nonzero(chronodate_first3);
	nonzero(chronodate_last3);
	nonzero(chronoMatchLevel3);
	nonzero(chronoActivePhone3);
	
	nonzero(inputaddrmatchlevel);
	nonzero(inputaddractivephone);
	
	nonblank(altfirst);
	nonblank(altlast);
	nonblank(altlast_date);
	nonblank(altearly_date);
	nonblank(altfirst2);
	nonblank(altlast2);
	nonblank(altlast_date2);
	nonblank(altearly_date2);
	nonblank(altfirst3);
	nonblank(altlast3);
	nonblank(altlast_date3);
	nonblank(altearly_date3);
	
	nonzero(score1);
	nonzero(score2);
	nonzero(score3);
	nonzero(score4);
	
	nonzero(score);
	
	nonblank(hphonelat);
	nonblank(hphonelong);
	
	nonblank(watchlist_table);
	nonblank(watchlist_record_number);
	nonblank(watchlist_program);
	nonblank(watchlist_fname);
	nonblank(watchlist_lname);
	nonblank(watchlist_address);
	nonblank(WatchlistPrimRange);
	nonblank(WatchlistPreDir);
	nonblank(WatchlistPrimName);
	nonblank(WatchlistAddrSuffix);
	nonblank(WatchlistPostDir);
	nonblank(WatchlistUnitDesignation);
	nonblank(WatchlistSecRange);
	nonblank(watchlist_city);
	nonblank(watchlist_state);
	nonblank(watchlist_zip);
	nonblank(watchlist_contry);
	nonblank(watchlist_entity_name);
	nonzero(watchlist_num_with_name);
	
	nonblank(dirsaddr_phone);
	nonblank(phonever_type);
	nonzero(phoneaddr_firstcount);
	nonzero(phoneaddr_lastcount);
	nonzero(phoneaddr_addrcount);
	nonzero(phoneaddr_phonecount);
	nonzero(phoneaddr_cmpycount);
	
	nonzero(chronophone_namematch);
	nonzero(chronophone2_namematch);
	nonzero(chronophone3_namematch);
	
	nonfalse(isPOTS);
	
	nonfalse(phone_disconnected);
	nonzero(phone_disconnectdate);
	nonfalse(phoneaddr_disconnected);
	nonzero(phoneaddr_disconnectdate);
	nonzero(phone_disconnectcount);
	
	nonzero(utiliaddr_firstcount);
	nonzero(utiliaddr_lastcount);
	nonzero(utiliaddr_addrcount);
	nonzero(utiliaddr_phonecount);
	nonzero(utiliaddr_socscount);
	nonzero(utiliaddr_date);
	
	nonblank(socsvalid);
	nonzero(verdate_last);
	nonzero(socsdidCount);
	nonzero(altlast_count);
	
	nonblank(chrono_sources);
	nonzero(chrono_addrcount);
	nonfalse(chrono_eqfsaddrcount);
	nonfalse(chrono_dladdrcount);
	nonfalse(chrono_emaddrcount);

	nonblank(chrono_sources2);
	nonzero(chrono_addrcount2);
	nonfalse(chrono_eqfsaddrcount2);
	nonfalse(chrono_dladdrcount2);
	nonfalse(chrono_emaddrcount2);
	
	nonblank(chrono_sources3);
	nonzero(chrono_addrcount3);
	nonfalse(chrono_eqfsaddrcount3);
	nonfalse(chrono_dladdrcount3);
	nonfalse(chrono_emaddrcount3);

	
	nonblank(idtheftflag);
	
	nonblank(phone_sources);
	nonzero(p_did);
	nonzero(adls_per_phone); 
	nonzero(adls_per_phone_current);
	nonzero(adls_per_phone_created_6months);
	nonzero(adls_per_phone_multiple_use); 
	nonzero(addrs_per_phone);	
	nonzero(addrs_per_phone_created_6months);	
	
	nonblank(phone_from_did);
	nonzero(phones_per_adl); 
	nonzero(phones_per_adl_created_6months);  
	
	nonblank(phone_from_addr);
	nonzero(phones_per_addr); 
	nonzero(phones_per_addr_current); 
	nonzero(phones_per_addr_multiple_use);  
	nonzero(phones_per_addr_created_6months);  
	nonfalse(targusgatewayused);
	nonblank(targustype);
	
	nonblank(gong_ADL_dt_first_seen);
	nonblank(gong_ADL_dt_last_seen);

	nonblank(publish_code);
	
	nonfalse(isPrison);
	nonfalse(inCalif);
	
	nonzero(invalid_ssns_per_adl);
	nonzero(invalid_ssns_per_adl_created_6months);
	nonzero(invalid_addrs_per_adl);
	nonzero(invalid_addrs_per_adl_created_6months);
	
	self.iid_flags := le.iid_flags | ri.iid_flags;
	
	self.chrono_addr_flags := le.chrono_addr_flags;	// these are on the ssn records
	
	SELF := le;
END;




// patch the flags for nonfcra prior to the rollup
temp clean_flags(risk_indicators.layout_output le, integer c) := transform
	self.version := c;
	SELF.veh_correct_vin                	:= if(isFCRA, le.veh_correct_vin                	, [] );
	SELF.veh_correct_ffid               	:= if(isFCRA, le.veh_correct_ffid               	, [] );
	SELF.bankrupt_correct_cccn          	:= if(isFCRA, le.bankrupt_correct_cccn          	, [] );
	SELF.bankrupt_correct_ffid          	:= if(isFCRA, le.bankrupt_correct_ffid          	, [] );
	SELF.lien_correct_tmsid_rmsid       	:= if(isFCRA, le.lien_correct_tmsid_rmsid       	, [] );
	SELF.lien_correct_ffid              	:= if(isFCRA, le.lien_correct_ffid              	, [] );
	SELF.crim_correct_ofk               	:= if(isFCRA, le.crim_correct_ofk               	, [] );
	SELF.crim_correct_ffid              	:= if(isFCRA, le.crim_correct_ffid              	, [] );
	SELF.prop_correct_lnfare            	:= if(isFCRA, le.prop_correct_lnfare            	, [] );
	SELF.prop_correct_ffid              	:= if(isFCRA, le.prop_correct_ffid              	, [] );
	SELF.water_correct_ffid             	:= if(isFCRA, le.water_correct_ffid             	, [] );
	SELF.water_correct_RECORD_ID        	:= if(isFCRA, le.water_correct_RECORD_ID        	, [] );
	SELF.proflic_correct_ffid           	:= if(isFCRA, le.proflic_correct_ffid           	, [] );
	SELF.proflic_correct_RECORD_ID      	:= if(isFCRA, le.proflic_correct_RECORD_ID      	, [] );
	SELF.student_correct_ffid           	:= if(isFCRA, le.student_correct_ffid           	, [] );
	SELF.student_correct_RECORD_ID      	:= if(isFCRA, le.student_correct_RECORD_ID      	, [] );
	SELF.air_correct_ffid               	:= if(isFCRA, le.air_correct_ffid               	, [] );
	SELF.air_correct_RECORD_ID          	:= if(isFCRA, le.air_correct_RECORD_ID          	, [] );
	SELF.avm_correct_ffid               	:= if(isFCRA, le.avm_correct_ffid               	, [] );
	SELF.avm_correct_RECORD_ID          	:= if(isFCRA, le.avm_correct_RECORD_ID          	, [] );
	SELF.infutor_correct_ffid           	:= if(isFCRA, le.infutor_correct_ffid           	, [] );
	SELF.infutor_correct_record_id      	:= if(isFCRA, le.infutor_correct_record_id      	, [] );
	SELF.impulse_correct_ffid           	:= if(isFCRA, le.impulse_correct_ffid           	, [] );
	SELF.impulse_correct_record_id      	:= if(isFCRA, le.impulse_correct_record_id      	, [] );
	SELF.gong_correct_ffid              	:= if(isFCRA, le.gong_correct_ffid              	, [] );
	SELF.gong_correct_record_id         	:= if(isFCRA, le.gong_correct_record_id         	, [] );
	SELF.advo_correct_ffid              	:= if(isFCRA, le.advo_correct_ffid              	, [] );
	SELF.advo_correct_record_id         	:= if(isFCRA, le.advo_correct_record_id         	, [] );
	SELF.paw_correct_ffid               	:= if(isFCRA, le.paw_correct_ffid               	, [] );
	SELF.paw_correct_record_id          	:= if(isFCRA, le.paw_correct_record_id          	, [] );
	SELF.email_data_correct_ffid        	:= if(isFCRA, le.email_data_correct_ffid        	, [] );
	SELF.email_data_correct_record_id   	:= if(isFCRA, le.email_data_correct_record_id   	, [] );
	SELF.inquiries_correct_ffid         	:= if(isFCRA, le.inquiries_correct_ffid         	, [] );
	SELF.inquiries_correct_record_id    	:= if(isFCRA, le.inquiries_correct_record_id    	, [] );
	SELF.ssn_correct_ffid               	:= if(isFCRA, le.ssn_correct_ffid               	, [] );
	SELF.ssn_correct_record_id          	:= if(isFCRA, le.ssn_correct_record_id          	, [] );
	SELF.header_correct_record_id       	:= if(isFCRA, le.header_correct_record_id       	, [] );
	SELF.ibehavior_correct_ffid	:= if(isFCRA, le.ibehavior_correct_ffid	, [] );
	SELF.ibehavior_correct_record_id	:= if(isFCRA, le.ibehavior_correct_record_id	, [] );
	self := le;
end;

ssnrecs1 := project(ssnrecs, clean_flags(left, 1));
pphonerecs1 := project(pphonerecs, clean_flags(left, 2));
combined_records1 := ungroup(ssnrecs1 + pphonerecs1);

// force the ssnrecs to be the left record on the rollup so we don't get results from rollup that are indeterminate
combined_records := group(sort( combined_records1, seq, version, record), seq );

combine_Scores := ROLLUP(combined_records,left.seq=right.seq,combo(LEFT,RIGHT));



risk_indicators.Layout_Output combineVerification(temp le) := transform

	temp_address := RECORD
		string combo_prim_range := '';
		string combo_predir := '';
		string combo_prim_name := '';
		string combo_suffix := '';
		string combo_postdir := '';
		string combo_unit_desig := '';
		string combo_sec_range := '';
		string combo_city := '';
		string combo_state := '';
		string combo_zip := '';
	end;
	
	temp_address get_ver_Addr(temp l) := TRANSFORM
		SELF.combo_prim_range 	:= l.verprim_range;
		SELF.combo_predir 		:= l.verpredir;
		SELF.combo_prim_name	:= l.verprim_name;
		SELF.combo_suffix 		:= l.versuffix;
		SELF.combo_postdir 		:= l.verpostdir;
		SELF.combo_unit_desig 	:= l.verunit_desig;
		SELF.combo_sec_range 	:= l.versec_range;
		SELF.combo_city 		:= l.vercity;
		SELF.combo_state 		:= l.verstate;
		SELF.combo_zip 			:= l.verzip;
	end;

	temp_address get_dirs_Addr(temp l) := TRANSFORM
		SELF.combo_prim_range 	:= l.dirs_prim_range;
		SELF.combo_predir 		:= l.dirs_predir;
		SELF.combo_prim_name 	:= l.dirs_prim_name;
		SELF.combo_suffix 		:= l.dirs_suffix;
		SELF.combo_postdir 		:= l.dirs_postdir;
		SELF.combo_unit_desig 	:= l.dirs_unit_desig;
		SELF.combo_sec_range 	:= l.dirs_sec_range;
		SELF.combo_city 		:= l.dirscity;
		SELF.combo_state 		:= l.dirsstate;
		SELF.combo_zip 			:= l.dirszip;
	end;

	temp_address get_dirsaddr_Addr(temp l) := TRANSFORM
		SELF.combo_prim_range 	:= l.dirsaddr_prim_range;
		SELF.combo_predir 		:= l.dirsaddr_predir;
		SELF.combo_prim_name 	:= l.dirsaddr_prim_name;
		SELF.combo_suffix 		:= l.dirsaddr_suffix;
		SELF.combo_postdir 		:= l.dirsaddr_postdir;
		SELF.combo_unit_desig 	:= l.dirsaddr_unit_desig;
		SELF.combo_sec_range 	:= l.dirsaddr_sec_range;
		SELF.combo_city 		:= l.dirsaddr_city;
		SELF.combo_state 		:= l.dirsaddr_state;
		SELF.combo_zip 			:= l.dirsaddr_zip;
	end;

	temp_address get_utili_Addr(temp l) := TRANSFORM
		SELF.combo_prim_range 	:= l.utili_prim_range;
		SELF.combo_predir 		:= l.utili_predir;
		SELF.combo_prim_name 	:= l.utili_prim_name;
		SELF.combo_suffix 		:= l.utili_suffix;
		SELF.combo_postdir 		:= l.utili_postdir;
		SELF.combo_unit_desig 	:= l.utili_unit_desig;
		SELF.combo_sec_range 	:= l.utili_sec_range;
		SELF.combo_city 		:= l.utilicity;
		SELF.combo_state 		:= l.utilistate;
		SELF.combo_zip 			:= l.utilizip;
	end;

	temp_address get_inquiryNAP_Addr(temp l) := TRANSFORM
		SELF.combo_prim_range 	:= l.inquiryNAPprim_range;
		SELF.combo_predir 		:= l.inquiryNAPpredir;
		SELF.combo_prim_name 	:= l.inquiryNAPprim_name;
		SELF.combo_suffix 		:= l.inquiryNAPsuffix;
		SELF.combo_postdir 		:= l.inquiryNAPpostdir;
		SELF.combo_unit_desig 	:= l.inquiryNAPunit_desig;
		SELF.combo_sec_range 	:= l.inquiryNAPsec_range;
		SELF.combo_city 		:= l.inquiryNAPcity;
		SELF.combo_state 		:= l.inquiryNAPst;
		SELF.combo_zip 			:= l.inquiryNAPz5;
	end;
	
	temp_address get__Addr(temp l) := TRANSFORM
		self := [];
	end;

	combo_first := MAP(le.firstscore=100 OR (le.phonever_type IN ['P','I'] and iid_constants.tscore(le.firstscore)>=iid_constants.tscore(le.dirs_firstscore)) OR 
										(le.phonever_type='A' and iid_constants.tscore(le.firstscore)>=iid_constants.tscore(le.dirsaddr_firstscore)) OR
										(le.phonever_type='U' and iid_constants.tscore(le.firstscore)>=iid_constants.tscore(le.utili_firstscore)) OR
										(le.phonever_type='S' and iid_constants.tscore(le.firstscore)>=iid_constants.tscore(le.inquiryNAPfnameScore)) => le.verfirst,
					    le.phonever_type IN ['P','I'] => le.dirsfirst,
					    le.phonever_type = 'A' => le.dirsaddr_first,
					    le.phonever_type = 'U' => le.utilifirst,
							le.phonever_type = 'S' => le.inquiryNAPfname,
							le.firstcount > 0			 => le.verfirst, // per bug 156971
					    '');
	self.combo_first := combo_first;
	
	combo_last := MAP(le.lastscore=100 OR (le.phonever_type IN ['P','I'] and iid_constants.tscore(le.lastscore)>=iid_constants.tscore(le.dirs_lastscore)) OR 
									   (le.phonever_type='A' and iid_constants.tscore(le.lastscore)>=iid_constants.tscore(le.dirsaddr_lastscore)) OR
									   (le.phonever_type='U' and iid_constants.tscore(le.lastscore)>=iid_constants.tscore(le.utili_lastscore)) OR
										 (le.phonever_type='S' and iid_constants.tscore(le.lastscore)>=iid_constants.tscore(le.inquiryNAPlnameScore))  => le.verlast,
					   le.phonever_type  IN ['P','I'] => le.dirslast,
					   le.phonever_type = 'A' => le.dirsaddr_last,
					   le.phonever_type = 'U' => le.utililast,
						 le.phonever_type = 'S' => le.inquiryNAPlname,
						 le.lastcount > 0			  => le.verlast, // per bug 156971
					   '');	
	self.combo_last := combo_last;


	combo_address := MAP(
													ExactAddrRequired and le.addrcount>0 => ROW(get_ver_addr(le)),
													ExactAddrRequired and le.phonever_type IN ['P','I'] and le.phoneaddrcount>0 => ROW(get_dirs_Addr(le)),
													ExactAddrRequired and le.phonever_type='A' and le.phoneaddr_addrcount>0 => ROW(get_dirsaddr_Addr(le)),
													ExactAddrRequired and le.phonever_type='U' and le.utiliaddr_addrcount>0 => ROW(get_utili_Addr(le)),
													ExactAddrRequired and le.phonever_type='S' and le.inquiryNAPaddrcount>0 => ROW(get_inquiryNAP_Addr(le)),	
													~ExactAddrRequired and le.addrscore=100 OR (
															(le.phonever_type IN ['P','I'] and iid_constants.tscore(le.addrscore)>=iid_constants.tscore(le.dirs_addrscore)) OR 
															(le.phonever_type='A' and iid_constants.tscore(le.addrscore)>=iid_constants.tscore(le.dirsaddr_addrscore)) OR 
															(le.phonever_type='U' and iid_constants.tscore(le.addrscore)>=iid_constants.tscore(le.utili_addrscore)) OR
															(le.phonever_type='S' and iid_constants.tscore(le.addrscore)>=iid_constants.tscore(le.inquiryNAPaddrScore))
																																			) => ROW(get_ver_addr(le)),
													~ExactAddrRequired and le.phonever_type IN ['P','I'] => ROW(get_dirs_Addr(le)),
													~ExactAddrRequired and le.phonever_type='A' => ROW(get_dirsaddr_Addr(le)),
													~ExactAddrRequired and le.phonever_type='U' => ROW(get_utili_Addr(le)),
													~ExactAddrRequired and le.phonever_type='S' => ROW(get_inquiryNAP_Addr(le)),
													~ExactAddrRequired and le.addrcount>0 => ROW(get_ver_addr(le)), // per bug 156971
													ROW(get__Addr(le)) );
	self := combo_address;
	// do we need to add an option in here for inquiry miskey in row 3?				  
	combo_hphone := MAP(le.phonever_type IN ['P','I'] AND le.dirsaddr_phonescore>89 and le.dirsaddr_phonescore<100 => le.dirsaddr_phone,	//used phone from diraddr
						le.phonever_type IN ['P','I'] AND le.utili_phonescore>89 and le.utili_phonescore<100 => le.utiliphone,	//used phone from utility
						le.phonever_type IN ['P','I'] AND le.dirs_phonescore=100 => le.phone10,
						le.phonever_type='A' => le.dirsaddr_phone,
						le.phonever_type='U' => le.utiliphone,
						le.phonever_type='S' => le.inquiryNAPphone,
						'');
	self.combo_hphone := combo_hphone;
	
	combo_wphone := IF(le.wphonewphonescore = 100, le.wphone10,'');	// just outputting the input wphone if match otherwise blank
	self.combo_wphone := combo_wphone;
	
	combo_ssn := le.versocs;
	self.combo_ssn := combo_ssn;
	
	combo_dob := IF((integer)le.verdob <> 0,le.verdob,'');
	self.combo_dob := combo_dob;
	
	combo_cmpy := IF(le.dirsaddr_cmpyscore > le.dirs_cmpyscore and le.dirsaddr_cmpyscore<>255, le.dirsaddr_cmpy, le.dirscmpy);	
	self.combo_cmpy := combo_cmpy;
	
	combo_firstscore := risk_indicators.FnameScore(combo_first, le.fname);
	self.combo_firstscore := combo_firstscore;
	
	combo_lastscore := risk_indicators.LnameScore(combo_last, le.lname);
	self.combo_lastscore := combo_lastscore;
	
	zip_score := Risk_Indicators.AddrScore.zip_score(le.in_zipcode, combo_address.combo_zip[1..5]);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, combo_address.combo_city, combo_address.combo_state, le.cityzipflag);
	combo_addrscore := IF(ExactAddrZip5andPrimRange,
												IF(zip_score=100
													 and Risk_Indicators.AddrScore.primRange_score(le.prim_range, combo_address.combo_prim_range)=100,
													 100, 11),
												Risk_Indicators.AddrScore.AddressScore( le.prim_range, le.prim_name, le.sec_range, 
																																combo_address.combo_prim_range, combo_address.combo_prim_name,
																																combo_address.combo_sec_range, zip_score, cityst_score));
	self.combo_addrscore := combo_addrscore;
	self.combo_citystatescore := cityst_score;
	self.combo_zipscore := zip_score;
	
	combo_hphonescore := risk_indicators.PhoneScore(combo_hphone, le.phone10);
	self.combo_hphonescore := combo_hphonescore;
	combo_wphonescore := risk_indicators.PhoneScore(combo_wphone, le.wphone10);
	self.combo_wphonescore := combo_wphonescore;
	combo_ssnscore := le.socsscore;
	self.combo_ssnscore := combo_ssnscore;
	combo_dobscore := le.dobscore;
	self.combo_dobscore := combo_dobscore;
	self.combo_cmpyscore := Did_add.company_name_match_score(combo_cmpy, le.employer_name);	
	
	
	
	// Only give a count of 1 if that count was used as part of the nap level
	phonefirst := IF((le.phonever_type in ['P','I'] and le.phonefirstcount>0) or (le.phonever_type='A' and le.phoneaddr_firstcount>0),1,0);	
	phonelast := IF((le.phonever_type in ['P','I']  and le.phonelastcount >0) or (le.phonever_type='A' and le.phoneaddr_lastcount >0),1,0);
	phoneaddr := IF((le.phonever_type in ['P','I']  and le.phoneaddrcount >0) or (le.phonever_type='A' and le.phoneaddr_addrcount >0),1,0);
	phonephone := IF((le.phonever_type in ['P','I'] and le.phoneverlevel > 1 and le.phonephonecount>0) or (le.phonever_type='A' and le.phoneaddr_phonecount>0),1,0);
	phonecmpy := IF((le.phonever_type in ['P','I']  and le.phonecmpycount >0) or (le.phonever_type='A' and le.phoneaddr_cmpycount >0),1,0);
	
	// Only count the utility verification if it was used in the nap level
	utiliFcount := IF(le.phonever_type='U' and le.utiliaddr_firstcount>0, 1,0);
	utiliLcount := IF(le.phonever_type='U' and le.utiliaddr_lastcount >0, 1,0);
	utiliAcount := IF(le.phonever_type='U' and le.utiliaddr_addrcount >0, 1,0);
	utiliPcount := IF(le.phonever_type='U' and le.utiliaddr_phonecount>0, 1,0);
	
	// Only count the inquiry verification if it was used in the nap level
	inquiryFcount := IF(le.phonever_type='S' and le.inquiryNAPfirstcount>0, 1,0);
	inquiryLcount := IF(le.phonever_type='S' and le.inquiryNAPlastcount >0, 1,0);
	
	merged8_9 := le.phonever_type='S' and le.phoneverlevel=12 and 
						le.inquiryNAPfirstcount>=1 and le.inquiryNAPlastcount>=1 and le.inquiryNAPaddrcount=0 and le.inquiryNAPphonecount>= 1;
	
	inquiryAcount := IF(le.phonever_type='S' and (le.inquiryNAPaddrcount >0 or merged8_9), 1,0);
	inquiryPcount := IF(le.phonever_type='S' and le.inquiryNAPphonecount>0, 1,0);
	
	combo_firstcount := le.firstcount + phonefirst + utiliFcount + inquiryFcount;
	self.combo_firstcount := combo_firstcount;
	
	combo_lastcount := le.lastcount + phonelast + utiliLcount + inquiryLcount;
	self.combo_lastcount := combo_lastcount;
	
	combo_addrcount := le.addrcount + phoneaddr + utiliAcount + inquiryAcount;
	self.combo_addrcount := combo_addrcount;
	
	combo_hphonecount := /*le.hphonecount+*/phonephone + utiliPcount + inquiryPcount;
	self.combo_hphonecount := combo_hphonecount;
	
	combo_ssncount := le.socscount;
	self.combo_ssncount := combo_ssncount;
	
	combo_dobcount := le.dobcount;
	self.combo_dobcount := combo_dobcount;
	
	combo_cmpycount := phonecmpy;	
	self.combo_cmpycount := combo_cmpycount;
	
	combo_wphonecount := le.wphonewphonecount;
	self.combo_wphonecount := combo_wphonecount;
	
	// moved combo_sec_rangescore down here so we have access to the combo_addrcount variable
	combo_sec_rangescore := map(combo_addrcount>0 and le.sec_range='' and combo_address.combo_sec_range<>'' => 15,  // we have a sec range on database, but not provided on input, default to low score
								combo_addrcount=0 or combo_address.combo_sec_range='' => 255, 
								(100 - (10 * MAX(ut.StringSimilar(le.sec_range, combo_address.combo_sec_range), ut.StringSimilar(combo_address.combo_sec_range, le.sec_range)) )) );
	self.combo_sec_rangescore := combo_sec_rangescore;	
	
	self.numelever := (INTEGER)(BOOLEAN)combo_firstcount+(INTEGER)(BOOLEAN)combo_lastcount+(INTEGER)(BOOLEAN)combo_addrcount+(INTEGER)(BOOLEAN)combo_hphonecount
							+(INTEGER)(BOOLEAN)combo_wphonecount+(INTEGER)(BOOLEAN)combo_ssncount+(INTEGER)(BOOLEAN)combo_dobcount+(INTEGER)(BOOLEAN)combo_cmpycount;
	//self.numsource := self.combo_firstcount+self.combo_lastcount+self.combo_addrcount+self.combo_hphonecount+self.combo_ssncount+self.combo_wphonecount+self.combo_dobcount+self.combo_cmpycount;
	
	// this section used to be in it's own project, taking up extra time.  
	// create combo variables above and use those instead of what the combo values are in le.combo_
	BOOLEAN addrMiskey := iid_constants.ga(combo_addrscore) AND combo_addrscore < 100 AND 
														(
														((le.prim_range<> combo_address.combo_prim_range and le.prim_range<>'') or le.prim_range='')
															or
														(combo_sec_rangescore between 70 and 99)  // adding check for sec range transposition or 1 byte off
														);
	self.addrmiskeyflag := addrMiskey;													
	self.hphonemiskeyflag := IF(iid_constants.gn(combo_hphonescore) AND combo_hphonescore < 100 and combo_hphonescore <> 95, 1, 0);
	self.socsmiskeyflag := IF(iid_constants.gn(combo_ssnscore) AND combo_ssnscore < 100, 1,0);
	self.aptscamflag := IF(le.addrvalflag='N' and ~iid_constants.ga(combo_addrscore) ,1,0);
	self.idtheftflag := MAP(le.socsverlevel IN [7,9] and le.idtheftflag='1' => '1',
					    //isDisjoint => 2,
					    '0');
					    
	self.correctdob := IF(iid_constants.g(combo_dobscore) and combo_dobscore < 100 and combo_dob[7..8] <> '00', combo_dob,'');
	self.correctssn := IF(iid_constants.gn(combo_ssnscore) and combo_ssnscore < 100, combo_ssn,'');
	self.correcthphone := IF(iid_constants.gn(combo_hphonescore) AND combo_hphonescore < 100 and combo_hphonescore <> 95, combo_hphone,'');
	self.correctaddr := IF(addrMiskey,  
							Risk_Indicators.MOD_AddressClean.street_address('',combo_address.combo_prim_range,combo_address.combo_predir,combo_address.combo_prim_name,combo_address.combo_suffix,combo_address.combo_postdir,combo_address.combo_unit_desig,combo_address.combo_sec_range),
							'');
	self.correctlast := MAP(iid_constants.g(combo_lastscore) and combo_lastscore < 100 => combo_last,
													(BSOptions & iid_constants.BSOptions.IsInstantIDv1) > 0 and le.swappedNames => combo_last,	// is this correct?  seems right.
													'');
	self.drlcvalflag := MAP(le.drlcvalflag='99' => '2',
					    le.drlcvalflag='1' => '1',
					    le.drlcvalflag>'1' => '3',
					    le.drlcvalflag);
	self.phonevalflag := IF(le.hriskphoneflag='5','3',le.phonevalflag);
	self.name_addr_phone := MAP(le.phonever_type='U' => le.utiliphone,
						   le.phonever_type='A' => le.dirsaddr_phone,  
							 le.phonever_type='S' => le.inquiryNAPphone,		// i think we need this here but not sure
						   le.phoneaddr_phonecount >= le.utiliaddr_phonecount => le.dirsaddr_phone,
						   le.utiliphone);
	
	// Because these are being opened up to randomized socials, only return true if the low issue date is not a randomized low issue date
	self.non_us_ssn := Risk_Indicators.rcSet.isCode85(le.ssn, le.socllowissue);
	
	// figure dobmatchlevel
	inDay := le.dob[7..8];
	inMonth := le.dob[5..6];
	inYear := le.dob[1..4];
	
	comboDay := combo_dob[7..8];
	comboMonth := combo_dob[5..6];
	comboYear := combo_dob[1..4];
	
	dayMatch := inDay not in ['00',''] and inDay=comboDay;
	monthMatch := inMonth not in ['00',''] and inMonth=comboMonth;
	yearMatch := inYear not in ['0000',''] and inYear=comboYear;
	
	self.dobmatchlevel := map(le.dob = '' or combo_dob = '' => '0',											// no dob input or no dob found
														~dayMatch and ~monthMatch and ~yearMatch => '1',					// nothing matches
														dayMatch and ~monthMatch and ~yearMatch => '2',						// only day matches
														~dayMatch and monthMatch and ~yearMatch => '3',						// only month matches
														dayMatch and monthMatch and ~yearMatch => '4',						// only day and month match
														dayMatch and ~monthMatch and yearMatch => '5',						// only day and year match
														~dayMatch and ~monthMatch and yearMatch => '6',						// only year matches
														~dayMatch and monthMatch and yearMatch => '7',						// only month and year match
														'8');
											
	
	self := le;
END;

finalCombo := project(combine_Scores, combineVerification(left));

//after we have the final verification, add the county name of the input address if the address was verified
with_county_name_roxie := join(finalCombo, Census_Data.Key_Fips2County,
							 LEFT.st<>'' AND LEFT.county<>'' AND left.combo_addrcount>0 and
               KEYED(LEFT.st = right.state_code) and
		           KEYED(LEFT.county = RIGHT.county_fips),
							 transform(risk_indicators.Layout_Output, self.combo_county := right.county_name, self := left),
							 LEFT OUTER, atmost(riskwise.max_atmost), keep(1));

with_county_name_thor := join(distribute(finalCombo, hash64(seq)), pull(Census_Data.Key_Fips2County),
							 LEFT.st<>'' AND LEFT.county<>'' AND left.combo_addrcount>0 and
               (LEFT.st = right.state_code) and
		           (LEFT.county = RIGHT.county_fips),
							 transform(risk_indicators.Layout_Output, self.combo_county := right.county_name, self := left),
							 LEFT OUTER, atmost(riskwise.max_atmost), keep(1), MANY LOOKUP);

#IF(onThor)
	with_county_name := group(sort(with_county_name_thor, seq, LOCAL), seq, LOCAL);
#ELSE
	with_county_name := with_county_name_roxie;
#END

// moved from iid_getphoneaddrflags because we didnt have chronoaddrflags there
with_zip_flags := risk_indicators.iid_getZipFlags(with_county_name);
							 
layout_output_tmp := record
	risk_indicators.layout_output;
	string key_sec_range := '';
end;							 
							 
// moved from iid_getphoneaddrflags because we didnt have chronoaddrflags there
layout_output_tmp flagroll(layout_output_tmp l, layout_output_tmp r) := transform
	//self := l;
	self	:= if(trim(l.sec_range) != '' and 
			trim(l.key_sec_range) = '' and
			trim(r.key_sec_range) != '', 
		r, l);	// note: previously was self := r;
END;

layout_output_tmp hrtrans(risk_indicators.layout_output l,risk_indicators.key_HRI_Address_To_SIC r) := transform
	// override the address type to a P if the high risk database finds a match to 'UNITED STATES POSTAL SERVICE'													
	addr_type := if(trim(r.sic_code)='2265', 'P', l.addr_type);	
	self.addr_type := addr_type;
	self.hriskaddrflag := MAP(trim(l.zipclass) = 'P' => '1',
														trim(l.zipclass) = 'U' => '2',
														trim(l.zipclass) = 'M' or trim(addr_type) = 'M' => '3',
														trim(l.prim_name)='' OR trim(l.z5)='' => '5',
														trim(r.sic_code)='' => '0',	 		 
														//trying to keep the cmra hits	
														trim(r.sic_code)<>'' and r.sic_code in risk_indicators.iid_constants.setCRMA => '4',		
														//trying to not keep the lift from cmra that aren't cmra that become rc 14	
														trim(r.sic_code)<>'' and trim(l.sec_range) = trim(r.sec_range) => '4',
														'');
	self.hriskcmpy := IF(self.hriskaddrflag='4',r.company_name,'');
	self.hrisksic := IF(self.hriskaddrflag='4',r.sic_code,'');
	self.hriskphone := '';
	self.hriskaddr := IF(self.hriskaddrflag='4',Risk_Indicators.MOD_AddressClean.street_address('',r.prim_range,r.predir,r.prim_name,r.suffix,r.postdir,'',r.sec_range),'');
	self.hriskcity := IF(self.hriskaddrflag='4',r.city,'');
	self.hriskstate := IF(self.hriskaddrflag='4',r.state,'');
	self.hriskzip := IF(self.hriskaddrflag='4',r.z5,'');
	self.addrcommflag := MAP(	l.hriskphoneflag='6' => '1',
														self.hriskaddrflag='4' => '2',
														'0');
	self.key_sec_range := r.sec_range;
	self := l;
END;

layout_output_tmp hrtrans_FCRA(risk_indicators.layout_output l,risk_indicators.key_HRI_Address_To_SIC_filtered_FCRA r) := transform
	// override the address type to a P if the high risk database finds a match to 'UNITED STATES POSTAL SERVICE'													
	addr_type := if(trim(r.sic_code)='2265', 'P', l.addr_type);	
	self.addr_type := addr_type;
	
	// see which chronology matches input and then check the override addr flags to see if we need to override the key result here
	checkHRoverride := map(	risk_indicators.ga(l.chronoaddrscore) => l.chrono_addr_flags.highRisk,
													risk_indicators.ga(l.chronoaddrscore2) => l.chrono_addr_flags2.highRisk,
													risk_indicators.ga(l.chronoaddrscore3) => l.chrono_addr_flags3.highRisk,
													'');
	self.hriskaddrflag := MAP(checkHRoverride in ['0','N'] => '0',
														checkHRoverride in ['1','Y'] => '4',	// considered high risk in rv attributes
														trim(l.zipclass) = 'P' => '1',
														trim(l.zipclass) = 'U' => '2',
														trim(l.zipclass) = 'M' or trim(addr_type) = 'M' => '3',
														trim(l.prim_name)='' OR trim(l.z5)='' => '5',
														trim(r.sic_code)='' => '0',	
														//with the new cmra code we don't want to impact rc 14's		 
														//trying to keep the cmra hits	
														trim(r.sic_code)<>'' and r.sic_code in risk_indicators.iid_constants.setCRMA => '4',		
														//trying to not keep the lift from cmra that aren't cmra that become rc 14	
														trim(r.sic_code)<>'' and trim(l.sec_range) = trim(r.sec_range) => '4',														
														'');
	self.hriskcmpy := IF(self.hriskaddrflag='4',r.company_name,'');
	self.hrisksic := IF(self.hriskaddrflag='4',if(l.isPrison, '2225', r.sic_code),'');	// need to set this to 2225 if corrections says this is a prison
	self.hriskphone := '';
	self.hriskaddr := IF(self.hriskaddrflag='4',Risk_Indicators.MOD_AddressClean.street_address('',r.prim_range,r.predir,r.prim_name,r.suffix,r.postdir,'',r.sec_range),'');
	self.hriskcity := IF(self.hriskaddrflag='4',r.city,'');
	self.hriskstate := IF(self.hriskaddrflag='4',r.state,'');
	self.hriskzip := IF(self.hriskaddrflag='4',r.z5,'');
	self.addrcommflag := MAP(	l.hriskphoneflag='6' => '1',
														self.hriskaddrflag='4' => '2',
														'0');
	self.key_sec_range := r.sec_range;	
	self := l;
END;


biggerrec_roxie := if (isFCRA,
			join(with_zip_flags,risk_indicators.key_HRI_Address_To_SIC_filtered_FCRA,
				left.z5!='' and left.prim_name != '' and
				keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and 
				keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
				keyed(ut.NNEQ(left.sec_range, right.sec_range)) AND 
				// check date
				right.dt_first_seen < left.historydate,hrtrans_FCRA(left,right),left outer,
				ATMOST(keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
					  keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
						keyed(ut.NNEQ(left.sec_range, right.sec_range)), RiskWise.max_atmost), keep(100)),
			join(with_zip_flags,risk_indicators.key_HRI_Address_To_SIC,
				left.z5!='' and left.prim_name != '' and
				keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and 
				keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
				keyed(ut.NNEQ(left.sec_range, right.sec_range)) AND 
				// check date
				right.dt_first_seen < left.historydate,hrtrans(left,right),left outer,
				ATMOST(keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
					  keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
						keyed(ut.NNEQ(left.sec_range, right.sec_range)), RiskWise.max_atmost), keep(100)));

biggerrec_thor := if (isFCRA,
			join(distribute(with_zip_flags, hash64(z5, prim_name, prim_range)),
				distribute(pull(risk_indicators.key_HRI_Address_To_SIC_filtered_FCRA), hash64(z5, prim_name, prim_range)),
				left.z5!='' and left.prim_name != '' and
				(left.z5=right.z5) and (left.prim_name=right.prim_name) and (left.addr_suffix=right.suffix) and 
				(left.predir=right.predir) and (left.postdir=right.postdir) and (left.prim_range=right.prim_range) and 
				(ut.NNEQ(left.sec_range, right.sec_range)) AND 
				// check date
				right.dt_first_seen < left.historydate,hrtrans_FCRA(left,right),left outer, keep(100), LOCAL),
			join(distribute(with_zip_flags, hash64(z5, prim_name, prim_range)),
				distribute(pull(risk_indicators.key_HRI_Address_To_SIC), hash64(z5, prim_name, prim_range)),
				left.z5!='' and left.prim_name != '' and
				(left.z5=right.z5) and (left.prim_name=right.prim_name) and (left.addr_suffix=right.suffix) and 
				(left.predir=right.predir) and (left.postdir=right.postdir) and (left.prim_range=right.prim_range) and 
				(ut.NNEQ(left.sec_range, right.sec_range)) AND 
				// check date
				right.dt_first_seen < left.historydate,hrtrans(left,right),left outer, keep(100), LOCAL));

#IF(onThor)
	biggerrec := group(sort(biggerrec_thor, seq, LOCAL), seq, LOCAL);
#ELSE
	biggerrec := biggerrec_roxie;
#END

flagrecs_tmp := rollup(biggerrec, left.seq = right.seq, flagroll(left,right));
flagrecs := project(flagrecs_tmp, transform(risk_indicators.layout_output, self := left));

// moved this searching here from instantid_records ret_temp because CIID needs these results as well as FlexID
// Adapted from Risk_Indicators.getAllBocaShellData

layout_output_tmp get_hotlist(flagrecs le, USPIS_HotList.key_addr_search_zip ri) := transform
				self.USPISHotList := ri.zip<>'';
				self.key_sec_range := ri.sec_range;
				self := le;
end; 

with_hotlist_roxie := 
	join(flagrecs, USPIS_HotList.key_addr_search_zip, 
		left.z5<>'' and left.prim_name<>'' and
		keyed(left.z5=right.zip) and
		keyed(left.prim_range=right.prim_range) and
		keyed(left.prim_name=right.prim_name) and
		keyed(left.addr_suffix=right.addr_suffix) and
		keyed(left.predir=right.predir) and
		keyed(left.postdir=right.postdir) and
		keyed(ut.NNEQ(left.sec_range, right.sec_range)),
			get_hotlist(LEFT,RIGHT),
			left outer, atmost(riskwise.max_atmost),keep(10));

with_hotlist_thor := 
	join(distribute(flagrecs, hash64(z5, prim_range, prim_name)), 
		distribute(pull(USPIS_HotList.key_addr_search_zip), hash64(zip, prim_range, prim_name)), 
		left.z5<>'' and left.prim_name<>'' and
		(left.z5=right.zip) and
		(left.prim_range=right.prim_range) and
		(left.prim_name=right.prim_name) and
		(left.addr_suffix=right.addr_suffix) and
		(left.predir=right.predir) and
		(left.postdir=right.postdir) and
		(ut.NNEQ(left.sec_range, right.sec_range)),
			get_hotlist(LEFT,RIGHT),
			left outer, atmost(riskwise.max_atmost),keep(10), LOCAL);

#IF(onThor)
	with_hotlist := group(sort(with_hotlist_thor, seq), seq);
#ELSE
	with_hotlist := with_hotlist_roxie;
#END

// Adapted from Risk_Indicators.Boca_Shell_Advo
layout_output_tmp get_advo(with_hotlist le, Advo.Key_Addr1 ri) := TRANSFORM
											self.ADVODoNotDeliver := TRIM(ri.dnd_indicator) = 'Y';
											self.ADVOAddressVacancyIndicator := TRIM(ri.Address_Vacancy_Indicator) = 'Y';
											self.ADVOResidentialOrBusinessInd := TRIM(ri.residential_or_business_ind);
											self.ADVODropIndicator := TRIM(ri.Drop_Indicator);
											self.key_sec_range := ri.sec_range;	
											self := le
END; 

with_advo_temp_roxie := join(with_hotlist, Advo.Key_Addr1,
					left.z5 != '' and 
					left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(ut.NNEQ(left.sec_range, right.sec_range)), 
					get_Advo(LEFT,RIGHT), left outer,
					atmost(riskwise.max_atmost), keep(10));

with_advo_temp_thor := join(distribute(with_hotlist, hash64(z5, prim_range, prim_name)), 
					distribute(pull(Advo.Key_Addr1), hash64(zip, prim_range, prim_name)),
					left.z5 != '' and 
					left.prim_range != '' and
					(left.z5 = right.zip) and
					(left.prim_range = right.prim_range) and
					(left.prim_name = right.prim_name) and
					(left.addr_suffix = right.addr_suffix) and
					(left.predir = right.predir) and
					(left.postdir = right.postdir) and
					(ut.NNEQ(left.sec_range, right.sec_range)), 
					get_Advo(LEFT,RIGHT), left outer,
					atmost(riskwise.max_atmost), keep(10), LOCAL);

#IF(onThor)
	with_advo_temp := group(sort(distribute(with_advo_temp_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
#ELSE
	with_advo_temp := with_advo_temp_roxie;
#END

Layout_Output_tmp rollWithAdvo(with_advo_temp l, with_advo_temp r) := TRANSFORM
//	SELF := le;
	self := if(trim(l.sec_range) != '' 
		and trim(l.key_sec_range) = ''
		and trim(r.key_sec_range) != '', r, l);	// note: previously was self := r;
END;
with_advo_rolled := rollup(with_advo_temp, left.seq = right.seq, rollWithAdvo(left,right));
//don't append ADVO data if it's restricted in the DRM	
with_advo := if(isFCRA or datarestriction[iid_constants.posADVORestriction] = '1', flagrecs, project(with_advo_rolled, Risk_Indicators.Layout_Output));					
		
Risk_Indicators.Layout_Output getDIDdeceased(with_advo le, 	doxie.key_death_masterV2_ssa_DID ri) := TRANSFORM
																	SELF.DIDdeceased := ri.l_did<>0;
																	SELF.DIDdeceasedDate := (UNSIGNED)ri.dod8;
																	SELF.DIDdeceasedDOB := (UNSIGNED)ri.dob8;
																	SELF.DIDdeceasedfirst := ri.fname;
																	SELF.DIDdeceasedlast := ri.lname;
																	SELF := le;
END;
	
withDIDdeceased_nonfcra_roxie := JOIN(with_advo, doxie.key_death_masterV2_ssa_DID, 
												LEFT.did<>0 AND KEYED(LEFT.did=RIGHT.l_did) AND
												(UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND
												(right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
												getDIDdeceased(LEFT, RIGHT),	
												LEFT OUTER, ATMOST(riskwise.max_atmost), KEEP(100));

withDIDdeceased_nonfcra_thor := JOIN(distribute(with_advo, hash64(did)), 
												distribute(pull(doxie.key_death_masterV2_ssa_DID), hash64(l_did)), 
												LEFT.did<>0 AND (LEFT.did=RIGHT.l_did) AND
												(UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND
												(right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
												getDIDdeceased(LEFT, RIGHT),	
												LEFT OUTER, ATMOST(LEFT.did=RIGHT.l_did, riskwise.max_atmost), KEEP(100), LOCAL);
										
#IF(onThor)
	withDIDdeceased_nonfcra := group(sort(distribute(withDIDdeceased_nonfcra_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
#ELSE
	withDIDdeceased_nonfcra := withDIDdeceased_nonfcra_roxie;
#END

withDIDdeceased_FCRA_roxie := JOIN(with_advo, doxie.key_death_masterV2_ssa_DID_fcra, 
												LEFT.did<>0 AND KEYED(LEFT.did=RIGHT.l_did) AND
												(UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND
												(right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
													getDIDdeceased(LEFT,RIGHT),												
												LEFT OUTER, ATMOST(riskwise.max_atmost), KEEP(100));

withDIDdeceased_FCRA_thor := JOIN(distribute(with_advo, hash64(did)), 
												distribute(pull(doxie.key_death_masterV2_ssa_DID_fcra), hash64(l_did)), 
												LEFT.did<>0 AND (LEFT.did=RIGHT.l_did) AND
												(UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND
												(right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
													getDIDdeceased(LEFT,RIGHT),												
												LEFT OUTER, ATMOST(LEFT.did=RIGHT.l_did, riskwise.max_atmost), KEEP(100), LOCAL);

#IF(onThor)
	withDIDdeceased_FCRA := group(sort(distribute(withDIDdeceased_FCRA_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
#ELSE
	withDIDdeceased_FCRA := withDIDdeceased_FCRA_roxie;
#END

withDIDdeceased := if(isfcra, withDIDdeceased_FCRA, withDIDdeceased_nonFCRA);												

Risk_Indicators.Layout_Output rollDeceased(withDIDdeceased le, withDIDdeceased ri) := TRANSFORM
	SELF := le;

END;

rolledDeceased := ROLLUP(SORT(withDIDdeceased, -DIDdeceasedfirst,-DIDdeceasedlast,-DIDdeceasedDate,-DIDdeceasedDOB), TRUE, rollDeceased(LEFT,RIGHT));	

combinedFinal := if((BSOptions & iid_constants.BSOptions.IsInstantIDv1) > 0 or bsVersion >= 50, rolledDeceased, with_advo);	// only do the deceased by DID for CIID/FLEXID											
//combinedFinal := project(combinedFinal_tmp, Risk_Indicators.Layout_Output);

 //output(ssnrecs, named('ssnrecs'));
 //output(pphonerecs, named('pphonerecs'));
 //output(combined_records, named('combined_records'));
 //output(combine_Scores, named('combine_Scores'));
 //output(finalCombo, named('finalCombo'));
 //output(biggerrec);
 //output(flagrecs);
 //output(with_hotlist);
 //output(with_advo_temp);
 //OUTPUT(	with_advo_rolled);	
return combinedFinal;

end;