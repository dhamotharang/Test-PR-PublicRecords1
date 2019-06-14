﻿IMPORT Std;
EXPORT files := MODULE

 WagesRec := RECORD
  string ssn;
  string firstname;
  string middleinit;
  string lastname;
  string industrycode;
  string wageyearqtr;
  integer8 wageamt;
  string empnum;
  string fileyrqtr;
  string insertdate;
  string updatedate;
  string fein;
  string employeraddress;
  string employercity;
  string employerstate;
  string employerzip;
  string employerzip4;
  string wageflag;
  string tradename;
  string employername;
  integer8 succaccount;
  integer8 xferdate;
  string percent;
  string chargecode;
  string ratecode;
  string sutacode;
  unsigned6 employeelexid;
  unsigned2 employee_xadl2_weight;
  unsigned2 employee_xadl2_score;
  unsigned4 employee_xadl2_keys_used;
  unsigned2 employee_xadl2_distance;
  string20 employee_xadl2_matches;
  string employee_xadl2_keys_desc;
  string employee_xadl2_matches_desc;
  integer2 employee_xlink_weight;
  unsigned2 employee_xlink_score;
  integer1 employee_xlink_distance;
  unsigned4 employee_xlink_keys;
  string employee_xlink_keys_desc;
  string60 employee_xlink_matches;
  string employee_xlink_matches_desc;
  string10 addressprimaryrange;
  string2 addresspredirectional;
  string28 addressprimaryname;
  string4 addressaddresssuffix;
  string2 addresspostdirectional;
  string10 addressunitdesignation;
  string8 addresssecondaryrange;
  string25 addresspostalcity;
  string25 addressvanitycity;
  string2 addressstate;
  string5 addresszip;
  string4 addresszip4;
  string2 addressdbpc;
  string1 addresscheckdigit;
  string2 addressrecordtype;
  string5 addresscounty;
  string10 addresslatitude;
  string11 addresslongitude;
  string4 addressmsa;
  string7 addressgeoblock;
  string1 addressgeomatchcode;
  string4 addresserrorstatus;
  boolean addresscachehit;
  boolean addresscleanerhit;
  string addresscleanedaddress;
  string addressinputaddress;
  boolean addressnoaddressinput;
  boolean addressnoaddresscleanererror;
  string addresserrorcodedescription;
  unsigned6 tradeultid;
  unsigned6 tradeorgid;
  unsigned6 tradeseleid;
  unsigned6 tradeproxid;
  unsigned6 tradepowid;
  unsigned6 tradedotid;
  unsigned6 tradeempid;
  unsigned6 tradescore;
  unsigned6 tradeweight;
  unsigned6 employerultid;
  unsigned6 employerorgid;
  unsigned6 employerseleid;
  unsigned6 employerproxid;
  unsigned6 employerpowid;
  unsigned6 employerdotid;
  unsigned6 employerempid;
  unsigned6 employerscore;
  unsigned6 employerweight;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned8 score;
  unsigned8 weight;
  string employeeentitycontextuid;
  string ultentitycontextuid;
  string seleentitycontextuid;
  string proxentitycontextuid;
  unsigned6 wagesrecid;
 END;

 EXPORT Wages := DATASET('~fraudgov::tndata::wages_output', WagesRec, THOR);
 
 TrumpRec := RECORD
  string dummycode;
  string acctno;
  string checkdigit;
  string fedno;
  string cocd;
  string areacd;
  string status;
  string liabcd;
  string datefirstemp;
  string dateliabest;
  string compyr;
  string timelapsecd;
  string ownershipcd;
  string reinstatedate;
  string unitaddeddate;
  string liabtermdate;
  string dateacquired;
  string bkstopcode;
  string bankruptcydate;
  string legalactioncd;
  string letofassessment;
  string statusreceiptdate;
  string acquiredbyacctno;
  string unpaidbalcd;
  string warrantsissued;
  string datewarrantissued;
  string auditdate;
  string fieldrepcd;
  string datepurged;
  string numownssn;
  string ownername1;
  string ownerssn1;
  string ownername2;
  string ownerssn2;
  string ownername3;
  string ownerssn3;
  string reconamt;
  string unpdbalamt;
  string prevchrgamt;
  string ownername;
  string phonenumber;
  string mno;
  string mnosic6;
  string mnoavgwages;
  string flempname;
  string slempname;
  string fltradename;
  string sltradename;
  string flstreetaddr;
  string slstreetaddr;
  string attnof;
  string citystate;
  string zip;
  string altzipcode;
  string country;
  string leaseclientind;
  string aggregateleasingno;
  string leasesic6;
  string leaseavgwages;
  string keyaccount;
  string relatedaccount;
  string accounttype;
  string percent;
  string ratecode;
  string sutacode;
  string transferdate;
  string employertype;
  string annchgadjamt;
  string annpremadjamt;
  string newsic6;
  string sutadumpingind;
  string sutainfractiondate;
  string sutapenaltyenddate;
  string sutabeginyyq;
  string sutaendyyq;
  string oldcumcontrib;
  string cumcontribpaid;
  string cumbenchg;
  string mostcurrtaxpay;
  string annyear;
  string anntaxwages;
  string anncontribpd;
  string annbenchg;
  string reserveratio;
  string rrcode;
  string annyear2;
  string anntaxwages2;
  string anncontribpd2;
  string annbenchg2;
  string reserveratio2;
  string rrcode2;
  string annyear3;
  string anntaxwages3;
  string anncontribpd3;
  string annbenchg3;
  string reserveratio3;
  string rrcode3;
  string annyear4;
  string anntaxwages4;
  string anncontribpd4;
  string annbenchg4;
  string reserveratio4;
  string rrcode4;
  string annyear5;
  string anntaxwages5;
  string anncontribpd5;
  string annbenchg5;
  string reserveratio5;
  string rrcode5;
  string annyear6;
  string anntaxwages6;
  string anncontribpd6;
  string annbenchg6;
  string reserveratio6;
  string rrcode6;
  string qtrsonfile;
  string qtryr;
  string ratecodeqtrinfo;
  string solvencyrate;
  string totalwages;
  string taxablewages;
  string contribdue;
  string duedate;
  string fmoemp;
  string smoemp;
  string tmoemp;
  string penaltycd;
  string nopayrollcd;
  string qtrlyunpdcd;
  string qtrlymagtapecd;
  string jsataxineffect;
  string qtrlyrptind;
  string qtrlysutadumpind;
  string qtrrtnmarker;
  string totchg;
  string delqcode;
  string trans014;
  string qtryr2;
  string ratecodeqtrinfo2;
  string solvencyrate2;
  string totalwages2;
  string taxablewages2;
  string contribdue2;
  string duedate2;
  string fmoemp2;
  string smoemp2;
  string tmoemp2;
  string penaltycd2;
  string nopayrollcd2;
  string qtrlyunpdcd2;
  string qtrlymagtapecd2;
  string jsataxineffect2;
  string qtrlyrptind2;
  string qtrlysutadumpind2;
  string qtrrtnmarker2;
  string totchg2;
  string delqcode2;
  string trans0142;
  string qtryr3;
  string ratecodeqtrinfo3;
  string solvencyrate3;
  string totalwages3;
  string taxablewages3;
  string contribdue3;
  string duedate3;
  string fmoemp3;
  string smoemp3;
  string tmoemp3;
  string penaltycd3;
  string nopayrollcd3;
  string qtrlyunpdcd3;
  string qtrlymagtapecd3;
  string jsataxineffect3;
  string qtrlyrptind3;
  string qtrlysutadumpind3;
  string qtrrtnmarker3;
  string totchg3;
  string delqcode3;
  string trans0143;
  string qtryr4;
  string ratecodeqtrinfo4;
  string solvencyrate4;
  string totalwages4;
  string taxablewages4;
  string contribdue4;
  string duedate4;
  string fmoemp4;
  string smoemp4;
  string tmoemp4;
  string penaltycd4;
  string nopayrollcd4;
  string qtrlyunpdcd4;
  string qtrlymagtapecd4;
  string jsataxineffect4;
  string qtrlyrptind4;
  string qtrlysutadumpind4;
  string qtrrtnmarker4;
  string totchg4;
  string delqcode4;
  string trans0144;
  string qtryr5;
  string ratecodeqtrinfo5;
  string solvencyrate5;
  string totalwages5;
  string taxablewages5;
  string contribdue5;
  string duedate5;
  string fmoemp5;
  string smoemp5;
  string tmoemp5;
  string penaltycd5;
  string nopayrollcd5;
  string qtrlyunpdcd5;
  string qtrlymagtapecd5;
  string jsataxineffect5;
  string qtrlyrptind5;
  string qtrlysutadumpind5;
  string qtrrtnmarker5;
  string totchg5;
  string delqcode5;
  string trans0145;
  string qtryr6;
  string ratecodeqtrinfo6;
  string solvencyrate6;
  string totalwages6;
  string taxablewages6;
  string contribdue6;
  string duedate6;
  string fmoemp6;
  string smoemp6;
  string tmoemp6;
  string penaltycd6;
  string nopayrollcd6;
  string qtrlyunpdcd6;
  string qtrlymagtapecd6;
  string jsataxineffect6;
  string qtrlyrptind6;
  string qtrlysutadumpind6;
  string qtrrtnmarker6;
  string totchg6;
  string delqcode6;
  string trans0146;
  string qtryr7;
  string ratecodeqtrinfo7;
  string solvencyrate7;
  string totalwages7;
  string taxablewages7;
  string contribdue7;
  string duedate7;
  string fmoemp7;
  string smoemp7;
  string tmoemp7;
  string penaltycd7;
  string nopayrollcd7;
  string qtrlyunpdcd7;
  string qtrlymagtapecd7;
  string jsataxineffect7;
  string qtrlyrptind7;
  string qtrlysutadumpind7;
  string qtrrtnmarker7;
  string totchg7;
  string delqcode7;
  string trans0147;
  string qtryr8;
  string ratecodeqtrinfo8;
  string solvencyrate8;
  string totalwages8;
  string taxablewages8;
  string contribdue8;
  string duedate8;
  string fmoemp8;
  string smoemp8;
  string tmoemp8;
  string penaltycd8;
  string nopayrollcd8;
  string qtrlyunpdcd8;
  string qtrlymagtapecd8;
  string jsataxineffect8;
  string qtrlyrptind8;
  string qtrlysutadumpind8;
  string qtrrtnmarker8;
  string totchg8;
  string delqcode8;
  string trans0148;
  string qtryr9;
  string ratecodeqtrinfo9;
  string solvencyrate9;
  string totalwages9;
  string taxablewages9;
  string contribdue9;
  string duedate9;
  string fmoemp9;
  string smoemp9;
  string tmoemp9;
  string penaltycd9;
  string nopayrollcd9;
  string qtrlyunpdcd9;
  string qtrlymagtapecd9;
  string jsataxineffect9;
  string qtrlyrptind9;
  string qtrlysutadumpind9;
  string qtrrtnmarker9;
  string totchg9;
  string delqcode9;
  string trans0149;
  string qtryr10;
  string ratecodeqtrinfo10;
  string solvencyrate10;
  string totalwages10;
  string taxablewages10;
  string contribdue10;
  string duedate10;
  string fmoemp10;
  string smoemp10;
  string tmoemp10;
  string penaltycd10;
  string nopayrollcd10;
  string qtrlyunpdcd10;
  string qtrlymagtapecd10;
  string jsataxineffect10;
  string qtrlyrptind10;
  string qtrlysutadumpind10;
  string qtrrtnmarker10;
  string totchg10;
  string delqcode10;
  string trans01410;
  string qtryr11;
  string ratecodeqtrinfo11;
  string solvencyrate11;
  string totalwages11;
  string taxablewages11;
  string contribdue11;
  string duedate11;
  string fmoemp11;
  string smoemp11;
  string tmoemp11;
  string penaltycd11;
  string nopayrollcd11;
  string qtrlyunpdcd11;
  string qtrlymagtapecd11;
  string jsataxineffect11;
  string qtrlyrptind11;
  string qtrlysutadumpind11;
  string qtrrtnmarker11;
  string totchg11;
  string delqcode11;
  string trans01411;
  string qtryr12;
  string ratecodeqtrinfo12;
  string solvencyrate12;
  string totalwages12;
  string taxablewages12;
  string contribdue12;
  string duedate12;
  string fmoemp12;
  string smoemp12;
  string tmoemp12;
  string penaltycd12;
  string nopayrollcd12;
  string qtrlyunpdcd12;
  string qtrlymagtapecd12;
  string jsataxineffect12;
  string qtrlyrptind12;
  string qtrlysutadumpind12;
  string qtrrtnmarker12;
  string totchg12;
  string delqcode12;
  string trans01412;
  string qtryr13;
  string ratecodeqtrinfo13;
  string solvencyrate13;
  string totalwages13;
  string taxablewages13;
  string contribdue13;
  string duedate13;
  string fmoemp13;
  string smoemp13;
  string tmoemp13;
  string penaltycd13;
  string nopayrollcd13;
  string qtrlyunpdcd13;
  string qtrlymagtapecd13;
  string jsataxineffect13;
  string qtrlyrptind13;
  string qtrlysutadumpind13;
  string qtrrtnmarker13;
  string totchg13;
  string delqcode13;
  string trans01413;
  string qtryr14;
  string ratecodeqtrinfo14;
  string solvencyrate14;
  string totalwages14;
  string taxablewages14;
  string contribdue14;
  string duedate14;
  string fmoemp14;
  string smoemp14;
  string tmoemp14;
  string penaltycd14;
  string nopayrollcd14;
  string qtrlyunpdcd14;
  string qtrlymagtapecd14;
  string jsataxineffect14;
  string qtrlyrptind14;
  string qtrlysutadumpind14;
  string qtrrtnmarker14;
  string totchg14;
  string delqcode14;
  string trans01414;
  string qtryr15;
  string ratecodeqtrinfo15;
  string solvencyrate15;
  string totalwages15;
  string taxablewages15;
  string contribdue15;
  string duedate15;
  string fmoemp15;
  string smoemp15;
  string tmoemp15;
  string penaltycd15;
  string nopayrollcd15;
  string qtrlyunpdcd15;
  string qtrlymagtapecd15;
  string jsataxineffect15;
  string qtrlyrptind15;
  string qtrlysutadumpind15;
  string qtrrtnmarker15;
  string totchg15;
  string delqcode15;
  string trans01415;
  string qtryr16;
  string ratecodeqtrinfo16;
  string solvencyrate16;
  string totalwages16;
  string taxablewages16;
  string contribdue16;
  string duedate16;
  string fmoemp16;
  string smoemp16;
  string tmoemp16;
  string penaltycd16;
  string nopayrollcd16;
  string qtrlyunpdcd16;
  string qtrlymagtapecd16;
  string jsataxineffect16;
  string qtrlyrptind16;
  string qtrlysutadumpind16;
  string qtrrtnmarker16;
  string totchg16;
  string delqcode16;
  string trans01616;
  string qtryr17;
  string ratecodeqtrinfo17;
  string solvencyrate17;
  string totalwages17;
  string taxablewages17;
  string contribdue17;
  string duedate17;
  string fmoemp17;
  string smoemp17;
  string tmoemp17;
  string penaltycd17;
  string nopayrollcd17;
  string qtrlyunpdcd17;
  string qtrlymagtapecd17;
  string jsataxineffect17;
  string qtrlyrptind17;
  string qtrlysutadumpind17;
  string qtrrtnmarker17;
  string totchg17;
  string delqcode17;
  string trans01417;
  string qtryr18;
  string ratecodeqtrinfo18;
  string solvencyrate18;
  string totalwages18;
  string taxablewages18;
  string contribdue18;
  string duedate18;
  string fmoemp18;
  string smoemp18;
  string tmoemp18;
  string penaltycd18;
  string nopayrollcd18;
  string qtrlyunpdcd18;
  string qtrlymagtapecd18;
  string jsataxineffect18;
  string qtrlyrptind18;
  string qtrlysutadumpind18;
  string qtrrtnmarker18;
  string totchg18;
  string delqcode18;
  string trans01418;
  string qtryr19;
  string ratecodeqtrinfo19;
  string solvencyrate19;
  string totalwages19;
  string taxablewages19;
  string contribdue19;
  string duedate19;
  string fmoemp19;
  string smoemp19;
  string tmoemp19;
  string penaltycd19;
  string nopayrollcd19;
  string qtrlyunpdcd19;
  string qtrlymagtapecd19;
  string jsataxineffect19;
  string qtrlyrptind19;
  string qtrlysutadumpind19;
  string qtrrtnmarker19;
  string totchg19;
  string delqcode19;
  string trans01419;
  string qtryr20;
  string ratecodeqtrinfo20;
  string solvencyrate20;
  string totalwages20;
  string taxablewages20;
  string contribdue20;
  string duedate20;
  string fmoemp20;
  string smoemp20;
  string tmoemp20;
  string penaltycd20;
  string nopayrollcd20;
  string qtrlyunpdcd20;
  string qtrlymagtapecd20;
  string jsataxineffect20;
  string qtrlyrptind20;
  string qtrlysutadumpind20;
  string qtrrtnmarker20;
  string totchg20;
  string delqcode20;
  string trans01420;
  string citystatezipconcatenated;
  string10 physicaladdressprimaryrange;
  string2 physicaladdresspredirectional;
  string28 physicaladdressprimaryname;
  string4 physicaladdressaddresssuffix;
  string2 physicaladdresspostdirectional;
  string10 physicaladdressunitdesignation;
  string8 physicaladdresssecondaryrange;
  string25 physicaladdresspostalcity;
  string25 physicaladdressvanitycity;
  string2 physicaladdressstate;
  string5 physicaladdresszip;
  string4 physicaladdresszip4;
  string2 physicaladdressdbpc;
  string1 physicaladdresscheckdigit;
  string2 physicaladdressrecordtype;
  string5 physicaladdresscounty;
  string10 physicaladdresslatitude;
  string11 physicaladdresslongitude;
  string4 physicaladdressmsa;
  string7 physicaladdressgeoblock;
  string1 physicaladdressgeomatchcode;
  string4 physicaladdresserrorstatus;
  boolean physicaladdresscachehit;
  boolean physicaladdresscleanerhit;
  string physicaladdresscleanedaddress;
  string physicaladdressinputaddress;
  boolean physicaladdressnoaddressinput;
  boolean physicaladdressnoaddresscleanererror;
  string physicaladdresserrorcodedescription;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 dotid;
  unsigned6 empid;
  unsigned6 score;
  unsigned6 weight;
  integer1 businessisultinput;
  integer1 businessisseleinput;
  integer1 businessisproxinput;
  string bestultcompanyname;
  string9 bestultfein;
  string10 bestultprimaryrange;
  string2 bestultpredirectional;
  string28 bestultprimaryname;
  string4 bestultaddresssuffix;
  string2 bestultpostdirectional;
  string10 bestultunitdesignation;
  string8 bestultsecondaryrange;
  string25 bestultpostalcity;
  string25 bestultvanitycity;
  string2 bestultstate;
  string5 bestultzip;
  string4 bestultzip4;
  string18 bestultcounty;
  string10 bestultphone;
  integer4 bestultdatefirstseen;
  integer4 bestultdatelastseen;
  unsigned4 bestultincorporationdate;
  string8 bestultsic;
  string6 bestultnaics;
  string bestselecompanyname;
  string9 bestselefein;
  string10 bestseleprimaryrange;
  string2 bestselepredirectional;
  string28 bestseleprimaryname;
  string4 bestseleaddresssuffix;
  string2 bestselepostdirectional;
  string10 bestseleunitdesignation;
  string8 bestselesecondaryrange;
  string25 bestselepostalcity;
  string25 bestselevanitycity;
  string2 bestselestate;
  string5 bestselezip;
  string4 bestselezip4;
  string18 bestselecounty;
  string10 bestselephone;
  integer4 bestseledatefirstseen;
  integer4 bestseledatelastseen;
  unsigned4 bestseleincorporationdate;
  string8 bestselesic;
  string6 bestselenaics;
  boolean bestseleisactive;
  boolean bestseleisdefunct;
  string bestproxcompanyname;
  string9 bestproxfein;
  string10 bestproxprimaryrange;
  string2 bestproxpredirectional;
  string28 bestproxprimaryname;
  string4 bestproxaddresssuffix;
  string2 bestproxpostdirectional;
  string10 bestproxunitdesignation;
  string8 bestproxsecondaryrange;
  string25 bestproxpostalcity;
  string25 bestproxvanitycity;
  string2 bestproxstate;
  string5 bestproxzip;
  string4 bestproxzip4;
  string18 bestproxcounty;
  string10 bestproxphone;
  integer4 bestproxdatefirstseen;
  integer4 bestproxdatelastseen;
  unsigned4 bestproxincorporationdate;
  string8 bestproxsic;
  string6 bestproxnaics;
  string mappininfo;
  integer8 bipattributesisnew;
  integer8 bipattributesinactive;
  integer8 bipattributeshierarchysize;
  string ultentitycontextuid;
  string seleentitycontextuid;
  string proxentitycontextuid;
  unsigned6 bizrecid;
  string1 advohitflag;
  string1 advovacancyindicator;
  string1 advothrowbackindicator;
  string1 advoseasonaldeliveryindicator;
  string5 advoseasonalsuppressionstartdate;
  string5 advoseasonalsuppressionenddate;
  string1 advodonotdeliverindicator;
  string1 advocollegeindicator;
  string10 advocollegesuppressionstartdate;
  string10 advocollegesuppressionenddate;
  string1 advoaddressstyle;
  string5 advosimplifyaddresscount;
  string1 advodropindicator;
  string1 advoresidentialorbusinessindicator;
  string1 advoonlywaytogetmailindicator;
  string1 advorecordtypecode;
  string1 advoaddresstype;
  string1 advoaddressusagetype;
  string8 advofirstseendate;
  string8 advolastseendate;
  string8 advovendorfirstreporteddate;
  string8 advovendorlastreporteddate;
  string8 advovacationbegindate;
  string8 advovacationenddate;
  string8 advonumberofcurrentvacationmonths;
  string8 advomaxvacationmonths;
  string8 advovacationperiodscount;
  integer8 isnotvacantbusinessflag;
  integer8 ispoboxflag;
  string advoresidentialorbusinessindicatordescription;
  string biscorporatekey;
  string biscorporatestate;
  string biscorporateprocessdate;
  string bislegalname;
  string biscorporatefilingdescription;
  string biscorporatestatus;
  string biscorporatestatusdate;
  string biscorporatestatuscomment;
  string biscorporateincorporationdate;
  string biscorporateincorporationstate;
  string biscorporatefederaltaxid;
  string bisorganizationstructuredescription;
  string bisprofitindicator;
  string bisregisteredagentname;
  string bisbiplevel;
  string bisenterprisenumber;
  string bisbusinessdescription;
  string biscompanytype;
  integer8 bisnumberofemployees;
  string bissalesorrevenue;
  integer8 bissales;
  integer8 bisearnings;
  integer8 bisnetworth;
  integer8 bisassets;
  integer8 bisliabilities;
  string bisupdatedate;
  string selestreetaddressconcatenated;
  string selestreetaddresscityconcatenated;
  string bestseleaddressconcatenated;
  string proxstreetaddressconcatenated;
  string proxstreetaddresscityconcatenated;
  string bestproxaddressconcatenated;
  integer8 bisgsahasgsa;
  string bisgsabiplevel;
  integer8 selegsaflag;
  integer8 proxgsaflag;
 END;
 
 EmployerPrep := DATASET('~fraudgov::tndata::ts999_output', TrumpRec, THOR);
 EXPORT Employer := PROJECT(EmployerPrep, 
                      TRANSFORM(RECORDOF(LEFT), 
											// Acctno has some garbage data in it. Some of these are incorrectly getting cast to account numbers. Fix that
											acctno := std.str.CleanSpaces(std.str.FindReplace(LEFT.acctno, '"', '\''));
											SELF.acctno := IF(REGEXFIND('[a-z]', acctno, NOCASE), '', acctno);
											SELF.status := IF(LEFT.status in ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18'], LEFT.status, '');
											SELF.statusreceiptdate := MAP((UNSIGNED)LEFT.statusreceiptdate[5..6] > 20 => '19', '20') + LEFT.statusreceiptdate[5..6] + LEFT.statusreceiptdate[1..2] + LEFT.statusreceiptdate[3..4],
											SELF.datefirstemp := MAP((UNSIGNED)LEFT.datefirstemp[5..6] > 20 => '19', '20') + LEFT.datefirstemp[5..6] + LEFT.datefirstemp[1..2] + LEFT.datefirstemp[3..4],
											SELF.dateliabest := MAP((UNSIGNED)LEFT.dateliabest[5..6] > 20 => '19', '20') + LEFT.dateliabest[5..6] + LEFT.dateliabest[1..2] + LEFT.dateliabest[3..4],
											SELF.liabtermdate := MAP((UNSIGNED)LEFT.liabtermdate[5..6] > 20 => '19', '20') + LEFT.liabtermdate[5..6] + LEFT.liabtermdate[1..2] + LEFT.liabtermdate[3..4],											
											SELF := LEFT)); 
 
 ClaimsRec := RECORD
  string claim_ssn;
  string col_monetary_determination_id;
  integer8 claim_bye_ccyymmdd;
  integer8 claim_eff_ccyymmdd;
  string claim_prog_type;
  string claim_claim_type;
  integer8 claim_submit_ccyymmdd;
  string claim_submit_method;
  string claim_init_add;
  decimal6_2 claim_mba;
  decimal5_2 claim_wba;
  decimal5_2 claim_max_earn_allowed;
  integer8 claim_weeks;
  string claim_sep_emp_name;
  string claim_sep_emp_no; // this joins to trump
  string claim_decision_code;
  string application_id;
  integer8 seperation_date;
  string seperation_reason;
  string claim_status;
  string col_dba;
  string col_company;
  string col_address1;
  string col_address2;
  string col_city;
  string col_state;
  string col_zip;
  string col_mailingaddress1;
  string col_mailingaddress2;
  string col_mailingcity;
  string col_mailingstate;
  string col_mailingzip;
  string col_data_source;
  string claim_type;
  string10 physicaladdressprimaryrange;
  string2 physicaladdresspredirectional;
  string28 physicaladdressprimaryname;
  string4 physicaladdressaddresssuffix;
  string2 physicaladdresspostdirectional;
  string10 physicaladdressunitdesignation;
  string8 physicaladdresssecondaryrange;
  string25 physicaladdresspostalcity;
  string25 physicaladdressvanitycity;
  string2 physicaladdressstate;
  string5 physicaladdresszip;
  string4 physicaladdresszip4;
  string2 physicaladdressdbpc;
  string1 physicaladdresscheckdigit;
  string2 physicaladdressrecordtype;
  string5 physicaladdresscounty;
  string10 physicaladdresslatitude;
  string11 physicaladdresslongitude;
  string4 physicaladdressmsa;
  string7 physicaladdressgeoblock;
  string1 physicaladdressgeomatchcode;
  string4 physicaladdresserrorstatus;
  boolean physicaladdresscachehit;
  boolean physicaladdresscleanerhit;
  string physicaladdresscleanedaddress;
  string physicaladdressinputaddress;
  boolean physicaladdressnoaddressinput;
  boolean physicaladdressnoaddresscleanererror;
  string physicaladdresserrorcodedescription;
  string10 mailingaddressprimaryrange;
  string2 mailingaddresspredirectional;
  string28 mailingaddressprimaryname;
  string4 mailingaddressaddresssuffix;
  string2 mailingaddresspostdirectional;
  string10 mailingaddressunitdesignation;
  string8 mailingaddresssecondaryrange;
  string25 mailingaddresspostalcity;
  string25 mailingaddressvanitycity;
  string2 mailingaddressstate;
  string5 mailingaddresszip;
  string4 mailingaddresszip4;
  string2 mailingaddressdbpc;
  string1 mailingaddresscheckdigit;
  string2 mailingaddressrecordtype;
  string5 mailingaddresscounty;
  string10 mailingaddresslatitude;
  string11 mailingaddresslongitude;
  string4 mailingaddressmsa;
  string7 mailingaddressgeoblock;
  string1 mailingaddressgeomatchcode;
  string4 mailingaddresserrorstatus;
  boolean mailingaddresscachehit;
  boolean mailingaddresscleanerhit;
  string mailingaddresscleanedaddress;
  string mailingaddressinputaddress;
  boolean mailingaddressnoaddressinput;
  boolean mailingaddressnoaddresscleanererror;
  string mailingaddresserrorcodedescription;
  unsigned6 legalphysicalultid;
  unsigned6 legalphysicalorgid;
  unsigned6 legalphysicalseleid;
  unsigned6 legalphysicalproxid;
  unsigned6 legalphysicalpowid;
  unsigned6 legalphysicaldotid;
  unsigned6 legalphysicalempid;
  unsigned6 legalphysicalscore;
  unsigned6 legalphysicalweight;
  unsigned6 legalmailingultid;
  unsigned6 legalmailingorgid;
  unsigned6 legalmailingseleid;
  unsigned6 legalmailingproxid;
  unsigned6 legalmailingpowid;
  unsigned6 legalmailingdotid;
  unsigned6 legalmailingempid;
  unsigned6 legalmailingscore;
  unsigned6 legalmailingweight;
  unsigned6 dbaphysicalultid;
  unsigned6 dbaphysicalorgid;
  unsigned6 dbaphysicalseleid;
  unsigned6 dbaphysicalproxid;
  unsigned6 dbaphysicalpowid;
  unsigned6 dbaphysicaldotid;
  unsigned6 dbaphysicalempid;
  unsigned6 dbaphysicalscore;
  unsigned6 dbaphysicalweight;
  unsigned6 dbamailingultid;
  unsigned6 dbamailingorgid;
  unsigned6 dbamailingseleid;
  unsigned6 dbamailingproxid;
  unsigned6 dbamailingpowid;
  unsigned6 dbamailingdotid;
  unsigned6 dbamailingempid;
  unsigned6 dbamailingscore;
  unsigned6 dbamailingweight;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned8 score;
  unsigned8 weight;
  integer1 businessisultinput;
  integer1 businessisseleinput;
  integer1 businessisproxinput;
  string bestultcompanyname;
  string9 bestultfein;
  string10 bestultprimaryrange;
  string2 bestultpredirectional;
  string28 bestultprimaryname;
  string4 bestultaddresssuffix;
  string2 bestultpostdirectional;
  string10 bestultunitdesignation;
  string8 bestultsecondaryrange;
  string25 bestultpostalcity;
  string25 bestultvanitycity;
  string2 bestultstate;
  string5 bestultzip;
  string4 bestultzip4;
  string18 bestultcounty;
  string10 bestultphone;
  integer4 bestultdatefirstseen;
  integer4 bestultdatelastseen;
  unsigned4 bestultincorporationdate;
  string8 bestultsic;
  string6 bestultnaics;
  string bestselecompanyname;
  string9 bestselefein;
  string10 bestseleprimaryrange;
  string2 bestselepredirectional;
  string28 bestseleprimaryname;
  string4 bestseleaddresssuffix;
  string2 bestselepostdirectional;
  string10 bestseleunitdesignation;
  string8 bestselesecondaryrange;
  string25 bestselepostalcity;
  string25 bestselevanitycity;
  string2 bestselestate;
  string5 bestselezip;
  string4 bestselezip4;
  string18 bestselecounty;
  string10 bestselephone;
  integer4 bestseledatefirstseen;
  integer4 bestseledatelastseen;
  unsigned4 bestseleincorporationdate;
  string8 bestselesic;
  string6 bestselenaics;
  boolean bestseleisactive;
  boolean bestseleisdefunct;
  string bestproxcompanyname;
  string9 bestproxfein;
  string10 bestproxprimaryrange;
  string2 bestproxpredirectional;
  string28 bestproxprimaryname;
  string4 bestproxaddresssuffix;
  string2 bestproxpostdirectional;
  string10 bestproxunitdesignation;
  string8 bestproxsecondaryrange;
  string25 bestproxpostalcity;
  string25 bestproxvanitycity;
  string2 bestproxstate;
  string5 bestproxzip;
  string4 bestproxzip4;
  string18 bestproxcounty;
  string10 bestproxphone;
  integer4 bestproxdatefirstseen;
  integer4 bestproxdatelastseen;
  unsigned4 bestproxincorporationdate;
  string8 bestproxsic;
  string6 bestproxnaics;
  string mappininfo;
  integer8 bipattributesisnew;
  integer8 bipattributesinactive;
  integer8 bipattributeshierarchysize;
  string ultentitycontextuid;
  string seleentitycontextuid;
  string proxentitycontextuid;
  unsigned6 bizrecid;
  string1 advohitflag;
  string1 advovacancyindicator;
  string1 advothrowbackindicator;
  string1 advoseasonaldeliveryindicator;
  string5 advoseasonalsuppressionstartdate;
  string5 advoseasonalsuppressionenddate;
  string1 advodonotdeliverindicator;
  string1 advocollegeindicator;
  string10 advocollegesuppressionstartdate;
  string10 advocollegesuppressionenddate;
  string1 advoaddressstyle;
  string5 advosimplifyaddresscount;
  string1 advodropindicator;
  string1 advoresidentialorbusinessindicator;
  string1 advoonlywaytogetmailindicator;
  string1 advorecordtypecode;
  string1 advoaddresstype;
  string1 advoaddressusagetype;
  string8 advofirstseendate;
  string8 advolastseendate;
  string8 advovendorfirstreporteddate;
  string8 advovendorlastreporteddate;
  string8 advovacationbegindate;
  string8 advovacationenddate;
  string8 advonumberofcurrentvacationmonths;
  string8 advomaxvacationmonths;
  string8 advovacationperiodscount;
  integer8 isnotvacantbusinessflag;
  integer8 ispoboxflag;
  string advoresidentialorbusinessindicatordescription;
  string biscorporatekey;
  string biscorporatestate;
  string biscorporateprocessdate;
  string bislegalname;
  string biscorporatefilingdescription;
  string biscorporatestatus;
  string biscorporatestatusdate;
  string biscorporatestatuscomment;
  string biscorporateincorporationdate;
  string biscorporateincorporationstate;
  string biscorporatefederaltaxid;
  string bisorganizationstructuredescription;
  string bisprofitindicator;
  string bisregisteredagentname;
  string bisbiplevel;
  string bisenterprisenumber;
  string bisbusinessdescription;
  string biscompanytype;
  integer8 bisnumberofemployees;
  string bissalesorrevenue;
  integer8 bissales;
  integer8 bisearnings;
  integer8 bisnetworth;
  integer8 bisassets;
  integer8 bisliabilities;
  string bisupdatedate;
  string selestreetaddressconcatenated;
  string selestreetaddresscityconcatenated;
  string bestseleaddressconcatenated;
  string proxstreetaddressconcatenated;
  string proxstreetaddresscityconcatenated;
  string bestproxaddressconcatenated;
  integer8 bisgsahasgsa;
  string bisgsabiplevel;
  integer8 selegsaflag;
  integer8 proxgsaflag;
 END;
 
 ClaimsBase := DATASET('~fraudgov::tndata::claims_output', ClaimsRec, THOR);
 EXPORT Claims := PROJECT(ClaimsBase, TRANSFORM({RECORDOF(LEFT), UNSIGNED acctno}, SELF.acctno := (UNSIGNED)std.str.CleanSpaces(std.str.FindReplace(LEFT.claim_sep_emp_no, '"', '\'')), SELF.claim_sep_emp_no := std.str.CleanSpaces(std.str.FindReplace(LEFT.claim_sep_emp_no, '"', '\'')), SELF := LEFT)); 
 
 ClaimantsRec := RECORD
  string claimant_ssn;
  string claimant_last_name;
  string claimant_first_name;
  string claimant_mi;
  string claimant_address;
  string claimant_city;
  string claimant_state;
  string claimant_zip;
  integer8 claimant_dob;
  string claimant_fips_code;
  string claimant_fips_x;
  string claimant_phone_nbr;
  string claimant_addr_eff;
  string application_id;
  string claim_status;
  string email;
  string registration_ip;
  string registration_ip_location;
  string recent_ip;
  string recent_ip_location;
  string10 claimantaddressprimaryrange;
  string2 claimantaddresspredirectional;
  string28 claimantaddressprimaryname;
  string4 claimantaddressaddresssuffix;
  string2 claimantaddresspostdirectional;
  string10 claimantaddressunitdesignation;
  string8 claimantaddresssecondaryrange;
  string25 claimantaddresspostalcity;
  string25 claimantaddressvanitycity;
  string2 claimantaddressstate;
  string5 claimantaddresszip;
  string4 claimantaddresszip4;
  string2 claimantaddressdbpc;
  string1 claimantaddresscheckdigit;
  string2 claimantaddressrecordtype;
  string5 claimantaddresscounty;
  string10 claimantaddresslatitude;
  string11 claimantaddresslongitude;
  string4 claimantaddressmsa;
  string7 claimantaddressgeoblock;
  string1 claimantaddressgeomatchcode;
  string4 claimantaddresserrorstatus;
  boolean claimantaddresscachehit;
  boolean claimantaddresscleanerhit;
  string claimantaddresscleanedaddress;
  string claimantaddressinputaddress;
  boolean claimantaddressnoaddressinput;
  boolean claimantaddressnoaddresscleanererror;
  string claimantaddresserrorcodedescription;
  unsigned6 claimantlexid;
  unsigned2 claimant_xadl2_weight;
  unsigned2 claimant_xadl2_score;
  unsigned4 claimant_xadl2_keys_used;
  unsigned2 claimant_xadl2_distance;
  string20 claimant_xadl2_matches;
  string claimant_xadl2_keys_desc;
  string claimant_xadl2_matches_desc;
  integer2 claimant_xlink_weight;
  unsigned2 claimant_xlink_score;
  integer1 claimant_xlink_distance;
  unsigned4 claimant_xlink_keys;
  string claimant_xlink_keys_desc;
  string60 claimant_xlink_matches;
  string claimant_xlink_matches_desc;
  unsigned8 payment_bye_ccyymmdd;
  unsigned8 payment_nbr;
  unsigned8 payment_date;
  unsigned8 payment_cert_date;
  unsigned8 payment_canc_date;
  unsigned8 payment_wed;
  string12 payment_prog;
  decimal6_2 payment_net_amt;
  decimal5_2 payment_wba;
  decimal5_2 payment_child_support;
  decimal5_2 payment_wh_tax_amt;
  decimal5_2 payment_earnings_reported;
  decimal5_2 payment_offset;
  decimal5_2 payment_retirement;
  string75 claimstatus;
  string50 col_pr_direct_deposit_number;
  string75 col_desc;
  decimal19_2 col_pr_payment_amount;
  string1 col_pr_payment_cleared;
  unsigned8 col_pr_unreceived_date;
  unsigned8 col_pr_unreceived_reason;
  unsigned8 col_pr_reissue_date;
  unsigned8 col_banking_error_code;
  unsigned8 col_banking_trace_nbr;
  string1 col_bank_status_flag;
  string50 col_pr_direct_deposit_routing_number;
  unsigned8 col_pr_direct_deposit_account_type;
  unsigned8 col_banking_batch_nbr;
  unsigned8 col_pr_check_seq_payment_id;
  unsigned8 col_pr_id_parent;
  unsigned8 col_pr_payment_status;
  unsigned8 col_paymentcancelledsource;
  unsigned8 col_istransferweek;
  string claimantentitycontextuid;
  unsigned6 claimantrecid;
 END;

 
EXPORT Claimant := DATASET('~fraudgov::tndata::claimants_output', ClaimantsRec, THOR);

END;