import ut, models;

todays_date := (string) risk_indicators.iid_constants.todaydate;

export rcSet := MODULE

export isCode01(STRING inFirst, STRING inLast, STRING inSSN, STRING inPhone, STRING inStreetAddr) := inFirst='' OR inLast='' OR inSSN='' OR inPhone='' OR inStreetAddr='';
export isCode01a(STRING inFirst, STRING inLast, STRING inPhone, STRING inStreetAddr) := inFirst='' OR inLast='' OR inPhone='' OR inStreetAddr='';
export isCode01b(STRING inCmpy, STRING inPhone, STRING inStreetAddr) := inCmpy='' OR inPhone='' OR inStreetAddr='';
export isCode02(STRING decsflag) := decsflag='1';
export isCode03(STRING socsdobflag) := socsdobflag='1';
export isCode04(UNSIGNED1 lastcount, UNSIGNED1 socscount, UNSIGNED1 addrcount, STRING phoneverType, UNSIGNED1 phonelastcount, UNSIGNED1 phonephonecount, UNSIGNED1 phoneaddrcount,
			 UNSIGNED1 phoneaddrlastcount, UNSIGNED1 phoneaddrphonecount, UNSIGNED1 phoneaddraddrcount, UNSIGNED1 utiliaddrlastcount, UNSIGNED1 utiliaddrphonecount, UNSIGNED1 utiliaddraddrcount) := 
																lastcount>=1 AND socscount>=1 AND addrcount=0 AND 
																((phonevertype='P' AND phonelastcount=0 AND phonephonecount>=1 AND phoneaddrcount>=1) OR
																(phonevertype='A' AND phoneaddrlastcount=0 AND phoneaddrphonecount>=1 AND phoneaddraddrcount>=1) OR
																(phonevertype='U' AND utiliaddrlastcount=0 AND utiliaddrphonecount>=1 AND utiliaddraddrcount>=1));
export isCode05(unsigned3 distance) := distance > 50 and distance <> 9999; // geographically distant
export isCode06(STRING socsvalflag, STRING inSSN) := socsvalflag = '1' OR LENGTH(StringLib.StringFilter(TRIM(inSSN), '0123456789')) <> LENGTH(TRIM(inSSN));
export isCode07(STRING hriskphoneflag) := hriskphoneflag = '5';
export isCode08(STRING phonetype, STRING inPhone) := phonetype <> '1' and inPhone <> '';
export isCode09(STRING nxx_type) := PRIIPhoneRiskFlag('').isPaging(nxx_type);
export isCode10(STRING nxx_type) := PRIIPhoneRiskFlag('').isMobile(nxx_type) OR PRIIPhoneRiskFlag('').isCellular(nxx_type) OR PRIIPhoneRiskFlag('').isPCS(nxx_type);
export isCode11(STRING addrvalflag, STRING inStreetAddr, STRING inCity, STRING inState, STRING inZip) := addrvalflag='N' and ((inStreetAddr<>'' and inCity<>'' and inState<>'') or 
																									(inStreetAddr<>'' and inZip<>''));
export isCode12(STRING zipclass) := zipclass='P'; // zipclass is different than addrtype from ACE, addrtype is only for that record, zipclass is the classification for that entire zipcode
										// zipclass comes from citystzip file
export isCode13 := false; 
export isCode14(STRING hriskaddrflag) := hriskaddrflag = '4';
export isCode15(STRING hriskphoneflag) := hriskphoneflag = '6';
export isCode16(STRING phonezipflag) := phonezipflag = '1';
export isCode17(unsigned3 distance) := distance > 50  and distance <> 9999; // geographically distant
export isCode18 := false;  // open

export isCode19(UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount) := combolastcount=0 AND comboaddrcount=0 AND combohphonecount=0 AND combossncount=0;
export isCode20(UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount) := combolastcount=0 AND comboaddrcount=0 AND combohphonecount=0 AND combossncount>0;
export isCode21(STRING inLast, STRING inPhone, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount) := inLast<>'' and LENGTH(Stringlib.StringFilter(inPhone,'0123456789'))=10 and 
																										combolastcount=0 AND comboaddrcount>0 AND combohphonecount=0;
export isCode22(STRING inLast, STRING inAddr, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount) := inLast<>'' and inAddr<>'' and combolastcount=0 AND comboaddrcount=0 AND combohphonecount>0;
export isCode23(STRING inSSN, STRING inLast, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount) := inLast<>'' and LENGTH(Stringlib.StringFilter(inSSN,'0123456789')) IN [4,9] and 
																						((combolastcount=0 AND comboaddrcount=0 AND combohphonecount>0 AND combossncount=0) OR
																						(combolastcount=0 AND comboaddrcount>0 AND combohphonecount=0 AND combossncount=0) OR
																						(combolastcount=0 AND comboaddrcount>0 AND combohphonecount>0 AND combossncount=0));
export isCode24(STRING inAddr, STRING inSSN, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combossncount) := inAddr<>'' and LENGTH(Stringlib.StringFilter(inSSN,'0123456789')) IN [4,9] and 
																									combolastcount>0 AND comboaddrcount=0 AND combossncount=0;
export isCode25(STRING inAddr, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount) := inAddr<>'' and comboaddrcount=0 and 
																					~(combolastcount=0 and comboaddrcount=0 and combohphonecount=0 and combossncount=0);// not rc19

// legacy products which had 23, 24 and 26 in the same set, so this was coded to not return 26 if 23 or 24 were already returned in that set
// in a new set which doesn't include 23 and 24, trigger 26 based on just the unverified SSN by itself
export isCode26(STRING inSSN, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combossncount, boolean with23and24, boolean with19=false, UNSIGNED1 combohphonecount=0) := 
																						LENGTH(Stringlib.StringFilter(inSSN,'0123456789')) IN [4,9] and 
																						if(with23and24, combolastcount>0 and comboaddrcount>0 and combossncount=0, combossncount=0) and
																						// if 19 is returned, don't return 26 - added for CIID enhancements bug 73191, didn't change any other product that uses 19 and 26 together
																						if(with19, ~isCode19(combolastcount, comboaddrcount, combohphonecount, combossncount), true);
																						
export isCode27(STRING inPhone, UNSIGNED1 combolastcount, UNSIGNED1 combohphonecount) := LENGTH(Stringlib.StringFilter(inPhone,'0123456789'))=10 and combohphonecount=0 and combolastcount>0;
export isCode28(UNSIGNED1 comboDobCount, STRING inDob) := comboDobCount=0 AND LENGTH(StringLib.StringFilter(inDob,'0123456789'))>=8;
export isCode29(BOOLEAN socsmiskeyflag) := socsmiskeyflag;
export isCode30(BOOLEAN addrmiskeyflag) := addrmiskeyflag;
export isCode31(BOOLEAN hphonemiskeyflag) := hphonemiskeyflag;
export isCode32(STRING watchlist_table, STRING watchlist_record_number) := (watchlist_table <> '' AND watchlist_record_number[1..4] IN ['OFAC', 'OFC']) or watchlist_table='OFC';

