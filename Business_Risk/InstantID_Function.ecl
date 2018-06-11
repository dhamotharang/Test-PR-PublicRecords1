
import aca, codes, Business_Header, Business_Header_SS, BankruptcyV3, corp2, 
		yellowpages, Risk_Indicators, did_add, doxie, ut, riskwise, suppress, 
		Risk_Reporting, liensv2, PAW, census_data, EBR, DCA, iesp, ut, gateway, Royalty, MDR, Business_Risk_BIP;

export InstantID_Function(DATASET(Layout_Input) indata1, dataset(Gateway.Layouts.Config) gateways, 
					boolean hasbdids = false, unsigned1 dppa, unsigned1 glb, 
					boolean isUtility=false, boolean ln_branded=false, string4 tribcode='', boolean ExcludeWatchLists = false,boolean ofac_only=false,
					unsigned1 ofac_version=1,boolean include_ofac=FALSE,boolean include_additional_watchlists=FALSE,
					real Global_WatchList_Threshold =.84,dob_radius = -1,boolean IsPOBoxCompliant=false, integer bsVersion=1,
					string10 ExactMatchLevel=risk_indicators.iid_constants.default_ExactMatchLevel,
					string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction, 
					boolean IncludeMSoverride=false,
					boolean runDLverification=false,
					dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem),
					unsigned1 in_append_best=0,
					BOOLEAN IncludeRepAttributes = FALSE,
					BOOLEAN IncludeAllRC = FALSE,
					string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
					Boolean RestrictExperianData = False   //Experian data sources 'ER' and 'Q3' can't be used for commercial credit origination products (e.g. SmallBusiness_Service)
					) :=
FUNCTION

isFCRA := false;
isCNSMR := ut.IndustryClass.is_Knowx;
min_score := 80;
min_addrscore := 70; 
min_numscore := 90;
g(UNSIGNED1 i) := i BETWEEN min_score AND 100;
ga(UNSIGNED1 i) := i BETWEEN min_addrscore AND 100;
gn(UNSIGNED1 I) := i BETWEEN min_numscore AND 100;
tscore(UNSIGNED1 i) := IF(i>100,0,i);
unsigned tmax2(unsigned i1, unsigned i2) := map(i1 > 100 => if (i2 > 100, 0, i2),
									   i2 > 100 => if (i1 > 100, 0, i1),
									   i1 > i2 => i1, 
									   i2);

unsigned8 BSOptions := 0;
lastSeenThreshold := risk_indicators.iid_constants.oneyear;									 
									   
// recent_check is used for reason code A7 to flag if we've seen any updates to the business data in the past 3 years
recent_check(string8 d1, string8 d2) := ut.DaysApart(d1,d2) <= risk_indicators.iid_constants.threeyears OR (unsigned)d2 >= (unsigned)d1;

// dedup the input so Batch doesn't run into memory errors when customers pass in the same input 100 times.
indata := dedup(sort(indata1, 
						company_name,alt_company_name,phone10,fein,prim_range,prim_name,sec_range,p_city_name,st,z5,rep_fname,rep_lname,rep_orig_z5,rep_prim_name,rep_prim_range,rep_ssn,rep_phone,rep_dob, seq),
						company_name,alt_company_name,phone10,fein,prim_range,prim_name,sec_range,p_city_name,st,z5,rep_fname,rep_lname,rep_orig_z5,rep_prim_name,rep_prim_range,rep_ssn,rep_phone,rep_dob);

			
//-------------- Do Representative Stuff first, get that out of the way before appending BDIDs and searching by BDID ----------------//
risk_indicators.layout_input into_rep(indata L) := transform
	self.seq			:= L.seq;
	self.historydate := l.historydate;
	self.fname 		:= L.Rep_Fname;
	self.mname 		:= L.Rep_Mname;
	self.lname 		:= L.Rep_Lname;
	self.suffix		:= L.Rep_name_suffix;
	self.in_streetaddress := Risk_Indicators.MOD_AddressClean.street_address('',L.rep_prim_range, L.rep_predir, L.rep_prim_name, L.rep_addr_suffix, L.rep_postdir, L.rep_unit_desig, L.rep_sec_range);
	self.in_city 		:= L.rep_orig_city;
	self.in_state		:= L.rep_orig_st;
	self.in_zipcode 	:= L.rep_orig_z5;
	self.in_country	:= ''; // not supplied on input yet
	self.prim_range	:= L.rep_prim_range;
	self.predir		:= L.rep_predir;
	self.prim_name		:= L.rep_prim_name;
	self.addr_suffix	:= L.rep_addr_suffix;
	self.postdir		:= L.rep_postdir;
	self.unit_desig	:= L.rep_unit_desig;
	self.sec_range		:= L.rep_sec_range;
	self.p_city_name	:= L.rep_p_city_name;
	self.st			:= L.rep_st;
	self.z5			:= L.rep_z5;
	self.zip4			:= L.rep_zip4;
	self.lat			:= L.rep_lat;
	self.long			:= L.rep_long;
	self.addr_type		:= L.rep_addr_type;
	self.addr_status	:= L.rep_addr_status;
	self.country		:= L.rep_country;
	self.county := l.rep_county;
	self.dob			:= L.rep_dob;
	self.age			:= L.rep_age;
	self.ssn			:= L.rep_ssn;
	self.phone10		:= L.rep_phone;
	self.dl_number		:= L.rep_dl_num;
	self.dl_state		:= L.rep_dl_state;
	self.email_address	:= L.rep_email;
	self.wphone10		:= '';
	self.ip_address	:= '';
	self.employer_name	:= L.company_name;
	self.lname_prev	:= L.rep_alt_lname;
end;

repIN := project(indata, into_rep(LEFT));

// riskwise migration products require 2 elements for verification for most tribcodes, tribcode is defaulted to '' for business instantid service so that it isn't impacted by this change
boolean require2ele := if(tribcode!='', true, false); 
BOOLEAN suppressNearDups := false;

boolean runSSNCodes := true;
boolean runBestAddrCheck := true;
boolean runChronoPhoneLookup := true;
boolean runAreaCodeSplitSearch := true;
boolean allowCellphones := false;
string CustomDataFilter := '';  // this is only for Identifier2, leave it blank here

																								
ciid_results := risk_indicators.InstantID_Function(repIN, gateways, dppa, glb, isUtility, ln_branded, 
											ofac_only, suppressNearDups, require2ele, true,, ExcludeWatchLists,,ofac_version,
											include_ofac,include_additional_watchlists,Global_WatchList_Threshold,dob_radius, bsversion,
											runSSNCodes,runBestAddrCheck,runChronoPhoneLookup,runAreaCodeSplitSearch,allowCellphones,
											exactMatchLevel, DataRestriction, CustomDataFilter, runDLverification, watchlists_requested,
											in_append_best:=in_append_best, in_DataPermission:=DataPermission);

// want is to fail immediately as we don't want customers to think there was no hit on OFAC

if(exists(ciid_results(watchlist_table = 'ERR')), FAIL('Bridger Gateway Error'));

royalties4Targus := Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(ciid_results), src, TargusType, TRUE, FALSE, FALSE, TRUE);

nugen_rec := record, MAXLENGTH(14000)
	risk_indicators.Layout_InstandID_NuGen;
	integer	chrono_date1;
	integer	chrono_date2;
	integer	chrono_date3;
	string	decsflag;
	string	hriskphoneflag;
	string	phonevalflag;
	string	phonezipflag;
	string	hriskaddrflag;
	string	socsdobflag;
	string	socsvalflag;
	string	drlcvalflag;
	string	addrvalflag;
	string	dwelltype;
	string	bansflag;
	boolean	socsmiskeyflag;
	boolean	hphonemiskeyflag;
	boolean	addrmiskeyflag;
	integer	combo_firstcount;
	integer	combo_lastcount;
	integer	combo_addrcount;
	UNSIGNED1 combo_hphonecount := 0;
	UNSIGNED1 combo_ssncount := 0;
	UNSIGNED1 combo_dobcount := 0;
	unsigned1 numelever := 0;
	unsigned1 numsource := 0;
	STRING1 	phonever_type := '';
	unsigned1 firstcount := 0;
	unsigned1 lastcount := 0;
	unsigned1 addrcount := 0;
	unsigned1 socscount := 0; 
	UNSIGNED1 cmpycount := 0;  
	UNSIGNED1 feincount := 0;
	UNSIGNED1 wphonecount := 0; 	
	STRING8 correctdob := '';
	STRING9 correctssn := '';
	STRING50 correctaddr := '';
	STRING10 correcthphone := '';
	STRING20 correctlast := '';
	UNSIGNED1 dirsaddr_lastscore := 0;
	STRING1 areacodesplitflag := '';
	STRING8 areacodesplitdate := '';
	STRING3 altareacode := '';
	string1 reverse_areacodesplitflag := '';
	STRING30 hriskcmpy := '';
	STRING6 hrisksic := '';
	string8 bansdatefiled := '';
	boolean phonedissflag := false;
	UNSIGNED1 firstscore := 0;
	UNSIGNED1 lastscore := 0;
	UNSIGNED1 addrscore := 0;
	UNSIGNED1 hphonescore := 0;
	UNSIGNED1 socsscore := 0;
	UNSIGNED1 dobscore := 0;
	string1 phonetype := '';
	string1 zipclass := '';
	boolean inputAddrNotMostRecent := false;
	string3 inputsocscode := '';
	UNSIGNED1 combo_sec_rangescore := 0;
	BOOLEAN ssnexists := true;
	string2 nxx_type := '';
	string1 publish_code := '';
end;

// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
boolean IsInstantID := tribcode='';
unsigned1 IIDVersion := 0;	// version 0 will not get v1 reason codes
reasoncode_settings := dataset([{IsInstantID, IIDVersion}],riskwise.layouts.reasoncode_settings);
actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

nugen_rec format_out(risk_indicators.Layout_Output le) := TRANSFORM
	SELF.acctNo		:= '';
	SELF.transaction_id := 0;
	
	self.verfirst 		:= if(tribcode in ['bnk4', 'cbbl'], le.combo_first, IF(le.combo_firstcount>0, le.combo_first, ''));
	verlast 		:= if(tribcode in ['bnk4', 'cbbl'], le.combo_last, IF(le.combo_lastcount>0, le.combo_last, ''));
	self.verlast 		:= verlast;
	vaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,le.combo_predir,le.combo_prim_name,le.combo_suffix,le.combo_postdir,le.combo_unit_desig,le.combo_sec_range);
	veraddr 		:= if(tribcode in ['bnk4', 'cbbl'], vaddr, IF(le.combo_addrcount>0, vaddr,''));			
	SELF.veraddr 		:= veraddr;			
	SELF.vercity 		:= if(tribcode in ['bnk4', 'cbbl'], le.combo_city, IF(le.combo_addrcount>0, le.combo_city, ''));
	SELF.verstate 		:= if(tribcode in ['bnk4', 'cbbl'], le.combo_state, IF(le.combo_addrcount>0, le.combo_state, ''));
	SELF.verzip 		:= if(tribcode in ['bnk4', 'cbbl'], le.combo_zip[1..5], IF(le.combo_addrcount>0, le.combo_zip[1..5], ''));
	SELF.verzip4		:= if(tribcode in ['bnk4', 'cbbl'], le.combo_zip[6..9], IF(le.combo_addrcount>0, le.combo_zip[6..9], ''));
	SELF.verdob 		:= if(tribcode in ['bnk4', 'cbbl'], le.combo_dob, IF(le.combo_dobcount>0, le.combo_dob, ''));
	SELF.verssn 		:= IF(le.combo_ssncount>0 and le.combo_ssnscore between min_numscore and 100, le.combo_ssn, IF(le.socsverlevel=1,le.ssn,''));
	SELF.verhphone 	:= if(tribcode in ['bnk4', 'cbbl'], le.combo_hphone, IF(le.combo_hphonecount>0, le.combo_hphone, ''));
	self.vercounty := IF(le.combo_addrcount>0, le.combo_county, '');
	
	SELF.verify_addr 	:= IF(le.addrmultiple,'O','');
	SELF.verify_dob := IF(le.combo_dobcount>0,'Y','N');
	self.firstscore := tscore(le.combo_firstscore);
	self.lastscore := tscore(le.combo_lastscore);
	self.addrscore := tscore(le.combo_addrscore);
	self.hphonescore := tscore(le.combo_hphonescore);
	self.socsscore := tscore(le.combo_ssnscore);
	self.dobscore := tscore(le.dobscore);
	
	SELF.NAS_summary 	:= le.socsverlevel;
	SELF.NAP_summary 	:= le.phoneverlevel;
	SELF.NAP_Type       := le.nap_type;
	SELF.NAP_Status     := le.nap_status;
	SELF.valid_ssn 	:= IF(le.socllowissue != '', 'G', '');
	
	SELF.corrected_lname := le.correctlast;
	SELF.corrected_dob 	 := le.correctdob;
	SELF.corrected_phone := le.correcthphone;
	SELF.corrected_ssn 	 := le.correctssn;
	SELF.corrected_address := le.correctaddr;
	
	SELF.area_code_split := if(le.areacodesplitflag='Y', le.altareacode, '');
	SELF.area_code_split_date := if(le.areacodesplitflag='Y', le.areacodesplitdate, '');
	
	SELF.additional_score1 := 0;
	SELF.additional_score2 := 0;
	
	SELF.phone_fname 	:= le.dirsfirst;
	SELF.phone_lname 	:= le.dirslast;
	SELF.phone_address 	:= Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,
											le.dirs_suffix,le.dirs_postdir,le.dirs_unit_desig,le.dirs_sec_range);
	SELF.phone_city 	:= le.dirscity;
	SELF.phone_st 		:= le.dirsstate;
	SELF.phone_zip 	:= le.dirszip;
	
	SELF.name_addr_phone := le.name_addr_phone;
	SELF.publish_code    := le.publish_code;
	
	SELF.ssa_date_first := le.socllowissue;
	SELF.ssa_date_last 	:= le.soclhighissue;
	SELF.ssa_state 	:= le.soclstate;
	SELF.ssa_state_name := Codes.GENERAL.STATE_LONG(le.soclstate);
	
	SELF.current_fname 	:= le.verfirst;
	SELF.current_lname 	:= le.verlast;
	
	addr1 			:= Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range, le.chronopredir, 
										   le.chronoprim_name, le.chronosuffix,
										   le.chronopostdir, le.chronounit_desig, le.chronosec_range);
	addr2 			:= Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, 
										   le.chronoprim_name2, le.chronosuffix2,
										   le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2);
	addr3 			:= Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3, le.chronopredir3, 
										   le.chronoprim_name3, le.chronosuffix3,
										   le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3);
	SELF.Chronology := DATASET([{1, addr1, le.chronoprim_range, le.chronopredir, le.chronoprim_name, le.chronosuffix, le.chronopostdir, le.chronounit_desig, le.chronosec_range, 
										le.chronocity, le.chronostate, le.chronozip, le.chronozip4, le.chronophone, le.chronodate_first, le.chronodate_last, le.chronoaddr_isbest, ''},
									{2, addr2, le.chronoprim_range2, le.chronopredir2, le.chronoprim_name2, le.chronosuffix2, le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2, 
											le.chronocity2, le.chronostate2, le.chronozip2, le.chronozip4_2, le.chronophone2, le.chronodate_first2, le.chronodate_last2, le.chronoaddr_isbest2, ''},
									{3, addr3, le.chronoprim_range3, le.chronopredir3, le.chronoprim_name3, le.chronosuffix3, le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3, 
											le.chronocity3, le.chronostate3, le.chronozip3, le.chronozip4_3, le.chronophone3, le.chronodate_first3, le.chronodate_last3, le.chronoaddr_isbest3, ''}], 
									Risk_Indicators.Layout_AddressHistory);

	self.chrono_date1 := Le.chronodate_last;
	self.chrono_date2 := Le.chronodate_last2;
	self.chrono_Date3 := Le.chronodate_last3;
	SELF.Additional_Lname := if(le.socsverlevel IN risk_indicators.iid_constants.ssn_name_match, DATASET([{le.altfirst,le.altlast,le.altlast_date},
							    {le.altfirst2,le.altlast2,le.altlast_date2},
							    {le.altfirst3,le.altlast3,le.altlast_date3}], Risk_Indicators.Layout_LastNames), 
								dataset([], Risk_Indicators.Layout_LastNames));

	SELF.Watchlist_Table 	:= le.watchlist_table;
	SELF.Watchlist_Record_Number := le.Watchlist_Record_Number;
	SELF.Watchlist_Program :=le.Watchlist_program;
	SELF.Watchlist_fname 	:= le.Watchlist_fname;
	SELF.Watchlist_lname 	:= le.Watchlist_lname;
	SELF.Watchlist_address 	:= le.Watchlist_address;
	SELF.Watchlist_city 	:= le.Watchlist_city;
	SELF.Watchlist_state 	:= le.Watchlist_state;
	SELF.Watchlist_zip 		:= le.Watchlist_zip;
	SELF.Watchlist_contry 	:= le.Watchlist_contry;
	SELF.Watchlist_Entity_Name := le.Watchlist_Entity_Name;

	// if ssn is verified and flagged as deceased, return the information about the deceased SSN
	ssn_verified := le.socsverlevel IN risk_indicators.iid_constants.ssn_name_match;
	self.deceasedDate := if(ssn_verified, if(le.deceasedDate=0, '', (string)le.deceasedDate), '');
	self.deceasedDOB := if(ssn_verified, if(le.deceasedDOB=0, '', (string)le.deceasedDOB), '');
	self.deceasedFirst := if(ssn_verified, le.deceasedFirst, '');
	self.deceasedLast := if(ssn_verified, le.deceasedLast, '');
	
	self.verdl := le.verified_dl;
		
	risk_indicators.mac_add_sequence(le.watchlists, watchlists_with_seq);
	self.watchlists := watchlists_with_seq;

	// add a sequence number to the reason codes for sorting in XML
	risk_indicators.mac_add_sequence(risk_indicators.reasonCodes(le, if(IncludeAllRC, CHOOSEN:ALL,6), reasoncode_settings), reasons_with_seq);
	self.ri := reasons_with_seq;
	
	SELF.fua 		:= risk_indicators.getActionCodes(le,4, SELF.NAS_summary, SELF.NAP_summary, ac_settings := actioncode_settings);
	
	cvi_temp := risk_indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,le.correctssn,
																						le.correctaddr,le.correcthphone,'',veraddr,verlast);																			
	SELF.CVI := map(IncludeMSoverride and risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months) and (integer)cvi_temp > 10 => '10',
									IsPOBoxCompliant AND risk_indicators.rcSet.isCodePO(le.addr_type) and (integer)cvi_temp > 10 => '10',
									cvi_temp);
	
	// only populate this field if MS reason code is triggered
	self.SubjectSSNCount := if(risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months), (string)le.ssns_per_adl_seen_18months, '');

	SELF 		:= le;
	SELF := [];  // set models and red flags = blank
