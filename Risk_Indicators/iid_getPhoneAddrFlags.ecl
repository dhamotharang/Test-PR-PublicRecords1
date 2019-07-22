
import _Control, address, riskwise, risk_indicators, gong;
onThor := _Control.Environment.OnThor;

export iid_getPhoneAddrFlags(grouped dataset(risk_indicators.Layout_Output) with_did, 
								boolean isFCRA, boolean runAreaCodeSplitSearch = true, unsigned1 BSversion = 1) := function


// with_zip_flags := iid_getZipFlags(with_DID);	// moved to iid combine verification

// one of the optimization options in IID v2 is to allow this search to be skipped when not needed.
with_ac_split := risk_indicators.iid_getACsplit(with_did, isFCRA);
ac_split := if(runAreaCodeSplitSearch, with_ac_split, with_did);



///////////////////////////////////////////////////////////////////////////////////////
//      The following block is processed only when history date is specified         //
///////////////////////////////////////////////////////////////////////////////////////

//(NB: Connected phones are much easier to find)
// Find out which phones are connected (both home and business)
layout_gonghistory := RECORDOF (Gong.Key_History_phone);
gong_key := if(isFCRA, Gong.Key_FCRA_History_phone, Gong.Key_History_phone);
connected_h_phones_roxie := JOIN (ac_split, gong_key,
															(integer) Left.phone10 != 0
															AND keyed (Left.phone10[4..10] = Right.p7 AND Left.phone10[1..3] = Right.p3)
															AND ((unsigned) (Right.dt_first_seen[1..6]) < left.historydate)
															AND (left.historydate <= (unsigned) (Right.dt_last_seen[1..6])),	
															TRANSFORM (layout_gonghistory, SELF := Right), 
																	ATMOST(
																keyed (Left.phone10[4..10] = Right.p7 AND Left.phone10[1..3] = Right.p3),
																RiskWise.max_atmost),
															keep(100));
															
connected_h_phones_thor := JOIN (distribute(ac_split((integer)phone10 !=0), hash64(phone10)), 
															distribute(pull(gong_key((integer)(p3+p7) != 0)), hash64(p3+p7)),
															(Left.phone10[4..10] = Right.p7 AND Left.phone10[1..3] = Right.p3)
															AND ((unsigned) (Right.dt_first_seen[1..6]) < left.historydate)
															AND (left.historydate <= (unsigned) (Right.dt_last_seen[1..6])),	
															TRANSFORM (layout_gonghistory, SELF := Right), 
																	ATMOST(
																 (Left.phone10[4..10] = Right.p7 AND Left.phone10[1..3] = Right.p3),
																RiskWise.max_atmost),
															keep(100), LOCAL);							
														
#IF(onThor)
	connected_h_phones := connected_h_phones_thor;
#ELSE
	connected_h_phones := connected_h_phones_roxie;
#END

connected_w_phones_roxie := JOIN (ac_split, gong_key,
															(integer) Left.wphone10 != 0
															AND keyed (Left.wphone10[4..10] = Right.p7 AND Left.wphone10[1..3] = Right.p3)
															AND ((unsigned) (Right.dt_first_seen[1..6]) < left.historydate)
															AND (left.historydate <= (unsigned) (Right.dt_last_seen[1..6])),
															TRANSFORM (layout_gonghistory, SELF := Right), 
																			ATMOST(
																		keyed (Left.wphone10[4..10] = Right.p7 AND Left.wphone10[1..3] = Right.p3),
																		RiskWise.max_atmost),
																	keep(100));
																	
connected_w_phones_thor := JOIN (distribute(ac_split((integer)wphone10!=0), hash64(wphone10)), 
															distribute(pull(gong_key((integer)(p3+p7)!=0)), hash64(p3+p7)),
															(Left.wphone10[4..10] = Right.p7 AND Left.wphone10[1..3] = Right.p3)
															AND ((unsigned) (Right.dt_first_seen[1..6]) < left.historydate)
															AND (left.historydate <= (unsigned) (Right.dt_last_seen[1..6])),
															TRANSFORM (layout_gonghistory, SELF := Right), 
																			ATMOST(
																		(Left.wphone10[4..10] = Right.p7 AND Left.wphone10[1..3] = Right.p3),
																		RiskWise.max_atmost),
																	keep(100), LOCAL);
																	
#IF(onThor)
	connected_w_phones := connected_w_phones_thor;
#ELSE
	connected_w_phones := connected_w_phones_roxie;
#END

