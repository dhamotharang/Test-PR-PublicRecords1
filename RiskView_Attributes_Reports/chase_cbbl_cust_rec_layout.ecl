﻿export chase_cbbl_cust_rec_layout:=RECORD
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