END;

repOUT := project(ciid_results, format_out(LEFT));

layout_output rep_to_output(repOUT  L, indata R) := transform
	self.RepDid		:= L.did;
	self.RepFNameVerify := if(tribcode in ['bnk4', 'cbbl'], l.verfirst, if (L.fname != '' and g(tscore(risk_indicators.fnamescore(L.verfirst, L.fname))), L.verfirst, ''));
	self.RepLNameVerify := if(tribcode in ['bnk4', 'cbbl'], l.verlast, if (L.lname != '' and g(tscore(risk_indicators.lnamescore(L.verlast, L.lname))), L.verlast, ''));
	RepFNameVerFlag	:= g(tscore(risk_indicators.fnamescore(L.verfirst, L.fname))) and L.fname != '';
	RepLNameVerFlag	:= g(tscore(risk_indicators.lnamescore(L.verlast,  L.lname))) and L.lname != '';
	self.RepNameVerFlag	:= if(repfnameverflag and replnameverflag, 'Y', 'N');
	repvaddr := if(tribcode in ['bnk4', 'cbbl'], l.veraddr, if (MIN(ut.stringsimilar(L.veraddr, l.in_streetaddress),ut.stringsimilar(l.in_streetaddress, L.veraddr)) <= 3, L.verAddr, ''));
	self.RepAddrVerify 	:=  repvaddr;
	self.RepCityVerify	:= if(tribcode in ['bnk4', 'cbbl'], l.vercity, if (L.vercity = L.in_city, L.vercity, ''));
	self.RepStateVerify := if(tribcode in ['bnk4', 'cbbl'], l.verstate, if (L.verstate = L.in_state, L.verstate, ''));
	self.RepZipVerify	:= if(tribcode in ['bnk4', 'cbbl'], l.verzip, if (L.in_zipcode = L.verzip, L.verzip,''));
	self.RepZip4Verify	:= if(tribcode in ['bnk4', 'cbbl'], l.verzip4, if (L.zip4 = L.verzip4, L.zip4, ''));
	self.repAddrVerFlag := if (MIN(ut.StringSimilar(self.RepAddrVerify,L.in_streetaddress),ut.StringSimilar(L.in_streetaddress,self.RepAddrVerify)) <= 3 and L.in_streetaddress != '','Y','N');
	self.repCityVerFLag	:= if (L.in_city = L.vercity and L.in_city != '', 'Y', 'N');
	self.repStateVerFlag	:= if (L.in_state = L.verstate and L.in_state != '', 'Y','N');
	self.repZipVerFlag	:= if (L.in_zipcode = L.verzip and L.in_zipcode != '', 'Y','N');
	self.repZip4VerFLag	:= if (L.zip4 = L.verzip4 and L.zip4 != '', 'Y','N');
	self.repCountyVerify := if(repvaddr<>'', l.vercounty, '');
	self.RepPhoneVerify	:= if(tribcode in ['bnk4', 'cbbl'], l.verhphone, if (gn(tscore(risk_indicators.phonescore(L.phone10, L.verhphone))), L.verhphone, ''));
	rep_ssnverified := gn(tscore(did_add.SSN_Match_Score(L.ssn, L.verssn, LENGTH(TRIM(L.ssn))=4 AND tribcode='')));
	self.RepSsnVerify   := if (rep_ssnverified, L.verssn, '');
	self.RepDOBVerify	:= if(tribcode in ['bnk4', 'cbbl'], l.verdob, if (L.dob = L.verdob, L.verdob, ''));
	self.repPhoneVerFlag := if (gn(tscore(risk_indicators.phonescore(L.phone10, L.verhphone))) and L.phone10 != '', 'Y','N');
	self.repSSNVerFlag  := if (rep_ssnverified, 'Y', 'N');
	SELF.valid_ssn := L.valid_ssn;
	self.repDOBVerFlag	:= if (L.verdob = L.dob and L.dob != '', 'Y', 'N');
	self.RepNas_Score	:= (string)L.NAS_Summary;
	self.RepNAP_Score	:= (string)L.NAP_Summary;
	temp_cvi			:= L.cvi; //risk_indicators.cviScore(L.phoneverlevel,L.socsverlevel,L,L.correctssn,L.correctaddr,L.correcthphone,'',verified_addr,L.verlast, true);
	self.RepCVI		:= if(temp_cvi='00', '0', temp_cvi);	
	self.RepBestFname	:= '';
	self.RepBestLname	:= '';
	self.RepBestAddr1	:= '';
	self.RepBestCity	:= '';
	self.RepBestState	:= '';
	self.RepBestZip	:= '';
	self.RepBestZip4	:= '';
	self.RepBestDob	:= '';
	self.RepBestPhone	:= '';
	self.RepBestSSN	:= '';
	
	self.RepPhoneFname	:= L.phone_fname;
	self.RepPhoneLname	:= L.phone_lname;
	self.RepPhoneAddr1	:= L.phone_address;
	self.RepPhoneCity	:= L.phone_city;
	self.RepPhoneState	:= L.phone_st;
	self.RepPhoneZip	:= L.phone_zip[1..5];
	self.RepPhoneZip4	:= '';
	self.RepPhoneFromAddr := L.name_addr_phone;
	self.rep_publish_code     := L.publish_code;
	self.RepSSNEarlyDate := L.ssa_date_first;
	self.RepSSNLateDate  := L.ssa_date_last;
	self.RepSSNIssueState := L.ssa_state;
	self.RepSSNExists := L.ssnExists;
	self.RepWatchlist_table 			:= L.watchlist_table;
	self.RepWatchlist_record_number 	:= L.watchlist_record_number;
	self.RepWatchlist_program :=L.watchlist_program;
	self.RepWatchlist_lname 			:= L.watchlist_lname;
	self.RepWatchlist_fname	 		:= L.watchlist_fname;
	self.RepWatchlist_Address		:= L.watchlist_address;
	self.RepWatchlist_city 			:= L.watchlist_city;
	self.RepWatchlist_state 			:= L.watchlist_state;
	self.RepWatchlist_zip 			:= L.watchlist_zip;
	self.RepWatchlist_country 		:= L.watchlist_contry;
	self.RepWatchlist_Entity_Name		:= L.Watchlist_Entity_Name;
	self.Hist_Addr_1				:= L.chronology[1].address;//.Addr1FromComponents(L.chronoPrim_range, L.chronoPredir, L.chronoPrim_Name, L.chronoSuffix, L.chronoPostDir, L.chronoUnit_Desig, L.chronoSec_Range);
	self.Hist_City_1				:= L.chronology[1].City;
	self.Hist_State_1				:= L.chronology[1].St;
	self.Hist_Zip_1				:= L.chronology[1].Zip[1..5];
	self.Hist_Zip4_1				:= '';
	self.Hist_Phone_1				:= L.chronology[1].phone;
	self.Hist_Date_Last_Seen_1		:= L.chrono_date1;
	self.Hist_Addr_2				:= L.chronology[2].address;//address.Addr1FromComponents(L.chronoPrim_range2, L.chronoPredir2, L.chronoPrim_Name2, L.chronoSuffix2, L.chronoPostDir2, L.chronoUnit_Desig2, L.chronoSec_Range2);
	self.Hist_City_2				:= L.chronology[2].City;
	self.Hist_State_2				:= L.chronology[2].St;
	self.Hist_Zip_2				:= L.chronology[2].Zip[1..5];
	self.Hist_Zip4_2				:= '';
	self.Hist_Phone_2				:= L.chronology[2].phone;
	self.Hist_Date_Last_Seen_2		:= L.chrono_date2;
	self.Hist_Addr_3				:= L.chronology[3].address;//.Addr1FromComponents(L.chronoPrim_range3, L.chronoPredir3, L.chronoPrim_Name3, L.chronoSuffix3, L.chronoPostDir3, L.chronoUnit_Desig3, L.chronoSec_Range3);
	self.Hist_City_3				:= L.chronology[3].City;
	self.Hist_State_3				:= L.chronology[3].St;
	self.Hist_Zip_3				:= L.chronology[3].Zip[1..5];
	self.Hist_Zip4_3				:= '';
	self.Hist_Phone_3				:= L.chronology[3].phone;
	self.Hist_Date_Last_Seen_3		:= L.chrono_date3;	
	self.Alt_Fname_1				:= L.Additional_Lname[1].fname1;
	self.Alt_Lname_1				:= L.Additional_Lname[1].lname1;
	self.Alt_Date_Last_Seen_1		:= L.Additional_Lname[1].date_last;
	self.Alt_Fname_2				:= l.Additional_Lname[2].fname1;
	self.Alt_Lname_2				:= L.Additional_Lname[2].lname1;
	self.Alt_Date_Last_Seen_2		:= L.Additional_Lname[2].date_last;
	self.Alt_Fname_3				:= l.Additional_Lname[3].fname1;
	self.Alt_Lname_3				:= L.Additional_Lname[3].lname1;
	self.Alt_Date_Last_Seen_3		:= L.Additional_Lname[3].date_last;
	self.homeAddrLat				:= L.lat;
	self.homeAddrLong				:= L.long;
	rep_pris	 					:= l.ri;
	rep_followups				:= l.fua; 
	self.rep_pri1				:= if (count(rep_pris)>=1, rep_pris[1].hri, '');
	self.rep_pri2				:= if (count(rep_pris)>=2, rep_pris[2].hri, '');
	self.rep_pri3				:= if (count(rep_pris)>=3, rep_pris[3].hri, '');
	self.rep_pri4				:= if (count(rep_pris)>=4, rep_pris[4].hri, '');
	self.rep_pri5				:= if (count(rep_pris)>=5, rep_pris[5].hri, '');
	self.rep_pri6				:= if (count(rep_pris)>=6, rep_pris[6].hri, '');
	self.rep_followup1			:= if (count(rep_followups)>=1, rep_followups[1].hri,'');
	self.rep_followup2			:= if (count(rep_followups)>=2, rep_followups[2].hri,'');
	self.rep_followup3			:= if (count(rep_followups)>=3, rep_followups[3].hri,'');
	self.rep_followup4			:= if (count(rep_followups)>=4, rep_followups[4].hri,'');
	self.repDeceasedSSN			:= l.decsflag;	
	self.rep_hriskphoneflag	:= L.hriskphoneflag;
	self.rep_hriskcmpy 		:= l.hriskcmpy;
	self.rep_hrisksic		:= l.hrisksic;
	self.rep_phonevalflag	:= L.phonevalflag;
	self.rep_phonezipmismatch	:= L.phonezipflag;
	self.rep_hriskaddrflag	:= L.hriskaddrflag;
	self.rep_socsdobflag	:= L.socsdobflag;
	self.rep_socsvalflag	:= L.socsvalflag;
	self.rep_drlcvalflag	:= L.drlcvalflag;
	self.rep_addrvalflag	:= L.addrvalflag;
	self.rep_dwelltype	:= L.dwelltype;
	self.rep_bansflag 	:= L.bansflag;
	self.rep_bansdatefiled := L.bansdatefiled;
	self.rep_phonedissflag := L.phonedissflag;
	self.rep_socsmiskeyflag	:= L.socsmiskeyflag;
	self.rep_phonemiskeyflag	:= L.hphonemiskeyflag;
	self.rep_addrmiskeyflag	:= L.addrmiskeyflag;
	self.rep_firstcount	:= L.combo_firstcount;
	self.rep_lastcount	:= L.combo_lastcount;
	self.rep_addrcount	:= L.combo_addrcount;
	self.rep_hphonecount	:= L.combo_hphonecount;
	self.rep_ssncount	:= L.combo_ssncount;
	self.rep_dobcount	:= L.combo_dobcount;
	self.rep_numelever	:= L.numelever;
	self.rep_correctdob := L.correctdob;
	self.rep_correctssn := L.correctssn;
	self.rep_correctaddr := L.correctaddr;
	self.rep_correcthphone := L.correcthphone;
	self.rep_correctlast := L.correctlast;
	self.rep_header_firstcount := L.firstcount;
	self.rep_header_lastcount := L.lastcount;
	self.rep_header_addrcount := L.addrcount;
	self.rep_header_ssncount := L.socscount;
	self.rep_phonever_type := L.phonever_type;
	self.rep_dirsaddr_lastscore := L.dirsaddr_lastscore;
	self.rep_areacodesplitflag 	:= l.areacodesplitflag;
	self.rep_areacodesplitdate 	:= l.areacodesplitdate;
	self.rep_altareacode 		:= l.altareacode;
	self.rep_reverse_areacodesplitflag 	:= l.reverse_areacodesplitflag;
	self.rep_firstscore := l.firstscore;
	self.rep_lastscore := l.lastscore;
	self.rep_addrscore := l.addrscore;
	self.rep_phonescore := l.hphonescore;
	self.rep_socsscore := l.socsscore;
	self.rep_dobscore := l.dobscore;
	self.rep_phonetype := l.phonetype;
	self.rep_zipclass := l.zipclass;
	self.rep_inputAddrNotMostRecent := l.inputAddrNotMostRecent;
	self.rep_inputsocscode := l.inputsocscode;
	self.rep_nxx_type := l.nxx_type;
	
	self.Hist_Addr_1_isBest		:= if(l.chronology[1].isBestMatch, 'Y', 'N');
	self.Hist_Addr_2_isBest		:= if(l.chronology[2].isBestMatch, 'Y', 'N');
	self.Hist_Addr_3_isBest		:= if(l.chronology[3].isBestMatch, 'Y', 'N');
	
	self.subjectSSNcount := l.subjectSSNcount;
	self.rep_verDL := l.verDL;

	self.rep_deceasedDate := l.deceasedDate;
	self.rep_deceasedDOB := l.deceasedDOB;
	self.rep_deceasedFirst := l.deceasedFirst;
	self.rep_deceasedLast := l.deceasedLast;
	
	self.RepWatchlist_Table_2 := l.watchlists[2].watchlist_table;
	self.RepWatchlist_program_2 :=l.watchlists[2].watchlist_program;
	self.RepWatchlist_Record_Number_2 := l.watchlists[2].watchlist_Record_Number;
	self.RepWatchlist_fname_2 := l.watchlists[2].watchlist_fname;
	self.RepWatchlist_lname_2 := l.watchlists[2].watchlist_lname;
	self.RepWatchlist_address_2 := l.watchlists[2].watchlist_address;
	self.RepWatchlist_city_2 := l.watchlists[2].watchlist_city;
	self.RepWatchlist_state_2 := l.watchlists[2].watchlist_state;
	self.RepWatchlist_zip_2 := l.watchlists[2].watchlist_zip;
	self.RepWatchlist_country_2 := l.watchlists[2].watchlist_contry;
	self.RepWatchlist_Entity_Name_2 := l.watchlists[2].watchlist_Entity_Name;
	
	self.RepWatchlist_Table_3 := l.watchlists[3].watchlist_table;
	self.RepWatchlist_program_3 :=l.watchlists[3].watchlist_program;
	self.RepWatchlist_Record_Number_3 := l.watchlists[3].watchlist_Record_Number;
	self.RepWatchlist_fname_3 := l.watchlists[3].watchlist_fname;
	self.RepWatchlist_lname_3 := l.watchlists[3].watchlist_lname;
	self.RepWatchlist_address_3 := l.watchlists[3].watchlist_address;
	self.RepWatchlist_city_3 := l.watchlists[3].watchlist_city;
	self.RepWatchlist_state_3 := l.watchlists[3].watchlist_state;
	self.RepWatchlist_zip_3 := l.watchlists[3].watchlist_zip;
	self.RepWatchlist_country_3 := l.watchlists[3].watchlist_contry;
	self.RepWatchlist_Entity_Name_3 := l.watchlists[3].watchlist_Entity_Name;
	
	self.RepWatchlist_Table_4 := l.watchlists[4].watchlist_table;
	self.RepWatchlist_program_4 :=l.watchlists[4].watchlist_program;
	self.RepWatchlist_Record_Number_4 := l.watchlists[4].watchlist_Record_Number;
	self.RepWatchlist_fname_4 := l.watchlists[4].watchlist_fname;
	self.RepWatchlist_lname_4 := l.watchlists[4].watchlist_lname;
	self.RepWatchlist_address_4 := l.watchlists[4].watchlist_address;
	self.RepWatchlist_city_4 := l.watchlists[4].watchlist_city;
	self.RepWatchlist_state_4 := l.watchlists[4].watchlist_state;
	self.RepWatchlist_zip_4 := l.watchlists[4].watchlist_zip;
	self.RepWatchlist_country_4 := l.watchlists[4].watchlist_contry;
	self.RepWatchlist_Entity_Name_4 := l.watchlists[4].watchlist_Entity_Name;
	
	self.RepWatchlist_Table_5 := l.watchlists[5].watchlist_table;
	self.RepWatchlist_program_5 :=l.watchlists[5].watchlist_program;
	self.RepWatchlist_Record_Number_5 := l.watchlists[5].watchlist_Record_Number;
	self.RepWatchlist_fname_5 := l.watchlists[5].watchlist_fname;
	self.RepWatchlist_lname_5 := l.watchlists[5].watchlist_lname;
	self.RepWatchlist_address_5 := l.watchlists[5].watchlist_address;
	self.RepWatchlist_city_5 := l.watchlists[5].watchlist_city;
	self.RepWatchlist_state_5 := l.watchlists[5].watchlist_state;
	self.RepWatchlist_zip_5 := l.watchlists[5].watchlist_zip;
	self.RepWatchlist_country_5 := l.watchlists[5].watchlist_contry;
	self.RepWatchlist_Entity_Name_5 := l.watchlists[5].watchlist_Entity_Name;
	
	self.RepWatchlist_Table_6 := l.watchlists[6].watchlist_table;
	self.RepWatchlist_program_6 :=l.watchlists[6].watchlist_program;
	self.RepWatchlist_Record_Number_6 := l.watchlists[6].watchlist_Record_Number;
	self.RepWatchlist_fname_6 := l.watchlists[6].watchlist_fname;
	self.RepWatchlist_lname_6 := l.watchlists[6].watchlist_lname;
	self.RepWatchlist_address_6 := l.watchlists[6].watchlist_address;
	self.RepWatchlist_city_6 := l.watchlists[6].watchlist_city;
	self.RepWatchlist_state_6 := l.watchlists[6].watchlist_state;
	self.RepWatchlist_zip_6 := l.watchlists[6].watchlist_zip;
	self.RepWatchlist_country_6 := l.watchlists[6].watchlist_contry;
	self.RepWatchlist_Entity_Name_6 := l.watchlists[6].watchlist_Entity_Name;
	
	self.RepWatchlist_Table_7 := l.watchlists[7].watchlist_table;
	self.RepWatchlist_program_7 :=l.watchlists[7].watchlist_program;
	self.RepWatchlist_Record_Number_7 := l.watchlists[7].watchlist_Record_Number;
	self.RepWatchlist_fname_7 := l.watchlists[7].watchlist_fname;
	self.RepWatchlist_lname_7 := l.watchlists[7].watchlist_lname;
	self.RepWatchlist_address_7 := l.watchlists[7].watchlist_address;
	self.RepWatchlist_city_7 := l.watchlists[7].watchlist_city;
	self.RepWatchlist_state_7 := l.watchlists[7].watchlist_state;
	self.RepWatchlist_zip_7 := l.watchlists[7].watchlist_zip;
	self.RepWatchlist_country_7 := l.watchlists[7].watchlist_contry;
	self.RepWatchlist_Entity_Name_7 := l.watchlists[7].watchlist_Entity_Name;

	self := R;
	self.repriskindicators := rep_pris;
	self.busriskindicators := [];
	SELF.attributes := [];
