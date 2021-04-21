IMPORT location_services;

EXPORT layout := MODULE

  //fields as they appear in query's WU
  SHARED permissions := RECORD
    string  applicationtype;
    string  dppapurpose;
    string  glbpurpose;
    string  datapermissionmask;
    string  DataRestrictionMask;
    string  industryclass;
    string  excludedmvpii;
    string  ssnmask;
    string  dlmask;
    string  dobmask;
    string  intendeduse;
    string  ignorefares;
    string  ignorefidelity;
    string  lnbranded;
    string  includeminors;
    string  probationoverride;
    string  deathmasterpurpose;
  END;

  //fields as they appear in query's WU
  EXPORT request := RECORD (permissions)
    string allowheaderquick;
    string apn;
    string streetaddress;
    string city;
    string State;
    string zip;
    string fipscounty;
    string includeavm;
    string includeassignmentsandreleases;
    string usingkeepssns;
    string keepoldssns;
    string suppressnonmarketingdeathsources;
    string lexidsourceoptout;
    string raw;
    string didtypemask;
    string companyname;
    string firstword;
    string anyword1;
    string anyword2;
    string prim_range;
    string primrange;
    string isprp;
    string addr;
    string addressorigin;
    string statecityzip;
    string z5;
    string postalcode;
    string prim_name;
    string primname;
    string street_name;
    string st;
    string st_orig;
    string onlyexactmatches;
    string strictmatch;
    string zipradius;
    string mileradius;
    string county;
    string suffix;
    string allowusecnkey;
    string firstname;
    string unparsedfullname;
    string nameasis;
    string asisname;
    string lfmname;
    string cleanfmlname;
    string phoneticmatch;
    string lname;
    string lastname;
    string middlename;
    string phone;
    string sec_range;
    string secrange;
    string scorethreshold;
  END;

  EXPORT request_defaults := request - permissions;

  EXPORT response := location_services.layout_PropHistory_out;

END;
