﻿EXPORT nonfcra_liattributes_v3_layout := RECORD
  string20 seq;
  string30 accountnumber;
  string4 ageoldestrecord;
  string4 agenewestrecord;
  string1 recentupdate;
  string2 srcsconfirmidaddrcount;
  string1 creditbureaurecord;
  string2 invalidssn;
  string2 invalidaddr;
  string2 invalidphone;
  string2 verificationfailure;
  string2 ssnnotfound;
  string2 ssnfoundother;
  string1 verifiedname;
  string2 verifiedssn;
  string2 verifiedphone;
  string2 verifiedphonefullname;
  string2 verifiedphonelastname;
  string2 verifiedaddress;
  string2 verifieddob;
  string3 ageriskindicator;
  string3 subjectssncount;
  string3 subjectaddrcount;
  string3 subjectphonecount;
  string3 subjectssnrecentcount;
  string3 subjectaddrrecentcount;
  string3 subjectphonerecentcount;
  string3 ssnidentitiescount;
  string3 ssnaddrcount;
  string3 ssnidentitiesrecentcount;
  string3 ssnaddrrecentcount;
  string3 inputaddridentitiescount;
  string3 inputaddrssncount;
  string3 inputaddrphonecount;
  string3 inputaddridentitiesrecentcount;
  string3 inputaddrssnrecentcount;
  string3 inputaddrphonerecentcount;
  string3 phoneidentitiescount;
  string3 phoneidentitiesrecentcount;
  string2 phoneother;
  string3 ssnlastnamecount;
  string3 subjectlastnamecount;
  string4 lastnamechangeage;
  string3 lastnamechangecount01;
  string3 lastnamechangecount03;
  string3 lastnamechangecount06;
  string3 lastnamechangecount12;
  string3 lastnamechangecount24;
  string3 lastnamechangecount36;
  string3 lastnamechangecount60;
  string3 sfduaddridentitiescount;
  string3 sfduaddrssncount;
  string2 ssndeceased;
  string8 ssndatedeceased;
  string2 ssnissued;
  string2 ssnrecent;
  string8 ssnlowissuedate;
  string8 ssnhighissuedate;
  string2 ssnissuestate;
  string2 ssnnonus;
  string2 ssnissuedpriordob;
  string2 ssn3years;
  string2 ssnafter5;
  string3 ssnproblems;
  string3 relativescount;
  string3 relativesbankruptcycount;
  string3 relativesfelonycount;
  string3 relativespropownedcount;
  string13 relativespropownedtaxtotal;
  string2 relativesdistanceclosest;
  string4 inputaddrageoldestrecord;
  string4 inputaddragenewestrecord;
  string3 inputaddrlenofres;
  string2 inputaddrdwelltype;
  string2 inputaddrlandusecode;
  string2 inputaddrapplicantowned;
  string2 inputaddrfamilyowned;
  string2 inputaddroccupantowned;
  string4 inputaddragelastsale;
  string10 inputaddrlastsalesprice;
  string2 inputaddrnotprimaryres;
  string2 inputaddractivephonelist;
  string10 inputaddractivephonenumber;
  string10 inputaddrtaxvalue;
  string4 inputaddrtaxyr;
  string10 inputaddrtaxmarketvalue;
  string10 inputaddravmtax;
  string10 inputaddravmsalesprice;
  string10 inputaddravmhedonic;
  string10 inputaddravmvalue;
  string2 inputaddravmconfidence;
  string5 inputaddrcountyindex;
  string5 inputaddrtractindex;
  string5 inputaddrblockindex;
  string10 inputaddrmedianincome;
  string10 inputaddrmedianvalue;
  string3 inputaddrmurderindex;
  string3 inputaddrcartheftindex;
  string3 inputaddrburglaryindex;
  string3 inputaddrcrimeindex;
  string4 curraddrageoldestrecord;
  string4 curraddragenewestrecord;
  string3 curraddrlenofres;
  string2 curraddrdwelltype;
  string2 curraddrlandusecode;
  string2 curraddrapplicantowned;
  string2 curraddrfamilyowned;
  string2 curraddroccupantowned;
  string4 curraddragelastsale;
  string10 curraddrlastsalesprice;
  string2 curraddractivephonelist;
  string10 curraddractivephonenumber;
  string10 curraddrtaxvalue;
  string4 curraddrtaxyr;
  string10 curraddrtaxmarketvalue;
  string10 curraddravmtax;
  string10 curraddravmsalesprice;
  string10 curraddravmhedonic;
  string10 curraddravmvalue;
  string2 curraddravmconfidence;
  string5 curraddrcountyindex;
  string5 curraddrtractindex;
  string5 curraddrblockindex;
  string10 curraddrmedianincome;
  string10 curraddrmedianvalue;
  string3 curraddrmurderindex;
  string3 curraddrcartheftindex;
  string3 curraddrburglaryindex;
  string3 curraddrcrimeindex;
  string4 prevaddrageoldestrecord;
  string4 prevaddragenewestrecord;
  string3 prevaddrlenofres;
  string2 prevaddrdwelltype;
  string2 prevaddrlandusecode;
  string2 prevaddrapplicantowned;
  string2 prevaddrfamilyowned;
  string2 prevaddroccupantowned;
  string4 prevaddragelastsale;
  string10 prevaddrlastsalesprice;
  string2 prevaddractivephonelist;
  string10 prevaddractivephonenumber;
  string10 prevaddrtaxvalue;
  string4 prevaddrtaxyr;
  string10 prevaddrtaxmarketvalue;
  string10 prevaddravmtax;
  string10 prevaddravmsalesprice;
  string10 prevaddravmhedonic;
  string10 prevaddravmvalue;
  string2 prevaddravmconfidence;
  string5 prevaddrcountyindex;
  string5 prevaddrtractindex;
  string5 prevaddrblockindex;
  string10 prevaddrmedianincome;
  string10 prevaddrmedianvalue;
  string3 prevaddrmurderindex;
  string3 prevaddrcartheftindex;
  string3 prevaddrburglaryindex;
  string3 prevaddrcrimeindex;
  string2 inputcurraddrmatch;
  string4 inputcurraddrdistance;
  string2 inputcurraddrstatediff;
  string10 inputcurraddrtaxdiff;
  string11 inputcurraddrincomediff;
  string11 inputcurraddrvaluediff;
  string4 inputcurraddrcrimediff;
  string2 inputcurrecontrajectory;
  string2 inputprevaddrmatch;
  string4 currprevaddrdistance;
  string2 currprevaddrstatediff;
  string10 currprevaddrtaxdiff;
  string11 currprevaddrincomediff;
  string11 currprevaddrvaluediff;
  string4 currprevaddrcrimediff;
  string2 prevcurrecontrajectory;
  string1 educationattendedcollege;
  string2 educationprogram2yr;
  string2 educationprogram4yr;
  string2 educationprogramgraduate;
  string2 educationinstitutionprivate;
  string2 educationinstitutionrating;
  string2 educationfieldofstudytype;
  string1 addrstability;
  string2 statusmostrecent;
  string2 statusprevious;
  string2 statusnextprevious;
  string3 addrchangecount01;
  string3 addrchangecount03;
  string3 addrchangecount06;
  string3 addrchangecount12;
  string3 addrchangecount24;
  string3 addrchangecount36;
  string3 addrchangecount60;
  string6 predictedannualincome;
  string3 propownedcount;
  string13 propownedtaxtotal;
  string3 propownedhistoricalcount;
  string3 propageoldestpurchase;
  string3 propagenewestpurchase;
  string3 propagenewestsale;
  string4 propnewestsalepurchaseindex;
  string3 proppurchasedcount01;
  string3 proppurchasedcount03;
  string3 proppurchasedcount06;
  string3 proppurchasedcount12;
  string3 proppurchasedcount24;
  string3 proppurchasedcount36;
  string3 proppurchasedcount60;
  string3 propsoldcount01;
  string3 propsoldcount03;
  string3 propsoldcount06;
  string3 propsoldcount12;
  string3 propsoldcount24;
  string3 propsoldcount36;
  string3 propsoldcount60;
  string3 watercraftcount;
  string3 watercraftcount01;
  string3 watercraftcount03;
  string3 watercraftcount06;
  string3 watercraftcount12;
  string3 watercraftcount24;
  string3 watercraftcount36;
  string3 watercraftcount60;
  string3 aircraftcount;
  string3 aircraftcount01;
  string3 aircraftcount03;
  string3 aircraftcount06;
  string3 aircraftcount12;
  string3 aircraftcount24;
  string3 aircraftcount36;
  string3 aircraftcount60;
  string1 wealthindex;
  string3 subprimesolicitedcount;
  string3 subprimesolicitedcount01;
  string3 subprimesolicitedcount03;
  string3 subprimesolicitedcount06;
  string3 subprimesolicitedcount12;
  string3 subprimesolicitedcount24;
  string3 subprimesolicitedcount36;
  string3 subprimesolicitedcount60;
  string2 derogseverityindex;
  string3 derogcount;
  string4 derogage;
  string3 felonycount;
  string4 felonyage;
  string3 felonycount01;
  string3 felonycount03;
  string3 felonycount06;
  string3 felonycount12;
  string3 felonycount24;
  string3 felonycount36;
  string3 felonycount60;
  string3 arrestcount;
  string4 arrestage;
  string3 arrestcount01;
  string3 arrestcount03;
  string3 arrestcount06;
  string3 arrestcount12;
  string3 arrestcount24;
  string3 arrestcount36;
  string3 arrestcount60;
  string3 liencount;
  string3 lienfiledcount;
  string4 lienfiledage;
  string3 lienfiledcount01;
  string3 lienfiledcount03;
  string3 lienfiledcount06;
  string3 lienfiledcount12;
  string3 lienfiledcount24;
  string3 lienfiledcount36;
  string3 lienfiledcount60;
  string3 lienreleasedcount;
  string4 lienreleasedage;
  string3 lienreleasedcount01;
  string3 lienreleasedcount03;
  string3 lienreleasedcount06;
  string3 lienreleasedcount12;
  string3 lienreleasedcount24;
  string3 lienreleasedcount36;
  string3 lienreleasedcount60;
  string3 bankruptcycount;
  string4 bankruptcyage;
  string2 bankruptcytype;
  string35 bankruptcystatus;
  string3 bankruptcycount01;
  string3 bankruptcycount03;
  string3 bankruptcycount06;
  string3 bankruptcycount12;
  string3 bankruptcycount24;
  string3 bankruptcycount36;
  string3 bankruptcycount60;
  string3 evictioncount;
  string4 evictionage;
  string3 evictioncount01;
  string3 evictioncount03;
  string3 evictioncount06;
  string3 evictioncount12;
  string3 evictioncount24;
  string3 evictioncount36;
  string3 evictioncount60;
  string3 nonderogcount;
  string3 nonderogcount01;
  string3 nonderogcount03;
  string3 nonderogcount06;
  string3 nonderogcount12;
  string3 nonderogcount24;
  string3 nonderogcount36;
  string3 nonderogcount60;
  string3 profliccount;
  string4 proflicage;
  string2 proflictypecategory;
  string8 proflicexpiredate;
  string3 profliccount01;
  string3 profliccount03;
  string3 profliccount06;
  string3 profliccount12;
  string3 profliccount24;
  string3 profliccount36;
  string3 profliccount60;
  string3 proflicexpirecount01;
  string3 proflicexpirecount03;
  string3 proflicexpirecount06;
  string3 proflicexpirecount12;
  string3 proflicexpirecount24;
  string3 proflicexpirecount36;
  string3 proflicexpirecount60;
  string3 prsearchcollectioncount;
  string3 prsearchcollectioncount01;
  string3 prsearchcollectioncount03;
  string3 prsearchcollectioncount06;
  string3 prsearchcollectioncount12;
  string3 prsearchcollectioncount24;
  string3 prsearchcollectioncount36;
  string3 prsearchcollectioncount60;
  string3 prsearchidvfraudcount;
  string3 prsearchidvfraudcount01;
  string3 prsearchidvfraudcount03;
  string3 prsearchidvfraudcount06;
  string3 prsearchidvfraudcount12;
  string3 prsearchidvfraudcount24;
  string3 prsearchidvfraudcount36;
  string3 prsearchidvfraudcount60;
  string3 prsearchothercount;
  string3 prsearchothercount01;
  string3 prsearchothercount03;
  string3 prsearchothercount06;
  string3 prsearchothercount12;
  string3 prsearchothercount24;
  string3 prsearchothercount36;
  string3 prsearchothercount60;
  string2 inputphonestatus;
  string2 inputphonepager;
  string2 inputphonemobile;
  string2 inputphonetype;
  string2 inputphoneservicetype;
  string2 inputareacodechange;
  string4 phoneedaageoldestrecord;
  string4 phoneedaagenewestrecord;
  string4 phoneotherageoldestrecord;
  string4 phoneotheragenewestrecord;
  string2 invalidphonezip;
  string4 inputphoneaddrdist;
  string6 inputaddrsiccode;
  string2 inputaddrvalidation;
  string5 inputaddrerrorcode;
  string2 inputaddrhighrisk;
  string2 inputphonehighrisk;
  string2 inputaddrprison;
  string2 curraddrprison;
  string2 prevaddrprison;
  string2 historicaladdrprison;
  string2 inputzippobox;
  string2 inputzipcorpmil;
  string1 donotmail;
  string6 historydate;
  unsigned6 did;
  boolean fnamepop;
  boolean lnamepop;
  boolean addrpop;
  string1 ssnlength;
  boolean dobpop;
  boolean emailpop;
  boolean ipaddrpop;
  boolean hphnpop;
 END;