end;

wRep_nobest := join(repOut, indata, 
				left.seq = right.seq, 
			 rep_to_output(LEFT,RIGHT), 
			 left outer, lookup);

glb_ok := ut.PermissionTools.glb.ok(glb);		 
dppa_ok := ut.PermissionTools.dppa.ok(dppa);

doxie.mac_best_records(wRep_nobest,
											 Repdid,
											 outfile,
											 dppa_ok,
											 glb_ok, 
											 ,
											 doxie.DataRestriction.fixed_DRM);
											 
wRep_nobest get_rep_best(wRep_nobest L, outfile R) := transform
	self.repbestfname := R.fname;
	self.repbestlname := R.lname;
	self.repbestaddr1 := Risk_Indicators.MOD_AddressClean.street_address('',R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
	self.repbestprimrange 	:= R.prim_range;
	self.repbestprimname	:= R.prim_name;
	self.repbestsecrange	:= R.sec_range;
	self.repbestcity	:= R.city_name;
	self.repbeststate	:= R.st;
	self.repbestzip	:= R.zip;
	self.repbestzip4	:= R.zip4;
	self.repbestphone	:= R.phone;
	self.repbestssn	:= R.ssn;
	self.repbestdob	:= (string)R.dob;
	self := L;
end;
			 
wRep := join(wRep_nobest, outfile, 
						left.Repdid != 0 and left.Repdid = right.did,
						   get_rep_best(LEFT,RIGHT),left outer);
							 
// *******************************************************
 // If requested, get Chase Rep Attributes - Non-FCRA 3.0 *
// ********************************************************* 
bocaShell := Risk_Indicators.Boca_Shell_Function(ciid_results, gateways, dppa, glb, isUtility, ln_branded,
																									   TRUE,//includeRelativeInfo
																										 FALSE,//includeDLInfo
																										 FALSE,//includeVehInfo
																											TRUE,//includeDerogInfo
																										IF(IncludeRepAttributes, 3, bsversion), DataRestriction := DataRestriction, DataPermission := DataPermission);

Rep_Attributes := RECORD
	STRING32 Name := '';
	STRING128 Value := '';
END;

wRep addRepAttributes(wRep le, bocaShell ri) := TRANSFORM
	Rep_Lien_Unrel_Lvl := Business_Risk.Business_Attributes_Master(ri).Rep_Lien_Unrel_Lvl;
	Rep_Prop_Owner := Business_Risk.Business_Attributes_Master(ri).Rep_Prop_Owner;
	Rep_Prof_License_Category := Business_Risk.Business_Attributes_Master(ri).Rep_Prof_License_Category;
	Rep_Accident_Count := Business_Risk.Business_Attributes_Master(ri).Rep_Accident_Count;
	Rep_Paydayloan_Flag := Business_Risk.Business_Attributes_Master(ri).Rep_Paydayloan_Flag;
	Rep_Age_Lvl := Business_Risk.Business_Attributes_Master(ri).Rep_Age_Lvl;
	Rep_Bankruptcy_Count := Business_Risk.Business_Attributes_Master(ri).Rep_Bankruptcy_Count;
	Rep_Ssns_Per_Adl := Business_Risk.Business_Attributes_Master(ri).Rep_Ssns_Per_Adl;
	Rep_Past_Arrest := Business_Risk.Business_Attributes_Master(ri).Rep_Past_Arrest;
	Rep_Add1_Lres_Lvl := Business_Risk.Business_Attributes_Master(ri).Rep_Add1_Lres_Lvl;
	Rep_Criminal_Assoc_Lvl := Business_Risk.Business_Attributes_Master(ri).Rep_Criminal_Assoc_Lvl;
	Rep_Felony_Count := Business_Risk.Business_Attributes_Master(ri).Rep_Felony_Count;
	
	fullSet := DATASET([
												{'Rep_Lien_Unrel_Lvl', Rep_Lien_Unrel_Lvl},
												{'Rep_Prop_Owner', Rep_Prop_Owner},
												{'Rep_Prof_License_Category', Rep_Prof_License_Category},
												{'Rep_Accident_Count', Rep_Accident_Count},
												{'Rep_Paydayloan_Flag', Rep_Paydayloan_Flag},
												{'Rep_Age_Lvl', Rep_Age_Lvl},
												{'Rep_Bankruptcy_Count', Rep_Bankruptcy_Count},
												{'Rep_Ssns_Per_Adl', Rep_Ssns_Per_Adl},
												{'Rep_Past_Arrest', Rep_Past_Arrest},
												{'Rep_Add1_Lres_Lvl', Rep_Add1_Lres_Lvl},
												{'Rep_Criminal_Assoc_Lvl', Rep_Criminal_Assoc_Lvl},
												{'Rep_Felony_Count', Rep_Felony_Count}
											], Rep_Attributes);
	
	SELF.Attributes := fullSet;
	SELF := le;
	SELF := [];
END;
wRepAttributes := JOIN(wRep, bocaShell, 
											LEFT.seq = RIGHT.seq, 
											addRepAttributes(LEFT, RIGHT), 
											LEFT OUTER, ATMOST(RiskWise.max_atmost)
											);

grouped_rep := IF(IncludeRepAttributes, GROUP(SORT(wRepAttributes, seq), seq), GROUP(SORT(wRep, seq), seq));

//------------- OFAC/Watchlist info --------------
skipWatchlist := (ExcludeWatchLists and ofac_version=1) or (ofac_version>1 and Include_Ofac=FALSE and Include_Additional_Watchlists=FALSE and count(watchlists_requested)=0); 
gateways_temp := if(skipwatchlist, dataset([], Gateway.Layouts.Config), gateways);  // short circuit the gateway call by removing the gateway information completely
normalWatch := if(skipwatchlist, grouped_rep,
					getWatchLists2(grouped_rep, tribcode != '' OR ofac_only,,ofac_version,include_ofac,include_additional_watchlists,Global_WatchList_Threshold,watchlists_requested,gateways_temp, dob_radius)); 										

risk_indicators.layout_output prep_for_attus(grouped_rep le) := transform
	self.seq := le.seq;
	self.employer_name := le.company_name;
	self.country := le.country;		
	self := [];
end;

attus_in := project(grouped_rep, prep_for_attus(left));
attus_out := risk_indicators.getAttus(attus_in, gateways, dppa, glb);

layout_output addAttus(grouped_rep le, attus_out rt) := transform
	SELF.watchlist_table := rt.watchlist_table;
	SELF.watchlist_record_number := rt.watchlist_record_number;
	SELF.watchlist_program :=rt.watchlist_program;
	SELF.watchlist_fname := rt.watchlist_fname;
	SELF.watchlist_lname := rt.watchlist_lname;
	SELF.watchlist_cmpy :=  rt.watchlist_entity_name;
	SELF.watchlist_address := rt.watchlist_address;
	SELF.watchlist_city := rt.watchlist_city;
	SELF.watchlist_state := rt.watchlist_state;
	SELF.watchlist_zip := rt.watchlist_zip;
	SELF.watchlist_country := rt.watchlist_contry;
  SELF := le;
end;

b2bzWatch := join(grouped_rep, attus_out, left.seq=right.seq, addAttus(left, right), left outer);

withWatchlistsData := if(tribcode='b2bz', group(sort(b2bzWatch,seq),seq), normalWatch);	


layout_output addZipClass(withWatchlistsData le, riskwise.Key_CityStZip rt) := transform
	self.zipclass := rt.zipclass;
	self.zipcity := rt.prefctystname;
	self.statezipflag := IF(rt.state <> '' and le.st <> '' and StringLib.StringToUpperCase(le.st) <> rt.state, '1', '0');
	self.cityzipflag := IF(rt.city <> '' and le.p_city_name <> '' and (risk_indicators.LnameScore(StringLib.StringToUpperCase(le.p_city_name), rt.city) < 80), '1', '0');
	self := le;
end;

wZipClass := join(withWatchlistsData, riskwise.Key_CityStZip,
				keyed(right.zip5=left.orig_z5) and left.orig_z5!='',
				addZipClass(left, right), left outer, ATMOST(keyed(right.zip5=left.orig_z5),RiskWise.max_atmost), keep(100));

layout_output zipRoll(layout_output le, layout_output ri) := transform
	self.statezipflag := IF(le.statezipflag = '0', le.statezipflag, ri.statezipflag);
	self.cityzipflag := IF(le.cityzipflag = '0', le.cityzipflag, ri.cityzipflag);
	self := le;
end;
wZipClassRoll := ROLLUP(wZipClass,true,zipRoll(left,right));

// standardized the working layout so this function is easier to maintain.
// TODO:  may want to add some of these working layout fields to layout_output 
// 				if the modelers want them in the new business shell
working_layout := record
	layout_output;
	string2	src := '';
	unsigned4	dt_last_seen := 0;
	boolean	rcnt_a7;
	integer addr_compare_score := 0; //addrscore gets dropped when header not recent.  hang onto true addrscore to set address miskey flag
	boolean	bh_amatch;
	boolean	bh_cmatch;
	boolean	bh_pmatch;
	boolean	gong_amatch;
	boolean	gong_cmatch;
	boolean	gong_pmatch;
	boolean	csrc1			 := false;
	boolean	csrc2			 := false;
	boolean	asrc1			 := false;
	boolean	asrc2			 := false;
	boolean	psrc1			 := false;
	boolean	psrc2			 := false;
	boolean matchprison := false;
	boolean	RelFound	:= false;
	unsigned3 phone_dt_first := 0;
end;		

//-------------check prison address --------------
working_layout test_addr_against_ACA(wZipClassRoll L, aca.key_aca_addr R) := transform
	self.matchPrison := if (R.zip != '', true, false);
	self := l;
	self := [];
end;

wprison := join(wZipClassRoll, 
		    aca.key_aca_addr,
				keyed(left.prim_name = right.prim_name) and
				keyed(left.prim_Range = right.prim_range) and
				keyed(left.z5 = right.zip),
			test_addr_against_ACA(LEFT,RIGHT),
			left outer, 
			ATMOST(RiskWise.max_atmost), 
			keep(1));  // changed this to a keep(1), if any record matches to the ACA file with input address, it's a prison.  Don't need to keep more than one and then rollup			


// Convert Business_Risk.Layout_Input to Risk_Indicators.Layout_Input so we can use getDirsBy(Phone|Addr) 
risk_indicators.Layouts.layout_input_plus_overrides br_layout_to_ri_layout( Business_Risk.Layout_Input br ) := TRANSFORM
	SELF.seq := br.seq;
	self.historydate := br.historydate;
	SELF.prim_range := br.prim_range;
	SELF.predir := br.predir;
	SELF.prim_name := br.prim_name;
	SELF.addr_suffix := br.addr_suffix;
	SELF.postdir := br.postdir;
	SELF.unit_desig := br.unit_desig;
	SELF.sec_range := br.sec_range;
	SELF.p_city_name := br.p_city_name;
	SELF.st := br.st;
	SELF.z5 := br.z5;
	SELF.zip4 := br.zip4;
	SELF.phone10 := br.phone10;
	SELF := [];
END;


risk_indic_indata := PROJECT( indata, br_layout_to_ri_layout( LEFT ) );
					
deduped_input_addresses := dedup(sort(risk_indic_indata, z5, st, prim_range, prim_name, sec_range, seq), z5, st, prim_range, prim_name, sec_range);
dirs_by_addr := RiskWise.getDirsByAddr( deduped_input_addresses, isFCRA, glb, BSOptions );

deduped_input_phones := dedup(sort(risk_indic_indata, phone10, seq), phone10);
dirs_by_phone := RiskWise.getDirsByPhone( deduped_input_phones, gateways, dppa, glb, isFCRA, BSOptions, lastSeenThreshold, ExactMatchLevel,'');
							
working_layout check_gong_for_ver1(wprison L, RiskWise.Layout_Dirs_Address R) := transform	
	cmpymatch_score 	:= tmax2(CnameScore(l.company_name, r.listed_name), CnameScore(L.alt_company_name, R.listed_name));
	cmpymatch 		:= g(cmpymatch_score);
	phonematchscore 	:= tscore(max(0,Risk_Indicators.PhoneScore(l.phone10, r.phone10)));
	phonematch 		:= gn(phonematchscore);
	
	zip_score := Risk_Indicators.AddrScore.zip_score(l.orig_z5, r.z5);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(l.p_city_name, l.st, r.p_city_name, r.st, l.cityzipflag);
	addrmatchscore := tscore(Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range, 
																						r.prim_range, r.prim_name, r.sec_range,
																						zip_score, cityst_score));
	addrmatch			:= ga(addrmatchscore);
	self.cnamescore 	:= if (cmpymatch, tscore(cmpymatch_Score), l.cnamescore);
	self.vercmpy 		:= IF (cmpymatch, r.listed_name, l.vercmpy);	
	self.cnameMatchFlag := if (cmpymatch, 'Y', 'N');
	self.FeinMatchFlag := 'N';  // don't have fein on dirs records, set match flag to 'N'
	self.phonescore 	:= if (L.phoneMatchFlag != 'Y', if (cmpymatch and phonematch, phonematchscore, L.phonescore), L.phonescore);
	self.phoneMatchFlag := if (L.phoneMatchFlag != 'Y', if (cmpymatch and phonematch, 'Y', 'N'), L.phoneMatchFlag);
	self.verphone 		:= if (L.phoneMatchFlag = 'Y', L.verphone, if (self.phoneMatchFlag = 'Y' and cmpymatch, R.phone10, L.verphone));
	self.addrscore 	:= if (cmpymatch, max(addrmatchscore, L.addrscore), L.addrscore);
	self.citystatescore := if (cmpymatch, max(cityst_score, L.citystatescore), L.citystatescore);
	self.zipscore := if (cmpymatch, max(zip_score, L.zipscore), L.zipscore);
	self.addrMatchFlag	:= if (cmpymatch, 'Y', 'N');
	self.verAddr		:= if (self.AddrMatchFlag = 'Y' and cmpymatch, Risk_Indicators.MOD_AddressClean.street_address('',R.prim_range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range), L.verAddr);
	self.vercity		:= map(cmpymatch and MIN(ut.stringsimilar(R.p_city_name,L.p_city_name),ut.stringsimilar(L.p_city_name,R.p_city_name)) < 3 => R.p_city_name,
						  cmpymatch and MIN(ut.stringsimilar(R.v_city_name,L.v_city_name),ut.stringsimilar(L.v_city_name,R.v_city_name)) < 3 => R.v_city_name, 
						  L.vercity);
	self.cityMatchFlag	:= map (cmpymatch and l.p_city_name != '' and MIN(ut.stringsimilar(R.p_city_name,L.p_city_name),ut.stringsimilar(L.p_city_name,R.p_city_name)) < 3 => 'Y',
						   cmpymatch and l.v_city_name != '' and MIN(ut.stringsimilar(R.v_city_name,L.v_city_name),ut.stringsimilar(L.v_city_name,R.v_city_name)) < 3 => 'Y',
						   'N');
	self.verstate 		:= IF (cmpymatch and R.st = L.st, R.st, L.verstate);
	self.stateMatchFlag := IF (cmpymatch and L.st != '' and R.st = L.st, 'Y', 'N');
	self.verzip		:= IF (cmpymatch and (integer)R.z5  = (integer)L.z5, 
							(if((integer)r.z5=0,'',(string)R.z5)), L.verzip);
	self.verzip4	:= IF (cmpymatch and (integer)R.z5 = (integer)L.z5 and (integer)R.z4 = (integer)L.zip4, 
							(if((integer)r.z4=0,'',(string)R.z4)), L.verzip4);
	self.zipMatchFlag	:= IF (cmpymatch and L.z5 != '' and (integer)R.z5  = (integer)L.z5, 'Y', 'N');
	self.gong_cmatch	:= cmpymatch;
	self.gong_pmatch	:= cmpymatch and phonematch;
	self.gong_amatch	:= cmpymatch and ga(addrmatchscore);
	//------ From join below
	self.CmpyPhoneFromAddr := if (cmpymatch, r.phone10, l.cmpyphonefromaddr); 
	self.csrc1		:= cmpymatch;
	self.asrc1		:= addrmatch;
	self.psrc1		:= phonematch;
	self.phonefound	:= L.phonefound + if (phonematch, 1, 0);
	self.addrfound		:= L.addrfound + if (addrmatch, 1, 0);
	self.cmpyfound		:= L.cmpyfound + if (cmpymatch, 1, 0);
	self.phonecmpycount := L.phonecmpycount + IF(cmpymatch and phonematch and r.business_flag,1,0);
	self.phoneaddrcount := L.phoneaddrcount + IF(phonematch and addrmatch and r.business_flag,1,0);
	self.cmpyaddrcount	:= L.cmpyaddrcount + IF(cmpymatch and addrmatch and r.business_flag,1,0);
	self.phonecmpyaddrcount := L.phonecmpyaddrcount + IF(phonematch and addrmatch and cmpymatch, 1, 0) ;
	self.wrongphoneflag			 := map(r.prim_name = '' or L.phone10 = '' => '', // left outer condition - no match
								   ~cmpymatch and ~phonematch => '0',
								   ~phonematch => '1',
								   '2');
	self.resAddrFlag 			 := if (R.business_flag or R.prim_name = '', 'N', 'Y');
	self.busphonelat			 := if (L.busphonelat = '' and phonematch, R.geo_lat, L.busphonelat);
	self.busphonelong			 := if (L.busphonelong = '' and phonematch, R.geo_long, L.busphonelong);
	self.busPhoneZip			 := if (L.busPhoneZip = ''and phonematch, R.z5, L.busPhoneZip);
		
	myGetDate := risk_indicators.iid_constants.myGetDate(l.historydate);
	isrecent := recent_check(myGetDate,r.dt_last_seen[1..6]+'31');
	self.rcnt_a7 := (cmpymatch or phonematch) and isrecent;
	//-------- From join Below
	self := L;