export isCode33(unsigned1 addrcount, unsigned1 cmpycount, unsigned1 wphonecount, string inAddr, string inCmpy, string inPhone) := (inAddr!='' and inCmpy!='' and inPhone !='') and
																	((addrcount=0 and ~(cmpycount=0 and wphonecount=0)) or (addrcount<>0 and (cmpycount=0 and wphonecount=0)));
export isCode34(UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount, STRING inPhone, STRING inSSN) := combolastcount = 0 OR comboaddrcount = 0 OR 
																								(combohphonecount = 0 AND LENGTH(Stringlib.StringFilter(inPhone,'0123456789'))=10) OR 
																								(combossncount = 0 AND LENGTH(Stringlib.StringFilter(inSSN,'0123456789')) IN [4,9]);
export isCode35 := false;
export isCode36(STRING2 rc) := rc='00';
export isCode37(STRING inLast, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount) := inLast<>'' and combolastcount=0 and 
																				~(combolastcount=0 AND comboaddrcount=0 AND combohphonecount=0 AND combossncount=0);// not rc19
export isCode38(STRING altlast, UNSIGNED1 socscount, UNSIGNED1 lastcount, STRING altlast2, boolean miskeylast) := (altlast<>'' and socscount>0 and lastcount>0 and ~miskeylast) OR (altlast2<>'');
export isCode39(string lowissue, unsigned3 historydate) := ((integer)(risk_indicators.iid_constants.myGetDate(historydate)[1..6]) - (INTEGER)(lowissue[1..6])) < 100;
export isCode40(STRING zipclass) := zipclass = 'U' or zipclass = 'M';
export isCode41(STRING drlcvalflag) := drlcvalflag = '1' or drlcvalflag = '3';
export isCode42(STRING bansflag) := bansflag = '1';
export isCode43(STRING bansflag, UNSIGNED2 firstcount, UNSIGNED2 lastcount, UNSIGNED2 addrcount) := bansflag = '2' or (bansflag = '1' and firstcount > 0 and lastcount > 0 and addrcount > 0);
export isCode43b(STRING bansflag, UNSIGNED2 cmpycount, UNSIGNED2 addrcount) := bansflag='2' or (bansflag='1' and cmpycount>0 and addrcount>0);
export isCode44(STRING areacodesplitflag) := areacodesplitflag='Y';
export isCode45(UNSIGNED2 lastcount, UNSIGNED2 socscount, UNSIGNED2 addrcount, STRING phonevertype, UNSIGNED2 phonelastcount, UNSIGNED2 phonephonecount, UNSIGNED2 phoneaddrcount,
			 UNSIGNED2 phoneaddrlastcount, UNSIGNED2 phoneaddrphonecount, UNSIGNED2 phoneaddraddrcount, UNSIGNED2 utiliaddrlastcount, UNSIGNED2 utiliaddrphonecount, UNSIGNED2 utiliaddraddrcount) := 
								lastcount=0 AND socscount>=1 AND addrcount>=1 AND 
								((phonevertype='P' and phonelastcount>=1 AND phonephonecount>=1 AND phoneaddrcount=0) OR
								(phonevertype='A' and phoneaddrlastcount>=1 and phoneaddrphonecount>=1 and phoneaddraddrcount=0) OR
								(phonevertype='U' and utiliaddrlastcount>=1 and utiliaddrphonecount>=1 and utiliaddraddrcount=0));
export isCode46(string wphonetypeflag) := wphonetypeflag='2';
export isCode47(string phoneaddr, string veraddr, string phonecmpy, string vercmpy) := map(phonecmpy<>'' and vercmpy<>'' and 100-ut.CompanySimilar100(phonecmpy, vercmpy)<80 => true, 
																		 phoneaddr<>'' and veraddr<>'' and 100-MAX(ut.StringSimilar100(phoneaddr, veraddr),ut.StringSimilar100(veraddr, phoneaddr))<80 => true,
																		 false);// input phone assoc with different business name or address 
export isCode48(string inFirst, unsigned1 combofirstcount, unsigned1 combolastcount) := combolastcount >= 1 AND combofirstcount = 0 AND inFirst <> '';
export isCode49(unsigned3 disthphoneaddr) := disthphoneaddr > 10 AND disthphoneaddr <> 9999;
export isCode50(STRING hriskaddrflag, STRING hrisksic, STRING hriskphoneflag, STRING hrisksicphone) := (hriskaddrflag='4' AND hrisksic = '2225') /*OR (hriskphoneflag='6' AND hrisksicphone = '2225')*/;													  
export isCode51(string inLast, string inSSN, boolean lastssnmatch2, unsigned1 socslevel, boolean ssnExists) := inLast <> '' and LENGTH(Stringlib.StringFilter(inSSN,'0123456789'))=9 and ~lastssnmatch2 and socslevel in [1,2,3,4,5,6,8,10] and ssnexists;
export isCode52(string inFirst, string inSSN, boolean firstssnmatch, unsigned1 socslevel, boolean ssnExists) := inFirst <> '' and LENGTH(Stringlib.StringFilter(inSSN,'0123456789'))=9 and ~firstssnmatch and socslevel in [1,2,3,5,6,7,8,11] and ssnexists;															  
export isCode53(unsigned3 disthphonewphone) := disthphonewphone > 100 AND disthphonewphone <> 9999;
export isCode54(string fein, string bestfein) := fein != '' and bestfein != '' and fein != bestfein;
export isCode55(string wphonevalflag) := wphonevalflag='0';
export isCode56(boolean wphonedissflag) := wphonedissflag;
export isCode57(string wphonetypeflag) := wphonetypeflag='1';
export isCode58(STRING fein) := ~(LENGTH(Stringlib.StringFilter(fein,'0123456789'))=9);
export isCode59(string cmpy) := cmpy='';
export isCode60(unsigned2 cmpycount, unsigned2 addrcount, unsigned2 wphonecount, string inCmpy, string inAddr, string inWphone) := inCmpy <> '' and inAddr <> '' and inWphone<>'' and 
																										cmpycount=0 AND addrcount=0 AND wphonecount=0;
export isCode61(unsigned2 cmpycount, unsigned2 addrcount, unsigned2 wphonecount, string inCmpy, string inAddr, string inWphone) := inCmpy <> '' and inAddr <> '' and inWphone<>'' and
																										cmpycount=0 AND addrcount>0 AND wphonecount=0;
