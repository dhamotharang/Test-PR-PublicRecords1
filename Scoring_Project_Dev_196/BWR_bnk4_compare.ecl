import risk_indicators, ut, ashirey;

eyeball := 25;

input_layout := RECORD
  string30 acctno;
  string30 account;
  string32 riskwiseid;
  string1 firstcount;
  string1 lastcount;
  string1 addrcount;
  string1 phonecount;
  string1 socscount;
  string2 socsverlevel;
  string1 dobcount;
  string1 drlccount;
  string1 cmpycount;
  string1 cmpyaddrcount;
  string1 cmpyphonecount;
  string1 fincount;
  string1 emailcount;
  string15 verfirst;
  string20 verlast;
  string50 veraddr;
  string30 vercity;
  string2 verstate;
  string9 verzip;
  string10 verhphone;
  string9 versocs;
  string20 verdrlc;
  string8 verdob;
  string30 vercmpy;
  string50 vercmpyaddr;
  string30 vercmpycity;
  string2 vercmpystate;
  string9 vercmpyzip;
  string10 vercmpyphone;
  string20 verfin;
  string1 numelever;
  string2 numsource;
  string2 numcmpyelever;
  string2 numcmpysource;
  string3 firstscore;
  string3 lastscore;
  string3 cmpyscore;
  string3 addrscore;
  string3 phonescore;
  string3 socscore;
  string3 dobscore;
  string3 drlcscore;
  string3 cmpyscore2;
  string3 cmpyaddrscore;
  string3 cmpyphonescore;
  string3 finscore;
  string3 emailscore;
  string30 wphonename;
  string50 wphoneaddr;
  string30 wphonecity;
  string2 wphonestate;
  string9 wphonezip;
  string1 socsmiskeyflag;
  string1 phonemiskeyflag;
  string1 addrmiskeyflag;
  string1 idtheftflag;
  string1 hphonetypeflag;
  string2 hphonesrvc;
  string1 hphone2addrtypeflag;
  string1 hphone2typeflag;
  string1 wphonetypeflag;
  string2 wphonesrvc;
  string1 areacodesplitflag;
  string3 altareacode;
  string1 phonezipflag;
  string3 socsdob;
  string1 hhriskphoneflag;
  string30 hriskcmpy;
  string6 sic;
  string1 zipclassflag;
  string28 zipname;
  string6 medincome;
  string1 addrriskflag;
  string1 bansflag;
  string10 bansdatefiled;
  string1 addrvalflag;
  string5 addrreason;
  string4 lowissue;
  string1 dwelltypeflag;
  string1 phonedissflag;
  string3 ecovariables;
  string4 tcifull;
  string4 tcilast;
  string4 tciaddr;
  string errorcode;
 END;
 
basefilename := '~nkoubsky::out::chase_bnk4_batch_dev192_w20140120-125134';
testfilename := '~nkoubsky::out::chase_bnk4_batch_dev192_w20140120-142436';  

ds_baseline := dataset(basefilename,input_layout, csv(quote('"'), maxlength(32000))) : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout, csv(quote('"'), maxlength(32000))) : PERSIST('nkoubsky::persist::RVA40114');


cmpr := record, maxlength(50000)
	DATASET(input_layout) res;
end;

blank := DATASET(1, TRANSFORM(input_layout, SELF.acctno := '-', SELF := []));

clean_baseline := join(ds_baseline, ds_new, left.acctno = right.acctno
					AND LEFT.errorcode + RIGHT.errorcode = '',
					TRANSFORM(input_layout, SELF := LEFT));

clean_second := join(ds_baseline, ds_new, left.acctno = right.acctno
					AND LEFT.errorcode + RIGHT.errorcode = '',
					TRANSFORM(input_layout, SELF := RIGHT));
					
// j1 := join(clean_baseline, clean_second, left.acctno = right.acctno
					// AND LEFT.seq <> RIGHT.seq
					// AND LEFT <> RIGHT,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

ashirey.Diff(ds_baseline, ds_new, ['acctno'], j1, 'BNK4' );

// j2 := join(clean_baseline, clean_second, left.acctno = right.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

OUTPUT(CHOOSEN(clean_baseline,eyeball));
OUTPUT(COUNT(clean_baseline), NAMED('base_count'));
OUTPUT(CHOOSEN(clean_second,eyeball));
OUTPUT(COUNT(clean_second), NAMED('second_count'));

// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
OUTPUT(count(j1), NAMED('difference_count'));
OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
// OUTPUT(count(j2), NAMED('valid_to_optout_count'));
OUTPUT(CHOOSEN(j1, 25), named('differences'));