end;


with_dirs_address := join(wprison, dirs_by_addr,
					left.prim_name = right.prim_name and
					left.st = right.st and
					left.z5 = right.z5 and
					left.prim_range = right.prim_range and
					ut.NNEQ( left.sec_range, right.sec_range ) and
					((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)) AND
				     (RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'01'))),
				check_gong_for_ver1(LEFT,RIGHT),
				left outer,ATMOST(left.prim_name = right.prim_name and
					left.st = right.st and
					left.z5 = right.z5 and
					left.prim_range = right.prim_range,RiskWise.max_atmost), keep(100), MANY LOOKUP);
					
working_layout countadd(working_layout l, working_layout r) := transform
	self.rcnt_a7 := l.rcnt_a7 or r.rcnt_a7;

	self.feinscore		:= max(l.feinscore,R.feinscore);
	// self.rcntf		:= if (l.feinscore > r.feinscore or l.feinscore = r.feinscore and l.feinmatchflag = 'Y', L.rcntf, R.rcntF);
	self.verfein 		:= IF(l.feinscore>=r.feinscore, l.verfein,r.verfein);
	self.feinMatchFlag	:= IF(l.feinscore>R.feinscore , l.feinMatchFlag,
							if (L.feinscore = R.feinscore and l.feinMatchFlag = 'Y', L.FeinMatchFlag,R.feinMatchFlag));
	self.addr_compare_score := max(l.addr_compare_score, r.addr_compare_score);
	self.addrscore		:= max(L.addrscore,r.addrscore);
	self.citystatescore := max(L.citystatescore, r.citystatescore);
	self.zipscore := max(l.zipscore, r.zipscore);
	// self.rcnta		:= if (l.addrscore > r.addrscore or l.addrscore = r.addrscore and l.addrmatchflag = 'Y', l.rcnta, R.rcnta);
	self.veraddr 		:= IF(l.addrscore>=r.addrscore,l.veraddr,r.veraddr);
	self.addrMatchFlag	:= IF(l.addrscore>R.addrscore ,l.addrMatchFlag,
							if (L.addrscore = R.addrscore and l.AddrMatchFlag = 'Y', L.AddrMatchFlag,R.addrMatchFlag));
	self.vercity		:= IF(l.vercity = '', R.vercity, 
						if(R.vercity = '', L.vercity,
						if(l.addrscore>=r.addrscore,l.vercity,r.vercity)));
	self.cityMatchFlag	:= IF(l.cityMatchFlag = 'N', R.cityMatchFLag,
						if(R.cityMatchFlag = 'N', L.CityMatchFlag,
						if(l.addrscore>R.addrscore ,l.cityMatchFlag,
							if (L.addrscore = R.addrscore and l.CityMatchFlag = 'Y', L.CityMatchFlag,R.cityMatchFlag))));
	self.verstate		:= if (L.verstate = '', R.verstate,
						if(R.verstate = '', L.verstate,
						IF(l.addrscore>=r.addrscore,l.verstate,r.verstate)));
	self.stateMatchFlag	:= if (L.stateMatchFlag = 'N', R.stateMatchFlag,
						if (R.stateMatchFlag = 'N', L.stateMatchFlag,
						IF(l.addrscore>R.addrscore,l.stateMatchFlag,
							if (L.addrscore = R.addrscore and l.StateMatchFlag = 'Y', L.StateMatchFlag,R.stateMatchFlag))));
	self.verzip		:= if (L.verzip = '', R.verzip,
						if(R.verzip = '', L.verzip,
						IF(l.addrscore>=r.addrscore,l.verzip,r.verzip)));
	self.verzip4		:= if (L.verzip4 = '', R.verzip4,
						if (R.verzip4 = '', L.verzip4,
						IF(l.addrscore>=r.addrscore,l.verzip4,r.verzip4)));
	self.zipMatchFlag	:= if (L.zipMatchFlag = 'N', R.ZipMatchFlag,
						if (R.zipMatchFlag = 'N', L.zipMatchFlag,
						IF(l.addrscore>R.addrscore, L.zipmatchFlag, 
							if (L.addrscore = R.addrscore and l.ZipMatchFlag = 'Y', L.ZipMatchFlag,R.zipMatchFlag))));
	self.multisrcaddr	:= L.multisrcaddr or (l.src != r.src and r.src != '' and ga(self.addrscore));
	self.cnamescore	:= max(L.cnamescore,r.cnamescore);
	// self.rcntc		:= if(l.cnamescore > r.cnamescore or l.cnamescore = r.cnamescore and l.cnameMatchFlag = 'Y', L.rcntc, R.rcntC);
	self.vercmpy 		:= IF(l.cnamescore>=r.cnamescore,l.vercmpy,r.vercmpy);
	self.cnameMatchFlag	:= IF(l.cnamescore>R.cnamescore,l.cnameMatchFlag,
							if (L.cnamescore = R.cnamescore and l.cnameMatchFlag = 'Y', L.cnameMatchFlag,R.cnameMatchFlag));
	self.multisrccmpy	:= L.multisrccmpy or (l.src != r.src and r.src != '' and g(self.cnamescore));
	self.phonescore	:= max(l.phonescore,r.phonescore);
	// self.rcntP		:= if (L.phonescore > R.phonescore or L.phonescore = R.phonescore and L.phonematchflag = 'Y', L.rcntp, R.rcntP);
	self.verPhone		:= if(L.phonescore>=R.phonescore, L.verphone, R.verphone);
	self.PhoneMatchFlag := if(L.phonescore>R.phonescore, L.phoneMatchFlag,
							if (L.phonescore = R.phonescore and L.phoneMatchFlag = 'Y', L.phoneMatchFlag, R.phoneMatchFlag));
	self.bh_amatch		:= l.bh_amatch or R.bh_amatch;
	self.bh_cmatch		:= l.bh_cmatch or R.bh_cmatch;
	self.bh_pmatch		:= l.bh_pmatch or R.bh_pmatch;
	self.gong_amatch 	:= l.gong_amatch or R.gong_amatch;
	self.gong_cmatch 	:= l.gong_cmatch or R.gong_cmatch;
	self.gong_pmatch 	:= l.gong_pmatch or R.gong_pmatch;
	self.asrc1		 := (L.asrc1 or R.asrc1);
	self.asrc2		 := (L.asrc2 or R.asrc2);
	self.csrc1		 := (L.csrc1 or R.csrc1);
	self.csrc2		 := (L.csrc2 or R.csrc2);
	self.psrc1		 := (l.psrc1 or R.psrc1);
	self.psrc2		 := (L.psrc2 or R.psrc2);
	self.phonefound	 := max(L.phonefound,R.phonefound);
	self.addrfound		 := max(L.addrfound,R.addrfound);
	self.cmpyfound		 := max(L.cmpyfound,R.cmpyfound);
	self.phonecmpycount  := max(l.phonecmpycount, r.phonecmpycount);
	self.phoneaddrcount  := max(l.phoneaddrcount, r.phoneaddrcount);
	self.cmpyaddrcount := max(l.cmpyaddrcount, r.cmpyaddrcount);
	self.phonecmpyaddrcount := max(l.phonecmpyaddrcount, R.phonecmpyaddrcount);
	self.CmpyPhoneFromAddr		 := IF(l.phonecmpycount>=r.phonecmpycount and L.cmpyphonefromaddr != '',l.CmpyPhoneFromAddr,r.CmpyPhoneFromAddr);
	self.PhoneMatchFirst		 := IF(l.phonecmpycount>=r.phonecmpycount and L.phoneMatchFirst != '',l.PhoneMatchFirst,r.PhoneMatchFirst);
	self.PhoneMatchLast 		 := IF(l.phonecmpycount>=r.phonecmpycount and L.phoneMatchLast != '',l.PhoneMatchLast,r.PhoneMatchLast);
	self.PhoneMatchCompany 		 := IF(l.phonecmpycount>=r.phonecmpycount and L.phoneMatchCompany != '',l.PhoneMatchCompany,r.PhoneMatchCompany);
	self.PhoneMatchAddr 		 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchAddr != '',l.PhoneMatchAddr,r.PhoneMatchAddr);
	self.PhoneMatchCity 		 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchCity != '',l.PhoneMatchCity,r.PhoneMatchCity);
	self.PhoneMatchState 	 	 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchState != '',l.PhoneMatchState,r.PhoneMatchState);
	self.PhoneMatchZip 		 	 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchZip != '',l.PhoneMatchZip,r.PhoneMatchZip);
	self.PhoneMatchZip4			 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchZip4 != '',l.PhoneMatchZip4,r.PhoneMatchZip4);
	self.dist_busphone_busaddr 	 := min((integer)L.dist_busphone_busaddr,(integer)R.dist_busphone_busaddr);
	self.phonezipmismatch 	 := l.phonezipmismatch and R.phonezipmismatch;
	self.wrongphoneflag		 := if ((integer)L.wrongphoneflag > (integer) R.wrongphoneflag, L.wrongphoneflag, 
								if (R.wrongphoneflag = '', L.wrongphoneflag, R.wrongphoneflag));
	self.phonevalidflag		:= if((integer)L.phonevalidflag > (integer)R.phonevalidflag, L.phonevalidflag, R.phonevalidflag);
	self.busphonelat		 := if (L.busphonelat = '', R.busphonelat, L.busphonelat);
	self.busphonelong		 := if (L.busphonelong = '', R.busphonelong, L.busphonelong);
	self.busPhoneZip		 := if (l.busPhoneZip = '', R.busPhoneZip, L.busPhoneZip);
	self.resphoneflag		:= if (L.resPhoneflag = 'Y' or R.resPhoneFlag = 'Y', 'Y', 'N');
	self.resAddrflag 		:= if (L.resAddrflag = 'N' or R.resAddrFlag  = 'N', 'N', 'Y');
	self 			:= l;
END;					

rolled_dirs_address := rollup(with_dirs_address,true,countadd(LEFT,RIGHT));



	
	
working_layout check_gong_for_ver2(rolled_dirs_address L, RiskWise.Layout_Dirs_Phone R) := transform
	cmpymatch_score 	:= tmax2(CnameScore(l.company_name, r.listed_name), CnameScore(L.alt_company_name, R.listed_name));
	cmpymatch 		:= g(cmpymatch_score);
	
	zip_score := Risk_Indicators.AddrScore.zip_score(l.orig_z5, r.z5);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(l.p_city_name, l.st, r.p_city_name, r.st, l.cityzipflag);
	addrmatchscore := tscore(Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range, 
																						r.prim_range, r.prim_name, r.sec_range,
																						zip_score, cityst_score));
																						
	addrmatch 		:= ga(addrmatchscore);
	phonematchscore 	:= tscore(max(0,Risk_Indicators.PhoneScore(l.phone10, r.phone10)));
	phonematch 		:= gn(phonematchscore);
	
	goodHit := IF(( (INTEGER)addrmatch+(INTEGER)phonematch+(INTEGER)cmpymatch) >1,true,false);// need at least 2 elements to match to keep record

	self.addrscore 	:= if (goodhit and addrmatchscore > l.addrscore, addrmatchscore, L.addrscore);
	self.citystatescore 	:= if (goodhit and addrmatchscore > l.addrscore, cityst_score, L.citystatescore);
	self.zipscore 	:= if (goodhit and addrmatchscore > l.addrscore, zip_score, L.zipscore);
	self.addrMatchFlag	:= if (addrmatch and goodhit, 'Y', L.addrmatchflag);
	self.verAddr		:= if (addrmatch and goodhit, Risk_Indicators.MOD_AddressClean.street_address('',R.prim_range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range), L.verAddr);
	self.vercity		:= map (addrmatch and goodhit and MIN(ut.stringsimilar(R.p_city_name,L.p_city_name),ut.stringsimilar(L.p_city_name,R.p_city_name)) < 3 => R.p_city_name, 
						   addrmatch and goodhit and MIN(ut.stringsimilar(R.v_city_name,L.v_city_name),ut.stringsimilar(L.v_city_name,R.v_city_name)) < 3 => R.v_city_name, 
						   L.vercity);
	self.cityMatchFlag	:= map (addrmatch and goodhit and l.p_city_name != '' and MIN(ut.stringsimilar(R.p_city_name,L.p_city_name),ut.stringsimilar(L.p_city_name,R.p_city_name)) < 3 => 'Y',
						   addrmatch and goodhit and l.v_city_name != '' and MIN(ut.stringsimilar(R.v_city_name,L.v_city_name),ut.stringsimilar(L.v_city_name,R.v_city_name)) < 3 => 'Y',
						   L.cityMatchFlag);
	self.verstate 		:= IF (addrmatch and goodhit and R.st = L.st, R.st, L.verstate);
	self.stateMatchFlag := IF (addrmatch and goodhit and L.st != '' and R.st = L.st, 'Y', L.stateMatchFlag);
	self.verzip		:= IF (addrmatch and goodhit and (integer)R.z5  = (integer)L.z5, 
							(if((integer)r.z5=0,'',(string)R.z5)), L.verzip);
	self.verzip4	:= IF (addrmatch and goodhit and (integer)R.z5 = (integer)L.z5 and (integer)R.z4 = (integer)L.zip4, 
							(if((integer)r.z4=0,'',(string)R.z4)), L.verzip4);
	self.zipMatchFlag	:= IF (addrmatch and goodhit and L.z5 != '' and (integer)R.z5  = (integer)L.z5, 'Y', L.zipMatchFlag);
	self.phonematchflag := if (phonematch and goodhit, 'Y', L.phonematchflag);
	self.verphone		:= if (phonematch and goodhit, R.phone10, L.verphone);
	self.phonescore	:= if (phonematch  and goodhit, phonematchscore, L.phonescore);
	self.gong_cmatch	:= (L.gong_cmatch or cmpymatch);
	self.gong_pmatch	:= (L.gong_pmatch or (phonematch and goodhit));
	self.gong_amatch	:= (L.gong_amatch or (addrmatch and goodhit));
	//---------from join below
	self.csrc1 		:= if (cmpymatch and R.current_flag, true, false);
	self.asrc1 		:= if (addrmatch and R.current_flag, true, false);
	self.psrc1		:= if (phonematch and R.current_flag, true, false);
	self.phonefound	:= if (R.current_flag, L.phonefound + if (phonematch, 1, 0), L.phonefound);
	self.addrfound		:= if (R.current_flag, L.addrfound + if (addrmatch, 1, 0), L.addrfound);
	self.cmpyfound		:= if (R.current_flag, L.cmpyfound + if (cmpymatch, 1, 0), L.cmpyfound);
	self.phonecmpycount := if (R.current_flag, L.phonecmpycount + IF(cmpymatch and phonematch,1,0), L.phonecmpycount);
	self.phoneaddrcount := if (R.current_flag, L.phoneaddrcount + IF(phonematch and addrmatch,1,0), L.phoneaddrcount);
	self.cmpyaddrcount	:= if (R.current_flag, L.cmpyaddrcount + IF(cmpymatch and addrmatch,1,0), L.cmpyaddrcount);
	self.phonecmpyaddrcount := if (R.current_flag, L.phonecmpyaddrcount + IF(phonematch and addrmatch and cmpymatch, 1, 0), L.phonecmpyaddrcount);
	self.PhoneMatchFirst	:= if (R.current_flag, r.name_first, L.phonematchfirst);
	self.PhoneMatchLast		:= if (R.current_flag, r.name_last, L.phonematchlast);
	self.PhoneMatchCompany	:= if (R.current_flag, r.listed_name, L.phonematchcompany);
	self.PhoneMatchAddr		:= if (R.current_flag, Risk_Indicators.MOD_AddressClean.street_address('',r.prim_range, r.predir, r.prim_name,
							r.suffix, r.postdir, r.unit_desig, r.sec_range), L.phonematchaddr);
	self.PhoneMatchCity 	:= if (R.current_flag, r.p_city_name, L.phonematchcity);
	self.PhoneMatchState 	:= if (R.current_flag, r.st, L.phonematchstate);
	self.PhoneMatchZip 		:= if (R.current_flag, r.z5, L.phonematchzip);
	self.PhoneMatchZip4		:= if (R.current_flag, r.z4, L.phonematchzip4);
	self.phonezipmismatch 	:= if (R.current_flag and phonematch and l.orig_z5!='' and L.orig_z5 != R.z5, true, false);
	self.dist_busphone_busaddr 	:= if (R.current_flag, IF(length(trim(l.phone10))=10,if(l.lat='' or r.geo_lat='',9999,round(ut.ll_dist((REAL)l.lat,(REAL)l.long,(REAL)r.geo_lat,(REAL)r.geo_long))),9999), 9999);
	self.Busphonelat 		:= if (R.current_flag, r.geo_lat, L.busphonelat);
	self.Busphonelong	 	:= if (R.current_flag, r.geo_long, L.busphonelong);
	self.BusPhoneZip		:= if (R.current_flag, R.z5, L.busphonezip);
	self.resPhoneFlag		:= if (R.current_flag , if (r.business_flag or R.prim_name = '', 'N','Y'), 'N');
	self.homephonelat		:= R.geo_lat;
	self.homephonelong		:= R.geo_long;
	self.homephonezip		:= R.z5;
	
	myGetDate := risk_indicators.iid_constants.myGetDate(l.historydate);
	isrecent := recent_check(myGetDate,r.dt_last_seen[1..6]+'31');
	self.rcnt_a7 := l.rcnt_a7 or ((cmpymatch or addrmatch) and isrecent);
	// -- from join below.
	self := L;
end;

