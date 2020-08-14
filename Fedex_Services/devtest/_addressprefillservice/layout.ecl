IMPORT fedex_services;
EXPORT layout := MODULE

  EXPORT request := RECORD
    string applicationtype;
    string datapermissionmask;
    string datarestrictionmask;
    string dppapurpose;
    string glbpurpose;
    string industryclass;
    string firstname;
    string middlename;
    string lastname;
    string addr;
    string primrange;
    string predir;
    string primname;
    string postdir;
    string secrange;
    string city;
    string othercity1;
    string zip;
    string state;
    string scorethreshold;
    string dialcontactprecision;
    string addressorigin;
    string customerdataonly;
    string customerdatamaxrecords;
    //string maxresultsthistime := '100'; // if blank, no results returned
    string skiprecords;
  END;

  EXPORT response := RECORD
    fedex_services.Layouts.out;
  END;

END;
