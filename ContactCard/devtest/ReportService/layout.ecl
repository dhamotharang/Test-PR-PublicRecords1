IMPORT contactcard;
EXPORT layout := MODULE

  EXPORT request := RECORD
    STRING  addr;
    STRING  addressesperneighbor;
    STRING  addressorigin;
    STRING  agehigh;
    STRING  agelow;
    STRING  allowall;
    STRING  allowdateseen;
    STRING  allowdppa;
    STRING  allowfuzzydobmatch;
    STRING  allowglb;
    STRING  allowheaderquick;
    STRING  allowleadinglname;
    STRING  allownicknames;
    STRING  allowusecnkey;
    STRING  allowwildcard;
    STRING  alwayscompute;
    STRING  anyword1;
    STRING  anyword2;
    STRING  applicationtype;
    STRING  asisname;
    STRING  bdid;
    STRING  blind;
    STRING  bpsleadingnamematch;
    STRING  checknamevariants;
    STRING  city;
    STRING  cleanfmlname;
    STRING  cn;
    STRING  company;
    STRING  companyname;
    STRING  corpname;
    STRING  county;
    STRING  currentbyvendor;
    STRING  currentonly;
    STRING  currentresidentsonly;
    STRING  datapermissionmask;
    STRING  datarestrictionmask;
    STRING  datefirstseen;
    STRING  datelastseen;
    STRING  deathmasterpurpose;
    STRING  democustomername;
    STRING  dialcontactprecision;
    STRING  dialrecordmatch;
    STRING  did;
    STRING  didtypemask;
    STRING  displaymatchedparty;
    STRING  distancethreshold;
    STRING  dlmask;
    STRING  dlstate;
    STRING  dob;
    STRING  dobmask;
    STRING  donotfillblanks;
    STRING  dppapurpose;
    STRING  emailsearchtier;
    STRING  entity2_addr;
    STRING  entity2_bdid;
    STRING  entity2_city;
    STRING  entity2_companyname;
    STRING  entity2_did;
    STRING  entity2_fein;
    STRING  entity2_firstname;
    STRING  entity2_lastname;
    STRING  entity2_middlename;
    STRING  entity2_phone;
    STRING  entity2_ssn;
    STRING  entity2_state;
    STRING  entity2_unparsedfullname;
    STRING  entity2_zip;
    STRING  entity2_zipradius;
    STRING  entrp_month_value;
    STRING  excludedmvpii;
    STRING  excludelessors;
    STRING  excluderesidentsforassociatesaddresses;
    STRING  faresid;
    STRING  fein;
    STRING  firstname;
    STRING  firstword;
    STRING  fname3;
    STRING  fuzzysecrange;
    STRING  glbpurpose;
    STRING  gong_searchtype;
    STRING  groupbyfidtypeonly;
    STRING  household;
    STRING  ignorefares;
    STRING  ignorefidelity;
    STRING  includeakas;
    STRING  includeassociates;
    STRING  includecriminalindicators;
    STRING  includedetails;
    STRING  includeemailaddresses;
    STRING  includehistoricalneighbors;
    STRING  includehri;
    STRING  includeimposters;
    STRING  includeinsurancedrivers;
    STRING  includeminors;
    STRING  includeneighbors;
    STRING  includenondmvsources;
    STRING  includenonsubjectphonelessaddresses;
    STRING  includephonesfeedback;
    STRING  includephonesplus;
    STRING  includephonesplusforrna;
    STRING  includepropertysellerdata;
    STRING  includerelativeaddresses;
    STRING  includerelatives;
    STRING  industryclass;
    STRING  intendeduse;
    STRING  isprp;
    STRING  keepoldssns;
    STRING  lastname;
    STRING  lexidsourceoptout;
    STRING  lfmname;
    STRING  lname;
    STRING  lname4;
    STRING  lnbranded;
    STRING  lookuptype;
    STRING  matchbybuyeraddresses;
    STRING  matchbymailingaddresses;
    STRING  matchbyowneraddresses;
    STRING  matchbypropertyaddresses;
    STRING  matchbyselleraddresses;
    STRING  maxaddresses;
    STRING  maxassociates;
    STRING  maxdaysafter;
    STRING  maxdaysbefore;
    STRING  maxemailresults;
    STRING  maxhriper;
    STRING  maxneighborhoods;
    STRING  maxrelativeaddresses;
    STRING  maxrelatives;
    STRING  maxresults;
    STRING  maxresultsthistime;
    STRING  maxsubjectaddresses;
    STRING  middlename;
    STRING  mileradius;
    STRING  moxievehicles;
    STRING  nameasis;
    STRING  neighborrecency;
    STRING  neighborsperaddress;
    STRING  neighborsperna;
    STRING  neighborsproximityradius;
    STRING  nonexclusion;
    STRING  onlyexactmatches;
    STRING  othercity1;
    STRING  otherlastname1;
    STRING  otherstate1;
    STRING  otherstate2;
    STRING  partytype;
    STRING  penaltthreshold;
    STRING  phone;
    STRING  phonesperaddress;
    STRING  phonesperperson;
    STRING  phoneticdistancematch;
    STRING  phoneticmatch;
    STRING  postalcode;
    STRING  postdir;
    STRING  predir;
    STRING  prim_name;
    STRING  prim_range;
    STRING  primname;
    STRING  primrange;
    STRING  probationoverride;
    STRING  propaddresssearch;
    STRING  randomize;
    STRING  raw;
    STRING  recordbydate;
    STRING  reduceddata;
    STRING  relationship_highconfidenceassociates;
    STRING  relationship_highconfidencerelatives;
    STRING  relationship_rellookbackmonths;
    STRING  relationship_transassocmask;
    STRING  relativedepth;
    STRING  relativefirstname1;
    STRING  relativefirstname2;
    STRING  resellertype;
    STRING  rid;
    STRING  robustnessscoresorting;
    STRING  saltleadthreshold;
    STRING  scorethreshold;
    STRING  searchgoodssnonly;
    STRING  searchignoresaddressonly;
    STRING  sec_range;
    STRING  secrange;
    STRING  seisintadlservice;
    STRING  selectindividually;
    STRING  simplifiedcontactreturn;
    STRING  skiprecords;
    STRING  ssn;
    STRING  ssnmask;
    STRING  ssntypos;
    STRING  st;
    STRING  st_orig;
    STRING  state;
    STRING  statecityzip;
    STRING  street_name;
    STRING  strictmatch;
    STRING  suffix;
    STRING  suppressnonmarketingdeathsources;
    STRING  targetradius;
    STRING  tmsid;
    STRING  twopartysearch;
    STRING  ucc_key;
    STRING  unparsedfullname;
    STRING  useaddresshierarchy;
    STRING  usepropmarshall;
    STRING  usessnfallback;
    STRING  usingkeepssns;
    STRING  xadl2_weight_threshold;
    STRING  z5;
    STRING  zip;
    STRING  zipradius;
 END;




  EXPORT response := RECORD
    contactcard.layouts.result_rec;
  END;

END;