//consider all phones as "disconnected" by default:
risk_indicators.layout_output setDisconnectedTrue (risk_indicators.layout_output L) := TRANSFORM
  SELF.phonedissflag := TRUE;
  SELF.wphonedissflag := TRUE;
  SELF := L;
END;
ac_split_disc := PROJECT (ac_split, setDisconnectedTrue (Left));

// set connected home phones
risk_indicators.layout_output setConnectedPhones (risk_indicators.layout_output L, layout_gonghistory R, integer i) := TRANSFORM
  SELF.phonedissflag := IF (i = 1 and R.p3 <> '', FALSE, L.phonedissflag);
  SELF.wphonedissflag := IF (i = 2 and R.p3 <> '', FALSE, L.wphonedissflag);
  SELF := L;
END;
ac_split_home := JOIN (ac_split_disc, DEDUP (connected_h_phones, p7, p3, ALL),
                       Left.phone10[4..10] = Right.p7 AND Left.phone10[1..3] = Right.p3,
                       setConnectedPhones (LEFT, RIGHT, 1),
                       LEFT OUTER, LOOKUP);

//set business phones connected: 
phone_diss_history := JOIN (ac_split_home, DEDUP (connected_w_phones, p7, p3, ALL),
                          Left.wphone10[4..10] = Right.p7 AND Left.wphone10[1..3] = Right.p3,
                          setConnectedPhones (LEFT, RIGHT, 2),
                          LEFT OUTER, LOOKUP); 				 
//////////////////////////////////////////////////////////////////////////////////

// choose between historical and non-historical versions
// check the first record in the batch to determine if this a realtime transaction or an archive test
production_realtime_mode := with_did[1].historydate=risk_indicators.iid_constants.default_history_date
														or with_did[1].historydate = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..6]);		
														
with_phone_disconnect_hist := IF (production_realtime_mode, if(BSversion >= 50, ac_split_disc, ac_split), phone_diss_history);



