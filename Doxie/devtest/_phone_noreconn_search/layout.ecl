IMPORT AddressFeedback_Services, doxie_raw;
EXPORT layout := MODULE

  EXPORT request := RECORD
    string acctno;
    string applicationtype;
    string datapermissionmask;
    string datarestrictionmask;
    string dppapurpose;
    string glbpurpose;
    string industryclass;
    string ssnmask;
    string did;
    string ssn;
    string unparsedfullname;
    string firstname;
    string middlename;
    string lastname;
    string namesuffix;
    string allownicknames;
    string addr;
    string primrange;
    string predir;
    string primname;
    string postdir;
    string secrange;
    string city;
    string state;
    string zip;
    string county;
    string phone;
    string datefirstseen;
    string datelastseen;
    string companyname;
    string batchfriendly;
    string phoneticmatch;
    string strictmatch;
    string suppressnewporting;
    string suppressportedtestdate;
    string suppressblanknameaddress;
    string tugatewayphoneticmatch;
    string usedatesort;
    string useqsentv2;
    string usemetronet;
    string excludebusiness;
    string excludecurrentgong;
    string excluderesidence;
    string excludelandlines;
    string includeaddressfeedback;
    string includedeadcontacts;
    string includefullphonesplus;
    string includehri;
    string includelastresort;
    string includeminors;
    string includephonesfeedback;
    string includerealtimephones;
    // scorethreshold, maxresults, maxresultsthistime, skiprecords <--if included, must have some value assigned
  END;

  EXPORT response := RECORD
    doxie_raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse;
    dataset(AddressFeedback_Services.Layouts.feedback_report) Address_Feedback {MAXCOUNT(1)};
  END;

END;
