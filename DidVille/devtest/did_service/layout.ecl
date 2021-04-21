IMPORT didville, patriot;
EXPORT layout := MODULE

  EXPORT request := RECORD
    string9 ssn;
    string14 adl;
    string8 DateOfBirth;
    string120 Addr1;
    string120 Addr2;
    string30 FirstName;
    string30 LastName;
    string30 MiddleName;
    string5 NameSuffix;
    string2 State;
    string25 City;
    string5 Zip;
    string10 phone;
    string10 primrange;
    string10 secrange;
    string30 primname;
    string120 Name;
    string120 Appends;
    string120 Verify;
    string120 Fuzzies;
    boolean Lookups;
    boolean livingsits;
    boolean GLBData;
    boolean AllPossibles;
    string3 AppendThreshold;
    boolean PatriotProcess;
    boolean NameIsOrdered;
    string120 Email;
    unsigned2 maxScoreFromSSN;
    unsigned2 maxScoreFromAddress;
    unsigned2 maxScoreFromDOB;
    unsigned2 maxScoreFromPhone;
    unsigned1 soap_xadl_version_value;
    boolean Limited_Output;
  END;

  EXPORT response_rslt1 := RECORD
    patriot.Layout_Patriot - [record_sid, global_sid, dt_effective_first, dt_effective_last, delta_ind];
  END;

  EXPORT response_rslt2 := RECORD
    didville.Layout_Did_OutBatch;
  END;

END;
