EXPORT DDInput := MODULE

    EXPORT Address := RECORD
      //BOOLEAN isAddressCleaned;
      STRING120 streetAddress1;
      STRING120 streetAddress2;
      STRING10 prim_range;
      STRING2 predir;
      STRING28 prim_name;
      STRING4 addr_suffix;
      STRING2 postdir;
      STRING10 unit_desig;
      STRING8 sec_range;
      STRING25 city;
      STRING2 state;
      STRING5 zip;
      STRING4 zip4;
      STRING7 geo_blk;
      STRING3 county;  //Due Diligence is capturing the last 3 digits of the full 5 digit FIPS code.
    END;

    EXPORT Person := RECORD
      UNSIGNED6 lexID;
      STRING120 fullName;
      STRING20 firstName;
      STRING20 middleName;
      STRING20 lastName;
      STRING5 suffix;	
      Address; 
      UNSIGNED4 dob;
      STRING10 phone;
      STRING9 ssn;
      STRING14 phone2;
      STRING20 dlNumber;
      STRING2 dlState;
      STRING120 email;
    END;
    
    
    EXPORT PersonSearch := RECORD
      UNSIGNED6 seq;
      STRING30 accountNumber;
      UNSIGNED4 historyDateRaw; 
      Person searchBy;
      Person rawData; //only needed/used for reports
      STRING15 modelName; //only needed/used for citizenship requests
    END;
    
    
    

    EXPORT Business := RECORD
      UNSIGNED6 ultID;
      UNSIGNED6 orgID;
      UNSIGNED6 seleID;
      STRING120 companyName;
      Address;
      STRING9 fein;
      STRING10 phone;
    END;
    
    
    EXPORT BusinessSearch := RECORD
      UNSIGNED6 seq;
      STRING30 accountNumber;
      UNSIGNED4 historyDateRaw;
      Business searchBy;
      Business rawData //only needed/used for reports
    END;


END;