with_dirs_phone := join(rolled_dirs_address, dirs_by_phone,
					(integer)left.phone10 != 0 and
					(left.phone10[1..3] = right.p3) and
					(left.phone10[4..10] = right.p7) and
					((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)) AND
				     (RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'01'))),
				check_gong_for_ver2(LEFT,RIGHT),
				left outer, ATMOST((left.phone10[1..3] = right.p3) and
					(left.phone10[4..10] = right.p7),RiskWise.max_atmost), keep(200), MANY LOOKUP);


rolled_dirs_phone := group(sort(rollup(with_dirs_phone, true, countadd(LEFT,RIGHT)), seq), seq);

// ************ BEGIN PURE BNAP ********* /

// area code split info
working_layout get_ac_split(working_layout le, risk_indicators.key_areacode_change_plus ri) :=
TRANSFORM
	SELF.areacodesplitflag := IF(ri.old_NPA<>'' and ~ri.reverse_flag,'Y','N');
	SELF.areacodesplitdate := ri.permissive_start;
	SELF.altareacode := ri.new_NPA;
	SELF.reverse_areacodesplitflag := IF(ri.old_NPA<>'' and ri.reverse_flag,'Y','N');
	SELF := le;
END;

ac_split := JOIN(rolled_dirs_phone, 
			  risk_indicators.key_areacode_change_plus, 
				LENGTH(TRIM(LEFT.phone10))=10 AND
				(integer)left.phone10 != 0 and
				keyed(LEFT.phone10[1..3]=RIGHT.old_NPA) AND
				keyed(LEFT.phone10[4..6]=RIGHT.old_NXX) and
				(unsigned)right.permissive_start[1..6] < left.historydate, 
			  get_ac_split(LEFT,RIGHT),
			  left outer, atmost(100));


// high risk phone info
working_layout phtrans(working_layout le,risk_indicators.key_phone_table_v2 ri) := transform
	self.hriskphoneflag := if (ri.phone10 = '', 'U', (STRING)risk_indicators.PRIIPhoneRiskFlag(le.phone10).phoneRiskFlag(ri.nxx_type, ri.potDisconnect, ri.sic_code));
	self.phonevalidflag := map(length(trim(Le.phone10))< 10 => '4',
						  Ri.phone10 = '' => '0',
						  Ri.isacompany => '1',
						  '2');
	self.phonedisflag 	:= ri.potDisconnect;
	self.phone_dt_first := ri.dt_first_seen;
	self 			:= le;
END;

jphonerecs := join(ac_split,
			    risk_indicators.key_phone_table_v2,
					(integer)left.phone10 != 0 and
					keyed(left.phone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
			    phtrans(left,right),
			    left outer, atmost(100));


working_layout jphone_roll( working_layout l, working_layout r ) := TRANSFORM
	left_phone := not l.phonedisflag and r.phonedisflag // pick current over not
		or l.phonedisflag=r.phonedisflag and l.phonevalidflag='1' and r.phonevalidflag!='1' // business over non-business
		or l.phonedisflag=r.phonedisflag and l.phonevalidflag=r.phonevalidflag and l.phone_dt_first > r.phone_dt_first; // newest DFS over older
	self.hriskphoneflag := if( left_phone, l.hriskphoneflag, r.hriskphoneflag );
	self.phonedisflag   := if( left_phone, l.phonedisflag,   r.phonedisflag );
	self.phonevalidflag := if( left_phone, l.phonevalidflag, r.phonevalidflag );

	self := l;
END;

jphone_rolled := rollup( jphonerecs, true, jphone_roll(LEFT,RIGHT) );


working_layout tele_join(jphone_rolled L, risk_indicators.Key_Telcordia_tpm_Slim R) := transform
	self.hriskphoneflag := if (L.hriskphoneflag in ['U','7'],	
							(STRING)risk_indicators.PRIIPhoneRiskFlag(l.phone10).phoneRiskFlag(r.nxx_type, l.phonedisflag, ''),
							l.hriskphoneflag);
	dial := r.dial_ind;  
	self.nxx_type := r.nxx_type;
	point := r.point_id;
	self.TelcordiaPhoneType := map(dial='1' and point in['0','3','6'] => '1',
				  dial='0' and point in['0','3','6'] => '2',
				  dial='1' and point ~in['0','3','6'] => '3',
				  dial='0' and point ~in['0','3','6'] => '4',
				  '4');	
					
	self := L;
end;

jphonerecs2 := join(jphone_rolled, 
				risk_indicators.Key_Telcordia_tpm_Slim,
					keyed(left.phone10[1..3] = right.npa) and
					keyed(left.phone10[4..6] = right.nxx) and
					KEYED(RIGHT.tb=LEFT.phone10[7]),
				tele_join(lEFT,RIGHT),
				left outer, atmost(100), keep(1));
				
// high risk address by SIC code

working_layout hrtrans(working_layout l, risk_indicators.key_HRI_Address_To_SIC r) := transform
	self.hriskaddrflag := MAP(l.baddrtype = 'M' => '3',
						 l.prim_name='' OR l.z5='' => '5',
						 r.sic_code='' => '0',             // need a 1,2 here yet	 
						 r.sic_code<>'' => '4',
						 '');
	self.hrisksic 		:= r.sic_code;
	self 			:= l;
END;

working_layout rolltrans(working_layout l,working_layout r) := transform
	self.asrc1		 := (L.asrc1 or R.asrc1);
	self.asrc2		 := (L.asrc2 or R.asrc2);
	self.csrc1		 := (L.csrc1 or R.csrc1);
	self.csrc2		 := (L.csrc2 or R.csrc2);
	self.psrc1		 := (l.psrc1 or R.psrc1);
	self.psrc2		 := (L.psrc2 or R.psrc2);
	self.phonefound	 := max(L.phonefound,R.phonefound);
	self.addrfound		 := max(L.addrfound,R.addrfound);
	self.cmpyfound		 := max(L.cmpyfound,R.cmpyfound);
	self.phonecmpycount  := max(l.phonecmpycount, r.phonecmpycount);
	self.phoneaddrcount  := max(l.phoneaddrcount, r.phoneaddrcount);
	self.cmpyaddrcount := max(l.cmpyaddrcount, r.cmpyaddrcount);
	self.phonecmpyaddrcount := max(l.phonecmpyaddrcount, R.phonecmpyaddrcount);
	self.CmpyPhoneFromAddr		 := IF(l.phonecmpycount>=r.phonecmpycount and L.cmpyphonefromaddr != '',l.CmpyPhoneFromAddr,r.CmpyPhoneFromAddr);
	self.PhoneMatchFirst		 := IF(l.phonecmpycount>=r.phonecmpycount and L.phoneMatchFirst != '',l.PhoneMatchFirst,r.PhoneMatchFirst);
	self.PhoneMatchLast 		 := IF(l.phonecmpycount>=r.phonecmpycount and L.phoneMatchLast != '',l.PhoneMatchLast,r.PhoneMatchLast);
	self.PhoneMatchCompany 		 := IF(l.phonecmpycount>=r.phonecmpycount and L.phoneMatchCompany != '',l.PhoneMatchCompany,r.PhoneMatchCompany);
	self.PhoneMatchAddr 		 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchAddr != '',l.PhoneMatchAddr,r.PhoneMatchAddr);
	self.PhoneMatchCity 		 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchCity != '',l.PhoneMatchCity,r.PhoneMatchCity);
	self.PhoneMatchState 	 	 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchState != '',l.PhoneMatchState,r.PhoneMatchState);
	self.PhoneMatchZip 		 	 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchZip != '',l.PhoneMatchZip,r.PhoneMatchZip);
	self.PhoneMatchZip4			 := IF(l.phoneaddrcount>=r.phoneaddrcount and L.phoneMatchZip4 != '',l.PhoneMatchZip4,r.PhoneMatchZip4);
	self.dist_busphone_busaddr 	 := min((integer)L.dist_busphone_busaddr,(integer)R.dist_busphone_busaddr);
	self.phonezipmismatch 	 := l.phonezipmismatch and R.phonezipmismatch;
	self.wrongphoneflag		 := if ((integer)L.wrongphoneflag > (integer) R.wrongphoneflag, L.wrongphoneflag, 
								if (R.wrongphoneflag = '', L.wrongphoneflag, R.wrongphoneflag));
	self.busphonelat		 := if (L.busphonelat = '', R.busphonelat, L.busphonelat);
	self.busphonelong		 := if (L.busphonelong = '', R.busphonelong, L.busphonelong);
	self.busPhoneZip		 := if (l.busPhoneZip = '', R.busPhoneZip, L.busPhoneZip);
	self.hrisksic  := if(r.hrisksic<>'', r.hrisksic, l.hrisksic);
	self.hriskaddrflag := if(r.hrisksic<>'', r.hriskaddrflag, l.hriskaddrflag);
	self 				 := l;
END;

biggerrec := join(jphonerecs2, 
			   risk_indicators.key_HRI_Address_To_SIC,
				keyed(left.z5=right.z5) and 
				keyed(left.prim_name=right.prim_name) and 
				keyed(left.addr_suffix=right.suffix) and 
				keyed(left.predir=right.predir) and 
				keyed(left.postdir=right.postdir) and 
				keyed(left.prim_range=right.prim_range) and
				keyed(left.sec_range=right.sec_range) and right.dt_first_seen < left.historydate,
			   hrtrans(left,right),
			   left outer, atmost(100));


byAddrRollPhone := rollup(biggerrec, true, rolltrans(LEFT,RIGHT));


working_layout check_phone_vs_bh_2(byAddrRollPhone L, business_header_ss.Key_BH_Phone R) := transform
	cmpymatch_score := tmax2(CnameScore(l.company_name, r.company_name),CnameScore(L.alt_company_name, R.company_name));
	cmpymatch 	:= g(cmpymatch_score);
	phonescore := risk_indicators.PhoneScore(l.phone10, (string)r.phone);
	phonematch 	:= gn(phonescore);	
		
	zip_score := Risk_Indicators.AddrScore.zip_score(l.orig_z5, (string)r.zip);
	addr_compare_score := Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range, 
																						r.prim_range, r.prim_name, r.sec_range,
																						zip_score);
	addrmatchscore 	:= max(0, (addr_compare_score - 15) );  // subtract 15 here because we can't check the recency of this address without the dates present on the phone key
	addrmatch 		:= ga(addrmatchscore);
	
	self.veraddr 		:= IF (addrmatch and tscore(addrmatchscore) > l.addrscore,
						  Risk_Indicators.MOD_AddressClean.street_address('',l.prim_range, l.predir, l.prim_name,
							l.addr_suffix, l.postdir, l.unit_desig, l.sec_range),l.veraddr);	
	self.AddrMatchFlag	:= IF (addrmatch, 'Y', l.addrmatchflag);
	
	// can't do vercity in this transform because the payload of the bh_phone key doesn't have city available
	self.verzip		:= IF ((integer)R.zip  = (integer)L.z5, 
							(if(r.zip=0,'',intformat(R.zip, 5, 1) )), L.verzip);
	self.zipMatchFlag	:= IF (L.z5 != '' and (integer)R.zip  = (integer)L.z5, 'Y', l.zipmatchflag);

	self.vercmpy 		:= IF (cmpymatch and tscore(cmpymatch_Score) > l.cnamescore, r.company_name, l.vercmpy);
	self.cnamescore 	:= if(tscore(cmpymatch_Score) > l.cnamescore, tscore(cmpymatch_Score), l.cnamescore);
	self.cnameMatchFlag := if (cmpymatch, 'Y', l.cnamematchflag);
	
	self.verphone		:= IF (phonematch, 
													if(tscore(phonescore)>tscore(l.phonescore), (string)R.phone, l.verphone), 
													L.verphone);
	self.phonescore := IF (phonematch and tscore(phonescore)>tscore(l.phonescore), phonescore, l.phonescore);
	self.phonematchflag := if(phonematch or l.phonematchflag='Y','Y','N');

	self.csrc2		:= if (cmpymatch, true, L.csrc2);
	self.asrc2		:= if (addrmatch, true, L.asrc2);
	self.psrc2		:= if (phonematch, true, L.psrc2);
	self.phonefound	:= L.phonefound + if (phonematch, 1, 0);
	self.addrfound		:= L.addrfound + if (addrmatch, 1, 0);
	self.cmpyfound		:= L.cmpyfound + if (cmpymatch, 1, 0);
	self.phonecmpycount := L.phonecmpycount + IF(cmpymatch and phonematch,1,0);
	self.phoneaddrcount := L.phoneaddrcount + IF(phonematch and addrmatch,1,0);
	self.cmpyaddrcount	:= L.cmpyaddrcount + IF(cmpymatch and addrmatch,1,0);
	self.phonecmpyaddrcount := L.phonecmpyaddrcount + IF(phonematch and addrmatch and cmpymatch, 1, 0) ;
	self.rcnt_a7 := l.rcnt_a7 or cmpymatch or addrmatch;  // no dates on this key, so if we match, we'll call it recent by default so we don't trigger A7 reason code					
	self := l;
end;

phone_napready := join(byAddrRollPhone,
				   business_header_ss.Key_BH_Phone,
					left.phone10 != '' and
					keyed((integer)left.phone10 = right.phone),
				   check_phone_vs_bh_2(LEFT,RIGHT),
			        left outer, keep(100), ATMOST(keyed((integer)left.phone10 = right.phone),RiskWise.max_atmost));
			 

// roll it all up
rollphonerecs := rollup(phone_napready,true,rolltrans(left,right));


rollphonerecs try_yp_For_Lat_long(rollphonerecs L, yellowpages.Key_YellowPages_Phone R) := transform
	self.busphonelat := if (L.busphonelat = '', R.geo_lat, L.busphonelat);
	self.busphonelong := if (l.busphonelong = '', R.geo_long, L.busphonelong);
	self.busPhoneZip := if (L.busPhoneZip = '', R.zip, L.busPhoneZip);
	self := l;
end;

try_yp_temp := join(rollphonerecs,
			yellowpages.Key_YellowPages_Phone,
				left.phone10 != '' and
				keyed(left.phone10 = right.phone10),
			try_yp_for_lat_long(LEFT,RIGHT),
			left outer, keep(200), ATMOST(keyed(left.phone10 = right.phone10),RiskWise.max_atmost));
			
try_yp := if(isCNSMR,rollphonerecs,try_yp_temp);

try_yp_roll := rollup(try_yp, true, rolltrans(LEFT,RIGHT));


// ----------- BEGIN BNAS ----------------/

for_BNAS := record
	working_layout;
	boolean	addrmatch;
	boolean	namematch;
	boolean	ssnmatch;
end;

for_BNAS check_TIN_as_SSN(try_yp_roll L, business_risk.Key_SSN_Address R) := transform
	self.addrmatch := ga(Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range, 
																						r.prim_range, r.prim_name, r.sec_range));
	self.namematch := g(tmax2(CnameScore(L.company_name,trim(R.fname) + ' ' + trim(R.mname) + ' ' +trim(r.lname)),CnameScore(L.alt_company_name, trim(R.fname) + ' ' + trim(R.mname) + ' ' +trim(r.lname))));
	self.ssnmatch := L.fein = R.ssn;
	self := l;
end;

w_ssncheck := join(try_yp_roll,
			    business_risk.Key_SSN_Address,
					(integer)left.fein != 0 and left.prim_name != '' and
					keyed(left.fein = right.ssn) and
					keyed(left.prim_name = right.prim_name),
			    check_TIN_as_SSN(LEFT,RIGHT),
			    left outer, keep(100));
			    

for_bnas roll_SSN(for_bnas L, for_bnas R) := transform
	self.addrmatch := L.addrmatch or R.addrmatch;
	self.ssnmatch  := L.ssnmatch  or R.ssnmatch;
	self.namematch := L.namematch or R.nameMatch;
	self := L;
end;

rolled_bnas := rollup(w_ssncheck, true, roll_SSN(LEFT,RIGHT));

rolled_bnas check_for_deceased_Flag(rolled_bnas L, risk_indicators.key_ssn_table_v4_2 R) := transform

	dcNeeded := Suppress.dateCorrect.do(r.ssn).needed;
	
	iid_constants := risk_indicators.iid_constants;
	// determine which section of the table is permitted for use based on the data restriction mask
	header_version := map(DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse and
												DataRestriction[iid_constants.posEquifaxRestriction]=iid_constants.sFalse and
												DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse=> r.combo,
												DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse => r.en,
												DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse => r.tn,
												r.eq);  // default to the EQ version		
												
	// eq section is the SSA death records only. (what used to be known as Death v2)
	// EN and TN bureau records are additional in their respective sections, use the date restriction 
	bureau_deceased_records_permitted := DataRestriction[iid_constants.posBureauDeceasedRestriction]=iid_constants.sFalse;
	ri_isDeceased := if(bureau_deceased_records_permitted, header_version.isDeceased, r.eq.isDeceased);
	ri_dt_first_deceased := if(bureau_deceased_records_permitted, header_version.dt_first_deceased , r.eq.dt_first_deceased );
			
	self.deceasedTIN := if ((ri_isDeceased  AND ((string)ri_dt_first_deceased < risk_indicators.iid_constants.myGetDate(l.historydate))) and not dcNeeded, 'Y', 'N');
	
	self.BNAS_Indicator := map (~L.ssnmatch or ~(L.addrmatch or L.namematch) => '0',
						    L.ssnmatch and L.addrmatch and ~L.namematch => '1',
						    L.ssnmatch and L.namematch and ~L.addrmatch => '2',
						    '3');
								
	self := L;
end;

with_bnap_bnas := join(rolled_bnas,
			  risk_indicators.key_ssn_table_v4_2,
					keyed(left.FEIN = right.SSN) ,
			  check_for_deceased_Flag(LEFT,RIGHT),
			  left outer, atmost(250));
//----------------- END BNAS --------------/



appends := 'BEST_ALL';
verify := 'BEST_ALL';
thresh_num := 0;  
bdids_to_keep := 5;

// Append BDIDs if needed
bdidprep0 := project(indata, transform(Business_Header_SS.Layout_BDID_InBatch, self := left));
bdidprep_alt := project(indata(alt_company_name != ''), transform(business_header_ss.Layout_BDID_InBatch, self.company_name := Left.alt_company_name, self := left));

bdidprep := bdidprep0 + bdidprep_alt;

Business_Header_SS.MAC_BDID_Append(bdidprep,bdidappend1,thresh_num, bdids_to_keep)

// else, if BDIDs already present...
bdidnoprep := project(indata, transform(Business_Header_SS.Layout_BDID_OutBatch, self := left));

// now has bdid, either way
bdidbatch := if(hasbdids, bdidnoprep, bdidappend1);

// append bests
Business_Header_SS.MAC_BestAppend(bdidbatch,appends,verify,bdidbest,true)

