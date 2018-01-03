﻿IMPORT BatchShare, FFD, PersonContext, iesp;

EXPORT Constants := MODULE

	EXPORT BlankStatementid := ROW ([], FFD.Layouts.StatementIdRec);
	EXPORT BlankStatements := DATASET ([], FFD.Layouts.StatementIdRec);
	EXPORT BlankConsumerStatements := dataset([], iesp.share_fcra.t_ConsumerStatement);	
	EXPORT BlankPersonContextBatchSlim := dataset([], FFD.Layouts.PersonContextBatchSlim);
	
	EXPORT RecordType := MODULE(PersonContext.Constants.RecordTypes)
		EXPORT ComplianceRecordLevel := [DR, SR];
		EXPORT StatementRecordLevel := [RS,HSN,HSA,HSD,HSS,HSP,HSL];
		EXPORT StatementConsumerLevel := [HS,CS];
		EXPORT ComplianceSet := ComplianceRecordLevel;  // we will add other record types here later
	END;
	
  // to be used when fabricating a batch structure from a single input record
	EXPORT  typeof(BatchShare.Layouts.ShareAcct.acctno) SingleSearchAcctno := 'SingleRecord';
 
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
	END;

 // Make it 1 , 2 , 4, 8, 16, 64 .... (binary place value numbers )
  EXPORT ConsumerOptions := module
    EXPORT integer SHOW_CONSUMER_STATEMENTS := 1;
    EXPORT integer SHOW_DISPUTED_BANKRUPTCY := 2;
    EXPORT integer SHOW_DISPUTED            := 4; // bit will be used internally for debugging purposes
  END;

  EXPORT JoinLimits  := module
    EXPORT unsigned MAX_PERSON_CONTEXT_PER_RAW_RECORD := 2;
    EXPORT unsigned MAX_PERSON_CONTEXT_PER_HDR_RAW_RECORD := 8;
  END; 

END;