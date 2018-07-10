/*2015-11-06T19:44:02Z (Krishna Gummadi)
RRBug 193228 - Midex report upgrade changes
*/
EXPORT Constants := MODULE

  // Join related limits
	EXPORT UNSIGNED2 JOIN_LIMIT             := 10000; 
  EXPORT UNSIGNED2 JOIN_LIMIT_FOR_CHOOSEN := 1000;
  EXPORT UNSIGNED2 JOIN_LIMIT_UNLMTD      := 0;
  EXPORT UNSIGNED2 KEEP_LIMIT_HDR         := 10000;
	EXPORT UNSIGNED2 MAX_LICENSES 		      := 10;

  // Data(record) type values
	EXPORT STRING1 LicenseData      := 'L';
	EXPORT STRING1 NonPublicData    := 'N';
	EXPORT STRING1 PublicData       := 'P';
  
  // Combined penalty (more than on input field entered by customer)
  EXPORT UNSIGNED1 PENALTYTHRESHOLD := 15;
  // 4/2018 - US Bank & Chase want only Penalties <= 3; 
  // the code uses less than, so setting the penalty to 4
  EXPORT UNSIGNED1 PENALTY_SINGLE_INPUT_SEARCH := 4;
  
  // Midex Data Sources:  Sanctn_Mari - dbcode = 'N' => Non-Public
  //                      Sanctn      - Public
  //                      Sanctn_Mari - dbcode = 'F' => Freddie Mac  // 20130411 
  EXPORT STRING1  DATASOURCE_CODE_FREDDIE := 'F'; 
  EXPORT STRING1  DATASOURCE_CODE_NONPUB  := 'N';

  
  EXPORT STRING11 DATASOURCE_FREDDIE := 'Freddie Mac';
  EXPORT STRING11 DATASOURCE_NON_PUB := 'Non-Public';
  EXPORT STRING11 DATASOURCE_PUBLIC  := 'Public';
	EXPORT STRING11 DATASOURCE_PROFLIC := 'Prof-Lic';
  
  EXPORT UNSIGNED1 MAX_LIENS_JUDGMENTS_val := 10;
    
  // Midex Comprehensive Report Search Types
  EXPORT STRING PERSON_REPORT   			:= 'Person';
  EXPORT STRING BUSINESS_REPORT 			:= 'Business';
  EXPORT STRING NEW_BUSINESS_REPORT 	:= 'NewBusiness';
  EXPORT STRING MIDEX_REPORT    			:= 'Midex';
  
  EXPORT STRING15 NMLS_INDIV := 'NMLS-INDIVIDUAL';
  EXPORT STRING15 NMLS_COMP  := 'NMLS-COMPANY';
  EXPORT STRING15 NMLS_BR    := 'NMLS-BRANCH';
  EXPORT STRING15 NMLS       := 'NMLS';  // for those records not defined as comp or indiv
  
  EXPORT STRING INTERNALCODE      := 'INTERNALCODE';
  EXPORT STRING VERIFICATION      := 'VERIFICATION';
  EXPORT STRING PROFESSIONCODE    := 'PROFESSIONCODE';
  EXPORT STRING LICENSECODE       := 'LICENSECODE';
  EXPORT STRING OTHERINFO         := 'OTHERINFO';
  EXPORT STRING INCIDENT_TEXT     := 'INCIDENT_TEXT';
  EXPORT STRING INCIDENT_RESPONSE := 'INCIDENT_RESPONSE';
  
  EXPORT STRING1 INDIV_SEARCH := 'I';
  EXPORT STRING1 COMP_SEARCH  := 'C';
  EXPORT STRING1 ALL_LICENSES_SEARCH  := 'A';  
	
	EXPORT AFFILIATE_TYPES :=  MODULE
    EXPORT COMPANY    := 'CO';
    EXPORT BRANCH     := 'BR';
    EXPORT INDIVIDUAL := 'IN';
  END;
  
  EXPORT STRING1 NONPUBLIC_SUBJECT_PARTY_NUM := '0';
  
  EXPORT STRING1 AKA_NAME_TYPE := 'A';
  EXPORT STRING1 DBA_NAME_TYPE := 'D';
	EXPORT STRING  LIC_NOT_REPORTED := 'LICENSE WAS NOT REPORTED TO LEXISNEXIS BY A LICENSING AUTHORITY';
  
  // Alert versions
  // Changes done to the license status hash calculations and hence, need to increase the alert version from 2 to 3
  // Will need to change the current version to the previous version if in the future we make any other changes to the alert calculations.
  EXPORT AlertVersion := ENUM(UNSIGNED, None=0, First, Second, Current);
  
  EXPORT RECORD_STATUS :=
  MODULE
    EXPORT STRING1 LatestRecordUpdatingSource            := 'C';
    EXPORT STRING1 LatestRecordNonUpdatingSource         := 'N';
    EXPORT STRING1 LatestMariRidDroppedUpdatingSource    := 'D';
    EXPORT STRING1 LatestMariRidDroppedNonUpdatingSource := 'H';
    EXPORT STRING1 SupercededMariRidUpdatingSource       := 'S';
    EXPORT STRING1 SupercededMariRidNonUpdatingSource    := 'Z';
  END;
END; // END of the MODULE