MAC_phtrans (trans_name, key_phonetable) := MACRO
risk_indicators.layout_output trans_name (risk_indicators.layout_output le, key_phonetable ri, INTEGER i) := transform
	boolean diss_flag_old := IF (i=1, if(ri.phone10='' and le.phonedissflag, FALSE, le.phonedissflag), if(ri.phone10='' and le.wphonedissflag, FALSE, le.wphonedissflag));
	boolean pot_Disconnect_old := IF(le.historydate=risk_indicators.iid_constants.default_history_date, ri.potDisconnect, IF(diss_flag_old, true, false));
	
	boolean diss_flag50 := IF (i=1, if(ri.phone10='' and le.phonedissflag, FALSE, le.phonedissflag), 
			if(ri.phone10='' and le.wphonedissflag, FALSE, le.wphonedissflag));
	boolean pot_Disconnect50 :=  IF(diss_flag50 or ri.potDisconnect, true, false); 

	boolean diss_flag := if(bsVersion >= 50, diss_flag50, diss_flag_old);
	boolean pot_Disconnect := if(bsVersion >= 50, pot_Disconnect50, pot_Disconnect_old);
		//	IF(diss_flag or ri.potDisconnect, true, false));	
	
	self.nxx_type := IF(i=1,ri.nxx_type,le.nxx_type);
	self.hriskphoneflag := IF(i=1, // TODO AND ri.hri_dt_first_seen < history_date
						risk_indicators.PRIIPhoneRiskFlag(le.phone10).phoneRiskFlag(ri.nxx_type, pot_Disconnect, ri.sic_code),
						le.hriskphoneflag);
	self.hphonetypeflag := IF(i=1, // TODO AND ri.hri_dt_first_seen < history_date
						risk_indicators.PRIIPhoneRiskFlag(le.phone10).PWphoneRiskFlag(ri.nxx_type, ri.sic_code),
						le.hphonetypeflag);
	self.phonevalflag := IF(i=1,MAP(self.hriskphoneflag ='5' => '3',
							  ri.isaCompany => '1',
							  ~ri.isaCompany AND ri.phone10<>'' => '2',
							  length(trim(le.phone10)) >= 10 and ri.phone10 = '' and ri.nxx_type <> '' => '3',
							  length(trim(le.phone10)) < 6 or le.phone10 = '' => '4',
							  ri.nxx_type = '' => '0',
							  ''), le.phonevalflag);
	self.hphonevalflag := IF(i=1,MAP(length(trim(le.phone10)) < 6 or le.phone10 = '' => '6',
							   self.hphonetypeflag='5' => '3',
							   ri.isaCompany => '1',
							   self.hphonetypeflag in ['1','2','3','6','9','A'] => '4',
							   ~ri.isaCompany AND ri.phone10<>'' => '2',
							   ri.nxx_type = '' => '0',
							   '5'), le.hphonevalflag);
	self.isPOTS := IF(i=1,risk_indicators.PRIIPhoneRiskFlag(le.phone10).isPOTS(ri.nxx_type),le.isPOTS);
	self.phonedissflag := IF(i=1,pot_Disconnect,le.phonedissflag);
	self.phonezipflag := IF(i=1,MAP(~self.isPOTS => '0',
	                          self.hriskphoneflag='7' OR length(trim(le.in_zipCode))<5 => '2',
							  // the logic for a 1 appears below in the telcordia search,
							  '0'), le.phonezipflag);
	self.PWphonezipflag := IF(i=1,MAP(length(trim(le.phone10)) < 6 or length(trim(le.in_zipCode))<5 => '5',
																		ri.nxx_type = '' => '4',
																		~self.isPOTS => '0',
																		// logic for a 1 appears below in the telcordia search
																		le.ziptypeflag = '5' => '2', // not sure what to do for zip code not issued, will try this newly fixed field
																		'0'), le.PWphonezipflag);
	self.hriskcmpyphone := IF(i=1,IF(self.hriskphoneflag='6',ri.company_name,''), le.hriskcmpyphone);
	self.hrisksicphone := IF(i=1,IF(self.hriskphoneflag='6',ri.sic_code,''), le.hrisksicphone);
	self.hriskphonephone := IF(i=1,IF(self.hriskphoneflag='6',ri.phone10,''), le.hriskphonephone);
	self.hriskaddrphone := IF(i=1,IF(self.hriskphoneflag='6',Risk_Indicators.MOD_AddressClean.street_address('',ri.prim_range, '', ri.prim_name, '', '', '', ''),''), le.hriskaddrphone);
	self.hriskcityphone := IF(i=1,IF(self.hriskphoneflag='6',ri.city,''), le.hriskcityphone);
	self.hriskstatephone := IF(i=1,IF(self.hriskphoneflag='6',ri.state,''), le.hriskstatephone);
	self.hriskzipphone := IF(i=1,IF(self.hriskphoneflag='6',ri.zip5+ri.zip4,''), le.hriskzipphone);	
	self.nxx_type2 := IF(i=2,ri.nxx_type,le.nxx_type2);
	self.wphonedissflag := IF(i=2,pot_Disconnect, le.wphonedissflag);
	self.wphonetypeflag := IF(i=2,risk_indicators.PRIIPhoneRiskFlag(le.wphone10).PWphoneRiskFlag(ri.nxx_type, ri.sic_code),le.wphonetypeflag);
	self.wphonevalflag := IF(i=2,MAP(length(trim(le.wphone10)) < 6 or le.wphone10 = '' => '6',
							   self.wphonetypeflag='5' => '3',
							   ri.isaCompany => '1',
							   self.wphonetypeflag in ['1','2','3','6','9','A'] => '4',
							   ~ri.isaCompany AND ri.phone10<>'' => '2',
							   ri.nxx_type = '' => '0',
							   '5'), le.wphonevalflag);
							   
	self := le;
END;
ENDMACRO;

MAC_phtrans (phtrans_nonFCRA, risk_indicators.key_phone_table_v2);
MAC_phtrans (phtrans_FCRA, Gong.Key_FCRA_Business_Header_Phone_Table_Filtered_V2);

