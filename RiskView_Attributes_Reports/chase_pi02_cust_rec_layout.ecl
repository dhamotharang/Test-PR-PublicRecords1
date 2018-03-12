﻿export chase_pi02_cust_rec_layout:=RECORD
  string30 account;
  string30 acctno;
  string32 riskwiseid;
  string1 hriskphoneflag;
  string1 phonevalflag;
  string1 phonezipflag;
  string1 hriskaddrflag;
  string1 decsflag;
  string1 socsdobflag;
  string1 socsvalflag;
  string1 drlcvalflag;
  string3 frdriskscore;
  string1 areacodesplitflag;
  string3 altareacode;
  string8 splitdate;
  string1 addrvalflag;
  string1 dwelltypeflag;
  string50 cassaddr;
  string30 casscity;
  string2 cassstate;
  string9 casszip;
  string1 bansflag;
  string1 coaalertflag;
  string15 coafirst;
  string20 coalast;
  string50 coaaddr;
  string30 coacity;
  string2 coastate;
  string9 coazip;
  string1 idtheftflag;
  string1 aptscanflag;
  string1 addrhistoryflag;
  string2 firstcount;
  string2 lastcount;
  string2 formerlastcount;
  string2 addrcount;
  string2 hphonecount;
  string2 wphonecount;
  string2 socscount;
  string2 socsverlevel;
  string2 dobcount;
  string2 drlccount;
  string2 emailcount;
  string2 numelever;
  string2 numsource;
  string15 verfirst;
  string20 verlast;
  string30 vercmpy;
  string50 veraddr;
  string30 vercity;
  string2 verstate;
  string9 verzip;
  string10 verhphone;
  string10 verwphone;
  string9 versocs;
  string8 verdob;
  string20 verdrlc;
  string50 veremail;
  string3 firstscore;
  string3 lastscore;
  string3 cmpyscore;
  string3 addrscore;
  string3 hphonescore;
  string3 wphonescore;
  string3 socsscore;
  string3 dobscore;
  string3 dlnmscore;
  string3 emailscore;
  string1 socsmiskeyflag;
  string1 hphonemiskeyflag;
  string1 addrmiskeyflag;
  string30 hriskcmpy;
  string6 hrisksic;
  string10 hriskphone;
  string50 hriskaddr;
  string30 hriskcity;
  string2 hriskstate;
  string9 hriskzip;
  string4 disthphoneaddr;
  string4 disthphonewphone;
  string4 distwphoneaddr;
  string3 estincome;
  string2 numfraud;
  string15 first;
  string20 last;
  string50 addr;
  string30 city;
  string2 state;
  string9 zip;
  string15 first2;
  string20 last2;
  string50 addr2;
  string30 city2;
  string2 state2;
  string9 zip2;
  string errorcode;
 END;