working_layout intoOutLayout(with_bnap_bnas l, bdidbest r) := transform
  self.bdid 		 := r.bdid;
	self.score 		 := r.score;
	self.Bestaddr 		 := r.best_addr1;
	self.Bestcity 		 := r.best_city;
	self.Beststate 	 := r.best_state;
	self.Bestzip 		 := r.best_zip;
	self.BestZip4		 := r.best_zip4;
	self.bestCompanyName := r.best_CompanyName;
	self.Bestphone		 := r.best_phone;
	self.Bestfein 		 := r.best_fein;
	self.bestCompanyNamescore := tmax2(CnameScore(r.best_CompanyName, l.company_name), CnameScore(R.best_companyName, L.alt_company_Name));
	self.Bestphonescore	 := Risk_Indicators.PhoneScore(r.best_phone, l.phone10);
	self.Bestfeinscore 	 := r.verify_best_fein;
	self.Bestaddrscore 	 := r.verify_best_address;
	self.addrvalidflag 	 := if (L.prim_name = '', '', risk_indicators.iid_constants.addrvalflag(l.addr_status));
	self.baddrtype		 := if (L.prim_name = '', '', risk_indicators.iid_constants.dwelltype(L.addr_type));
	self.lat 			 := l.lat;
	self.long 		 := l.long;
	self  			 := l;
end; 


bestrecs_init := join(with_bnap_bnas, bdidbest, left.seq=right.seq, intoOutLayout(left, right), many lookup);

bestrecs := group(sort(bestrecs_init, seq),seq);

// Append FEIN info
working_layout get_feinTable(working_layout l, Business_Risk.key_fein_table r) := transform
	self.bdid 		:= IF(l.bdid=0 and r.bestCount=1, r.bestBDID, l.bdid);
	self.feinvalidflag 	:= map(r.isValidFormat => '0', '2'); 
	self.bkFeinFlag 	:= IF(r.isBankrupt,true,false);  
	self 			:= l;
end;

got_feinTable := join(bestrecs,
				  Business_Risk.key_fein_table,
					(unsigned4)Left.fein != 0 and
					keyed((unsigned4)left.fein=right.fein) and
					(RIGHT.busheader_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)),
				  get_feinTable(left,right),
				  left outer, keep(100));


working_layout get_BusHeader(working_layout l, Business_Header_SS.Key_BH_BDID_pl r) := TRANSFORM
	myGetDate := risk_indicators.iid_constants.myGetDate(l.historydate);					
	isrecent := recent_check(myGetDate, ((STRING)r.dt_last_seen)[1..6]+'31');
				   
	cmpymatch_score 	:= max(0,tmax2(CnameScore(l.company_name, r.company_name), CnameScore(L.alt_company_name, R.company_name)));
	cmpymatch 		:= g(cmpymatch_score);
	
	zip_score := Risk_Indicators.AddrScore.zip_score(l.orig_z5, if(r.zip=0, '', intformat(r.zip, 5, 1)));
	cityst_score := Risk_Indicators.AddrScore.citystate_score(l.p_city_name, l.st, r.city, r.state, l.cityzipflag);
	addr_compare_score := Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range, 
																						r.prim_range, r.prim_name, r.sec_range,
																						zip_score, cityst_score);
	addrmatchscore 	:= max(0, addr_compare_score - if (isrecent,0,15));
	addrmatch 		:= ga(addrmatchscore);

	phonematchscore 	:= max(0,Risk_Indicators.PhoneScore(l.phone10, (string10)if(r.phone <> 0, intformat(r.phone, 10, 1), '')) - if (isrecent,0,10));
	phonematch 		:= gn(phonematchscore);
	
	feinmatchscore 	:= max(0,did_add.ssn_match_score(l.fein, (string9)if(r.fein <> 0, intformat(r.fein, 9, 1), '')) - if (isrecent,0,10));
	feinmatch 		:= gn(feinmatchscore);
	
	self.src 			:= r.source;
	self.feinscore 	:= if(tscore(feinmatchscore) > l.feinscore, tscore(feinmatchscore), l.feinscore);
	self.phonescore 	:= if(tscore(Phonematchscore) > l.phonescore, tscore(phonematchscore), l.phonescore);
	self.cnamescore 	:= if(tscore(cmpymatch_Score) > l.cnamescore, tscore(cmpymatch_Score), l.cnamescore);
	self.addr_compare_score := if(tscore(addr_compare_score) > l.addrscore, tscore(addr_compare_score), l.addrscore);
	self.addrscore 	:= if(tscore(addrmatchscore) > l.addrscore, tscore(addrmatchscore), l.addrscore);
	self.citystatescore 	:= if(tscore(addrmatchscore) > l.addrscore, cityst_score, l.citystatescore);
	self.zipscore 	:= if(tscore(addrmatchscore) > l.addrscore, zip_score, l.zipscore);
	
	self.dt_last_seen 	:= r.dt_last_seen;			 
	self.verfein 		:= IF (feinmatch and tscore(feinmatchscore) > l.feinscore, (string9)if(r.fein <> 0, intformat(r.fein, 9, 1), ''),l.verfein);
	self.FeinMatchFlag	:= IF (feinmatch, 'Y', 'N');
	self.veraddr 		:= IF (addrmatch and tscore(addrmatchscore) > l.addrscore,
						  Risk_Indicators.MOD_AddressClean.street_address('',r.prim_range, r.predir, r.prim_name,
							r.addr_suffix, r.postdir, r.unit_desig, r.sec_range),l.veraddr);	
	self.AddrMatchFlag	:= IF (addrmatch, 'Y', l.addrmatchflag);
	self.vercity		:= IF (MIN(ut.stringsimilar(R.city,L.p_city_name),ut.stringsimilar(L.p_city_name,R.city)) < 3 or MIN(ut.stringsimilar(R.city,L.v_city_name), ut.stringsimilar(L.v_city_name,R.city)) < 3, R.city, L.vercity);
	self.cityMatchFlag	:= if ((L.p_city_name != '' and MIN(ut.stringsimilar(R.city,L.p_city_name), ut.stringsimilar(L.p_city_name,R.city)) < 3) or (L.v_City_name != '' and MIN(ut.stringsimilar(R.city,L.v_city_name), ut.stringsimilar(L.v_city_name,R.city)) < 3), 'Y', l.citymatchflag);
	self.verstate 		:= IF (R.state = L.st, R.state, L.verstate);
	self.stateMatchFlag := IF (L.st != '' and R.state = L.st, 'Y', l.statematchflag);
	self.verzip		:= IF ((integer)R.zip  = (integer)L.z5, 
							(if(r.zip=0,'',intformat(R.zip, 5, 1) )), L.verzip);
	self.verzip4	:= IF ((integer)R.zip = (integer)L.z5 and (integer)R.zip4 = (integer)L.zip4, 
							(if(r.zip4=0,'',intformat(R.zip4, 4, 1) )), L.verzip4);
	self.zipMatchFlag	:= IF (L.z5 != '' and (integer)R.zip  = (integer)L.z5, 'Y', l.zipmatchflag);
	self.verphone		:= IF (phonematch and tscore(Phonematchscore) > l.phonescore, (string)R.phone, L.verphone);
	self.phoneMatchflag := if (phonematch, 'Y', l.phonematchflag);
	self.vercmpy 		:= IF (cmpymatch and tscore(cmpymatch_Score) > l.cnamescore, r.company_name, l.vercmpy);
	self.cnameMatchFlag := if (cmpymatch, 'Y', l.cnamematchflag);
	self.rcnt_a7		:= isrecent or l.rcnt_a7;
	self.bh_amatch		:= addrmatch;
	self.bh_pmatch		:= phonematch;
	self.bh_cmatch		:= cmpymatch;
	self.gong_amatch	:= l.gong_amatch;
	self.gong_cmatch	:= l.gong_cmatch;
	self.gong_pmatch	:= l.gong_pmatch;	
	
	// we were previously joining to key_bh_bdid_phone to get the following fields, but that join was redundant because we have 
	// all of the same information available to us already in the payload of the Key_BH_BDID_pl key
	use_for_nap := r.phone<>0;  // only use the record as a phone source in nap calculation if it has a phone populated
	self.csrc2		:= if (use_for_nap and cmpymatch, true, false);
	self.asrc2		:= if (use_for_nap and addrmatch, true, false);
	self.psrc2		:= if (use_for_nap and phonematch, true, false);
	self.phonefound	:= L.phonefound + if (use_for_nap and phonematch, 1, 0);
	self.addrfound		:= L.addrfound + if (use_for_nap and addrmatch, 1, 0);
	self.cmpyfound		:= L.cmpyfound + if (use_for_nap and cmpymatch, 1, 0);
	self.phonecmpycount := L.phonecmpycount + IF(use_for_nap and cmpymatch and phonematch, 1, 0);
	self.phoneaddrcount := L.phoneaddrcount + IF(use_for_nap and phonematch and addrmatch, 1, 0);
	self.cmpyaddrcount	:= L.cmpyaddrcount + IF(use_for_nap and cmpymatch and addrmatch, 1, 0);
	self.phonecmpyaddrcount := L.phonecmpyaddrcount + IF(use_for_nap and phonematch and addrmatch and cmpymatch, 1, 0) ;
	
	self 	:= l;
	
end;

//Experian sources ER and Q3 are in this key so they must be filtered out if Smallbusiness_Services are call it.
bestcounts := join(got_feinTable(bdid != 0),
										Business_Header_SS.Key_BH_BDID_pl,
										keyed(left.bdid = right.bdid) and
										ut.PermissionTools.glb.SrcOk(glb, right.source, right.dt_first_seen) and
										(RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)) AND
										(
											RestrictExperianData = FALSE OR
											right.Source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source)
										),
										get_BusHeader(left, right),
										left outer, keep(500), ATMOST(keyed(left.bdid = right.bdid),1500))
										+ 
										got_feintable(bdid = 0);

bestcounts_sort   := group(sort(bestcounts, seq, bdid, -dt_last_seen, src), seq, bdid);
bestcounts_rollup := rollup(bestcounts_sort, true, countadd(left,right));


// Get Miskey Flags set correctly
working_layout calc_miskeys_and_recentFlag(working_layout l) := transform

	addr_verified := if(L.addrMatchFlag  = 'Y', 1, 0);
	cname_verified := if(L.cnameMatchFlag  = 'Y', 1, 0);
	phone_verified := if(L.phoneMatchFlag  = 'Y', 1, 0);
	fein_verified := if(L.feinMatchFlag  = 'Y', 1, 0);
	
	addr_recent_verified := if(L.rcnt_a7 and addr_verified=1, 1, 0);
	cname_recent_verified := if(L.rcnt_a7 and cname_verified=1, 1, 0);
	phone_recent_verified := if(L.rcnt_a7 and phone_verified=1, 1, 0);
	fein_recent_verified := if(L.rcnt_a7 and fein_verified=1, 1, 0);
	
	verified_count := addr_verified + cname_verified + phone_verified + fein_verified;
	recent_verified_count := addr_recent_verified + cname_recent_verified + phone_recent_verified + fein_recent_verified;
	
	self.verNotRecentFlag := if(verified_count > 0 and recent_verified_count < 2, true, false);
	
	self.cmpyMiskeyFlag  := if(g(L.cnamescore) and l.cnamescore < 99, true, false);  // new company score behaves a little differently
	// don't count 99 as a miskey anymore for examples like 'CITIZENHAWK' vs 'CITIZENHAWK, INC'
	// company names just missing LLC or INC on input shouldn't flag a miskey

	
	// double-check verified vs input for exact just in case score was dropped because the record wasn't recent
	self.phonemiskeyflag := IF(gn(l.phonescore) AND l.phonescore<100 and l.phone10<>l.verphone, true, false);	
	self.addrmiskeyflag  := IF(ga(l.addrscore) AND l.addrscore<100 and l.addr_compare_score<100, true,false);
	self.feinmiskeyflag  := if(gn(l.feinscore) AND l.feinscore<100 and l.fein<>l.verfein, true,false);

	
	// flag the address as not most recent if input populated, address verified somewhere, 
	// but is not the best address (and also make sure the best address is populated)
	input_populated := L.prim_name != '' and L.z5 != '';
	self.inputBusAddrNotMostRecent := input_populated and L.addrMatchFlag='Y' and (l.bestaddr!='' and ~ga(l.bestaddrscore));
	
	self 			 := l;
end;

miskeys := project(bestcounts_rollup,calc_miskeys_and_recentFlag(left));

// Calculate BNAP, BNAT and set BDID info attributes and Counts
working_layout get_bdidTable(working_layout l, Business_Risk.key_bdid_table r) := transform
						  
	self.multisrccmpyp := if (L.csrc1 and L.csrc2, true, false);
	self.multisrcaddrp := if (L.asrc1 and L.asrc2, true, false);

	self.BNAP_Indicator := map(L.phonecmpyaddrcount > 0 or (L.phonecmpycount > 0 and L.phoneaddrcount > 0 and L.cmpyaddrcount > 0) => '8',
						  L.cmpyaddrcount > 0 and L.phonefound = 0 => '7',
						  L.cmpyaddrcount > 0 and L.phonefound > 0 and L.phonecmpycount = 0 => '6',
						  L.phonecmpycount > 0 and L.addrfound = 0 => '5',
						  L.phonecmpycount > 0 and (L.cmpyaddrcount = 0 or L.phoneaddrcount = 0) and L.addrfound > 0 => '4',
						  L.phoneaddrcount > 0 and L.phonecmpycount = 0 => '3',
						  L.phonefound = 0 and (L.addrfound > 0 or L.cmpyfound > 0) and L.cmpyaddrcount = 0 => '2',
						  L.phonefound > 0 and L.phoneaddrcount = 0 and L.phonecmpycount = 0 => '1',
						  L.phonefound = 0 and L.addrfound = 0 and L.cmpyfound =0 => '0',
						  '0');
							
	self.BNAT_Indicator	 := map(~g(l.cnamescore) and ~ga(l.addrscore) and gn(l.feinscore) => '1',
						~g(l.cnamescore) and  ga(l.addrscore) and ~gn(l.feinscore) => '2',
						 g(l.cnamescore) and ~ga(l.addrscore) and ~gn(l.feinscore) => '2',
						~g(l.cnamescore) and  ga(l.addrscore) and gn(l.feinscore) => '3',
						 g(l.cnamescore) and ~ga(l.addrscore) and gn(l.feinscore) and L.addrvalidflag != '' => '4',
						 g(l.cnamescore) and ~ga(l.addrscore) and gn(l.feinscore) and L.addrvalidflag = ''  => '5',
						 g(l.cnamescore) and  ga(l.addrscore) and ~gn(l.feinscore) and l.feinvalidflag = '0' => '6',
						 g(l.cnamescore) and  ga(l.addrscore) and ~gn(l.feinscore) and l.feinvalidflag != '0' => '7',
						 g(l.cnamescore) and  ga(l.addrscore) and gn(l.feinscore) => '8',
						 l.bdid=0 and l.feinvalidflag='0' => '1',  // miss on verifies but hit on fein
						'0');
	self.bkBdidFlag 		:= if(r.cnt_B > 0,true,false);
	self.bankruptcy_Count	:= r.cnt_b;
	self.dt_first_seen_min 	:= r.dt_first_seen_min;   // min for all base records
	self.dt_last_seen_max 	:= r.dt_last_seen_max;    // max for all base records
	self.feincount 		:= if(gn(l.feinscore), 1, 0);
	self.numucc			:= r.cnt_u;
	self.addrcount   := if (L.bh_amatch, 1, 0) + if(L.gong_amatch, 1, 0);
	self.cmpycount   := if (L.bh_cmatch, 1, 0) + if(L.gong_cmatch, 1, 0);
	self.wphonecount := if (L.bh_pmatch, 1, 0) + if(L.gong_pmatch, 1, 0);
	
	self.dist_HomeAddr_BusAddr		:= if (L.dist_HomeAddr_BusAddr = 9999 and L.rep_z5 != '' and L.z5 != '', ut.zip_Dist(L.rep_z5, L.z5), L.dist_homeAddr_BusAddr); 
	self.dist_HomePhone_BusAddr		:= if (L.dist_HomePhone_BusAddr = 9999 and L.homephonezip != '' and L.z5 != '', ut.zip_Dist(L.HomePhoneZip, L.z5), L.dist_homePhone_BusAddr);
	self.dist_HomeAddr_BusPhone		:= if (L.dist_HomeAddr_BusPhone = 9999 and L.rep_z5 != '' and L.busphonezip != '', ut.zip_Dist(L.rep_z5, L.BusPhoneZip), L.dist_homeAddr_BusPhone);
	self.dist_HomePhone_BusPhone		:= if (L.dist_HomePhone_BusPhone = 9999 and L.busPhoneZip != '' and L.homephonezip != '', ut.zip_Dist(L.HomePhoneZip, L.BusPhoneZip), L.dist_homePhone_BusPhone);
	self.dist_HomePhone_HomeAddr		:= if (L.dist_HomePhone_HomeAddr = 9999 and L.homephonezip != '' and L.rep_z5 != '', ut.zip_Dist(L.homePhoneZip, L.rep_z5), L.dist_homePhone_HomeAddr);
	self.dist_BusPhone_BusAddr		:= if (L.dist_BusPhone_BusAddr = 9999 and L.busphonezip != '' and L.z5 != '', ut.zip_Dist(L.busPhoneZip, L.z5), L.dist_BusPhone_BusAddr);


	self 				:= l;
END;

got_bdidTable := join(miskeys,
				  Business_Risk.key_bdid_table,
					left.bdid != 0 and 
					keyed(left.bdid=right.bdid) and
					(RIGHT.dt_first_seen_min < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)),
				  get_bdidTable(left,right),
				  left outer, atmost(riskwise.max_atmost), keep(1));

// ************* END PURE BNAT ********** /


//------------------check for 'good standing' ---------
corprec := record
	unsigned4	seq;
	string30	corp_key;
end;

corprec get_corpkeys(got_bdidTable L, corp2.key_Corp_bdid R) := transform
	self.seq := l.seq;
	self.corp_key := R.corp_key;
end;

corpkeys := join(got_bdidTable,
			  corp2.key_Corp_bdid,
					left.bdid != 0 and 
					keyed(left.bdid = right.bdid),
			  get_corpkeys(LEFT,RIGHT), atmost(250));

corprec2 := record
	corp2.key_corp_corpkey;
	unsigned4	seq;
end;

corprec2 get_corp_recs(corpkeys L, corp2.key_corp_corpkey R) := transform
	self := R;
	self := L;
