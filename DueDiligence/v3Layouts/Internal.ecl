﻿IMPORT DueDiligence, iesp;


EXPORT Internal := MODULE

    EXPORT Address := RECORD
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
      STRING3 county;
      STRING50 countyName;
    END;
    
    EXPORT Name := RECORD
      STRING120 fullName;
      STRING20 firstName;
      STRING20 middleName;
      STRING20 lastName;
      STRING5 suffix;	
    END;
    
    
    
    
    //PERSON
    EXPORT SlimPerson := RECORD
      UNSIGNED6 lexID;
      Name;
      Address;
      STRING9 ssn;
      UNSIGNED4 dob;
      STRING10 phone;
      UNSIGNED1 relationship;
    END;

    EXPORT PersonTemp := RECORD
      UNSIGNED6 seq;
      SlimPerson inquired;
      SlimPerson bestData;
      BOOLEAN validPerson;
      UNSIGNED4 historyDateRaw;
      UNSIGNED4 historyDate;
      UNSIGNED6 inquiredDID;
      UNSIGNED1 lexIDScore;
      STRING2 indvType;
      DATASET(SlimPerson) spouses {MAXCOUNT(DueDiligence.Constants.MAX_SPOUSES)};          //populated in DueDiligence.getPersonDDv3PrereqsRelationships
      DATASET(SlimPerson) parents {MAXCOUNT(DueDiligence.Constants.MAX_PARENTS)}; 			   //populated in DueDiligence.getPersonDDv3PrereqsRelationships
      DATASET(SlimPerson) associations {MAXCOUNT(DueDiligence.Constants.MAX_ASSOCIATES)};  //populated in DueDiligence.getPersonDDv3PrereqsRelationships
      DueDiligence.v3Layouts.DDOutput.PerAttributes;
    END;
    
    
    
    //BUSINESS
    EXPORT SlimBusiness := RECORD
      UNSIGNED6 ultID;
      UNSIGNED6 orgID;
      UNSIGNED6 seleID;
      UNSIGNED6 proxID;
      UNSIGNED6 powID;
      STRING120 companyName;
      STRING9 fein;
      STRING10 phone;
      Address;
    END;
    
    EXPORT beoTitles := RECORD
      STRING50 title;
      UNSIGNED4 firstSeen;
      UNSIGNED4 lastSeen;
    END;
    
    EXPORT SlimExec := RECORD
      SlimPerson;
      STRING2 stateLegalEvents;
      STRING10 stateLegalEventsFlag;
      STRING2 offenseType;
      STRING10 offenseTypeFlag;
      DATASET(beoTitles) titles;
      BOOLEAN isOwnershipProng;
      BOOLEAN isControlProng;
    END;
    
    
    EXPORT BusinessTemp := RECORD
      UNSIGNED6 seq;
      UNSIGNED4 historyDateRaw;
      UNSIGNED4 historyDate;
      SlimBusiness inquiredBusiness;
      SlimBusiness bestData;
      BOOLEAN validBusiness;
      UNSIGNED1 lexIDScore;
      DATASET(SlimExec) beos {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxBusinessExecs)};
      DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents) beoCrimReport {MAXCOUNT(iesp.constants.DDRAttributesConst.MaxLegalEvents)};
    END;


END;