IMPORT doxie;
EXPORT layout := MODULE

  EXPORT request := RECORD
    string applicationtype;
    string datapermissionmask;
    string datarestrictionmask;
    string dppapurpose;
    string glbpurpose;
    string industryclass;
    string industrytype;
    string deathmasterpurpose;
    string ssnmask;
    string did;
    string ssn;
    string unparsedfullname;
    string firstname;
    string middlename;
    string lastname;
    //string namesuffix;
    string otherlastname1;
    string allownicknames;
    string addr;
    string fuzzysecrange;
    string primrange;
    string predir;
    string primname;
    string postdir;
    string secrange;
    string city;
    string othercity1;
    string zip;
    string zipradius;
    string county;
    string state;
    string otherstate1;
    string otherstate2;
    string dob;
    string agelow;
    string agehigh;
    string phone;
    string relativefirstname1;
    string relativefirstname2;
    string addresslimit;
    string allowdateseen;
    string allowheaderquick;
    string allowwildcard;
    string batchaccount;
    string batchfriendly;
    string bestonly;
    string currentonly;
    string currentresidentonly;
    string datefirstseen;
    string datelastseen;
    string dialbouncedistance;
    string dialcontactprecision;
    string dialrecordmatch;
    string didonly; 
    //string didtypemask; // if included, no response
    string distancethreshold;
    string dlnumber;
    string dlstate;
    string donotfillblanks;
    string ecl_negatetruedefaults;
    string excluddmvpii;
    string globalcompanyid;
    string groupbydid;
    string household;
    string keepoldssns;
    string lnbranded;
    string lookuptype;
    string maxhriper;
    string nolookupsearch;
    string nonexclusion;
    string phoneticdistancematch;
    string phoneticmatch;
    string probationoverride;
    string productcode;
    string raw;
    string reduceddata;
    string returnalsofound;
    // ....
    string includeaddressfeedback;
    string includealldidrecords;
    string includeexpandedphonesplussearch;
    string includehri;
    string includelastresort;
    string includephonesfeedback;
    string includephonesplus;
    // ...
  END;

  EXPORT response := RECORD
    doxie.Layout_Rollup.KeyRec_feedback_Masked;
  END;

END;
