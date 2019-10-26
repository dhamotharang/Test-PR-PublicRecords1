IMPORT Std;
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

 EXPORT Wages := DATASET('~fraudgov::tndata::20190701::wages_output', WagesRec, THOR);
 
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
 
 // EmployerPrep := DATASET('~fraudgov::tndata::ts999_output', TrumpRec, THOR); // Old File
 EmployerPrep := DATASET('~fraudgov::tndata::20190701::ts999_output', TrumpRec, THOR);
 EXPORT Employer := PROJECT(EmployerPrep, 
                      TRANSFORM({RECORDOF(LEFT), UNSIGNED uacctno}, 
											// Acctno has some garbage data in it. Some of these are incorrectly getting cast to account numbers. Fix that
											acctno := std.str.CleanSpaces(std.str.FindReplace(LEFT.acctno, '"', '\''));
											SELF.acctno := IF(REGEXFIND('[a-z+ ]', acctno, NOCASE), '0', acctno);
											SELF.uacctno := (UNSIGNED)SELF.acctno; 
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
 
 // ClaimsBase := DATASET('~fraudgov::tndata::claims_output', ClaimsRec, THOR); // Old File
 ClaimsBase := DATASET('~fraudgov::tndata::20190701::claims_output ', ClaimsRec, THOR);
 EXPORT Claims := PROJECT(ClaimsBase, TRANSFORM({RECORDOF(LEFT), UNSIGNED uacctno}, SELF.uacctno := (UNSIGNED)std.str.CleanSpaces(std.str.FindReplace(LEFT.claim_sep_emp_no, '"', '\'')), SELF.claim_sep_emp_no := std.str.CleanSpaces(std.str.FindReplace(LEFT.claim_sep_emp_no, '"', '\'')), SELF := LEFT)); 
 
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
  // unsigned8 payment_bye_ccyymmdd;
  // unsigned8 payment_nbr;
  // unsigned8 payment_date;
  // unsigned8 payment_cert_date;
  // unsigned8 payment_canc_date;
  // unsigned8 payment_wed;
  // string12 payment_prog;
  // decimal6_2 payment_net_amt;
  // decimal5_2 payment_wba;
  // decimal5_2 payment_child_support;
  // decimal5_2 payment_wh_tax_amt;
  // decimal5_2 payment_earnings_reported;
  // decimal5_2 payment_offset;
  // decimal5_2 payment_retirement;
  // string75 claimstatus;
  // string50 col_pr_direct_deposit_number;
  // string75 col_desc;
  // decimal19_2 col_pr_payment_amount;
  // string1 col_pr_payment_cleared;
  // unsigned8 col_pr_unreceived_date;
  // unsigned8 col_pr_unreceived_reason;
  // unsigned8 col_pr_reissue_date;
  // unsigned8 col_banking_error_code;
  // unsigned8 col_banking_trace_nbr;
  // string1 col_bank_status_flag;
  // string50 col_pr_direct_deposit_routing_number;
  // unsigned8 col_pr_direct_deposit_account_type;
  // unsigned8 col_banking_batch_nbr;
  // unsigned8 col_pr_check_seq_payment_id;
  // unsigned8 col_pr_id_parent;
  // unsigned8 col_pr_payment_status;
  // unsigned8 col_paymentcancelledsource;
  // unsigned8 col_istransferweek;
  // string claimantentitycontextuid;
  // unsigned6 claimantrecid;
 END;

 
// EXPORT Claimant := DATASET('~fraudgov::tndata::claimants_output', ClaimantsRec, THOR); //Old File
EXPORT Claimant := DATASET('~fraudgov::tndata::20190701::claimants_output', ClaimantsRec, THOR);

//fakewages

copy_Record :=
  record
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
		// INTEGER uacctno;
		// string qtryr;
		// REAL taxrate;
  end;


copy_Dataset :=
  dataset([
    {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20181', 1866, 832771, '20182', '4/18/2018 8:45:53 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 1875633}/*, 
 //   {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20182', 3466, '832771', '20183', '8/16/2018 10:02:21 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 700109,'0',0,'0'}, 
 //   {'210645975', 'JILL      ', ' ', 'HERBERT        ', '722515', '20174', 2973, '832773', '20191', '2/6/2019 9:32:46 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 53, 100, 34, 26, 'NAME,SSN,SSN4', '1/7/0/7/1/0/0/0/0/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 8088187,'0',0,'0'}, 
 //   {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20181', 3466, '832774', '20184', '8/16/2018 10:02:21 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 700109,'0',0,'0'}, 
 //   {'210645975', 'JILL      ', ' ', 'HERBERT        ', '722515', '20182', 2973, '832774', '20173', '2/6/2019 9:32:46 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 53, 100, 34, 26, 'NAME,SSN,SSN4', '1/7/0/7/1/0/0/0/0/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 8088187,'0',0,'0'}, 
 //   {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20172', 3466, '832775', '20183', '8/16/2018 10:02:21 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 700109,'0',0,'0'}, 
 //   {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20173', 3466, '832775', '20183', '8/16/2018 10:02:21 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 700109,0,0,0}, 
 //   {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20174', 3466, '832775', '20183', '8/16/2018 10:02:21 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 700109,0,0,0}, 
 //   {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20181', 3466, '832775', '20183', '8/16/2018 10:02:21 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 700109,0,0,0}, 
 //   {'210645975', 'JILL      ', ' ', 'HERBERT        ', '722515', '20164', 2973, '832772', '20191', '2/6/2019 9:32:46 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 53, 100, 34, 26, 'NAME,SSN,SSN4', '1/7/0/7/1/0/0/0/0/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 8088187,,,}, 
 //   {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20182', 3466, '832772', '20172', '8/16/2018 10:02:21 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 700109,,,}, 
 //   {'210645975', 'JILL      ', ' ', 'HERBERT        ', '722515', '20184', 2973, '832778', '20191', '2/6/2019 9:32:46 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 53, 100, 34, 26, 'NAME,SSN,SSN4', '1/7/0/7/1/0/0/0/0/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 8088187,0,0,0}, 
    {'210645975', 'JILL      ', 'A', 'HERBERT        ', '722515', '20191', 2973, '832778', '20192', '5/3/2019 9:29:51 PM', '', '271262777', 'PO BOX 496454                                               ', 'PT CHARLOTTE                  ', 'FL', '33949', '     ', '     ', 'DUNKIN DONUTS OF GATLINBURG                                                                         ', 'GATLINBURG DONUTS LLC                                                                               ', 0, 0, '', '', '', '', 1109568951, 0, 0, 0, 0, '                    ', '', '', 55, 100, 33, 26, 'NAME,SSN,SSN4', '1/7/2/7/1/0/0/0/1/7/0/7/7/1/1/1/0/0/0/0/0//5                ', 'FIRSTNAME,MIDDLENAME,LASTNAME,STATE,SSN5,SSN4,MAINNAME,', '          ', '  ', 'PO BOX 496454               ', '    ', '  ', '          ', '        ', 'PT CHARLOTTE             ', 'PORT CHARLOTTE           ', 'FL', '33949', '6454', '54', '4', 'P ', '12015', '26.912405 ', '-82.044072 ', '6580', '0103004', '5', 'S800', true, false, ' PO BOX 496454<BR/>PORT CHARLOTTE, FL 33949-6454', ' PO BOX 496454<BR/>PT CHARLOTTE, FL 33949', false, true, 'No error                                                ', 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, 71926724, 71926724, 71926724, 319247459, 319247459, 0, 0, 100, 69, '_011109568951', '_0271926724', '_0471926724', '_07319247459', 18716111,0,0,0}*/], copy_Record);
 
SHARED FakeWages := PROJECT(copy_Dataset, TRANSFORM(RECORDOF(copy_Record), SELF := LEFT));

EXPORT WagesPrepEmpNum := PROJECT(Wages(employeelexid != 0), 
											 TRANSFORM(RECORDOF(Wages), 
											 // Acctno has some garbage data in it. Some of these are incorrectly getting cast to account numbers. Fix that
											 // empnumclean := std.str.CleanSpaces(std.str.FindReplace(LEFT.empnum, '"', '\''));
											 SELF.empnum := IF(LEFT.empnum[1] = '0' AND LENGTH(LEFT.empnum) > 1, LEFT.empnum[2..],LEFT.empnum), 
											 SELF := LEFT));
											 

// EXPORT EmployeeWagePrep1 := TABLE(/*Wages(employeelexid != 0 and seleid != 0)+*/FakeWages, {ultid, seleid, empnum, employeelexid, wageyearqtr, boolean endperiod := false}, ultid, seleid, empnum, employeelexid, wageyearqtr, MERGE);
EXPORT EmployeeWagePrep1 := TABLE(WagesPrepEmpNum+FakeWages, {empnum, employeelexid, wageyearqtr, boolean endperiod := false}, empnum, employeelexid, wageyearqtr, MERGE);

// distinct list of wage quarters in order, replace with a better version later.
EXPORT FullWageYearQtr := SORT(TABLE(Wages, {UNSIGNED wageyearqtr := (UNSIGNED)wageyearqtr}, wageyearqtr, FEW)+DATASET([{20193}], {UNSIGNED wageyearqtr}), wageyearqtr);

// Employee Wages with the next quarter appended.
EXPORT EmployeeWagePrep2 := JOIN(EmployeeWagePrep1, FullWageYearQtr, (UNSIGNED)LEFT.wageyearqtr < (UNSIGNED)RIGHT.wageyearqtr, 
                       TRANSFORM({RECORDOF(LEFT), UNSIGNED NextWageYearQtr}, SELf.NextWageYearQtr := (UNSIGNED)RIGHT.wageyearqtr, SELF := LEFT),
											 KEEP(1), ALL, HASH);
											 
// Find the actual next quarter for the employee/employer											 
EXPORT EmployeeWagePrep3 := JOIN(EmployeeWagePrep2, EmployeeWagePrep2, LEFT.employeelexid = RIGHT.employeelexid AND LEFT.empnum=RIGHT.empnum AND (UNSIGNED)LEFT.NextWageYearQtr=(UNSIGNED)RIGHT.wageyearqtr, 
                       TRANSFORM(RECORDOF(LEFT), SELF.NextWageYearQtr := MAP(RIGHT.empnum = '0' => (UNSIGNED)LEFT.wageyearqtr, LEFT.NextWageYearQtr), SELF := LEFT),
                       LEFT OUTER, HASH);
											 
// Iterate through the quarters of employment per employee to carry the start date through the quarters
TYPEOF(EmployeeWagePrep3)  T(EmployeeWagePrep3 L, EmployeeWagePrep3 R) := TRANSFORM
  SELF.wageyearqtr := MAP((UNSIGNED)L.WageYearQtr=(UNSIGNED)L.NextWageYearQtr OR L.endperiod=>R.wageyearqtr, L.wageyearqtr);
	SELF.endperiod := (UNSIGNED)R.WageYearQtr=(UNSIGNED)R.NextWageYearQtr;
	//MAP(L.wageyearqtr != '' AND L.wageyearqtr != (STRING)L.NextWageYearQtr => L.wageyearqtr, R.wageyearqtr));
  SELF := R;
END;

EXPORT EmployeeWagePrep4 := ITERATE(SORT(GROUP(SORT(EmployeeWagePrep3, employeelexid, empnum), employeelexid, empnum),employeelexid, empnum, wageyearqtr),T(LEFT,RIGHT));

// dedupe and find the max nextquarter for the end date for the employment period
EXPORT EmployeeWagePrep5 := TABLE(EmployeeWagePrep4, {empnum,employeelexid, startwageyearqtr := wageyearqtr,endwageyearqtr := MAX(GROUP, nextwageyearqtr)}, empnum, employeelexid, wageyearqtr, MERGE)
           (startwageyearqtr != '');
/*
EXPORT EmployeeWagePrep6 := JOIN(EmployeeWagePrep5, NormTaxRate(qtryr != 'NA'), LEFT.empnum = (STRING)RIGHT.uacctno AND (STRING)LEFT.endwageyearqtr = RIGHT.qtryr,
  TRANSFORM({RECORDOF(LEFT), REAL endtaxrate},
    SELF.endtaxrate := RIGHT.taxrate,
		SELF := LEFT));*/
EXPORT EmployeeWagePeriod := EmployeeWagePrep5;

SHARED WagesAssociationsPrep := EmployeeWagePeriod; //TABLE(Wages(employeelexid != 0 and seleid != 0), {ultid, seleid, empnum, employeelexid, wageyearqtr}, ultid, seleid, empnum, employeelexid, wageyearqtr, MERGE);

SHARED WagesSeleAssociation := RECORD
	// UNSIGNED Fromultid;
	// UNSIGNED Toultid;
	// UNSIGNED FromSeleId;
	// UNSIGNED ToSeleId;
	UNSIGNED fromempnum;
	UNSIGNED toempnum;
	UNSIGNED8 employeelexid;
	INTEGER fromstartwageyearqtr;
	INTEGER fromendwageyearqtr;
	INTEGER tostartwageyearqtr;
	INTEGER toendwageyearqtr;
	// REAL fromstarttaxrate;
	// REAL fromendtaxrate;
	// REAL tostarttaxrate;
	// REAL toendtaxrate;
END;
/*
shared fn_QtrDiff(string L, string R) := FUNCTION
		// format 20181, 20194 etc
		
		// Returns true if R is same quarter as L, or one quarter past (ex. 20174 -> 20181)
		lyr := (integer)L[..4];
		lqtr := (integer)L[5..];
		ryr := (integer)R[..4];
		rqtr := (integer)R[5..];
		
		RETURN MAP((lyr = ryr AND lqtr = rqtr) => TRUE, // same year and quarter
							 (lyr = ryr AND (rqtr - lqtr) = 1) => TRUE, // same year, right is one quarter ahead
							 ((ryr - lyr) = 1 AND (rqtr = 1) AND (lqtr = 4)) => TRUE, // right is one year ahead at q1, left is q4
							 FALSE);
END;
*/
EXPORT WagesAssociationsSameQuarter := JOIN(WagesAssociationsPrep, WagesAssociationsPrep, 
                              left.employeelexid=RIGHT.employeelexid AND
															LEFT.empnum != RIGHT.empnum AND
															(UNSIGNED)left.startwageyearqtr = (UNSIGNED)right.startwageyearqtr,
	TRANSFORM(WagesSeleAssociation,
		// SELF.FromUltId := LEFT.ultid,
		// SELF.ToUltid := right.ultid,
		// SELF.FromSeleId := LEFT.seleid,
		// SELF.ToSeleID := RIGHT.seleid,
		SELF.FromEmpnum := (UNSIGNED)LEFT.empnum,
		SELF.ToEmpnum := (UNSIGNED)RIGHT.empnum,
		SELF.fromstartwageyearqtr := (INTEGER)LEFT.startwageyearqtr,
		SELF.fromendwageyearqtr := (INTEGER)LEFT.endwageyearqtr,
		SELF.tostartwageyearqtr := (INTEGER)RIGHT.startwageyearqtr,
		SELF.toendwageyearqtr := (INTEGER)RIGHT.endwageyearqtr,
		// SELF.fromstarttaxrate := LEFT.starttaxrate,
		// SELF.fromendtaxrate := LEFT.endtaxrate,
		// SELF.tostarttaxrate := RIGHT.starttaxrate,
		// SELF.toendtaxrate := RIGHT.endtaxrate,
		SELF := LEFT), LEFT OUTER, HASH);

EXPORT WagesAssociationsDiffQuarter := JOIN(WagesAssociationsPrep, WagesAssociationsPrep, 
                              left.employeelexid=RIGHT.employeelexid AND
															LEFT.empnum != RIGHT.empnum AND
															(UNSIGNED)left.startwageyearqtr < (UNSIGNED)right.startwageyearqtr,
	TRANSFORM(WagesSeleAssociation,
		// SELF.FromUltId := LEFT.ultid,
		// SELF.ToUltid := right.ultid,
		// SELF.FromSeleId := LEFT.seleid,
		// SELF.ToSeleID := RIGHT.seleid,
		SELF.FromEmpnum := (UNSIGNED)LEFT.empnum,
		SELF.ToEmpnum := (UNSIGNED)RIGHT.empnum,
		SELF.fromstartwageyearqtr := (INTEGER)LEFT.startwageyearqtr,
		SELF.fromendwageyearqtr := (INTEGER)LEFT.endwageyearqtr,
		SELF.tostartwageyearqtr := (INTEGER)RIGHT.startwageyearqtr,
		SELF.toendwageyearqtr := (INTEGER)RIGHT.endwageyearqtr,
		// SELF.fromstarttaxrate := LEFT.starttaxrate,
		// SELF.fromendtaxrate := LEFT.endtaxrate,
		// SELF.tostarttaxrate := RIGHT.starttaxrate,
		// SELF.toendtaxrate := RIGHT.endtaxrate,
		SELF := LEFT), HASH);
		
EXPORT WagesAssociationsAllQuarters := WagesAssociationsDiffQuarter + WagesAssociationsSameQuarter(/*MAX(fromstartwageyearqtr) != fromstartwageyearqtr AND */tostartwageyearqtr != 0);
// EXPORT WagesAssociations := WagesAssociationsDiffQuarter + WagesAssociationsSameQuarter;
			
// EXPORT WageAssociationPrep1 := TABLE(WagesAssociationsAllQuarters, {employeelexid,fromempnum,toempnum,mintostartwageyearqtr := MIN(GROUP,tostartwageyearqtr),maxtostartwageyearqtr := MAX(GROUP, tostartwageyearqtr)}, employeelexid,fromempnum, MERGE);
EXPORT WageAssociationPrep1 := TABLE(WagesAssociationsAllQuarters, {employeelexid,toempnum,maxfromendwageyearqtr := MAX(GROUP,fromendwageyearqtr)}, employeelexid,toempnum, MERGE);

EXPORT WageAssociationPrep2 := JOIN(WagesAssociationsAllQuarters,WageAssociationPrep1, LEFT.employeelexid=RIGHT.employeelexid AND LEFT.toempnum = RIGHT.toempnum,HASH);

EXPORT WageAssociationPrep3 := TABLE(WagesAssociationsAllQuarters, {employeelexid,fromempnum,mintostartwageyearqtr := MIN(GROUP,tostartwageyearqtr)}, employeelexid,fromempnum, MERGE);

EXPORT WageAssociationPrep4 := JOIN(WageAssociationPrep2,WageAssociationPrep3, LEFT.employeelexid=RIGHT.employeelexid AND LEFT.fromempnum = RIGHT.fromempnum,HASH);

//Adding Tax Rate to Wages

EXPORT TaxRatePrep1 := TABLE(Employer(uacctno != 0), {uacctno,qtryr1 := qtryr,ratecodeqtrinfo1 := ratecodeqtrinfo,qtryr2,ratecodeqtrinfo2,qtryr3,ratecodeqtrinfo3,qtryr4,ratecodeqtrinfo4,qtryr5,ratecodeqtrinfo5,qtryr6,ratecodeqtrinfo6,qtryr7,ratecodeqtrinfo7,qtryr8,ratecodeqtrinfo8,qtryr9,ratecodeqtrinfo9,qtryr10,ratecodeqtrinfo10,qtryr11,ratecodeqtrinfo11,qtryr12,ratecodeqtrinfo12,qtryr13,ratecodeqtrinfo13,qtryr14,ratecodeqtrinfo14,qtryr15,ratecodeqtrinfo15,qtryr16,ratecodeqtrinfo16,qtryr17,ratecodeqtrinfo17,qtryr18,ratecodeqtrinfo18,qtryr19,ratecodeqtrinfo19,qtryr20,ratecodeqtrinfo20});

OutRec := RECORD

INTEGER uacctno;
STRING qtryr;
REAL taxRate;

END;

OutRec NormIt(TaxRatePrep1 L,INTEGER C) := TRANSFORM
SELF := L;
qtr := CHOOSE(C, L.qtryr1,L.qtryr2,L.qtryr3,L.qtryr4,L.qtryr5,L.qtryr6,L.qtryr7,L.qtryr8,L.qtryr9,L.qtryr10,L.qtryr11,L.qtryr12,L.qtryr13,L.qtryr14,L.qtryr15,L.qtryr16,L.qtryr17,L.qtryr18,L.qtryr19,L.qtryr20);
//Might need to adjust this later
SELF.qtryr := MAP(qtr = 'Z' => 'NA',
                 (integer)qtr[2..] <= 20 => '20' + qtr[2..] + qtr[1],
                                              '19' + qtr[2..] + qtr[1]);
ratecode := CHOOSE(C, L.ratecodeqtrinfo1,L.ratecodeqtrinfo2,L.ratecodeqtrinfo3,L.ratecodeqtrinfo4,L.ratecodeqtrinfo5,L.ratecodeqtrinfo6,L.ratecodeqtrinfo7,L.ratecodeqtrinfo8,L.ratecodeqtrinfo9,L.ratecodeqtrinfo10,L.ratecodeqtrinfo11,L.ratecodeqtrinfo12,L.ratecodeqtrinfo13,L.ratecodeqtrinfo14,L.ratecodeqtrinfo15,L.ratecodeqtrinfo16,L.ratecodeqtrinfo17,L.ratecodeqtrinfo18,L.ratecodeqtrinfo19,L.ratecodeqtrinfo20);
SELF.taxRate := (integer)ratecode[1..4]/100;
END;

shared NormTaxRate := NORMALIZE(TaxRatePrep1,20,NormIt(LEFT,COUNTER));
EXPORT QtrYrTaxRates := NormTaxRate(qtryr != 'NA');
//Wage File with appended tax rate
EXPORT WagesPlusTaxRate := JOIN(WagesPrepEmpNum, NormTaxRate(qtryr != 'NA'), (INTEGER)LEFT.empnum = RIGHT.uacctno AND LEFT.wageyearqtr = RIGHT.qtryr);
//Creating file for wage/empnum/tax rate information - Wage output counts

EXPORT EmployerWageInfo_1 := TABLE(WagesPlusTaxRate,{empnum, tradename, namecount := COUNT(GROUP)},empnum,tradename,MERGE);

EXPORT EmployerWageInfo_2 := DEDUP(SORT(EmployerWageInfo_1,empnum,-namecount),empnum);

EXPORT EmployerWageInfo_3 := TABLE(WagesPlusTaxRate,{empnum,wageyearqtr,taxrate,employeecount := COUNT(GROUP), totalwages := SUM(GROUP,wageamt)},empnum,wageyearqtr, taxrate, MERGE);

SHARED EmployerWageInfoRec := RECORD
	RECORDOF(EmployerWageInfo_3);
	STRING tradename;
END;

EXPORT EmployerWageInfo := JOIN(EmployerWageInfo_3, EmployerWageInfo_2, LEFT.empnum = RIGHT.empnum,
		TRANSFORM(EmployerWageInfoRec,
		SELF.tradename := RIGHT.tradename,
		SELF := LEFT), LEFT OUTER, HASH);
//Finishing adding tax rate information
//Adding fromstarttaxrate
SHARED WagesAssocWithTaxRate_1 := RECORD
	RECORDOF(WageAssociationPrep4);
	STRING fromtradename;
	STRING fromstarttaxrate;

END;

EXPORT WageAssociationPrep5_1 := JOIN(WageAssociationPrep4, EmployerWageInfo, (STRING)LEFT.fromempnum = (STRING)RIGHT.empnum AND (STRING)LEFT.fromstartwageyearqtr = (STRING)RIGHT.wageyearqtr,
		TRANSFORM(WagesAssocWithTaxRate_1,
		SELF.fromtradename := RIGHT.tradename,
		SELF.fromstarttaxrate := IF(RIGHT.empnum = '0' OR RIGHT.empnum = '','',(STRING)RIGHT.taxrate),
		SELF := LEFT), LEFT OUTER, HASH);
//Adding fromendtaxrate
SHARED WagesAssocWithTaxRate_2 := RECORD
	RECORDOF(WageAssociationPrep5_1);
	STRING fromendtaxrate;
END;

EXPORT WageAssociationPrep5_2 := JOIN(WageAssociationPrep5_1, EmployerWageInfo, (STRING)LEFT.fromempnum = (STRING)RIGHT.empnum AND (STRING)LEFT.fromendwageyearqtr = (STRING)RIGHT.wageyearqtr,
		TRANSFORM(WagesAssocWithTaxRate_2,
		SELF.fromendtaxrate := IF(RIGHT.empnum = '0' OR RIGHT.empnum = '','',(STRING)RIGHT.taxrate),
		SELF := LEFT), LEFT OUTER, HASH);
//Adding tostarttaxrate		
SHARED WagesAssocWithTaxRate_3 := RECORD
	RECORDOF(WageAssociationPrep5_2);
	STRING totradename;
	STRING tostarttaxrate;

END;

EXPORT WageAssociationPrep5_3 := JOIN(WageAssociationPrep5_2, EmployerWageInfo, (STRING)LEFT.toempnum = (STRING)RIGHT.empnum AND (STRING)LEFT.tostartwageyearqtr = (STRING)RIGHT.wageyearqtr,
		TRANSFORM(WagesAssocWithTaxRate_3,
		SELF.totradename := RIGHT.tradename,
		SELF.tostarttaxrate := IF(RIGHT.empnum = '0' OR RIGHT.empnum = '','',(STRING)RIGHT.taxrate),
		SELF := LEFT), LEFT OUTER, HASH);
//Adding toendtaxrate		
SHARED WagesAssocWithTaxRate_4 := RECORD
	RECORDOF(WageAssociationPrep5_3);
	STRING toendtaxrate;
	BOOLEAN CleanMovementFlag;
	BOOLEAN PotentialNewEmployerFlag;
END;

EXPORT WageAssociationPrep5_4 := JOIN(WageAssociationPrep5_3, EmployerWageInfo, (STRING)LEFT.toempnum = (STRING)RIGHT.empnum AND (STRING)LEFT.toendwageyearqtr = (STRING)RIGHT.wageyearqtr,
		TRANSFORM(WagesAssocWithTaxRate_4,
		SELF.toendtaxrate := IF(RIGHT.empnum = '0' OR RIGHT.empnum = '','',(STRING)RIGHT.taxrate),
		//Add CleanMovementFlag at End
		SELF.CleanMovementFlag := IF(LEFT.fromstartwageyearqtr < LEFT.tostartwageyearqtr AND LEFT.fromendwageyearqtr <= LEFT.tostartwageyearqtr,1,0),
		//Add PotentialNewEmployerFlag (Only applies to TN)
		SELF.PotentialNewEmployerFlag := IF(LEFT.fromstarttaxrate = '2.7',1,0),
		SELF := LEFT), LEFT OUTER, HASH);


//FinalAssociations
EXPORT WagesAssociations := WageAssociationPrep5_4((fromstartwageyearqtr = fromendwageyearqtr AND fromstartwageyearqtr >= tostartwageyearqtr AND mintostartwageyearqtr = tostartwageyearqtr) OR maxfromendwageyearqtr = fromendwageyearqtr OR tostartwageyearqtr <= fromendwageyearqtr);
END;

