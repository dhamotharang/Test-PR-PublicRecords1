EXPORT fn_isAssignmentAndReleaseRecord(RecordType,state,documentTypeCode ) := functionmacro
import LN_PropertyV2;

   isAR := map( 
               documentTypeCode  <> '' and RecordType in [LN_PropertyV2.constants.ASSIGN_RELS.Assignments_Record_Type,LN_PropertyV2.constants.ASSIGN_RELS.Releases_Record_Type] => true,
               documentTypeCode  <> '' and state in ['MN','HI'] and RecordType in [LN_PropertyV2.constants.ASSIGN_RELS.Assignments_HI_MN_Record_Type,LN_PropertyV2.constants.ASSIGN_RELS.Releases_HI_MN_Record_Type] => true,
               false
               );

   return (isAR);
endmacro;