export isCode62(unsigned2 cmpycount, unsigned2 addrcount, unsigned2 wphonecount, string inCmpy, string inAddr, string inWphone) := inCmpy <> '' and inAddr <> '' and inWphone<>'' and
																										cmpycount=0 AND addrcount=0 AND wphonecount>0;
export isCode63(boolean cmpyMiskeyFlag) := cmpyMiskeyFlag;  // cmpy miskey
export isCode64(string nameaddrphone, string inPhone, unsigned1 dirsaddr_lastscore) := nameaddrphone <> inPhone AND nameaddrphone <> '' and LENGTH(Stringlib.StringFilter(inPhone,'0123456789'))>=6
																	  and dirsaddr_lastscore < 80;
export isCode65(unsigned2 addrcount, string inAddr, unsigned2 cmpycount) := addrcount=0 and inAddr<>'' and cmpycount>0;
export isCode66(STRING inLast, STRING inFirst, STRING inSSN, UNSIGNED2 lastcount, UNSIGNED2 socscount, UNSIGNED2 firstcount) := inLast <> '' and inFirst <> '' and LENGTH(Stringlib.StringFilter(inSSN,'0123456789')) IN [4,9] AND 
																									   (lastcount = 0 AND socscount >= 1 AND firstcount >= 1);
export isCode67(unsigned2 wphonecount, string inWphone, unsigned2 cmpycount) := wphonecount=0 AND inWphone<>'' and cmpycount>0;
export isCode68(unsigned2 wphonecount, string inWphone) := wphonecount=0 AND inWphone<>'';
export isCode69(STRING phonevalflag) := phonevalflag='2';
export isCode70(string resAddrFlag) := resAddrFlag ='Y';
export isCode71(boolean ssnExists, STRING inSSN, STRING socsvalflag) := ~ssnExists and LENGTH(Stringlib.StringFilter(inSSN,'0123456789')) = 9 and ~socsvalflag = '1';	// not reason code 6, make sure rc6 is output in the set or set it to false
export isCode72(STRING svl, STRING inSSN, BOOLEAN ssnExists, boolean lastssnmatch2) := svl in ['1','2','3','4','5','8'] and ssnExists and ~lastssnmatch2;
export isCode73(STRING inPhone, UNSIGNED2 phonephonecount, UNSIGNED2 combo_hphonecount) := LENGTH(Stringlib.StringFilter(inPhone,'0123456789'))=10 AND phonephonecount=0 and combo_hphonecount=0;
export isCode74(UNSIGNED2 phonelastcount, UNSIGNED2 phoneaddrcount, UNSIGNED2 phonephonecount, STRING phonevalflag)  := phonelastcount=0 AND phoneaddrcount=0 AND phonephonecount>0 and ~phonevalflag='0';
export isCode75(STRING1 publish_code) := publish_code ='5';
export isCode76(STRING correctlast) := correctlast <> '';
export isCode77(STRING inLname, STRING inFname) := inLname = '' OR inFname = '';
export isCode78(STRING inStreetAddr) := inStreetAddr = '';
export isCode79(STRING inSSN) := ~(LENGTH(Stringlib.StringFilter(inSSN,'0123456789')) IN [4,9]);
export isCode80(STRING inPhone) := ~(LENGTH(Stringlib.StringFilter(inPhone,'0123456789'))=10);
export isCode81(STRING inDob) := LENGTH(Stringlib.StringFilter(inDob,'0123456789'))<8;	// may need to change this back to 6
export isCode82(STRING nameaddrphone, STRING inPhone, UNSIGNED1 dirsaddr_lastscore) := nameaddrphone <> inPhone AND LENGTH(trim(inPhone))=10 and LENGTH(trim(nameaddrphone))=10;
export isCode83(STRING correctdob) := correctdob <> '';
export isCode84(UNSIGNED2 cmpycount, UNSIGNED2 addrcount, UNSIGNED2 phonecount, string incmpy, string inaddr, string inphone) := (incmpy<>'' and inaddr<>'' and inphone<>'') and
																										((cmpycount>0 and addrcount=0 and phonecount=0) or
																										(cmpycount=0 and addrcount>0 and phonecount=0) or
																										(cmpycount=0 and addrcount=0 and phonecount>0) or
																										(cmpycount=0 and addrcount=0 and phonecount=0));
// Ensure that only RS or IS can be returned, never both.  The following checks for a Randomized Social
SHARED checkRS(STRING inSSN, STRING socsvalflag, STRING socslowissuedate) := TRIM(socslowissuedate) IN ['0', '', '20110625'] AND NOT isCode06(socsvalflag, inSSN) AND LENGTH(TRIM(inSSN)) = 9;
// Because these are being opened up to randomized socials, only return true if the low issue date is not a randomized low issue date
export isCode85(string inSSN, STRING socslowissuedate) := inSSN[1..3] IN ['729','730','731','732','733'] AND TRIM(socslowissuedate) NOT IN ['0', '', '20110625'];
export isCode86(string incmpy, string vercmpy, string bestcmpy) := incmpy!='' and vercmpy='' and bestcmpy<>'';
export isCode87(string10 phone10, string10 CmpyPhoneFromAddr) := phonescore(phone10, cmpyphonefromaddr) < 80;
export isCode88(string orig_cmpy, string orig_dba, string vercmpy) := map(orig_dba=''=> false,
															vercmpy=''=> false,
															(100-(ut.CompanySimilar100(orig_dba, vercmpy))) > (100-(ut.CompanySimilar100(orig_cmpy, vercmpy))) => true,
														    false);  // dba name match on public records
export isCode89(string lowissue, unsigned3 historydate) := ((integer)(risk_indicators.iid_constants.myGetDate(historydate)[1..6]) - (INTEGER)(lowissue[1..6])) < 300 AND
																														~isCode39(lowissue[1..6], historydate) AND IF(lowissue = '20110625',  historydate <= Risk_Indicators.iid_constants.randomSSN3Years, TRUE);
export isCode90(string lowissue, string inDob) := ((INTEGER)(lowissue[1..6]) - (INTEGER)(inDob[1..6])) > 500 AND (INTEGER)(inDob[1..4]) > 1990;

export isCode91(boolean securityFreeze) := securityFreeze;
export isCode92(boolean securityAlert) := securityAlert;
export isCode93(boolean idTheftAlert) := idTheftAlert;
export isCode94(boolean dispute) := dispute;
export isCode95(boolean PreScreenOptOut) := PreScreenOptOut;
export isCode96(boolean correction) := correction;
export isCode97(unsigned criminal_count) := criminal_count > 0;
export isCode98(unsigned lruc, unsigned lhuc) := lruc > 0 or lhuc > 0;	// liens counts
export isCode99(unsigned source_count, boolean isbestmatch) := source_count > 0 and ~isbestmatch;