end;

corprecs := join(corpkeys,
			  corp2.key_corp_corpkey,
				left.corp_key!='' and 
				keyed(Left.corp_key = right.corp_key),
			  get_corp_recs(LEFT,RIGHT), ATMOST(keyed(Left.corp_key = right.corp_key),RiskWise.max_atmost), keep(100));
			  
corp_sort := dedup(sort(corprecs,seq, bdid, if (business_header.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc),0,1), if (corp_status_desc != '', 0, 1)),seq, bdid);

working_layout check_standing(got_bdidTable L, corp_sort R) := transform
	// default to good standing status on left outer part of join....
	self.goodstanding := if (r.seq = 0, 'U', if (business_header.is_ActiveCorp(r.record_type, R.corp_status_cd, R.corp_status_desc), 'A',
							if (stringlib.stringfind(R.corp_status_desc, 'INACTIVE', 1) != 0, 'I',
							if (stringlib.stringfind(R.corp_status_desc, 'DISSOLVED', 1) != 0, 'D','U'))));
		self.SOS_filing_name := r.corp_legal_name;
	self := l;
end;
	
wstanding := join(got_bdidTable,
				 corp_sort,
					left.seq = right.seq and left.bdid=right.bdid,
				 check_standing(LEFT,RIGHT), 
				 left outer, many lookup);


working_layout check_rels(wstanding L, business_header.Key_Business_Relatives R) := transform
	self.relfound := R.bdid2 != 0 and ((R.name and (R.corp_charter_number or
										   R.business_registration or
										   R.dca_company_number or
										   R.fein)) or
								R.name_address or
								R.name_phone);
	self := L;
end;
				
wrelatives := join(wstanding(bdid != 0), business_header.key_business_relatives,
					//left.bdid != 0 and 
					keyed(left.bdid = right.bdid1) and 
						right.bdid2 <> 0 and
						((right.name and (right.corp_charter_number or
										   right.business_registration or
										   right.dca_company_number or
										   right.fein)) or right.name_address or right.name_phone),
				check_rels(LEFT,RIGHT), left outer, keep(1), 
				ATMOST(RiskWise.max_atmost))
				+
				wstanding(bdid = 0);

				
// ---------------- Calc BVI and PRIs --------------

// PRIs are calc'd here after distance calculations.
working_layout Calc_BVI(wrelatives L) := transform
	temp_bvi := case(L.bnap_indicator,
					'0' => case (L.bnat_indicator, '0' => '0',
											 '1' => '10',
											 '2' => '0',
											 '3' => '0',
											 '4' => '20',
											 '5' => '30',
											 '6' => '30',
											 '7' => if (L.multisrcaddr and L.multisrccmpy, '50', '40'),
											 '8' => '50',
											 '0'),
					'1' => case (L.bnat_indicator, '0' => '0',
											 '1' => '10',
											 '2' => '0',
											 '3' => '0',
											 '4' => '20',
											 '5' => '30',
											 '6' => '30',
											 '7' => if (L.multisrcaddr and L.multisrccmpy, '50', '40'),
											 '8' => '50',
											 '0'),
					'2' => case (L.bnat_indicator, '0' => '0',
											 '1' => '10',
											 '2' => '0',
											 '3' => '0',
											 '4' => '20',
											 '5' => '30',
											 '6' => '30',
											 '7' => if (L.multisrcaddr and L.multisrccmpy, '50', '40'),
											 '8' => '50',
											 '0'),
					'3' => case (L.bnat_indicator, '0' => '10',
											 '1' => '10',
											 '2' => '0',
											 '3' => '0',
											 '4' => '20',
											 '5' => '30',
											 '6' => '30',
											 '7' => if (L.multisrcaddr and L.multisrccmpy, '50', '40'),
											 '8' => '50',
											 '0'),
					'4' => case (L.bnat_indicator, '0' => '20',
											 '1' => '20',
											 '2' => '20',
											 '3' => '20',
											 '4' => '20',
											 '5' => '40',
											 '6' => '40',
											 '7' => if (L.multisrcaddr and L.multisrccmpy, '50', '40'),
											 '8' => '50',
											 '0'),
					'5' => case (L.bnat_indicator, '0' => '30',
											 '1' => '20',
											 '2' => '30',
											 '3' => '30',
											 '4' => '30',
											 '5' => '30',
											 '6' => '40',
											 '7' => if (L.multisrcaddr and L.multisrccmpy, '50', '40'),
											 '8' => '50',
											 '0'),
					'6' => (string2)(ut.min2(case(L.bnat_indicator, '0' => 40,
											 '1' => 30,
											 '2' => 40,
											 '3' => 40,
											 '4' => 40,
											 '5' => 40,
											 '6' => 40,
											 '7' => 50,
											 '8' => 50,
											 0) + if(L.multisrccmpyp and L.multisrcaddrp, 10, 0),50)),
					'7' => (string2)(ut.Min2(case(L.bnat_indicator, '0' => 40,
											 '1' => 30,
											 '2' => 40,
											 '3' => 40,
											 '4' => 40,
											 '5' => 40,
											 '6' => 40,
											 '7' => 50,
											 '8' => 50,
											 0) + if(L.multisrccmpyp and L.multisrcaddrp, 10, 0),50)),
					'8' => (string2)(ut.min2(case(L.bnat_indicator, '0' => 40,
											 '1' => 30,
											 '2' => 40,
											 '3' => 40,
											 '4' => 40,
											 '5' => 50,
											 '6' => 40,
											 '7' => 50,
											 '8' => 50,
											 0) + if(L.multisrccmpyp and L.multisrcaddrp, 10, 0),50)),
					'0');					
	self.bvi := if (L.watchlist_record_number != '', '10', 
				 if (L.bnas_indicator = '0' or temp_bvi in ['30','40','50'] or L.DeceasedTIN = 'Y' or
					L.watchlist_record_number != '' or L.bdid = 0, temp_bvi,
					case (temp_bvi, '0' => case (L.bnas_indicator,  '1'=> '20',
													    '2'=> '20',
													    '3'=> '30',
													    temp_bvi),
								'10' => case (L.bnas_indicator, '1' => '20',
													    '2' => '20',
													    '3' => '30',
														temp_bvi),
								'20' => case (L.bnas_indicator, '1' => '30',
													    '2' => '30',
													    '3' => '40',
														temp_bvi),
								temp_bvi)));
	self.bphonetype := map(L.phone10 = '' or L.hriskphoneflag = '7' => 'B',
					   L.hriskphoneflag = 'U' => 'U',
					   L.hriskphoneflag = '2' => '8',
					   L.hriskphoneflag in ['1','3'] => '7',
					   L.resphoneflag = 'Y' => '0',
					   '2');
	self.company_status := L.goodstanding;
	
	self.bestFEIN := if(l.bestfeinscore between min_numscore and 100, l.bestfein, '');
	bestssn_score := did_add.ssn_match_score(l.rep_ssn, l.repbestssn, LENGTH(TRIM(l.rep_ssn))=4);
	Self.repbestSSN := if(bestssn_score between min_numscore and 100, l.repbestssn, '');
	self.repbestdob  := if(l.rep_dobscore between min_numscore and 100, l.repbestdob, '');

	// calculate the 10, 20, 30, 40 of ar2bi here, once, instead of doing it 3 times below
	nameCompare := l.repbestfname != '' and 
				(stringlib.stringfind(L.company_name,L.repbestfname, 1) != 0 or stringlib.stringfind(L.alt_company_name, L.repbestfname, 1) != 0 or 
				 stringlib.stringfind(L.company_name,L.repbestLname, 1) != 0 or stringlib.stringfind(L.alt_company_name, L.repbestlname, 1) != 0);   
	
	addcompare := ga(Risk_Indicators.AddrScore.AddressScore(L.repbestprimrange, L.repbestprimname, L.repbestsecrange,
										    L.prim_Range, L.prim_name, L.sec_range));	
	self.AR2BI := map(L.rep_lname = '' => '0',
				   l.repBestSSN != '' and if(L.bestfein != '', L.repBestSSN = L.Bestfein, L.repBestSSN = L.fein) => '40',
				   addcompare and namecompare => '30',
				   addcompare => '20',
				   namecompare => '10',
				   '0');
					 
	self := l;
end;

withBVI := project(wrelatives, Calc_BVI(LEFT));


//----------------- AR2BI ---------------------------
working_layout check_corp_contacts_and_calc_AR2BI(withBVI L, business_risk.Key_Bus_Cont_DID_2_BDID R) := transform
	self.AR2BI := if(R.bdid = L.bdid and l.bdid != 0, '50', l.ar2bi);
	self := L;
end;

AR2a := join(withBVI(repdid != 0), 
		  business_risk.Key_Bus_Cont_DID_2_BDID,
			left.bdid != 0 and
			keyed(left.repdid = right.did),
		  check_corp_contacts_and_calc_AR2BI(LEFT,RIGHT),
		  left outer, atmost(2500));


working_layout check_by_bdid_for_nameonly(withBVI L, business_header.Key_Business_Contacts_BDID R) := transform
	self.AR2BI := if(ut.NameMatch(L.rep_fname, '', L.rep_lname, R.fname, '', R.lname) < 3 and l.rep_lname!='', '50', l.ar2bi);
	self := L;
end;

//Experian Sources ER and Q3 cannot be returned in the following services:
// 1. Small Business Attributes
// 2. Small Business Attributes with SBFE Data
// 3. Small Business Credit Score with SBFE Data
// 4. Small Business Blended Credit Score with SBFE Data
// 5. Small Business Credit Report
// 6. Small Business Risk Score

//Experian sources ER and Q3 are in this key so they must be filtered out if Smallbusiness_Services are call it.
AR2b := join(withBVI(repdid = 0), business_header.Key_Business_Contacts_BDID,
				left.bdid != 0 and left.rep_lname != '' and 
				keyed(left.bdid = right.bdid) and
				(~right.glb OR ut.PermissionTools.glb.ok( glb) ) AND
				(
					RestrictExperianData = FALSE OR
					right.Source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source)
				),
			check_by_bdid_for_nameonly(LEFT,RIGHT),
			left outer, keep(200), ATMOST(keyed(left.bdid = right.bdid),RiskWise.max_atmost));

pawtemp := record
	unsigned contact_id;
	working_layout;
end;

// could add a search to PAW.key_bdid as well to see if that gains us anything
with_contact_ids := join(withBVI, PAW.key_did, 
							left.bdid!=0 and left.repdid!=0 and 
							keyed(left.repdid=right.did),
							transform(pawtemp, self.contact_id := right.contact_id, self := left),
							atmost(riskwise.max_atmost), keep(200));

working_layout check_people_at_work(with_contact_ids L, PAW.key_contactID R) := transform
	cmpymatch := CnameScore(l.company_name, r.company_name) between 80 and 100;
	repmatch := ut.NameMatch(L.rep_fname, '', L.rep_lname, R.fname, '', R.lname) < 3;
	self.AR2BI := if(cmpymatch and repmatch and l.rep_lname!='',	'50', l.ar2bi);
	self := L;
end;
							
AR2c := join(with_contact_ids,PAW.key_contactID,
							left.bdid!=0 and left.repdid!=0 and left.contact_id!=0 and
							keyed(left.contact_id=right.contact_id),
							check_people_at_work(left, right),
							left outer, ATMOST(RiskWise.max_atmost), keep(200));
							
AR2 := group(sort( ungroup(AR2a + AR2b + AR2c), seq, bdid), seq, bdid);

AR2 roll_AR2(AR2 L, AR2 R) := transform
	self.AR2BI := if ((integer)L.AR2BI > (integer)R.AR2BI, L.AR2BI, R.AR2BI);
	self := l;
end;

withAR2BI := rollup(AR2,true, roll_AR2(LEFT,RIGHT));


// pick the bdid with the best verification, AR2BI and goodstanding
//			 - for example, could we merge verification (but then which BDID do you return in the BDID field, and that would be difficult to troubleshoot questions)
//  		 - also, if we merge BDID information, do we sum up the liens, bankruptcy and UCCs ?
selected_bdid := group( 
											dedup(sort(ungroup(withAR2BI), seq, -(integer)bvi, 
																													-(integer)bnat_indicator, 
																													-(integer)bnap_indicator, 
																													-(integer)ar2bi, 
																													goodstanding, 
																													-cnamescore, 
																													-dt_last_seen_max,
																													-bdid),
														seq),
											seq);


// now that we have our selected bdid, add the county name of the verified address if populated
// and append the sic_code, naics_code and business description
selected_bdid_with_county_name := join(selected_bdid, Census_Data.Key_Fips2County,
							 LEFT.st<>'' AND LEFT.county<>'' AND trim(left.veraddr)<>'' and
               KEYED(LEFT.st = right.state_code) and
		           KEYED(LEFT.county = RIGHT.county_fips),
							 transform(working_layout, self.vercounty := right.county_name, self := left),
							 LEFT OUTER,KEEP(1));


// we could allow more than 1 record per vendor and add some logic to pick the one we want
// for now, just use a keep(1) to avoid the need for rolling up sic codes
with_ebr := join(selected_bdid_with_county_name,
		  EBR.Key_0010_Header_BDID,
			left.bdid != 0 and
			keyed(left.bdid = right.bdid) and
			right.sic_code <> '',
		  transform(working_layout, self.sic_code := right.sic_code,
																self.business_description := right.business_desc,
																self := left), atmost(riskwise.max_atmost), 
																LEFT OUTER,keep(1));
			
with_dca := join(with_ebr,
		  DCA.Key_DCA_BDID,
			left.bdid != 0 and 
			left.sic_code='' and  // only join if we don't already have the sic populated
			keyed(left.bdid = right.bdid) and
			right.sic1 <> '',
		  transform(working_layout, 
									add_dca := left.sic_code='';  // don't use dca if we already have sic from EBR
									self.sic_code := if(add_dca, right.sic1, left.sic_code);
									self.business_description := if(add_dca, right.text1, left.business_description),
									self := left), atmost(riskwise.max_atmost), 
									LEFT OUTER,keep(1));

with_naics_sics_temp := join(with_dca,
		  YellowPages.Key_YellowPages_BDID,
			left.bdid != 0 and 
			keyed(left.bdid = right.bdid) and
			right.sic_code <> '',
		  transform(working_layout, 
								self.naics_code := right.naics_code,
								// don't use YP heading or SIC if we have a real SIC description already from EBR or DCA
								self.sic_code := if(left.sic_code='',right.sic_code,left.sic_code),	
								self.business_description := if(left.business_description='',right.heading_string, left.business_description),  
								self := left), atmost(riskwise.max_atmost), LEFT OUTER,
								keep(1));

with_naics_sics := if(isCNSMR,with_dca,with_naics_sics_temp);


//----------------- Bankruptcy and Lien/Judgement data
bkrupt_slim := record
	string bk_tmsid;
	string	court_code;
	string	case_number;
	unsigned bdid;
	unsigned6	seq;
end;

// did, bdid, and ssn keys are all still v2, just search file and main are using v3 for now
// bans_bdid := BankruptcyV3.key_bankruptcyV3_bdid();
bans_bdid := BankruptcyV3.key_bankruptcyV3_bdid();

bkrupt_slim get_bankruptcies(working_layout L, recordof(bans_bdid) R) := transform
	self.seq := L.seq;
	self.bdid := L.bdid;
	self.bk_tmsid := R.tmsid;
	self.court_code := R.court_code;
	self.case_number := R.case_number;
end;

bk_keys := join(with_naics_sics, bans_bdid,
			left.bdid != 0 and
			keyed(left.bdid = right.p_bdid),
		  get_bankruptcies(LEFT,RIGHT), keep(100));

bk_search := BankruptcyV3.key_bankruptcyv3_search_full_bip();
	  
bkrec := record
	recordof(bk_search);
	unsigned6	seq;
end;

bkrec get_bkrupt_info(bk_keys L, recordof(bk_search) R) := transform
	self.seq := L.seq;
	self := R;
end;

bkrecs := join(bk_keys, 
			bk_search,
				keyed(left.bk_tmsid = right.tmsid) and
				right.name_type='D' and
				(unsigned)right.bdid=left.bdid,
			get_bkrupt_info(LEFT,RIGHT), keep(100));

bkrecs_srt_ddp := dedup(sort(bkrecs, seq, -date_filed, if (cname = '', 1, 0),if (prim_name ='', 1, 0),  -tmsid), seq);

working_layout fill_in_bkrupt(working_layout L, bkrecs_srt_ddp R) := transform

	self.bkbdidflag 		:=  if (R.seq = 0, false, true); 
	self.RecentBkName		:=  R.cname;
	self.RecentBkAddr		:= Risk_Indicators.MOD_AddressClean.street_address('',R.prim_range, R.predir, R.prim_name, R.addr_suffix, R.postdir, R.unit_desig, R.sec_range);
	self.RecentBkCity		:= R.p_city_name;
	self.RecentBkState		:=  R.st;
	self.RecentBkZip		:=  R.zip;
	self.RecentBkZip4		:= R.zip4;
	self.RecentBktype		:=  R.chapter;
	self.RecentBkDate		:= R.date_filed;
	self := L;
end;

wBKs := join(with_naics_sics, 
		   bkrecs_srt_ddp,
			left.seq = right.seq and
			(integer)Left.historydate > (integer)((string)Right.date_filed[1..6]),  //remove bk records after history date
		   fill_in_bkrupt(LEFT,RIGHT),
		   left outer, many lookup);
		   

//--------------------- Get Liens Info ----------------

lienrec := record
	unsigned6	seq := 0;
	unsigned3 historydate := 999999;
	unsigned6 	bdid := 0;
	string50 tmsid := '';
	string50 rmsid := '';
	unsigned2	cnt_rel := 0;
	unsigned2	cnt_unrel := 0;
	unsigned4 lien_total := 0;
	string120 def_company := '';
	string50 address := '';
	string25 orig_city := '';
	string2 orig_state := '';
	string5 orig_zip := '';
	string4 zip4 := '';
	string8 filing_date := '';
	string8 release_date := '';
	string50 filingtype_desc := '';	
end;

lienrec get_lien_rmsid(wBKs L, liensv2.key_liens_bdid R) := transform
	self.seq := L.seq;
	self.historydate := l.historydate;
	self.bdid := L.bdid;
	self.rmsid := R.rmsid;
	self.tmsid := R.tmsid;
	self := [];
end;

rmsids := join(wBKs,
			liensv2.key_liens_bdid,
				left.bdid != 0 and
				keyed(left.bdid = right.p_bdid),
			get_lien_rmsid(LEFT,RIGHT), keep(100));



