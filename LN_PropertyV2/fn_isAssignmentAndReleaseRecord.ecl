import LN_PropertyV2;

EXPORT fn_isAssignmentAndReleaseRecord(RecordType,state,documentTypeCode, mortgageRecord = #TEXT(LN_PropertyV2.Constants.RECORD_TYPE.MORTGAGE)) := functionmacro

   //mortgageRecord -> ln_fares_id[2]
   isAR := map(
               documentTypeCode  <> '' and RecordType in [LN_PropertyV2.constants.ASSIGN_RELS.Assignments_Record_Type,LN_PropertyV2.constants.ASSIGN_RELS.Releases_Record_Type]
               and mortgageRecord = LN_PropertyV2.Constants.RECORD_TYPE.MORTGAGE => true,
               documentTypeCode  <> '' and state in ['MN','HI'] and RecordType in [LN_PropertyV2.constants.ASSIGN_RELS.Assignments_HI_MN_Record_Type,LN_PropertyV2.constants.ASSIGN_RELS.Releases_HI_MN_Record_Type]
               and mortgageRecord = LN_PropertyV2.Constants.RECORD_TYPE.MORTGAGE => true,
               false
               );

   return (isAR);
endmacro;