export isCode9A(unsigned naprop, unsigned naprop2, unsigned naprop3, boolean appowned, boolean familyowned, boolean familysold, boolean appsold, boolean appowned2, boolean familyowned2,
			 boolean familysold2, boolean appsold2, boolean appowned3, boolean familyowned3, boolean familysold3, boolean appsold3, unsigned ownedtotal, unsigned soldtotal, unsigned ambigtotal) :=
				naprop < 2 and naprop2 < 2 and naprop3 < 2 and ~appowned and ~familyowned and ~familysold and ~appsold and ~appowned2 and ~familyowned2 and ~familysold2 and ~appsold2 and 
				~appowned3 and ~familyowned3 and ~familysold3 and ~appsold3 and ownedtotal = 0 and soldtotal = 0 and ambigtotal = 0;
export isCode9B(unsigned naprop, unsigned ownedtotal, unsigned naprop2, unsigned naprop3, unsigned soldtotal) := naprop < 2 and ownedtotal = 0 and (naprop2 > 1 or naprop3 > 1 or soldtotal > 0);
export isCode9C(unsigned datefirstseen, unsigned3 historydate) := ((integer)(risk_indicators.iid_constants.myGetDate(historydate)[1..6]) - datefirstseen) < 100;
export isCode9D(unsigned date1, unsigned date2, unsigned date3, unsigned history_date) :=
	FUNCTION
    year_1 := (integer)((string)date1)[1..4];
    year_2 := (integer)((string)date2)[1..4];
    year_3 := (integer)((string)date3)[1..4];

		sysyear := if(history_date <> 999999, (integer)((string)history_date)[1..4], (integer) (todays_date[1..4]));
		firstseendate := if(year_1 = 0, 10000, year_1);
		lres_yearsb := abs(sysyear - firstseendate);
		lres_years1 := if(lres_yearsb > 1000, -1, if(lres_yearsb > 100, 100, lres_yearsb));

		secondseendate := if(year_2 = 0, 10000, year_2);
		lres_yearsc := abs(firstseendate - secondseendate);
		lres_years2 := if(lres_yearsc > 1000, -1, if(lres_yearsc > 100, 100, lres_yearsc));

		thirdseendate := if(year_3 = 0, 10000, year_3);
		lres_yearsd := abs(secondseendate - thirdseendate);
		lres_years3 := if(lres_yearsd > 1000, -1, if(lres_yearsd > 100, 100, lres_yearsd));		

		a := lres_years1 <> -1;
		b := lres_years2 <> -1;
		c := lres_years3 <> -1;
		total := (integer)a + (integer)b + (integer)c;
		avglres := (if(a, lres_years1, 0) + if(b, lres_years2, 0) + if(c, lres_years3, 0)) / total;
		boolean no_addr_hist := if(date1 = 0 and date2 = 0 and date3 = 0, true, false);
		lres_avg := if((lres_years1 = -1 and lres_years2 = -1 and lres_years3 = -1) or no_addr_hist , false, avglres >= 0 and avglres <= 2);		 
					 
		RETURN lres_avg;
	END;
	
export isCode9E(unsigned source_count, unsigned add1_source_count) := source_count < 3 and add1_source_count < 3;
export isCode9F(unsigned datelastseen1, unsigned datelastseen2, unsigned creditlastseen, unsigned headerlastseen, unsigned3 historydate) := FUNCTION
									sysdate := (integer)(risk_indicators.iid_constants.myGetDate(historydate)[1..6]);
									is9F := datelastseen1<>0 and datelastseen2<>0 and creditlastseen<>0 and headerlastseen<>0 and
													(sysdate - datelastseen1) > 200 and (sysdate - datelastseen2) > 200 and (sysdate - creditlastseen) > 200 and
													(sysdate - headerlastseen) > 200;
									RETURN is9F;
								END;
export isCode9G(unsigned age, string dob, unsigned3 historydate) := age < 23 and dob <> '' and 
																																		((integer)(risk_indicators.iid_constants.myGetDate(historydate)[1..4]) - (integer)(dob[1..4])) < 23;
export isCode9H( unsigned2 num_records ) := num_records > 0;
export isCode9I( integer inferred_age, boolean no_ams, string1 ams_file_type, string1 ams_college_code, string1 ams_college_type, string25 ams_college_name) :=
	inferred_age < 28 AND (no_AMS OR (ams_file_type='M' AND ams_college_code='' AND ams_college_type='' AND ams_college_name=''));
export isCode9J( unsigned3 historydate, unsigned3 header_first_seen, unsigned3 credit_first_seen ) := FUNCTION
	// AgeOldestRecord calculation taken from Models.getRVAttributes
	sysdate := if(historydate <> 999999, (integer)((string)historydate)[1..6], (integer)(todays_date[1..6]));
	subjectFirstSeen := ut.Min2(header_first_seen, credit_first_seen);
	AgeOldestRecord := (string6)min(if(subjectFirstSeen=0, 0, round((ut.DaysApart((string)subjectFirstSeen, (string)sysdate)) / 30)), 960);
	return (integer2)AgeOldestRecord < 14;
end;

export isCode9K( string1 out_addr_type ) := out_addr_type = 'H';


export isCodeA0(string feinmatchcompany, string feinmatchaddr, string bestaddr) := feinmatchcompany != '' and ut.stringsimilar(feinmatchaddr, bestaddr) > 2;
export isCodeA1(string bvi) := (integer)bvi = 0;
export isCodeA2(unsigned2 bankruptcy_count, unsigned2 UnreleasedLienCount) := bankruptcy_count > 0 or UnreleasedLienCount > 0;
export isCodeA3(string bnap, string inCmpy, string inAddr, string inPhone) := (integer)bnap = 0 and inCmpy != '' and inAddr != '' and inPhone != '';
export isCodeA4(unsigned bdid, string goodstandingcode) := goodstandingcode='D' and bdid!=0;
export isCodeA5(boolean lienflag) := lienflag;
export isCodeA6(unsigned bdid, string goodstandingcode) := goodstandingcode='I' and bdid!=0;
export isCodeA7(boolean vernotrecentflag) := vernotrecentflag;
export isCodeA8(string ar2bi, string inFname, string inLname, string inCmpy) := ((INTEGER)ar2bi = 0 ) and inFname != '' and inLname != '' and inCmpy != '';
export isCodeA9( unsigned4 dt_first_seen_min, unsigned3 historydate ) := ((integer)(risk_indicators.iid_constants.myGetDate(historydate)[1..6]) - (INTEGER)((STRING)dt_first_seen_min)[1..6]) < 200;

export isCodeAS(BOOLEAN IsShiptoBilltoDifferent) := IsShiptoBilltoDifferent; 

export isCodeEA(INTEGER email_verification):=email_verification in [0, 1, 2, 3];         

