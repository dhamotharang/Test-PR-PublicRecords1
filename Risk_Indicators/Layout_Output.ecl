import iesp;

export Layout_Output := RECORD
	
	BOOLEAN trueDID := false;
	string15 adlCategory := '';
	STRING30 account := '';
	
	Layout_Input;
	
	STRING32 riskwiseid := '';

	STRING1 hriskphoneflag := '';  // pi hriskphoneflag
	STRING1 hphonetypeflag := '';	 // pw hriskphoneflag
	STRING1 wphonetypeflag := '';  // this is the same as hriskphoneflag but pw instead of pi logic
	STRING1 phonevalflag := '';  // pi phonevalflag
	STRING1 hphonevalflag := '';  // pw phonevalflag
	STRING1 wphonevalflag := '';
	STRING1 phonezipflag := '';
	STRING1 PWphonezipflag := '';  // pw phonezipflag
	BOOLEAN phonedissflag := false;
	BOOLEAN wphonedissflag := false;
	UNSIGNED1 phoneverlevel := 0;
	STRING1 phonever_type := '';
	STRING1 hriskaddrflag := '';
	STRING1 pullidflag := '';
	STRING1 decsflag := '';
	unsigned4 deceasedDate := 0;
	unsigned4 deceasedDOB := 0;
	string15 deceasedfirst := '';
	string20 deceasedlast := '';
	STRING1 socsdobflag := '';
	STRING1 PWsocsdobflag := '';
	STRING1 socsvalflag := '';
	STRING1 PWsocsvalflag := '';
	STRING1 socsRCISflag := '';
	STRING8 socllowissue := '';
	STRING8 soclhighissue := '';
	STRING2 soclstate := '';
	UNSIGNED1 socsverlevel := 0;
	STRING1 areacodesplitflag := '';
	STRING8 areacodesplitdate := '';
	STRING3 altareacode := '';
	STRING1 reverse_areacodesplitflag := '';
	STRING1 addrvalflag := '';
	STRING1 dwelltype := '';
	STRING2 src := '';
	UNSIGNED3 dt_last_seen := 0;
	STRING1 bansflag := '';
	string8 bansdatefiled :='';
	
	BOOLEAN coaalertflag := false;
	STRING15 coafirst := '';
	STRING20 coalast := '';
	STRING10 coaprim_range := '';
	STRING2 coapredir := '';
	string28 coaprim_name := '';
	STRING4 coasuffix := '';
	STRING2 coapostdir := '';
	STRING10 coaunit_desig := '';
	STRING8 coasec_range := '';
	STRING30 coacity := '';
	STRING2 coastate := '';
	STRING9 coazip := '';
	
	STRING1 idtheftflag := '';
	BOOLEAN aptscamflag := false;
	
	