// with liensV2, all fields we're interested in come from the liens_party_id file except the lien amount and filing description which come from the liens_main file
lienrec get_liens(rmsids L, liensv2.key_liens_party_ID R) := transform
	self.seq := L.seq;
	self.historydate := l.historydate;
	self.bdid := L.bdid;
	self.tmsid := l.tmsid;
	self.rmsid := r.rmsid;
	self.cnt_rel := if ((integer)R.date_last_seen != 0, 1, 0);
	self.cnt_unrel := if (self.cnt_rel = 0, 1, 0);
	self.def_company := r.cname;
	self.address := r.orig_address1;
	self.orig_city := r.orig_city;
	self.orig_state := r.orig_state;
	self.orig_zip := r.orig_zip5;
	self.zip4 := r.orig_zip4;
	self.filing_date := r.date_first_seen;
	self.release_date := r.date_last_seen;
	self.lien_total := 0;  // comes from main
	self.filingtype_desc := '';  // comes from main
	self := [];
end;

liensrecs1 := join(rmsids,
			   liensv2.key_liens_party_ID,
				keyed(left.rmsid = right.rmsid) and
				keyed(left.tmsid = right.tmsid) and
				left.bdid = (unsigned)right.bdid and  // for cases with multiple debtors, make sure to only include the party records that match on bdid
				right.name_type='D' and
				(unsigned)right.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
			   get_liens(LEFT,RIGHT), 
			   atmost( (keyed(left.rmsid=right.rmsid) and keyed(left.tmsid=right.tmsid)), riskwise.max_atmost), keep(100));

lienrec get_liens_main(liensrecs1 L, liensv2.key_liens_main_ID R) := transform
	self.lien_total := (integer)R.amount;
	self.filingtype_desc := r.filing_type_desc;
	//self.filing_date := if((integer)L.filing_date=0 and (integer)R.filing_date!=0, r.filing_date, l.filing_date);
	self := L;
end;
			   
liensrecs := join(liensrecs1,
			   liensv2.key_liens_main_ID,
				keyed(left.rmsid = right.rmsid) and
				keyed(left.tmsid = right.tmsid) and
				(integer)right.amount > 0 and
				(unsigned)right.orig_filing_date < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
			   get_liens_main(LEFT,RIGHT), 
			   atmost( (keyed(left.rmsid=right.rmsid) and keyed(left.tmsid=right.tmsid)), riskwise.max_atmost), keep(100));
			   

lienrec roll_and_count(liensrecs L, liensrecs R) := transform
	self.seq := L.seq;
	self.cnt_rel := L.cnt_rel + if ((integer)R.release_date != 0, 1, 0);
	self.cnt_unrel := L.cnt_unrel + if ((integer)R.release_date != 0, 0, 1);
	self.def_company := if (L.def_company = '', R.def_company, L.def_company);
	self.lien_total := L.lien_total + R.lien_total;
	self.filingtype_desc := if (L.filingtype_desc = '', R.filingtype_desc, L.filingtype_desc);
	self := if (L.filing_date = '' or (integer)L.filing_date < (integer)R.filing_date, R, L);
end;

lrecs_srt_ddp := rollup(sort(liensrecs,seq,-(if (filing_date = '', '0000000', filing_date)), if (def_company ='', 1, 0)),true,
					roll_and_count(LEFT,RIGHT));
					

working_layout add_liens(wBKs L, lrecs_srt_ddp R) := transform
	self.lienbdidflag		:= if (R.seq = 0, false, true);
	self.UnreleasedLienCount := R.cnt_unrel;
	self.ReleasedLienCount	:= R.cnt_rel;
	self.RecentLienName		:= R.def_company;
	self.RecentLienAddr		:= R.address;
	self.RecentLienCity		:= R.orig_city;
	self.RecentLienState	:= R.orig_state;
	self.RecentLienZip		:= R.orig_zip;
	self.RecentLienZip4		:= R.zip4;
	self.RecentLienDate		:= R.filing_date;
	self.RecentLienType		:= R.filingtype_desc;
	self.lien_total		:= R.lien_total;
	self := L;
END;

wLiens := join(wBKs,
			lrecs_srt_ddp,
				left.seq = right.seq and 
				left.bdid=right.bdid,  // added the bdid match now with multiple BDIDs returned from bdid append
			add_liens(LEFT,RIGHT),
			left outer, many lookup);


frec := record
	unsigned6	seq;
	string120	company_name;
	string120	addr1;
	string30	city;
	string2	state;
	string5	zip;
	string4	zip4;
end;

frec get_feinmatches(wLiens L, business_risk.Key_BH_Fein R) := transform
	self.seq := L.seq;
	self.zip := intformat(R.zip,5,1);
	self.zip4 := intformat(R.zip4, 4, 1);
	self := R;
end;

feinmatches := join(wLiens,
				business_risk.Key_BH_Fein,
					keyed((integer)left.fein = right.fein) and
					CnameScore(left.company_name, right.company_name) < 90,
				get_feinmatches(LEFT,RIGHT), keep(100));


working_layout denorm_feinmatches(working_layout L, feinmatches R, integer C) := transform
	self.FEINMatchCompany1	:= if (C = 1, R.company_name, L.feinmatchcompany1);
	self.FEINMatchAddr1		:= if (c = 1, R.addr1, L.feinmatchaddr1);
	self.FEINMatchCity1		:= if (c = 1, R.city, L.feinmatchcity1);
	self.FEINMatchState1	:= if (c = 1, R.state, L.feinmatchstate1);
	self.FEINMatchZip1		:= if (c = 1, R.zip, L.feinmatchzip1);
	self.FEINMatchZip4_1	:= if (c = 1, R.zip4, L.feinmatchzip4_1);
	self.FEINMatchCompany2	:= if (C = 2, R.company_name, L.feinmatchcompany2);
	self.FEINMatchAddr2		:= if (c = 2, R.addr1, L.feinmatchaddr2);
	self.FEINMatchCity2		:= if (c = 2, R.city, L.feinmatchcity2);
	self.FEINMatchState2	:= if (c = 2, R.state, L.feinmatchstate2);
	self.FEINMatchZip2		:= if (c = 2, R.zip, L.feinmatchzip2);
	self.FEINMatchZip4_2	:= if (c = 2, R.zip4, L.feinmatchzip4_2);
	self.FEINMatchCompany3	:= if (C = 3, R.company_name, L.feinmatchcompany3);
	self.FEINMatchAddr3		:= if (c = 3, R.addr1, L.feinmatchaddr3);
	self.FEINMatchCity3		:= if (c = 3, R.city, L.feinmatchcity3);
	self.FEINMatchState3	:= if (c = 3, R.state, L.feinmatchstate3);
	self.FEINMatchZip3		:= if (c = 3, R.zip, L.feinmatchzip3);
	self.FEINMatchZip4_3	:= if (c = 3, R.zip4, L.feinmatchzip4_3);
	self := L;
end;

wFeinMatches := NOFOLD(denormalize(wLiens, 
					   feinmatches,
							left.seq = right.seq and
							MIN(ut.stringsimilar(left.company_name,right.company_name), ut.stringsimilar(right.company_name,left.company_name)) > 2,
					   denorm_feinmatches(LEFT,RIGHT,COUNTER)));
						   
layout_output add_reasons(wFeinMatches L) := transform
	makeRC( string2 rc ) := dataset([{rc,Risk_Indicators.getHRIDesc(rc)}],risk_indicators.Layout_Desc);

	PRIs 	:= choosen(
				if( Risk_Indicators.rcSet.isCode32(L.watchlist_table, L.watchlist_record_number),      makeRC('32')) &
				if( Risk_Indicators.rcSet.isCodePO(L.addr_type) AND tribcode='',                       makeRC('PO')) &
				if( Risk_Indicators.rcSet.isCodeA4(l.bdid, l.goodstanding),                            makeRC('A4')) &
				if( Risk_Indicators.rcSet.isCodeA6(l.bdid, l.goodstanding),                            makeRC('A6')) &
				if( Risk_Indicators.rcSet.isCodeA0(L.feinmatchcompany1, L.feinmatchaddr1, L.bestaddr), makeRC('A0')) &
				if( Risk_Indicators.rcSet.isCodeWL(L.watchlist_table, L.watchlist_record_number),      makeRC('WL')) &
				if( Risk_Indicators.rcSet.isCode54( L.fein, L.bestFEIN ),                              makeRC('54') ) &
				if (L.addrmatchflag = 'N' and L.feinmatchflag = 'N' and L.phonematchflag = 'N' and L.cnamematchflag = 'N', makeRC('19')) &
				if (L.company_name != '' and L.cnamematchflag = 'N',                                   makeRC('37')) &
				if ((L.prim_name != '' or L.z5 != '' or L.st != '') and L.addrmatchflag = 'N',         makeRC('25')) &
				if (length(trim(L.phone10)) = 10 and L.phonematchflag = 'N',                           makeRC('27')) &
				if (length(trim(L.fein)) = 9 and L.feinmatchflag = 'N',                                makeRC('26')) &
				if (Risk_Indicators.rcSet.isCodePA(L.inputBusAddrNotMostRecent) AND tribcode='',       makeRC('PA')) &
				
				// only return ZI if 25 isn't already returned
				IF(l.orig_z5<>'' and l.zipscore < 100 and ~((L.prim_name != '' or L.z5 != '' or L.st != '') and L.addrmatchflag = 'N') AND tribcode='', makeRC('ZI')) &
				if (L.company_name = '',                                                               makeRC('77')) &
				if( Risk_Indicators.rcSet.isCode80(L.phone10),                                         makeRC('80')) &
				if (L.prim_name = '' and L.z5 = '' and L.st = '',                                      makeRC('78')) &
				if (length(trim(L.fein)) < 9,                                                          makeRC('79')) &

				IF(Risk_Indicators.rcSet.isCodeCZ(l.statezipflag, l.cityzipflag) AND tribcode='', makeRC('CZ')) & 
				
				if (L.phone10 != '' and L.phonematchcompany != '' and CnameScore(L.phonematchcompany,L.company_name) < 80 and MIN(ut.stringsimilar(L.veraddr, L.phonematchaddr), ut.stringsimilar(L.phonematchaddr, L.veraddr)) > 2, makeRC('74')) &
				if (L.phonedisflag,                                                                    makeRC('07')) &
				if (L.phonevalidflag = '0',                                                            makeRC('08')) &
				if (L.addrvalidflag not in ['','V'],                                                   makeRC('11')) &
				if (L.zipclass='P',                                                                    makeRC('12')) &
				// 13 The input address has an invalid apartment/ suite designation
				if ( Risk_Indicators.rcSet.isCode14(L.hriskaddrflag),                                  makeRC('14')) &

				// if (L.hriskphoneflag not in ['0','U'] and length(trim(l.phone10)) = 10, makeRC('15')) &
				if (Risk_Indicators.rcSet.isCode15(L.hriskphoneflag),                                  makeRC('15')) &
				// 75 The input name and address are associated with an unlisted/ non-published phone number
				if (Risk_Indicators.rcSet.isCode09(l.nxx_type),                                        makeRC('09')) &
				if (Risk_Indicators.rcSet.isCode10(l.nxx_type),                                        makeRC('10')) &
				if (L.phonezipmismatch,                                                                makeRC('16')) &
				
				// TODO:  PUT THIS BACK IN 60 DAYS FROM NOW WHEN CUSTOMERS ARE READY FOR IT
				// legacy products using tribcode still get reason code 40, otherwise use the new MO and CO
				// IF(Risk_Indicators.rcSet.isCode40(l.zipclass) AND tribcode<>'',DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc)) &
				// IF(Risk_Indicators.rcSet.isCodeMO(l.zipclass) AND tribcode='',DATASET([{'MO',risk_indicators.getHRIDesc('MO')}],risk_indicators.Layout_Desc)) &
				// IF(Risk_Indicators.rcSet.isCodeCO(l.zipclass) AND tribcode='',DATASET([{'CO',risk_indicators.getHRIDesc('CO')}],risk_indicators.Layout_Desc)) &

				// TODO:  TAKE THIS LINE OUT 60 DAYS FROM NOW WHEN CUSTOMERS ARE READY FOR MO AND CO INSTEAD
				IF(Risk_Indicators.rcSet.isCode40(l.zipclass),                                         makeRC('40')) &
				if (L.phone10 != '' and L.wrongphoneflag = '1',                                        makeRC('82')) &
				if (L.phone10 != '' and L.wrongphoneflag = '0',                                        makeRC('64')) &
				if (L.bkbdidflag,                                                                      makeRC('43')) &
				if (Risk_Indicators.rcSet.isCodeA5(L.lienbdidflag),                                    makeRC('A5')) &
				if (L.matchPrison,                                                                     makeRC('50')) &
				if( Risk_Indicators.rcSet.isCode49(L.dist_busphone_busAddr),                           makeRC('49')) &
				if( Risk_Indicators.rcSet.isCode53(L.dist_homephone_busphone),                         makeRC('53')) &
				if (Risk_Indicators.rcSet.isCodeA7(L.vernotrecentFlag),                                makeRC('A7')) &
				if (Risk_Indicators.rcSet.isCode70(L.resAddrFlag),                                     makeRC('70')) &
				if (L.resPhoneFlag = 'Y',                                                              makeRC('69')) &
				if (Risk_Indicators.rcSet.isCode44(L.areacodesplitflag),                               makeRC('44')) &
				if (L.cnamematchflag = 'N' and L.relFound,                                             makeRC('88')) &
				if (Risk_Indicators.rcSet.isCode86(L.company_name, L.vercmpy, L.bestCompanyName),      makeRC('86')) &
				if (L.cmpymiskeyflag,                                                                  makeRC('76')) &
				if (Risk_Indicators.rcSet.isCode29(L.feinmiskeyflag),                                  makeRC('29')) & // FYI, isCode29 is socs miskey
				if (Risk_Indicators.rcSet.isCode30(L.addrmiskeyflag),                                  makeRC('30')) &
				if (Risk_Indicators.rcSet.isCode31(L.phonemiskeyflag),                                 makeRC('31')),
				if( IncludeAllRC, CHOOSEN:ALL, 8));
				
	self.pri1 := if (count(pris) >= 1, pris[1].hri, '');
	self.pri2 := if (count(pris) >= 2, pris[2].hri, '');
	self.pri3 := if (count(pris) >= 3, pris[3].hri, '');
	self.pri4 := if (count(pris) >= 4, pris[4].hri, '');
	self.pri5 := if (count(pris) >= 5, pris[5].hri, '');
	self.pri6 := if (count(pris) >= 6, pris[6].hri, '');
	self.pri7 := if (count(pris) >= 7, pris[7].hri, '');
	self.pri8 := if (count(pris) >= 8, pris[8].hri, '');

	risk_indicators.mac_add_sequence(pris, reasons_with_seq);
	self.BusRiskIndicators := reasons_with_seq; 
	self := l;
end;

withReasons := project(wFeinMatches, add_reasons(LEFT));

// join the results back to the original input so that every record on input has a response populated
full_response_pre := join(indata1, withReasons,
						left.company_name=right.company_name and
						left.alt_company_name=right.alt_company_name and
						left.phone10=right.phone10 and
						left.fein=right.fein and
						left.prim_range=right.prim_range and
						left.prim_name=right.prim_name and
						left.sec_range=right.sec_range and
						left.p_city_name=right.p_city_name and
						left.st=right.st and
						left.z5=right.z5 and
						left.rep_fname=right.rep_fname and
						left.rep_lname=right.rep_lname and
						left.rep_orig_z5=right.rep_orig_z5 and
						left.rep_prim_name=right.rep_prim_name and
						left.rep_prim_range=right.rep_prim_range and
						left.rep_ssn=right.rep_ssn and
						left.rep_phone=right.rep_phone and
						left.rep_dob=right.rep_dob,	
			transform(layout_output, 	self.seq := left.seq, 
																self.account := left.account,
																self := right), keep(1));
			
//************track Royalties for who uses targus********* /
full_response := 
  PROJECT(
    full_response_pre, 
    TRANSFORM( layout_output,
        SELF.royalty_type_code_targus := royalties4Targus[1].royalty_type_code,
        SELF.royalty_type_targus      := royalties4Targus[1].royalty_type,
        SELF.royalty_count_targus     := royalties4Targus[1].royalty_count,
        SELF.non_royalty_count_targus := royalties4Targus[1].non_royalty_count,
        SELF.count_entity_targus      := royalties4Targus[1].count_entity,
        SELF := LEFT,
        SELF := []
    )
  );
  
 // *************************************
  // *   Boca Shell Logging Functionality  *
  // * NOTE: Because of the #stored below  *
  // * this MUST go at the end of this     *
  // * function in order to compile.       *
  // **************************************
	productID := Risk_Reporting.ProductID.Business_Risk__InstantID_Service;
	
//	intermediate_Log := Risk_Reporting.To_LOG_Boca_Shell(bocaShell, productID, IF(IncludeRepAttributes, 3, bsversion));
//	#stored('Intermediate_Log', intermediate_log);

 // ************ End Logging ***********
 
 // output(indata1, named('indata1BIIDFunc'), overwrite);
// output(repIN);
 // output(normalWatch, named('normalWatchBIID'), overwrite);
 // output(withWatchlistsData, named('withWatchlistsData'), overwrite);
 // output(with_dirs_phone, named('with_dirs_phone'));
 // output(rolled_dirs_phone, named('rolled_dirs_phone'));
 // output(byAddrRollPhone, named('byAddrRollPhone'));
 // output(phone_napready, named('phone_napready'));
 // output(rollphonerecs, named('rollphonerecs'));
 // output(bestcounts, named('bestcounts'));
 // output(bestcounts_ROLLUP, named('bestcounts_ROLLUP'));
 // output(AR2b, named('AR2b'));
 // output(got_bdidTable, named('got_bdidTable'));
 // OUTPUT(with_naics_sics, NAMED('with_naics_sics'));
 // OUTPUT(bkrecs_srt_ddp, NAMED('bkrecs_srt_ddp'));
 // countWatchlists := count(watchlists_requested);
 // OUTPUT(ofac_version, NAMED('ofac_version'));
 // OUTPUT(Include_Ofac, NAMED('Include_Ofac'));
 // OUTPUT(Include_Additional_Watchlists, NAMED('Include_Additional_Watchlists'));
 // OUTPUT(watchlists_requested, NAMED('watchlists_requested'));
 // OUTPUT(countWatchlists, NAMED('countWatchlists'));

return full_response;

end;