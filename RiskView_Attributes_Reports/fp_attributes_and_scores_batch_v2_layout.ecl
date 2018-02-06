﻿export fp_attributes_and_scores_batch_v2_layout:=RECORD
  string30 accountnumber;
  string2 identityrisklevel;
  string3 identityageoldest;
  string3 identityagenewest;
  string1 identityrecentupdate;
  string3 identityrecordcount;
  string3 identitysourcecount;
  string2 identityageriskindicator;
  string2 idverrisklevel;
  string2 idverssn;
  string1 idvername;
  string2 idveraddress;
  string2 idveraddressnotcurrent;
  string3 idveraddressassoccount;
  string2 idverphone;
  string2 idverdriverslicense;
  string2 idverdob;
  string3 idverssnsourcecount;
  string3 idveraddresssourcecount;
  string3 idverdobsourcecount;
  string2 idverssncreditbureaucount;
  string2 idverssncreditbureaudelete;
  string2 idveraddrcreditbureaucount;
  string2 sourcerisklevel;
  string1 sourcefirstreportingidentity;
  string1 sourcecreditbureau;
  string2 sourcecreditbureaucount;
  string3 sourcecreditbureauageoldest;
  string3 sourcecreditbureauagenewest;
  string3 sourcecreditbureauagechange;
  string1 sourcepublicrecord;
  string3 sourcepublicrecordcount;
  string3 sourcepublicrecordcountyear;
  string1 sourceeducation;
  string1 sourceoccupationallicense;
  string1 sourcevoterregistration;
  string2 sourceonlinedirectory;
  string1 sourcedonotmail;
  string1 sourceaccidents;
  string1 sourcebusinessrecords;
  string1 sourceproperty;
  string1 sourceassets;
  string1 sourcephonedirectoryassistance;
  string1 sourcephonenonpublicdirectory;
  string2 variationrisklevel;
  string3 variationidentitycount;
  string3 variationssncount;
  string3 variationssncountnew;
  string3 variationmsourcesssncount;
  string3 variationmsourcesssnunrelcount;
  string3 variationlastnamecount;
  string3 variationlastnamecountnew;
  string3 variationaddrcountyear;
  string3 variationaddrcountnew;
  string1 variationaddrstability;
  string3 variationaddrchangeage;
  string3 variationdobcount;
  string3 variationdobcountnew;
  string3 variationphonecount;
  string3 variationphonecountnew;
  string3 variationsearchssncount;
  string3 variationsearchaddrcount;
  string3 variationsearchphonecount;
  string2 searchvelocityrisklevel;
  string3 searchcount;
  string3 searchcountyear;
  string3 searchcountmonth;
  string3 searchcountweek;
  string3 searchcountday;
  string3 searchunverifiedssncountyear;
  string3 searchunverifiedaddrcountyear;
  string3 searchunverifieddobcountyear;
  string3 searchunverifiedphonecountyear;
  string3 searchbankingsearchcount;
  string3 searchbankingsearchcountyear;
  string3 searchbankingsearchcountmonth;
  string3 searchbankingsearchcountweek;
  string3 searchbankingsearchcountday;
  string3 searchhighrisksearchcount;
  string3 searchhighrisksearchcountyear;
  string3 searchhighrisksearchcountmonth;
  string3 searchhighrisksearchcountweek;
  string3 searchhighrisksearchcountday;
  string3 searchfraudsearchcount;
  string3 searchfraudsearchcountyear;
  string3 searchfraudsearchcountmonth;
  string3 searchfraudsearchcountweek;
  string3 searchfraudsearchcountday;
  string3 searchlocatesearchcount;
  string3 searchlocatesearchcountyear;
  string3 searchlocatesearchcountmonth;
  string3 searchlocatesearchcountweek;
  string3 searchlocatesearchcountday;
  string2 assocrisklevel;
  string3 assoccount;
  string2 assocdistanceclosest;
  string3 assocsuspicousidentitiescount;
  string3 assoccreditbureauonlycount;
  string3 assoccreditbureauonlycountnew;
  string3 assoccreditbureauonlycountmonth;
  string3 assochighrisktopologycount;
  string2 validationrisklevel;
  string2 validationssnproblems;
  string2 validationaddrproblems;
  string2 validationphoneproblems;
  string2 validationdlproblems;
  string2 validationipproblems;
  string2 correlationrisklevel;
  string3 correlationssnnamecount;
  string3 correlationssnaddrcount;
  string3 correlationaddrnamecount;
  string3 correlationaddrphonecount;
  string3 correlationphonelastnamecount;
  string2 divrisklevel;
  string3 divssnidentitycount;
  string3 divssnidentitycountnew;
  string3 divssnidentitymsourcecount;
  string3 divssnidentitymsourceurelcount;
  string3 divssnlnamecount;
  string3 divssnlnamecountnew;
  string3 divssnaddrcount;
  string3 divssnaddrcountnew;
  string3 divssnaddrmsourcecount;
  string3 divaddridentitycount;
  string3 divaddridentitycountnew;
  string3 divaddridentitymsourcecount;
  string3 divaddrsuspidentitycountnew;
  string3 divaddrssncount;
  string3 divaddrssncountnew;
  string3 divaddrssnmsourcecount;
  string3 divaddrphonecount;
  string3 divaddrphonecountnew;
  string3 divaddrphonemsourcecount;
  string3 divphoneidentitycount;
  string3 divphoneidentitycountnew;
  string3 divphoneidentitymsourcecount;
  string3 divphoneaddrcount;
  string3 divphoneaddrcountnew;
  string3 divsearchssnidentitycount;
  string3 divsearchaddridentitycount;
  string3 divsearchaddrsuspidentitycount;
  string3 divsearchphoneidentitycount;
  string2 searchcomponentrisklevel;
  string3 searchssnsearchcount;
  string3 searchssnsearchcountyear;
  string3 searchssnsearchcountmonth;
  string3 searchssnsearchcountweek;
  string3 searchssnsearchcountday;
  string3 searchaddrsearchcount;
  string3 searchaddrsearchcountyear;
  string3 searchaddrsearchcountmonth;
  string3 searchaddrsearchcountweek;
  string3 searchaddrsearchcountday;
  string3 searchphonesearchcount;
  string3 searchphonesearchcountyear;
  string3 searchphonesearchcountmonth;
  string3 searchphonesearchcountweek;
  string3 searchphonesearchcountday;
  string2 componentcharrisklevel;
  string3 ssnhighissueage;
  string3 ssnlowissueage;
  string2 ssnissuestate;
  string2 ssnnonus;
  string2 inputphonetype;
  string2 ipstate;
  string2 ipcountry;
  string2 ipcontinent;
  string3 inputaddrageoldest;
  string3 inputaddragenewest;
  string2 inputaddrtype;
  string3 inputaddrlenofres;
  string2 inputaddrdwelltype;
  string2 inputaddrdelivery;
  string2 inputaddractivephonelist;
  string2 inputaddroccupantowned;
  string3 inputaddrbusinesscount;
  string3 inputaddrnbrhdbusinesscount;
  string3 inputaddrnbrhdsinglefamilycount;
  string3 inputaddrnbrhdmultifamilycount;
  string10 inputaddrnbrhdmedianincome;
  string10 inputaddrnbrhdmedianvalue;
  string3 inputaddrnbrhdmurderindex;
  string3 inputaddrnbrhdcartheftindex;
  string3 inputaddrnbrhdburglaryindex;
  string3 inputaddrnbrhdcrimeindex;
  string3 inputaddrnbrhdmobilityindex;
  string3 inputaddrnbrhdvacantpropcount;
  string4 addrchangedistance;
  string2 addrchangestatediff;
  string11 addrchangeincomediff;
  string11 addrchangevaluediff;
  string4 addrchangecrimediff;
  string2 addrchangeecontrajectory;
  string2 addrchangeecontrajectoryindex;
  string3 curraddrageoldest;
  string3 curraddragenewest;
  string3 curraddrlenofres;
  string2 curraddrdwelltype;
  string2 curraddrstatus;
  string2 curraddractivephonelist;
  string10 curraddrmedianincome;
  string10 curraddrmedianvalue;
  string3 curraddrmurderindex;
  string3 curraddrcartheftindex;
  string3 curraddrburglaryindex;
  string3 curraddrcrimeindex;
  string3 prevaddrageoldest;
  string3 prevaddragenewest;
  string3 prevaddrlenofres;
  string2 prevaddrdwelltype;
  string2 prevaddrstatus;
  string2 prevaddroccupantowned;
  string10 prevaddrmedianincome;
  string10 prevaddrmedianvalue;
  string3 prevaddrmurderindex;
  string3 prevaddrcartheftindex;
  string3 prevaddrburglaryindex;
  string3 prevaddrcrimeindex;
  string3 fp_score;
  string3 fp_reason;
  string3 fp_reason2;
  string3 fp_reason3;
  string3 fp_reason4;
  string3 fp_reason5;
  string3 fp_reason6;
  string1 stolenidentityindex;
  string1 syntheticidentityindex;
  string1 manipulatedidentityindex;
  string1 vulnerablevictimindex;
  string1 friendlyfraudindex;
  string1 suspiciousactivityindex;
  string6 historydate;
  string200 errorcode;
 END;