export isCodeEI(UNSIGNED6 DID, unsigned1 socsverlevel, string socsvalid):= DID = Risk_Indicators.iid_constants.EmailFakeIds or
	(socsverlevel in [1,4,6,7,9,10,11,12] and socsvalid not in risk_indicators.iid_constants.set_valid_ssn_codes);         

export isCodeIA(string ipAddr, boolean hit) := ipAddr <> '' and ~hit;

shared setIP_invalid_states := ['WEBTV', 'AOL'];

export isCodeIB(string inState, string ipState, string ipCountry, boolean hit, string secLevDom, string ipType) := 
												inState <> '' and ipState <> '' and trim(StringLib.StringToUpperCase(inState)) <> trim(StringLib.StringToUpperCase(ipState)) 
												and trim(StringLib.StringToUpperCase(ipState)) not in setIP_invalid_states and // suppress IB when the state = webtv or aol.  don't put this logic into IC and ID state check so it thinks IB was already set (don't want to trigger IC, ID either)
												~(ipCountry <> '' and trim(StringLib.StringToUpperCase(ipCountry)) <> 'US') and 				//not IF
												~(hit and trim(secLevDom) = '' and trim(StringLib.StringToUpperCase(ipType)) <> 'RESERVED');	//not IE
export isCodeIC(string5 inZip, string5 ipZip, string ipCountry, boolean hit, string inState, string ipState, string secLevDom, string ipType, string ipAreaCode, string inPhone) := 
												inZip <> '' and ipZip <> '' and inZip <> ipZip and 
												~(inState <> '' and ipState <> '' and trim(StringLib.StringToUpperCase(inState)) <> trim(StringLib.StringToUpperCase(ipState))) and	//not IB
												~(ipCountry <> '' and trim(StringLib.StringToUpperCase(ipCountry)) <> 'US') and 				//not IF
												~(hit and trim(secLevDom) = '' and trim(StringLib.StringToUpperCase(ipType)) <> 'RESERVED') and	//not IE
												~((integer)ipAreaCode <> 0 and inPhone <> '' and ipAreaCode<>inPhone[1..3]);	//not ID
export isCodeID(string ipAreaCode, string inPhone, string inState, string ipState, string ipCountry, string secLevDom, boolean hit, string ipType) := 
												(integer)ipAreaCode <> 0 and inPhone <> '' and  ipAreaCode<>inPhone[1..3] and
												~(inState <> '' and ipState <> '' and trim(StringLib.StringToUpperCase(inState)) <> trim(StringLib.StringToUpperCase(ipState))) and	//not IB
												~(ipCountry <> '' and trim(StringLib.StringToUpperCase(ipCountry)) <> 'US') and 				//not IF
												~(hit and trim(secLevDom) = '' and trim(StringLib.StringToUpperCase(ipType)) <> 'RESERVED');	//not IE
export isCodeIE(boolean hit, string secLevDom, string ipType) := hit and trim(secLevDom) = '' and trim(StringLib.StringToUpperCase(ipType)) <> 'RESERVED';
export isCodeIF(string ipCountry) := trim(StringLib.StringToUpperCase(ipCountry)) <> 'US' and trim(ipCountry) <> '';
export isCodeIG(string ipType) := trim(StringLib.StringToUpperCase(ipType)) = 'RESERVED';										

export isCodeU1(unsigned annual_income, unsigned inc_threshold) := annual_income <= inc_threshold;
export isCodeU2(unsigned employ_months, unsigned emp_threshold) := employ_months <= emp_threshold;

export isCodeWL(STRING watchlist_table, STRING watchlist_record_number) := watchlist_table <> '' AND NOT isCode32(watchlist_table, watchlist_record_number);

export isCodeIB_can(string inState, string ipState, string ipCountry, boolean hit, string secLevDom, string ipType) := 
												inState <> '' and ipState <> '' and trim(StringLib.StringToUpperCase(inState)) <> trim(StringLib.StringToUpperCase(ipState)) and 
												trim(StringLib.StringToUpperCase(ipState)) not in setIP_invalid_states and // suppress IB when the state = webtv or aol.  don't put this logic into IC state check so it thinks IB was already set (don't want to trigger IC either)
												~(ipCountry <> '' and trim(StringLib.StringToUpperCase(ipCountry)) <> 'CA') and 				//not IF
												~(hit and trim(secLevDom) = '' and trim(StringLib.StringToUpperCase(ipType)) <> 'RESERVED');	//not IE
export isCodeIC_can(string5 inZip, string5 ipZip, string ipCountry, boolean hit, string inState, string ipState, string secLevDom, string ipType, string ipAreaCode, string inPhone) := 
												inZip <> '' and ipZip <> '' and trim(StringLib.StringToUpperCase(inZip)) <> trim(StringLib.StringToUpperCase(ipZip)) and 
												~(inState <> '' and ipState <> '' and trim(StringLib.StringToUpperCase(inState)) <> trim(StringLib.StringToUpperCase(ipState))) and	//not IB
												~(ipCountry <> '' and trim(StringLib.StringToUpperCase(ipCountry)) <> 'CA') and 				//not IF
												~(hit and trim(secLevDom) = '' and trim(StringLib.StringToUpperCase(ipType)) <> 'RESERVED');	//not IE
		
export isCodeIH(string ipCountry) := trim(StringLib.StringToUpperCase(ipCountry)) <> 'CA' and trim(ipCountry) <> '';
export isCodePO(string addrtype) := trim(StringLib.StringToUpperCase(addrtype)) = 'P';
export isCodePA(boolean inputAddrNotMostRecent) := inputAddrNotMostRecent;

// the range was extended to include 
// 900-70-0000 through 999-88-9999, 
// 900-90-0000 through 999-92-9999 and 
// 900-94-0000 through 999-99-9999
export isCodeIT(STRING9 inSSN) := 	inSSN[1]='9' and  
	(( (integer)inSSN[4..5] between 70 and 88 ) or
	( (integer)inSSN[4..5] between 90 and 92 ) or
	( (integer)inSSN[4..5] between 94 and 99 ));

export isCodeMI(unsigned adls_per_ssn_seen_18months ) := adls_per_ssn_seen_18months >= 3;


export isCodeEV(unsigned evict_rec_rel, unsigned evict_rec_unrel, unsigned evict_his_rel, unsigned evict_his_unrel ) := evict_rec_rel + evict_rec_unrel + evict_his_rel + evict_his_unrel > 0;
export isCodeMS(unsigned1 ssns_per_adl_seen_18months) := ssns_per_adl_seen_18months>=3;
export isCodeMN(string lowissue, unsigned3 historydate) := ((integer)(risk_indicators.iid_constants.myGetDate(historydate)[1..6]) - (INTEGER)(lowissue[1..6])) < 1700;
export isCodeCR(unsigned1 crim_rel_count) := crim_rel_count > 0;

