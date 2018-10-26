IMPORT BatchShare, FFD, PersonContext, iesp;

EXPORT Constants := MODULE

  EXPORT BlankConsumerRec := ROW ([], FFD.Layouts.ConsumerLogInquiry);
  EXPORT BlankStatementid := ROW ([], FFD.Layouts.StatementIdRec);
  EXPORT BlankStatements := DATASET ([], FFD.Layouts.StatementIdRec);
  EXPORT BlankConsumerStatements := DATASET([], iesp.share_fcra.t_ConsumerStatement);  
  EXPORT BlankConsumerAlerts := DATASET([], iesp.share_fcra.t_ConsumerAlert);  
  EXPORT BlankPersonContextBatchSlim := DATASET([], FFD.Layouts.PersonContextBatchSlim);

  EXPORT STRING1 subject_has_alert := 'Y';

/*  -- RecordTypes --
  CS - common consumer level statement
  DR - disputed record indicator
  FA - Fraud Alert flag
  HS - header specific consumer level statement
  IT - Identity Theft flag
  LH - Legal Hold flag
  RS - record level consumer statement
  SF - Security Freeze flag
  SR - long term suppression record indicator
*/  
  EXPORT RecordType := MODULE(PersonContext.Constants.RecordTypes)
    EXPORT AlertFlags := [SF, IT, FA, LH];
    EXPORT ComplianceRecordLevel := [DR, SR];
    EXPORT StatementRecordLevel := [RS];
    EXPORT StatementConsumerLevel := [HS,CS];
    EXPORT ComplianceSet := ComplianceRecordLevel + AlertFlags;  
  END;
  
  EXPORT AlertMessage := MODULE(PersonContext.Constants.AlertMessages)
    EXPORT CSMessage := 'The subject of this consumer report has Consumer Statement(s) on file.';
    EXPORT LegalHoldMessage := 'The file for this consumer is not currently available.';
  END;
  
  // to be used when fabricating a batch structure from a single input record
  EXPORT  TYPEOF(BatchShare.Layouts.ShareAcct.acctno) SingleSearchAcctno := 'SingleRecord';
 
  EXPORT StatusCode := PersonContext.Constants.StatusCodes;
 
  EXPORT DataGroups := PersonContext.Constants.DataGroups;
  
  EXPORT DataGroupSet := MODULE
    EXPORT Aircraft := [
      DataGroups.AIRCRAFT_DETAILS,
      DataGroups.AIRCRAFT_ENGINE,
      DataGroups.AIRCRAFT,
      DataGroups.PERSON
      ];  
    EXPORT Aircraft_Search := [
      DataGroups.AIRCRAFT,
      DataGroups.PERSON
      ];  
    EXPORT AssetReport := [
      DataGroups.PILOT_REGISTRATION,
      DataGroups.PILOT_CERTIFICATE,
      DataGroups.WATERCRAFT,
      DataGroups.WATERCRAFT_COASTGUARD,
      DataGroups.WATERCRAFT_DETAILS,
      DataGroups.ASSESSMENT,
      DataGroups.DEED,
      DataGroups.PROPERTY_SEARCH,
      DataGroups.AIRCRAFT,
      DataGroups.AIRCRAFT_DETAILS,
      DataGroups.AIRCRAFT_ENGINE,
      DataGroups.HDR,
      DataGroups.PERSON
      ];
    EXPORT ATF := [
      DataGroups.ATF,
      DataGroups.PERSON
      ];  
    EXPORT Bankruptcy := [
      DataGroups.BANKRUPTCY_MAIN,
      DataGroups.BANKRUPTCY_SEARCH,
      DataGroups.PERSON
      ];    
    EXPORT CCW := [
      DataGroups.CCW,
      DataGroups.PERSON
      ];
    EXPORT Criminal_Offenders := [
      DataGroups.OFFENDERS_PLUS,
      DataGroups.PERSON
      ];
    EXPORT Criminal := [
      DataGroups.OFFENDERS_PLUS,
      DataGroups.COURT_OFFENSES,
      DataGroups.ACTIVITY,
      DataGroups.PUNISHMENT,
      DataGroups.OFFENSES,
      DataGroups.SO_MAIN,
      DataGroups.SO_OFFENSES,
      DataGroups.PERSON
      ];
    EXPORT Gong := [
      DataGroups.GONG,
      DataGroups.PERSON
      ];
    EXPORT Hunting_Fishing := [
      DataGroups.HUNTING_FISHING,
      DataGroups.PERSON
      ];
    EXPORT HDR := [
      DataGroups.HDR,
      DataGroups.PERSON
      ];
    EXPORT Liens := [
      DataGroups.LIEN_MAIN, 
      DataGroups.LIEN_PARTY,
      DataGroups.PERSON
      ];
    EXPORT Marriage_Divorce := [
      DataGroups.MARRIAGE, 
      DataGroups.MARRIAGE_SEARCH,  
      DataGroups.PERSON
      ];
    EXPORT Person := [
      DataGroups.PERSON
      ];
    EXPORT Pilot := [
      DataGroups.PILOT_REGISTRATION,
      DataGroups.PILOT_CERTIFICATE,
      DataGroups.PERSON
      ];
    EXPORT PrelitReport := [
      DataGroups.BANKRUPTCY_MAIN,
      DataGroups.BANKRUPTCY_SEARCH,    
      DataGroups.LIEN_MAIN,    
      DataGroups.LIEN_PARTY,    
      DataGroups.WATERCRAFT,
      DataGroups.WATERCRAFT_COASTGUARD,
      DataGroups.WATERCRAFT_DETAILS,
      DataGroups.ASSESSMENT,
      DataGroups.DEED,
      DataGroups.PROPERTY_SEARCH,
      DataGroups.HDR,
      DataGroups.PERSON
      ];
    EXPORT ProfLicenses := [
      DataGroups.PROFLIC,
      DataGroups.PERSON
      ];
    EXPORT Property := [
      DataGroups.ASSESSMENT,
      DataGroups.DEED,
      DataGroups.PROPERTY_SEARCH,
      DataGroups.PERSON
      ];
    EXPORT SexOffender := [
      DataGroups.SO_MAIN,
      DataGroups.SO_OFFENSES,
      DataGroups.PERSON
      ];
    EXPORT Watercraft := [
      DataGroups.WATERCRAFT,
      DataGroups.WATERCRAFT_COASTGUARD,
      DataGroups.WATERCRAFT_DETAILS,
      DataGroups.PERSON
      ];
    EXPORT Weapons := [
      DataGroups.CCW,
      DataGroups.PERSON
      ];
    EXPORT CompReport := Aircraft + ATF + Bankruptcy + Criminal + HDR + Hunting_Fishing + Liens + Pilot+ ProfLicenses + Property + SexOffender + Watercraft + Weapons;
                         
  END;

 // Make it 1 , 2 , 4, 8, 16, 64 .... (binary place value numbers )
  EXPORT ConsumerOptions := module
    EXPORT integer SHOW_CONSUMER_STATEMENTS := 1;
    EXPORT integer SHOW_DISPUTED_BANKRUPTCY := 2;
    EXPORT integer SUPPRESS_RECORDS_WHEN_IT_ALERT := 4; 
    EXPORT integer SHOW_DISPUTED            := 8; // bit will be used internally for debugging purposes
  END;

  EXPORT JoinLimits  := module
    EXPORT unsigned MAX_PERSON_CONTEXT_PER_RAW_RECORD := 2;
    EXPORT unsigned MAX_PERSON_CONTEXT_PER_HDR_RAW_RECORD := 8;
  END; 

END;