jphonerecs_roxie := if (isFCRA,
				join(with_phone_disconnect_hist,Gong.Key_FCRA_Business_Header_Phone_Table_Filtered_V2,
					(integer)left.phone10 != 0 and
					keyed(left.phone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
					phtrans_FCRA(left,right,1),left outer,
					ATMOST( keyed(left.phone10=right.phone10), RiskWise.max_atmost), keep(100)),
					
				join(with_phone_disconnect_hist,risk_indicators.key_phone_table_v2,
					(integer)left.phone10 != 0 and
					keyed(left.phone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
					phtrans_nonFCRA(left,right,1),left outer,
					ATMOST( keyed(left.phone10=right.phone10), RiskWise.max_atmost), keep(100)));
	
jphonerecs_thor_pre := if (isFCRA,
				join(distribute(with_phone_disconnect_hist(phone10 != ''), hash64(phone10)),
					distribute(pull(Gong.Key_FCRA_Business_Header_Phone_Table_Filtered_V2((integer)phone10 != 0)), hash64(phone10)),
					(integer)left.phone10 != 0 and
					(left.phone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
					phtrans_FCRA(left,right,1),left outer,
					ATMOST( (left.phone10=right.phone10), RiskWise.max_atmost), keep(100), LOCAL),
				join(distribute(with_phone_disconnect_hist, hash64(phone10)),
				distribute(pull(risk_indicators.key_phone_table_v2((integer)phone10 != 0)), hash64(phone10)),
					(integer)left.phone10 != 0 and
					(left.phone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
					phtrans_nonFCRA(left,right,1),left outer,
					ATMOST( (left.phone10=right.phone10), RiskWise.max_atmost), keep(100), LOCAL));

jphonerecs_thor_nophone := PROJECT(with_phone_disconnect_hist(phone10 = ''), TRANSFORM(risk_indicators.layout_output,
																		self.hriskphoneflag := '7';
																		self.hphonetypeflag := 'Z';
																		self.phonevalflag := '4';
																		self.hphonevalflag := '6';
																		self.phonezipflag := '2';
																		self.PWphonezipflag := '5';
																		self.phonedissflag := false;
																		self := left));
																		
jphonerecs_thor := jphonerecs_thor_pre + jphonerecs_thor_nophone;

#IF(onThor)
	jphonerecs := group(sort(distribute(jphonerecs_thor, hash64(seq)), seq, did, LOCAL), seq, did, LOCAL);
#ELSE
	jphonerecs := jphonerecs_roxie;
#END

// rollup here before searching with the workphone
// add a rollup to calculate my flags
risk_indicators.layout_output flagroll(risk_indicators.layout_output l, risk_indicators.layout_output r) := transform
	
	// try the right for now
	self.hriskphoneflag := r.hriskphoneflag;
	self.hphonetypeflag := r.hphonetypeflag;
	self.wphonetypeflag := r.wphonetypeflag;
	self.phonevalflag := r.phonevalflag;
	self.hphonevalflag := r.hphonevalflag;
	self.wphonevalflag := r.wphonevalflag; 
	self.phonezipflag := r.phonezipflag;
	self.PWphonezipflag := r.PWphonezipflag;
	self.phonedissflag := IF(~l.phonedissflag,l.phonedissflag,r.phonedissflag);
	self.wphonedissflag := IF(~l.wphonedissflag,l.wphonedissflag,r.wphonedissflag);
	
	self.hriskcmpyphone := r.hriskcmpyphone;
	self.hrisksicphone := r.hrisksicphone;
	self.hriskphonephone := r.hriskphonephone;
	self.hriskaddrphone := r.hriskaddrphone;
	self.hriskcityphone := r.hriskcityphone;
	self.hriskstatephone := r.hriskstatephone;
	self.hriskzipphone := r.hriskzipphone;
		
	self	:= l;
END;

jphonerecsrolled := rollup(jphonerecs,true,flagroll(LEFT,RIGHT));


jphonerecs2_roxie := if (isFCRA,
				join(jphonerecsrolled,Gong.Key_FCRA_Business_Header_Phone_Table_Filtered_V2,
					(integer)left.wphone10 != 0 and
					keyed(left.wphone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
					phtrans_FCRA(left,right,2),left outer,
					ATMOST( keyed(left.wphone10=right.phone10), RiskWise.max_atmost), keep(100)),
					
				join(jphonerecsrolled,risk_indicators.key_phone_table_v2,
					(integer)left.wphone10 != 0 and
					keyed(left.wphone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
					phtrans_nonFCRA(left,right,2),left outer,
					ATMOST( keyed(left.wphone10=right.phone10), RiskWise.max_atmost), keep(100)));

jphonerecs2_thor_pre := if (isFCRA,
				join(distribute(jphonerecsrolled(wphone10 != ''), hash64(wphone10)),
				distribute(pull(Gong.Key_FCRA_Business_Header_Phone_Table_Filtered_V2((integer)phone10!=0)), hash64(phone10)),
					(integer)left.wphone10 != 0 and
					(left.wphone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
					phtrans_FCRA(left,right,2),left outer,
					ATMOST( (left.wphone10=right.phone10), RiskWise.max_atmost), keep(100), LOCAL),
				join(distribute(jphonerecsrolled, hash64(wphone10)),
					distribute(pull(risk_indicators.key_phone_table_v2((integer)phone10!=0)), hash64(phone10)),
					(integer)left.wphone10 != 0 and
					(left.wphone10=right.phone10) AND RIGHT.dt_first_seen < left.historydate,
					phtrans_nonFCRA(left,right,2),left outer,
					ATMOST( (left.wphone10=right.phone10), RiskWise.max_atmost), keep(100), LOCAL));
					
jphonerecs2_thor_nowphone := PROJECT(jphonerecsrolled(wphone10 = ''), TRANSFORM(risk_indicators.layout_output,
					self.wphonevalflag := '6';
					self.wphonetypeflag := 'Z';
					self.wphonedissflag := false;	
					self := left));
					
jphonerecs2_thor := jphonerecs2_thor_pre + jphonerecs2_thor_nowphone;

#IF(onThor)
	jphonerecs2 := group(sort(distribute(jphonerecs2_thor, hash64(seq)), seq, did, LOCAL), seq, did, LOCAL);
#ELSE
	jphonerecs2 := jphonerecs2_roxie;
#END

// rollup again here before searching telcordia
jphonerecs2rolled := rollup(jphonerecs2,true,flagroll(LEFT,RIGHT));


risk_indicators.layout_output teltrans(risk_indicators.layout_output le, risk_indicators.Key_Telcordia_tpm_slim ri, INTEGER i) := transform
	self.nxx_type := IF(i=1,IF(le.nxx_type='',ri.nxx_type,le.nxx_type), le.nxx_type);
	self.phonetype := IF(i=1,risk_indicators.PRIIPhoneRiskFlag('').telcordiaPhoneType(ri.dial_ind, ri.point_id),le.phonetype);
	self.hriskphoneflag := IF(i=1,IF(le.nxx_type='',risk_indicators.PRIIPhoneRiskFlag(le.phone10).phoneRiskFlag(ri.nxx_type, le.phonedissflag, ''),le.hriskphoneflag), le.hriskphoneflag);
	self.hphonetypeflag := IF(i=1,IF(le.nxx_type='',risk_indicators.PRIIPhoneRiskFlag(le.phone10).PWphoneRiskFlag(ri.nxx_type, '', self.phonetype),le.hphonetypeflag), le.hphonetypeflag);
	self.phonevalflag := IF(i=1,IF(le.nxx_type='',MAP(le.phonevalflag = '4' => '4',
											ri.nxx_type = '' => '0',
											le.phonevalflag='0' => '3',
											''),le.phonevalflag), le.phonevalflag);
	self.hphonevalflag := IF(i=1,IF(le.nxx_type='',MAP(le.hphonevalflag = '6' => '6',
											 self.hphonetypeflag in ['1','2','3','6','9','A'] => '4',
											 ri.nxx_type = '' => '0',
											 le.hphonevalflag='0' => '5',
											 '5'), le.hphonevalflag), le.hphonevalflag);
	self.isPOTS := IF(i=1,IF(le.nxx_type='',risk_indicators.PRIIPhoneRiskFlag(le.phone10).isPOTS(ri.nxx_type),le.isPOTS), le.isPOTS);
	self.phonezipflag := IF(i=1,IF(le.phonezipflag='2','2',
									IF(le.nxx_type='',MAP(le.phonezipflag='2' OR self.hriskphoneflag='7' OR length(trim(le.in_zipCode))<5 => '2',
											~self.isPOTS => '0',
											le.in_zipCode not in set(ri.zipcodes, zip) => '1',  
											'0'), IF(le.in_zipCode not in set(ri.zipcodes, zip),'1',le.phonezipflag))
											), le.phonezipflag);
	self.PWphonezipflag := IF(i=1,IF(le.nxx_type='',MAP(le.PWphonezipflag ='5' => '5',
																											ri.nxx_type='' => '4',
																											~self.isPOTS => '0',
																											le.in_zipCode <> '' and le.in_zipCode not in set(ri.zipcodes, zip) => '1',
																											
																											'0'), 
																									IF(le.in_zipCode <> '' and le.in_zipCode not in set(ri.zipcodes, zip) and ~le.PWphonezipflag='2','1',le.PWphonezipflag)), 
																		le.PWphonezipflag);
	self.nxx_type2 := IF(i=2,IF(le.nxx_type2='',ri.nxx_type,le.nxx_type2), le.nxx_type2);
	self.wphonetype := IF(i=2,risk_indicators.PRIIPhoneRiskFlag('').telcordiaPhoneType(ri.dial_ind, ri.point_id),le.wphonetype);
	self.wphonetypeflag := IF(i=2,IF(le.nxx_type2='',risk_indicators.PRIIPhoneRiskFlag(le.wphone10).PWphoneRiskFlag(ri.nxx_type, '', self.wphonetype),le.wphonetypeflag), le.wphonetypeflag);
	self.wphonevalflag := IF(i=2,IF(le.nxx_type2='',MAP(le.wphonevalflag = '6' => '6',
											  ri.nxx_type = '' => '0',
											  le.wphonevalflag='0' => '5',
											  le.wphonevalflag), le.wphonevalflag), le.wphonevalflag);
	self := le;
END;

telecordia_key := if(isFCRA, risk_indicators.Key_FCRA_Telcordia_tpm_slim, risk_indicators.Key_Telcordia_tpm_slim);

telphonerecs0_roxie := group(join(jphonerecs2rolled, telecordia_key,
												LEFT.phone10!='' AND
												keyed(LEFT.phone10[1..3]=(RIGHT.npa)) and 
												keyed(left.phone10[4..6]=RIGHT.nxx) and
												KEYED(RIGHT.tb IN [LEFT.phone10[7]]),
												teltrans(left,right,1),
											left outer, keep(500)), seq);					

telphonerecs0_thor_phone := join(distribute(jphonerecs2rolled(phone10!=''), hash64(phone10[1..6])), 
												distribute(pull(telecordia_key), hash64(npa+nxx)),
												(LEFT.phone10[1..3]=(RIGHT.npa)) and 
												(left.phone10[4..6]=RIGHT.nxx) and
												(RIGHT.tb IN [LEFT.phone10[7]]),
												teltrans(left,right,1),
											left outer, keep(500), LOCAL);			

telphonerecs0_thor := group(sort(distribute(telphonerecs0_thor_phone + jphonerecs2rolled(phone10=''), hash64(seq)),seq, LOCAL), seq,LOCAL);

#IF(onThor)
	telphonerecs0 := telphonerecs0_thor;
#ELSE
	telphonerecs0 := telphonerecs0_roxie;
#END

telphonerecs := rollup(telphonerecs0,true,flagroll(LEFT,RIGHT));

telphonerecs2_pre_roxie := group(join(telphonerecs, telecordia_key,
																			LEFT.wphone10!='' and
																			keyed(LEFT.wphone10[1..3]=(RIGHT.npa)) and
																			keyed(left.wphone10[4..6]=RIGHT.nxx) and 
																			KEYED(RIGHT.tb IN [LEFT.wphone10[7]]),
																		 teltrans(left,right,2),
																		 left outer, keep(500)), seq);

telphonerecs2_pre_thor_wphone := join(distribute(telphonerecs(wphone10!=''), hash64(wphone10[1..6])), 
																			distribute(pull(telecordia_key), hash64(npa+nxx)),
																			(LEFT.wphone10[1..3]=(RIGHT.npa)) and
																			(left.wphone10[4..6]=RIGHT.nxx) and 
																			(RIGHT.tb IN [LEFT.wphone10[7]]),
																		 teltrans(left,right,2),
																		 left outer, keep(500), LOCAL);
												
telphonerecs2_pre_thor := group(sort(distribute(telphonerecs2_pre_thor_wphone + telphonerecs(wphone10=''), hash64(seq)), seq, LOCAL), seq, LOCAL);

#IF(onThor)
	telphonerecs2_pre := telphonerecs2_pre_thor;
#ELSE
	telphonerecs2_pre := telphonerecs2_pre_roxie;
#END

telphonerecs2 := rollup(telphonerecs2_pre,true,flagroll(LEFT,RIGHT));
// OUTPUT(with_did, NAMED('with_did'));
// OUTPUT(connected_h_phones, NAMED('connected_h_phones'));
// OUTPUT(connected_W_phones, NAMED('connected_W_phones'));
// OUTPUT(with_phone_disconnect_hist, NAMED('with_phone_disconnect_hist'));
// OUTPUT(jphonerecs, NAMED('jphonerecs'));
// OUTPUT(jphonerecsrolled, NAMED('jphonerecsrolled'));
// OUTPUT(jphonerecs2, NAMED('jphonerecs2'));
// OUTPUT(jphonerecs2rolled, NAMED('jphonerec2srolled'));
// OUTPUT(telphonerecs2_pre, NAMED('telphonerecs2_pre'));

// moved hr stuff to combine verification because we dont have the chronoaddrflags populated in the phone branch of the logic

return telphonerecs2;

end;