export isCodeII := isCodeIB;
export isCodeIJ := isCodeIC; // aliases
export isCodeIK := isCodeID;

export isCodePV(string dwelltype, unsigned assessed_amount, Risk_Indicators.Layout_Address_AVM avm, unsigned census_value) := Models.EconCode( dwelltype, assessed_amount, avm, census_value ) = 'F';
export isCodeSR(unsigned1 sec_rangescore) := sec_rangescore < 70;
export isCodeB0 := isCode36; // same logic as rc36, but used for business

export isCodeCO(STRING zipclass) := zipclass = 'U';
export isCodeMO(STRING zipclass) := zipclass = 'M';
export isCodeCZ(string statezipflag, string cityzipflag) := statezipflag='1' or cityzipflag='1';  // if either state or city are mismatch, trigger the code

export isCodeZI(integer zip_score, boolean with25, STRING inAddr, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount) := function
	zip_unverified := zip_score < 100;
	// if ZI reason code is in the same set as 25, don't trigger ZI if 25 is already returned
	zipcheck := if(with25, 
								zip_unverified and ~isCode25(inAddr, combolastcount, comboaddrcount, combohphonecount, combossncount), 
								zip_unverified);
	return zipcheck;
end;
																									
export isCodeDV(boolean dl_searched, boolean dl_exists, string verified_dl) := dl_searched and dl_exists and verified_dl='';
export isCodeDF(boolean dl_searched, boolean dl_exists, string verified_dl, string drlcvalflag) := dl_searched and ~dl_exists and verified_dl='' and drlcvalflag='0';
export isCodeDM(boolean dl_searched, integer dl_score, string verified_dl) := dl_searched and verified_dl<>'' and dl_score < 100;
export isCodeDD(boolean dl_searched, boolean any_dl_found, string verified_dl) := dl_searched and verified_dl='' and any_dl_found;

export isCodeCL(string9 inSSN, string9 bestSSN, unsigned1 socsverlevel, string9 comboSSN) := 	trim(inSSN)<>'' and trim(bestSSN)<>'' and 
																																															socsverlevel in [4,7,9,10,11,12] and 
																																															trim(inSSN) <> trim(bestSSN) and trim(comboSSN) <> trim(bestSSN);

export isCodeFB( string ver_sources ) := 
			models.common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie') = 0
	and models.common.findw_cpp(ver_sources, 'EN' , ' ,', 'ie') = 0
	and models.common.findw_cpp(ver_sources, 'TN' , ' ,', 'ie') = 0
;
export isCodeFQ( unsigned2 inq_count12 ) := inq_count12 > 2;  // changed in Fraudpoint 2.0 release, per Mike and Brent's request.  it was previously being triggered by inq_count > 0, came back too often
export isCodeFR( unsigned1 rel_criminal_count ) := rel_criminal_count > 0;
export isCodeFM( string1 DoNotMail ) := DoNotMail='1';
// this rc is the same as VA, however, CIID wanted a different code/description that what FV was returning.  so, if this reason code changes or if VA changes, look at possibly changing both of them.
export isCodeFV( string1 advo_address_vacancy ) := advo_address_vacancy='Y';

export isCodeRS(STRING inSSN, STRING socsvalflag, STRING socslowissuedate, STRING socsRCISflag) := checkRS(inSSN, socsvalflag, socslowissuedate) AND socsRCISflag <> '1';
export isCodeIS(STRING inSSN, STRING socsvalflag, STRING socslowissuedate, STRING socsRCISflag) := checkRS(inSSN, socsvalflag, socslowissuedate) AND ~isCode85(inSSN, socsRCISflag) AND socsRCISflag = '1';
export isCodeBO(string ver_sources) :=  function
	identity_sources := models.common.zip2(ver_sources, ver_sources);  // put the sources into a dataset
	credit_bureau_sourced := count(identity_sources(str1 in Risk_Indicators.iid_constants.bureau_sources)) > 0;
	non_credit_bureau_sourced := count(identity_sources(str1 not in Risk_Indicators.iid_constants.bureau_sources)) > 0;
	credit_bureau_only := credit_bureau_sourced and not non_credit_bureau_sourced;
	return credit_bureau_only;
end;

export isCodeNB(STRING inDOB, STRING comboDOB) := LENGTH(TRIM(StringLib.StringFilter(inDOB,'0123456789')))>=8 AND TRIM(comboDOB)='';
export isCodeCA(STRING ADVODropIndicator, STRING SIC) := ADVODropIndicator='C' or SIC in risk_indicators.iid_constants.setCRMA;
// this rc is the same as FV, however, CIID wanted a different code/description that what FV was returning.  so, if this reason code changes or if FV changes, look at possibly changing both of them.
export isCodeVA(BOOLEAN ADVOAddressVacancyIndicator) := ADVOAddressVacancyIndicator=TRUE;	
export isCodeSD(STRING inState, STRING bestState) := TRIM(stringlib.stringtolowercase(inState))<>TRIM(stringlib.stringtolowercase(bestState)) AND TRIM(inState)<>'' and TRIM(bestState)<>'';
export isCodeDI(BOOLEAN DIDdeceased) := DIDdeceased=TRUE;
export isCodeNF(BOOLEAN nameSwapped, UNSIGNED DID) := nameSwapped=TRUE AND DID<>0;

