IMPORT risk_indicators;

//non-ESDL input/output
EXPORT layout := MODULE

  SHARED permissions := RECORD
    string  dppapurpose;
    string  glbpurpose;
    string  datapermissionmask;
    string  datarestrictionmask;
    string  industryclass;
    string  excludedmvpii;
    string  ssnmask;
    string  dlmask;
    string  dobmask;
    string  _transactionid;
    string  _batchuid;
    string  _gcid;
    string  lexidsourceoptout;
  END;

  //taken from query's WU
  //if some of these fields are datasets, or iesp.t_StringArrayItem, etc. they will be initialized incorrectly
  EXPORT request := RECORD(permissions)
    string adl_based_shell;
    string did;
    string  ofacversion;
    // string  gateways; //is initialized by regression framework
    // string  _batchjobid;
    // string  _batchspecid;
    // string  blind;
    // string  _blind;
    string  accountnumber;
    string  historydatetimestamp;
    string  historydateyyyymm;
    string  ssn;
    string  dateofbirth;
    string  age;
    string  homephone;
    string  workphone;
    string  firstname;
    string  middlename;
    string  lastname;
    string  namesuffix;
    string  addr;
    string  streetaddress;
    string  primrange;
    string  predir;
    string  primname;
    string  addrsuffix;
    string  postdir;
    string  unitdesignation;
    string  secrange;
    string  city;
    string  state;
    string  zip;
    string  country;
    string  dlnumber;
    string  dlstate;
    string  email;
    string  ipaddress;
    string  employername;
    string  formername;
    string  bsversion;
    string  includeofac;
    string  includeadditionalwatchlists;
    string  globalwatchlistthreshold;
    string  lastseenthreshold;
    string  __deathmasterpurpose;
    string  instantidarchivingoptin;
    string includescore;
    string leadintegritymode;
    string retaininputdid;
    string turnofftumblings;
    string useingestdate;
    string removefares;
    string excluderelatives;
  END;

  EXPORT request_defaults := request - permissions;

  EXPORT response := risk_indicators.Layout_Boca_Shell - historyDateTimeStamp;

END;
