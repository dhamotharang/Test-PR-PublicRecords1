EXPORT RawInput_Layout_IDA := RECORD
    STRING20 firstname;
    STRING20 middlename;
    STRING25 lastname;
    STRING3 suffix;
    STRING50 addressline1;
    STRING20 addressline2;
    STRING35 city;
    STRING2 state;
    UNSIGNED3 zip;
    UNSIGNED4 dob;
    STRING12 ssn;
    STRING12 dl;
    STRING5 dlstate;
    STRING10 phone;
    STRING clientassigneduniquerecordid;
    STRING50 emailaddress;
    STRING15 ipaddress;
  END;