// This section purely support Boca Shell
	STRING50 sources := '';
	STRING50 firstnamesources := '';
	STRING50 lastnamesources := '';
	STRING50 addrsources := '';
	STRING50 socssources := '';
	
	STRING50 hphonesources := '';
	STRING50 wphonesources := '';
	string50 dobsources := '';
	string50 cmpysources := '';
	
	unsigned1 num_nonderogs := 0;
	unsigned1 num_nonderogs30 := 0;
	unsigned1 num_nonderogs90 := 0;
	unsigned1 num_nonderogs180 := 0;
	unsigned1 num_nonderogs12 := 0;
	unsigned1 num_nonderogs24 := 0;
	unsigned1 num_nonderogs36 := 0;
	unsigned1 num_nonderogs60 := 0;
	
	// these should be 1-per source
	UNSIGNED2 firstcount := 0;
	UNSIGNED2 lastcount := 0;
	UNSIGNED2 addrcount := 0;
	UNSIGNED2 hphonecount := 0;
	UNSIGNED2 wphonecount := 0;
	UNSIGNED2 socscount := 0;
	UNSIGNED2 dobcount := 0;
	UNSIGNED2 cmpycount := 0;
	
	UNSIGNED2 numelever := 0;
	UNSIGNED2 numsource := 0;	
	
	BOOLEAN eqfsfirstcount := 0;
	BOOLEAN eqfslastcount := 0;
	BOOLEAN eqfsaddrcount := 0;
	BOOLEAN eqfssocscount := 0;
	
	BOOLEAN tufirstcount := 0;
	BOOLEAN tulastcount := 0;
	BOOLEAN tuaddrcount := 0;
	BOOLEAN tusocscount := 0;
	
	BOOLEAN dlfirstcount := 0;
	BOOLEAN dllastcount := 0;
	BOOLEAN dladdrcount := 0;
	BOOLEAN dlsocscount := 0;
	
	BOOLEAN emfirstcount := 0;
	BOOLEAN emlastcount := 0;
	BOOLEAN emaddrcount := 0;
	BOOLEAN emsocscount := 0;
	
	BOOLEAN bkfirstcount := 0;
	BOOLEAN bklastcount := 0;
	BOOLEAN bkaddrcount := 0;
	BOOLEAN bksocscount := 0;
	
	UNSIGNED3 adl_eqfs_first_seen := 0;
	UNSIGNED3 adl_eqfs_last_seen := 0;
	unsigned2 EQ_count := 0;
	unsigned2 TU_count := 0;
	unsigned2 DL_count := 0;
	unsigned2 PR_count := 0;
	unsigned2 V_count := 0;
	unsigned2 EM_count := 0;
	unsigned2 W_count := 0;
	unsigned3 adl_TU_first_seen := 0;
	unsigned3 adl_TU_last_seen := 0;
	unsigned3 adl_DL_first_seen := 0;
	unsigned3 adl_DL_last_seen := 0;
	unsigned3 adl_PR_first_seen := 0;
	unsigned3 adl_PR_last_seen := 0;
	unsigned3 adl_V_first_seen := 0;
	unsigned3 adl_V_last_seen := 0;
	unsigned3 adl_EM_first_seen := 0;
	unsigned3 adl_EM_last_seen := 0;
	unsigned3 adl_W_first_seen := 0;
	unsigned3 adl_W_last_seen := 0;
	UNSIGNED3 adl_other_first_seen := 0;
	UNSIGNED3 adl_other_last_seen := 0;