//new reason codes for FraudPoint 3
EXPORT isCodeAI(INTEGER iv_unverified_addr_count) := iv_unverified_addr_count > 17;
EXPORT isCodeAR(BOOLEAN truedid, STRING2 assocrisklevel) := truedid and trim(assocrisklevel) >= '7';
EXPORT isCodeBT(INTEGER nf_M_Bureau_ADL_FS_noTU) := nf_M_Bureau_ADL_FS_noTU < 6;
EXPORT isCodeCB(BOOLEAN truedid, STRING2 correlationrisklevel, BOOLEAN reqInputCB) := truedid and trim(correlationrisklevel) >= '7' and reqInputCB;
EXPORT isCodeCC(BOOLEAN truedid, STRING2 componentcharrisklevel) := truedid and trim(componentcharrisklevel) >= '7';
EXPORT isCodeDC(BOOLEAN iv_rv5_deceased) := (boolean)iv_rv5_deceased = true;
EXPORT isCodeDR(BOOLEAN truedid, STRING2 divrisklevel) := truedid and trim(divrisklevel) >= '7';
EXPORT isCodeF0(INTEGER lexID_phone_hi_risk_ct, INTEGER altlexid_phone_hi_risk_ct) := lexid_phone_hi_risk_ct > 0 OR altlexid_phone_hi_risk_ct > 0;
EXPORT isCodeF1(UNSIGNED3 tf_phone_count, UNSIGNED3 cf_phone_count) := tf_phone_count > 0 OR cf_phone_count > 0;
EXPORT isCodeF2(INTEGER lexid_ssn_hi_risk_ct, INTEGER altlexid_ssn_hi_risk_ct) := lexid_ssn_hi_risk_ct > 0 OR altlexid_ssn_hi_risk_ct > 0;
EXPORT isCodeF3(UNSIGNED3 tf_ssn_count, UNSIGNED3 cf_ssn_count) := tf_ssn_count > 0 OR cf_ssn_count > 0;
EXPORT isCodeF4(INTEGER lexid_addr_hi_risk_ct, INTEGER altlexid_addr_hi_risk_ct) := lexid_addr_hi_risk_ct > 0 OR altlexid_addr_hi_risk_ct > 0;
EXPORT isCodeF5(UNSIGNED3 tf_addr_count, UNSIGNED3 cf_addr_count) := tf_addr_count > 0 OR cf_addr_count > 0;
EXPORT isCodeF6(INTEGER hi_risk_ct) := hi_risk_ct > 0;
EXPORT isCodeF7(UNSIGNED3 tf_lexid_count, UNSIGNED3 cf_lexid_count) := tf_lexid_count > 0 OR cf_lexid_count > 0;
EXPORT isCodeHA(BOOLEAN truedid, INTEGER r_C10_M_Hdr_FS_d) := truedid and 0 < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 6;
EXPORT isCodeIR(BOOLEAN truedid, STRING2 identityrisklevel) := truedid and trim(identityrisklevel) >= '7';
EXPORT isCodeMD(INTEGER rv_C16_Inv_SSN_Per_ADL) := rv_C16_Inv_SSN_Per_ADL > 1;
EXPORT isCodePH(STRING10 phone10, STRING10 name_addr_phone, INTEGER1 nap_summary, BOOLEAN firstname, BOOLEAN lastname, BOOLEAN address) := 
				 (length(trim(phone10)) = 10 and name_addr_phone <> phone10 and nap_summary <> 12) or
				 (firstname and length(trim(phone10)) = 10 and nap_summary in [1,2,3,5,6,7,8,11]) or
				 (lastname and length(trim(phone10)) = 10 and nap_summary in [1,2,3,4,5,6,8,10]) or
				 (address and length(trim(phone10)) = 10 and nap_summary in [1,2,3,4,5,7,8,9]);
EXPORT isCodePN(STRING2 Experian_Phone_Verification, INTEGER1 nap_summary, STRING2 Insurance_Phone_Verification, STRING10 phone10) := length(trim(phone10)) = 10 and trim(Experian_Phone_Verification) <> '1'  and nap_summary not in [4,6,7,9,10,11,12] and trim(Insurance_Phone_Verification) <> '4';
EXPORT isCodeQA(STRING1 ssn_length, UNSIGNED2 inquiryPerSSN) := trim(ssn_length) in ['4','9'] and inquiryPerSSN > 10;
EXPORT isCodeQB(STRING1 ssn_length, UNSIGNED2 inquiryADLsPerSSN) := trim(ssn_length) in ['4','9'] and inquiryADLsPerSSN > 1;
EXPORT isCodeQC(STRING1 ssn_length, UNSIGNED2 inquiryLNamesPerSSN) := trim(ssn_length) in ['4','9'] and inquiryLNamesPerSSN > 2;
EXPORT isCodeQD(STRING1 ssn_length, UNSIGNED2 inquiryAddrsPerSSN) := trim(ssn_length) in ['4','9'] and inquiryAddrsPerSSN > 3;
EXPORT isCodeQE(STRING1 ssn_length, UNSIGNED2 inquiryDOBsPerSSN) := trim(ssn_length) in ['4','9'] and inquiryDOBsPerSSN > 1;
EXPORT isCodeQF(BOOLEAN address, UNSIGNED2 inquiryPerAddr) := address and inquiryPerAddr > 10;
EXPORT isCodeQG(BOOLEAN address, UNSIGNED2 inquiryADLsPerAddr) := address and inquiryADLsPerAddr > 5;
EXPORT isCodeQH(BOOLEAN address, UNSIGNED2 inquiryLNamesPerAddr) := address and inquiryLNamesPerAddr > 5;
EXPORT isCodeQI(BOOLEAN address, UNSIGNED2 inquirySSNsPerAddr) := address and inquirySSNsPerAddr > 5;
EXPORT isCodeQJ(BOOLEAN homephone, UNSIGNED2 inquiryPerPhone) := homephone and inquiryPerPhone > 8;
EXPORT isCodeQK(BOOLEAN homephone, UNSIGNED2 inquiryADLsPerPhone) := homephone and inquiryADLsPerPhone > 3;
EXPORT isCodeQL(BOOLEAN truedid, UNSIGNED2 inquiryemailsperadl) := truedid and inquiryemailsperadl > 5;
EXPORT isCodeQM(BOOLEAN email, UNSIGNED2 inquiryADLsPerEmail) := email and inquiryADLsPerEmail > 5;
EXPORT isCodeQN(INTEGER rv_I62_inq_addrs_per_adl) := rv_I62_inq_addrs_per_adl > 3;
EXPORT isCodeQO(INTEGER nf_fp_srchunvrfdaddrcount) := nf_fp_srchunvrfdaddrcount > 1;
EXPORT isCodeQP(INTEGER nf_fp_srchunvrfdphonecount) := nf_fp_srchunvrfdphonecount > 2;
EXPORT isCodeQR(INTEGER nf_fp_vardobcountnew) := nf_fp_vardobcountnew > 1;
EXPORT isCodeRC(BOOLEAN truedid, STRING2 sourcerisklevel) := truedid and trim(sourcerisklevel) >= '7';
EXPORT isCodeRF(BOOLEAN truedid, UNSIGNED1 relative_felony_count) := truedid and relative_felony_count > 1;
EXPORT isCodeSA(BOOLEAN truedid, STRING3 correlationssnaddrcount) := truedid and trim(correlationssnaddrcount) = '0';
EXPORT isCodeSC(BOOLEAN truedid, STRING2 searchcomponentrisklevel) := truedid and trim(searchcomponentrisklevel) >= '7';
EXPORT isCodeSN(BOOLEAN firstname, STRING1 ssn_length, INTEGER1 nas_summary, BOOLEAN lastname, BOOLEAN firstssnmatch, BOOLEAN lastssnmatch) := 
				 (firstname and trim(ssn_length) in  ['4', '9'] and nas_summary in [1,2,3,5,6,7,8,11]) or
				 (lastname and trim(ssn_length) in  ['4', '9'] and nas_summary in [1,2,3,4,5,6,8,10]) or
				 (((firstname and trim(ssn_length) in  ['4', '9'] and ~firstssnmatch) or (lastname and trim(ssn_length) in  ['4', '9'] and ~lastssnmatch)) and nas_summary not in [9,12]);