// End Boca Shell Section
	
	UNSIGNED2 phonefirstcount := 0;
	UNSIGNED2 phonelastcount := 0;
	UNSIGNED2 phoneaddrcount := 0;
	UNSIGNED2 phonephonecount := 0;
	UNSIGNED2 phonecmpycount := 0;
	BOOLEAN   phone_disconnected := false;
	UNSIGNED3 phone_disconnectdate := 0;
	UNSIGNED3 phone_disconnectcount := 0;
	UNSIGNED4 phone_date_last_seen := 0;
	UNSIGNED4 phone_date_first_seen := 0;
	
	UNSIGNED2 phoneaddr_firstcount := 0;
	UNSIGNED2 phoneaddr_lastcount := 0;
	UNSIGNED2 phoneaddr_addrcount := 0;
	UNSIGNED2 phoneaddr_phonecount := 0;
	UNSIGNED2 phoneaddr_cmpycount := 0;
	BOOLEAN   phoneaddr_disconnected := false;
	UNSIGNED3 phoneaddr_disconnectdate := 0;
	UNSIGNED4 phoneaddr_date_last_seen := 0;
	UNSIGNED4 phoneaddr_date_first_seen := 0;

	
	UNSIGNED2 utiliaddr_firstcount := 0;
	UNSIGNED2 utiliaddr_lastcount := 0;
	UNSIGNED2 utiliaddr_addrcount := 0;
	UNSIGNED2 utiliaddr_phonecount := 0;
	UNSIGNED2 utiliaddr_socscount := 0;
	UNSIGNED3 utiliaddr_date := 0;
	UNSIGNED3 utiliaddr_first_seen_date := 0;
	UNSIGNED3 utiliaddr_last_seen_date := 0;

		STRING15 verfirst := '';
	STRING20 verlast := '';
	STRING30 vercmpy := '';
	boolean  veraddr_isBest := false;
	string10 verprim_range := '';
	string2  verpredir:= '';
	string28 verprim_name:= '';
	string4  versuffix:= '';
	string2  verpostdir:= '';
	string10 verunit_desig:= '';
	string8  versec_range:= '';
	STRING30 vercity := '';
	STRING2 verstate := '';
	STRING9 verzip := '';
	string3 vercounty := '';
	string7 vergeo_blk := '';
	UNSIGNED3 verdate_first := 0;
	UNSIGNED3 verdate_last := 0;
	STRING10 verhphone := '';
	STRING10 verwphone := '';
	STRING9 versocs := '';
	STRING8 verdob := '';

	UNSIGNED1 firstscore := 0;
	UNSIGNED1 lastscore := 0;
	UNSIGNED1 cmpyscore := 0;
	UNSIGNED1 addrscore := 0;
	unsigned1 citystatescore := 0;
	unsigned1 zipscore := 0;
	UNSIGNED1 hphonescore := 0;
	UNSIGNED1 wphonescore := 0;
	UNSIGNED1 socsscore := 0;
	STRING1   socsvalid := '';
	unsigned2 socsdidCount := 0;
	UNSIGNED1 dobscore := 0;
	
	BOOLEAN socsmiskeyflag := false;
	BOOLEAN hphonemiskeyflag := false;
	BOOLEAN addrmiskeyflag := false;
	
	STRING1 addrcommflag := '';
	
	STRING30 hriskcmpy := '';
	STRING6 hrisksic := '';
	STRING10 hriskphone := '';
	STRING50 hriskaddr := '';
	STRING30 hriskcity := '';
	STRING2 hriskstate := '';
	STRING9 hriskzip := '';
	
	STRING30 hriskcmpyphone := '';
	STRING6 hrisksicphone := '';
	STRING10 hriskphonephone := '';
	STRING50 hriskaddrphone := '';
	STRING30 hriskcityphone := '';
	STRING2 hriskstatephone := '';
	STRING9 hriskzipphone := '';	
	
	UNSIGNED3 disthphoneaddr := 0;
	UNSIGNED3 disthphonewphone := 0;
	UNSIGNED3 distwphoneaddr := 0;
	
	UNSIGNED1 numfraud := 0;
	
	STRING8 correctdob := '';
	STRING9 correctssn := '';
	STRING50 correctaddr := '';
	STRING10 correcthphone := '';
	STRING20 correctlast := '';
	
	STRING15 dirsfirst := '';
	STRING20 dirslast := '';
	string10 dirs_prim_range := '';
	string2  dirs_predir:= '';
	string28 dirs_prim_name:= '';
	string4  dirs_suffix:= '';
	string2  dirs_postdir:= '';
	string10 dirs_unit_desig:= '';
	string8  dirs_sec_range:= '';
	STRING30 dirscity := '';
	STRING2 dirsstate := '';
	STRING9 dirszip := '';
	STRING50 dirscmpy := '';
	UNSIGNED1 dirs_firstscore := 0;
	UNSIGNED1 dirs_lastscore := 0;
	UNSIGNED1 dirs_addrscore := 0;	
	unsigned1 dirs_citystatescore := 0;
	unsigned1 dirs_zipscore := 0;
	UNSIGNED1 dirs_phonescore := 0;
	UNSIGNED1 dirs_cmpyscore := 0;
	
	STRING15 dirsaddr_first := '';
	STRING20 dirsaddr_last := '';
	string10 dirsaddr_prim_range := '';
	string2  dirsaddr_predir:= '';
	string28 dirsaddr_prim_name:= '';
	string4  dirsaddr_suffix:= '';
	string2  dirsaddr_postdir:= '';
	string10 dirsaddr_unit_desig:= '';
	string8  dirsaddr_sec_range:= '';
	STRING30 dirsaddr_city := '';
	STRING2 dirsaddr_state := '';
	STRING9 dirsaddr_zip := '';
	STRING10 dirsaddr_phone := '';
	STRING50 dirsaddr_cmpy := '';
	UNSIGNED1 dirsaddr_firstscore := 0;
	UNSIGNED1 dirsaddr_lastscore := 0;
	UNSIGNED1 dirsaddr_addrscore := 0;
	unsigned1 dirsaddr_citystatescore := 0;
	unsigned1 dirsaddr_zipscore := 0;
	UNSIGNED1 dirsaddr_phonescore := 0;
	UNSIGNED1 dirsaddr_cmpyscore := 0;
	
	STRING15 utilifirst := '';
	STRING20 utililast := '';
	string10 utili_prim_range := '';
	string2  utili_predir:= '';
	string28 utili_prim_name:= '';
	string4  utili_suffix:= '';
	string2  utili_postdir:= '';
	string10 utili_unit_desig:= '';
	string8  utili_sec_range:= '';
	STRING30 utilicity := '';
	STRING2 utilistate := '';
	STRING9 utilizip := '';
	STRING10 utiliphone := '';
	UNSIGNED1 utili_firstscore := 0;
	UNSIGNED1 utili_lastscore := 0;
	UNSIGNED1 utili_addrscore := 0;
	unsigned1 utili_citystatescore := 0;
	unsigned1 utili_zipscore := 0;
	UNSIGNED1 utili_phonescore := 0;
	
	STRING2 nxx_type := '';  // hphone
	STRING2 nxx_type2 := '';  // wphone
	STRING1 phonetype := '';	//hphone
	STRING1 wphonetype := '';	//wphone
	STRING1 ziptypeflag := '';  
	string1 zipclass := '';  // comes from citystatezip
		string28 zipcity := '';  // comes from citystatezip
	
	STRING2 drlcvalflag := '';
	STRING1 drlcsoundx := '';  // all these drlc soundex fields are actually flags
	STRING1 drlcfirst := '';
	STRING1 drlclast := '';
	STRING1 drlcmiddle := '';
	STRING1 drlcsocs := '';
	STRING1 drlcdob := '';
	STRING1 drlcgender := '';
	
	BOOLEAN dlMatch := false;
	STRING1 dlsocsvalflag := '';
	STRING1 dlsocsdobflag := '';
	
	STRING1 statezipflag := '';
	STRING1 cityzipflag := '';
	STRING1 hphonestateflag := '0';
	
	boolean chronoaddr_isBest := false;
	string15 chronofirst := '';
	string20 chronolast := '';
	string10 chronoprim_range := '';
	string2  chronopredir:= '';
	string28 chronoprim_name:= '';
	string4  chronosuffix:= '';
	string2  chronopostdir:= '';
	string10 chronounit_desig:= '';
	string8  chronosec_range:= '';
	STRING30 chronocity := '';
	STRING2 chronostate := '';
	STRING5 chronozip := '';
	STRING4 chronozip4 := '';
	string3 chronocounty := '';
	string7 chronogeo_blk := '';
	UNSIGNED3 chronodate_first := 0;
	UNSIGNED3 chronodate_last := 0;
	STRING10 chronophone := '';
	UNSIGNED1	chronoaddrscore := 0;
	STRING50 chrono_sources := '';
	UNSIGNED2 chrono_addrcount := 0;
	BOOLEAN chrono_eqfsaddrcount := 0;
	BOOLEAN chrono_dladdrcount := 0;
	BOOLEAN chrono_emaddrcount := 0;
	Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags;
	
	boolean chronoaddr_isBest2 := false;
	string15 chronofirst2 := '';
	string20 chronolast2 := '';
	string10 chronoprim_range2 := '';
	string2  chronopredir2 := '';
	string28 chronoprim_name2 := '';
	string4  chronosuffix2 := '';
	string2  chronopostdir2 := '';
	string10 chronounit_desig2 := '';
	string8  chronosec_range2 := '';
	STRING30 chronocity2 := '';
	STRING2 chronostate2 := '';
	STRING5 chronozip2 := '';
	STRING4 chronozip4_2 := '';
	string3 chronocounty2 := '';
	string7 chronogeo_blk2 := '';
	UNSIGNED3 chronodate_first2 := 0;
	UNSIGNED3 chronodate_last2 := 0;
	STRING10 chronophone2 := '';
	UNSIGNED1 chronoaddrscore2 := 0;
	STRING50 chrono_sources2 := '';
	UNSIGNED2 chrono_addrcount2 := 0;
	BOOLEAN chrono_eqfsaddrcount2 := 0;
	BOOLEAN chrono_dladdrcount2 := 0;
	BOOLEAN chrono_emaddrcount2 := 0;
	Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags2;
	
	boolean chronoaddr_isBest3 := false;
	string15 chronofirst3 := '';
	string20 chronolast3 := '';
	string10 chronoprim_range3 := '';
	string2  chronopredir3 := '';
	string28 chronoprim_name3 := '';
	string4  chronosuffix3 := '';
	string2  chronopostdir3 := '';
	string10 chronounit_desig3 := '';
	string8  chronosec_range3 := '';
	STRING30 chronocity3 := '';
	STRING2 chronostate3 := '';
	STRING5 chronozip3 := '';
	STRING4 chronozip4_3 := '';
	string3 chronocounty3 := '';
	string7 chronogeo_blk3 := '';
	UNSIGNED3 chronodate_first3 := 0;
	UNSIGNED3 chronodate_last3 := 0;
	STRING10 chronophone3 := '';
	UNSIGNED1 chronoaddrscore3 := 0;	
	STRING50 chrono_sources3 := '';
	UNSIGNED2 chrono_addrcount3 := 0;
	BOOLEAN chrono_eqfsaddrcount3 := 0;
	BOOLEAN chrono_dladdrcount3 := 0;
	BOOLEAN chrono_emaddrcount3 := 0;
	Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags3;
	
	UNSIGNED1 chronophone_namematch := 0;	
	UNSIGNED1 chronophone2_namematch := 0;
	UNSIGNED1 chronophone3_namematch := 0;
	unsigned1 chronoMatchLevel := 0;
	unsigned1 chronoMatchLevel2 := 0;
	unsigned1 chronoMatchLevel3 := 0;
	unsigned5 chronoActivePhone := 0;
	unsigned5 chronoActivePhone2 := 0;
	unsigned5 chronoActivePhone3 := 0;
	
	unsigned1 inputAddrMatchLevel := 0;
	unsigned5 inputAddrActivePhone := 0;
	
	string20	altfirst := '';
	STRING20 altlast := '';
	STRING8 altlast_date := '';
	STRING8 altearly_date := '';
	string20	altfirst2 := '';
	STRING20 altlast2 := '';
	STRING8 altlast_date2 := '';
	STRING8 altearly_date2 := '';
	string20	altfirst3 := '';
	STRING20 altlast3 := '';
	STRING8 altlast_date3 := '';
	STRING8 altearly_date3 := '';
	UNSIGNED1 altlast_count := 0;
	
	BOOLEAN lastssnmatch := true;
	BOOLEAN lastssnmatch2 := true;
	BOOLEAN firstssnmatch := true;
	BOOLEAN ssnexists := true;
	
	STRING15 combo_first := '';
	STRING20 combo_last := '';
	string10 combo_prim_range := '';
	string2  combo_predir:= '';
	string28 combo_prim_name:= '';
	string4  combo_suffix:= '';
	string2  combo_postdir:= '';
	string10 combo_unit_desig:= '';
	string8  combo_sec_range:= '';
	STRING30 combo_city := '';
	STRING2 combo_state := '';
	STRING9 combo_zip := '';
	string20 combo_county := '';
	STRING10 combo_hphone := '';
	STRING10 combo_wphone := '';
	STRING9 combo_ssn := '';
	STRING8 combo_dob := '';
	STRING50 combo_cmpy := '';
	UNSIGNED1 combo_firstscore := 0;
	UNSIGNED1 combo_lastscore := 0;
	UNSIGNED1 combo_addrscore := 0;
	unsigned1 combo_citystatescore := 0;
	unsigned1 combo_zipscore := 0;
	UNSIGNED1 combo_sec_rangescore := 0;
	UNSIGNED1 combo_hphonescore := 0;
	UNSIGNED1 combo_wphonescore := 0;
	UNSIGNED1 combo_ssnscore := 0;
	UNSIGNED1 combo_dobscore := 0;
	UNSIGNED1 combo_cmpyscore := 0;
	UNSIGNED1 combo_firstcount := 0;
	UNSIGNED1 combo_lastcount := 0;
	UNSIGNED1 combo_addrcount := 0;
	UNSIGNED1 combo_hphonecount := 0;
	UNSIGNED1 combo_ssncount := 0;
	UNSIGNED1 combo_dobcount := 0;
	UNSIGNED1 combo_cmpycount := 0;
	UNSIGNED1 combo_wphonecount := 0;
	
	UNSIGNED2 score1 := 0;
	UNSIGNED2 score2 := 0;
	UNSIGNED2 score3 := 0;
	UNSIGNED2 score4 := 0;
	
	UNSIGNED1 header_footprint := 0;
		
	STRING10 hphonelat := '';
	STRING11 hphonelong := '';
	
	BOOLEAN isPOTS := false;
	
	STRING60 watchlist_table := '';
	STRING10 watchlist_record_number := '';
	STRING120 watchlist_program :='';
	STRING20 watchlist_fname := '';
	STRING20 watchlist_lname := '';
	STRING50 watchlist_address := '';
	// parsed watchlist address
	STRING10 WatchlistPrimRange := '';
	STRING2  WatchlistPreDir := '';
	STRING28 WatchlistPrimName := '';
	STRING4  WatchlistAddrSuffix := '';
	STRING2  WatchlistPostDir := '';
	STRING10 WatchlistUnitDesignation := '';
	STRING8  WatchlistSecRange := '';
	STRING30 watchlist_city := '';
	STRING2 watchlist_state := '';
	STRING9 watchlist_zip := '';
	STRING30 watchlist_contry := '';
	STRING50 watchlist_entity_name := '';
	INTEGER watchlist_num_with_name := 0;
	
	STRING30 wphonename := '';
	STRING50 wphoneaddr := '';
	STRING30 wphonecity := '';
	STRING2 wphonestate := '';
	STRING9 wphonezip := '';

	UNSIGNED1 wphonewphonecount := 0;
	UNSIGNED1 wphonewphonescore := 0;
	
	BOOLEAN addrmultiple := false;
	
	STRING15 formerfirst := '';  // former stuff, may need a flag to turn on and off
	STRING20 formerlast := '';
	STRING50 formeraddr := '';
	STRING30 formercity := '';
	STRING2 formerstate := '';
	STRING9 formerzip := '';
	STRING15 formerfirst2 := '';
	STRING20 formerlast2 := '';
	STRING50 formeraddr2 := '';
	STRING30 formercity2 := '';
	STRING2 formerstate2 := '';
	STRING9 formerzip2 := '';
	
	string10 name_addr_phone := '';
	STRING50 phone_Sources := '';
	
	unsigned p_did := 0;
	unsigned1 adls_per_phone := 0; 
	unsigned1 adls_per_phone_created_6months := 0;
	
	unsigned1 adls_per_phone_multiple_use := 0;
	string40 p_street := '';
	unsigned1 addrs_per_phone := 0;
	unsigned1 addrs_per_phone_created_6months := 0;
	
	unsigned1 addrs_per_ssn := 0; 
	unsigned1 adls_per_ssn_created_6months := 0;
	unsigned1 addrs_per_ssn_created_6months := 0;
	
	unsigned1 lnames_per_ssn := 0;
	unsigned1 lnames_per_ssn_created_6months := 0;
	unsigned1 addrs_per_ssn_multiple_use := 0;
	unsigned1 adls_per_ssn_multiple_use := 0;
	unsigned1 adls_per_ssn_multiple_use_non_relative := 0;
	
	string10 phone_from_did := '';
	integer phones_per_adl := 0; 
	integer phones_per_adl_created_6months := 0;  
	
	string9 ssn_from_did := '';
	integer ssns_per_adl := 0;  
	integer ssns_per_adl_created_6months := 0; 
	
	integer ssns_per_adl_multiple_use := 0;  
	integer ssns_per_adl_multiple_use_non_relative := 0;  
	integer dobs_per_adl := 0;  
	integer dobs_per_adl_created_6months := 0;  
	
	string65 addr_from_did := '';
	integer addrs_per_adl := 0;  
	integer addrs_per_adl_created_6months := 0;  
	
	unsigned1 addrs_last_5years := 0;
	unsigned1 addrs_last_10years := 0;
	unsigned1 addrs_last_15years := 0;
	unsigned1 addrs_last30 := 0;
	unsigned1 addrs_last90 := 0;
	unsigned1 addrs_last12 := 0;
	unsigned1 addrs_last24 := 0;
	unsigned1 addrs_last36 := 0;
	
	unsigned4 reported_dob := 0;
	integer inferred_age := 0;
	string1 mobility_indicator := '';
	
	unsigned DID_from_srch := 0;
	integer adls_per_addr := 0;  
	integer adls_per_addr_multiple_use := 0;  
	integer adls_per_addr_created_6months := 0;  
	integer suspicious_adls_per_addr_created_6months := 0;  
	string9 ssn_from_addr := '';
	integer ssns_per_addr := 0;  
	integer ssns_per_addr_multiple_use := 0;  
	integer ssns_per_addr_created_6months := 0;  
	
	string10 phone_from_addr := '';
	integer phones_per_addr := 0;  
	integer phones_per_addr_multiple_use := 0;  
	integer phones_per_addr_created_6months := 0;  
		
	string1 inputsocscharflag := '';
	string3 inputsocscode := '';
	boolean inputAddrNotMostRecent := false;
	
	string20 last_from_did := '';
	unsigned3 newest_lname_dt_first_seen := 0;
	unsigned1 lnames_per_adl := 0;
	unsigned1 lnames_per_adl30 := 0;	
	unsigned1 lnames_per_adl90 := 0;
	unsigned1 lnames_per_adl180 := 0;
	unsigned1 lnames_per_adl12 := 0;
	unsigned1 lnames_per_adl24 := 0;
	unsigned1 lnames_per_adl36 := 0;
	unsigned1 lnames_per_adl60 := 0;
	
	string1 nap_type   := '';
	string1 nap_status := '';
	
	boolean targusgatewayused := false;
	string2 targustype := '';
	
	boolean insurance_dl_used := false;
	
	UNSIGNED3 adl_EN_first_seen := 0;
	UNSIGNED3 adl_EN_last_seen := 0;
	unsigned2 EN_count := 0;
	
	string8 gong_ADL_dt_first_seen := '';
	string8 gong_ADL_dt_last_seen := '';
	
	boolean inCalif := false;
	boolean isPrison := false;
	unsigned4 prisonFSdate := 0;
	
	string9  invalid_ssn_from_did := '';
	unsigned2 invalid_ssns_per_adl := 0;  
	unsigned2 invalid_ssns_per_adl_created_6months := 0;  
	
	string65 invalid_addr_from_did := '';
	unsigned2 invalid_addrs_per_adl := 0;  
	unsigned2 invalid_addrs_per_adl_created_6months := 0; 
	
	unsigned2 dl_addrs_per_adl := 0;
	unsigned2 vo_addrs_per_adl := 0;
	unsigned2 pl_addrs_per_adl := 0;
	
	unsigned2 VO_count := 0;
	unsigned2 EM_only_count := 0;
	unsigned3 adl_VO_first_seen := 0;
	unsigned3 adl_VO_last_seen := 0;
	unsigned3 adl_EM_only_first_seen := 0;
	unsigned3 adl_EM_only_last_seen := 0;
	
	STRING50 em_only_sources := '';
	
	unsigned1 DIDCount := 0;	// - The total number of DIDs found	
	unsigned6 DID2 := 0;	// - The second DID returned from the DID Append
	unsigned6 DID3 := 0;	// - The third DID returned from the DID Append

	STRING50 DID2_Sources := '';	// - RC_Sources for DID2
	STRING50 DID2_FNameSources := '';	// - FName_Sources for DID2
	STRING50 DID2_LNameSources := '';	// - LName_Sources for DID2
	STRING50 DID2_AddrSources := '';	// - Addr_Sources for DID2
	STRING50 DID2_SocsSources := '';	// - SSN_Sources for DID2
	unsigned3 DID2_CreditFirstSeen := 0;	// - Credit_First_Seen for DID2
	unsigned3 DID2_CreditLastSeen := 0;	// - Credit_Last_Seen for DID2
	unsigned3 DID2_HeaderFirstSeen := 0;	// - Header_First_Seen for DID2
	unsigned3 DID2_HeaderLastSeen := 0;	// - Header_Last_Seen for DID2
	unsigned1 did2_criminal_count := 0;
	unsigned1 did2_felony_count := 0;
	unsigned1 did2_liens_recent_unreleased_count := 0;
	unsigned1 did2_liens_historical_unreleased_count := 0;
	unsigned1 did2_liens_recent_released_count := 0;
	unsigned1 did2_liens_historical_released_count := 0;

	STRING50 DID3_Sources := '';	// - RC_Sources for DID3
	STRING50 DID3_FNameSources := '';	//  FName_Sources for DID3
	STRING50 DID3_LNameSources := '';	// - LName_Sources for DID3
	STRING50 DID3_AddrSources := '';	// - Addr_Sources for DID3
	STRING50 DID3_SocsSources := '';	// - SSN_Sources for DID3
	unsigned3 DID3_CreditFirstSeen := 0;	//  - Credit_First_Seen for DID3
	unsigned3 DID3_CreditLastSeen := 0;	// - Credit_Last_Seen for DID3
	unsigned3 DID3_HeaderFirstSeen := 0;	// - Header_First_Seen for DID3
	unsigned3 DID3_HeaderLastSeen := 0;	// - Header_Last_Seen for DID3
	unsigned1 did3_criminal_count := 0;
	unsigned1 did3_felony_count := 0;
	unsigned1 did3_liens_recent_unreleased_count := 0;
	unsigned1 did3_liens_historical_unreleased_count := 0;
	unsigned1 did3_liens_recent_released_count := 0;
	unsigned1 did3_liens_historical_released_count := 0;
	
	string1 publish_code := '';
	
	boolean non_us_ssn := false;
		
	unsigned1 adls_per_ssn_seen_18months := 0;
	unsigned1 ssns_per_adl_seen_18months := 0;
	dataset(risk_indicators.layouts.layout_watchlists) watchlists { maxcount(7) } := dataset([],risk_indicators.layouts.layout_watchlists);
	boolean DL_searched := false;
	boolean any_DL_found := false;
	boolean dl_exists := false;
	unsigned1 DL_score := 255;
	string20 verified_DL := '';	
	string50 verified_DL_sources := '';
	string1 dobmatchlevel := '';	
	
// new shell 4.0 intermediate fields	
	unsigned3 hdr_dt_first_seen := 0;
	unsigned3 hdr_dt_last_seen := 0;
	UNSIGNED2 dobcount2 := 0;	
	layouts.header_verification_summary 		header_summary;
	layouts.layout_address_history_summary 	address_history_summary;
	
	unsigned8 iid_flags := 0;
	string9 BestSSN := '';
	
	// new core identity verification fields
	UNSIGNED1  NameStreetAddressMatch := 0;
	UNSIGNED1  NameCityStateMatch := 0;
	UNSIGNED1  NameZipMatch := 0;
	UNSIGNED1  SSN5FullNameMatch := 0;
	
	string2 bestState := '';
	BOOLEAN ADVODoNotDeliver := false;
	STRING1 ADVODropIndicator := '';
	BOOLEAN ADVOAddressVacancyIndicator := false;
	STRING1 ADVOResidentialOrBusinessInd := '';
	BOOLEAN USPISHotList := false;
	BOOLEAN DIDdeceased := false;
	UNSIGNED4 DIDdeceasedDate := 0;
	UNSIGNED4 DIDdeceasedDOB := 0;
	STRING15 DIDdeceasedfirst := '';
	STRING20 DIDdeceasedlast := '';
	BOOLEAN swappedNames := false;
	
	Risk_Indicators.layouts.inquiryVerification;
	
	STRING3 phoneSourceUsed := '';
	STRING3 phoneAddrSourceUsed := '';

	BOOLEAN isAddrPhoneConnected := false;
	BOOLEAN isPhoneConnected := false;
	
	BOOLEAN IsShiptoBilltoDifferent := false;	// used for CBD check
	INTEGER email_verification := 0;	// used for CBD check
	
	
	boolean EverAssocITIN := false;	// used for AML
	boolean EverAssocIm := false;		// used for AML
	
	layout_overrides;
	
	// new shell 5.0 intermediate fields
	layouts.layout_hhid_summary hhid_summary; 
	risk_indicators.layouts.layout_address_sources_summary	address_sources_summary;
	Integer address_history_seq := 0;	
	string10 addr_hierarchy_best_prim_range := '';
	string2  addr_hierarchy_best_predir:= '';
	string28 addr_hierarchy_best_prim_name:= '';
	string4  addr_hierarchy_best_suffix:= '';
	string2  addr_hierarchy_best_postdir:= '';
	string10 addr_hierarchy_best_unit_desig:= '';
	string8  addr_hierarchy_best_sec_range:= '';
	STRING30 addr_hierarchy_best_city := '';
	STRING2 addr_hierarchy_best_state := '';
	STRING9 addr_hierarchy_best_zip := '';
	boolean addrsMilitaryEver := false;
	unsigned1 adls_per_phone_current := 0; 
	unsigned1 adls_per_addr_current := 0;		
	unsigned1 ssns_per_addr_current := 0;		
	unsigned1 phones_per_addr_current := 0;	
	unsigned8 rawaid_orig := 0;
	unsigned8 rawaid1 := 0;
	unsigned8 rawaid2 := 0;
	unsigned8 rawaid3 := 0;
	integer ssnLookupFlag := 0;
	string120 errMsg := '';
	risk_indicators.Layout_ConsumerFlags						ConsumerFlags;
	dataset(Risk_Indicators.Layouts.tmp_Consumer_Statements) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};

END;