EXPORT isCodeS1(STRING nf_seg_FraudPoint_3_0) := trim(nf_seg_FraudPoint_3_0) = '1: Stolen/Manip ID';
EXPORT isCodeS2(STRING nf_seg_FraudPoint_3_0) := trim(nf_seg_FraudPoint_3_0) = '2: Synth ID';
EXPORT isCodeS3(STRING nf_seg_FraudPoint_3_0) := trim(nf_seg_FraudPoint_3_0) = '3: Derog';
EXPORT isCodeS4(STRING nf_seg_FraudPoint_3_0) := trim(nf_seg_FraudPoint_3_0) = '4: Recent Activity';
EXPORT isCodeS5(STRING nf_seg_FraudPoint_3_0) := trim(nf_seg_FraudPoint_3_0) = '5: Vuln Vic/Friendly';
EXPORT isCodeVE(BOOLEAN truedid, STRING2 searchvelocityrisklevel) := truedid and trim(searchvelocityrisklevel) >= '7';
EXPORT isCodeVL(BOOLEAN truedid, STRING2 validationrisklevel) := truedid and trim(validationrisklevel) >= '7';
EXPORT isCodeVR(BOOLEAN truedid, STRING2 idverrisklevel) := truedid and trim(idverrisklevel) >= '7';
EXPORT isCodeVV(INTEGER inferred_age) := (0 < inferred_age and inferred_age <= 17) or inferred_age >= 70;
EXPORT isCodeVX(BOOLEAN truedid, STRING2 variationrisklevel) := truedid and trim(variationrisklevel) >= '7';

// Code checks for the Post Beneficiary Fraud product (PBF)
EXPORT isCodePBF000(BOOLEAN nothing_found) := nothing_found;
EXPORT isCodePBF010(UNSIGNED1 UCC_filing_count) := UCC_filing_count > 0;
EXPORT isCodePBF020(UNSIGNED1 bankruptcy_count) := bankruptcy_count > 0;
EXPORT isCodePBF030(UNSIGNED1 liens_judgment_count) := liens_judgment_count > 0;
EXPORT isCodePBF040(STRING1 business_affiliation_exists) := business_affiliation_exists = '1';
EXPORT isCodePBF050(STRING1 professional_license_found) := professional_license_found = '1';
EXPORT isCodePBF060(STRING1 is_incarcerated, STRING1 SOFR_found) :=
         is_incarcerated = '1' OR SOFR_found = '1';
EXPORT isCodePBF070(STRING1 possible_paw) := possible_paw = '1';
EXPORT isCodePBF080(STRING1 addr_high_risk, STRING1 addr_business, STRING1 addr_vacant, STRING1 addr_prison) :=
         addr_high_risk = '1' OR addr_business = '1' OR addr_vacant = '1' OR addr_prison = '1';
EXPORT isCodePBF090(UNSIGNED1 watercraft_count, UNSIGNED1 aircraft_count) :=
         watercraft_count > 0 OR aircraft_count > 0;
EXPORT isCodePBF100(STRING1 MVR_value_greater_than_threshold, STRING1 MVR_owns_commercial) :=
         MVR_value_greater_than_threshold = '1' OR MVR_owns_commercial = '1';
EXPORT isCodePBF110(UNSIGNED1 MVR_number_not_on_application) := MVR_number_not_on_application > 0;
EXPORT isCodePBF120(UNSIGNED1 number_of_real_property) := number_of_real_property > 1;
EXPORT isCodePBF130(STRING1 has_property_not_on_application) := has_property_not_on_application = '1';
EXPORT isCodePBF140(UNSIGNED1 number_of_people_not_on_application) :=
         number_of_people_not_on_application > 0;
EXPORT isCodePBF150(STRING1 is_incarcerated, STRING1 addr_prison) :=
         is_incarcerated = '1' OR addr_prison = '1';
EXPORT isCodePBF160(STRING1 valid_identity) := valid_identity = '0';
EXPORT isCodePBF170(STRING1 DL_out_of_state) := DL_out_of_state = '1';
EXPORT isCodePBF180(STRING2 addr_state, STRING2 benefit_state) := addr_state != benefit_state;
EXPORT isCodePBF190(STRING1 duplicate_entry) := duplicate_entry = '1';
// This is when the input SSN and Address match or just the SSN
EXPORT isCodePBF200(STRING30 matchcode) := matchcode IN ['S', 'SAZC'];
// This is when the input Name and Address match only
EXPORT isCodePBF210(STRING30 matchcode) := matchcode = 'ANZC';
// This is when the input SSN and Name match or the SSN, Name, and Address match 
EXPORT isCodePBF220(STRING30 matchcode) := matchcode IN ['SN', 'ANSZC'];

//WC1 = btst_did_summary = 4 and btst_cbd_inq_ver_cnt = 0;	
EXPORT isCodeOS_O1(unsigned2 btst_did_summary, INTEGER btst_cbd_inq_ver_cnt) := btst_did_summary = 4 and btst_cbd_inq_ver_cnt = 0;
//WC2 = bt_inq_count_day > 3 or st_inq_count_day > 3;	
EXPORT isCodeOS_O2 (INTEGER bt_inq_count_day, INTEGER st_inq_count_day) := bt_inq_count_day > 3 or st_inq_count_day > 3;	
//WC3 = (bt_inq_count_week > 5 or st_inq_count_week > 5) and not WC2;	
EXPORT isCodeOS_O3 (INTEGER bt_inq_count_day, INTEGER st_inq_count_day, INTEGER bt_inq_count_week, INTEGER st_inq_count_week) := ((bt_inq_count_week > 5 or st_inq_count_week > 5) and ((bt_inq_count_day > 3 or st_inq_count_day > 3) = false));
//WC4 = btst_did_summary = 4 and btst_economic_trajectory in (2, 3, 4, 9);	
EXPORT isCodeOS_O4 (unsigned2 btst_did_summary, INTEGER btst_economic_trajectory) := btst_did_summary = 4 and btst_economic_trajectory in [2, 3, 4, 9];			
//WC5 = btst_did_summary = 0;	
EXPORT isCodeOS_O5(unsigned2 btst_did_summary) := btst_did_summary = 0;
//WC6 = btst_did_summary = 1;	
EXPORT isCodeOS_O6(unsigned2 btst_did_summary) := btst_did_summary = 1;
//WC7 = btst_did_summary = 2;	
EXPORT isCodeOS_O7(unsigned2 btst_did_summary) := btst_did_summary = 2;
//for IID CCVI1810_1 chase
EXPORT isCodeVerlast (string verlast) := verlast = '';
EXPORT isCodeVerfirst (string verfirst) := verfirst = '';
END;