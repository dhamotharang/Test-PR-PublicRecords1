// This SPC is used for American student list suppression file Ingest process.
// The ingest file created by this process is then copied over to 
//			American_student_list.Ingest_ASL_Suppression
// Other files created by/for this process
//			American_student_list.In_ASL_Suppression
//			American_student_list.Layout_ASL_Suppression
//			American_student_list.config
OPTIONS:-gn 
MODULE:American_Student_List_Suppression
FILENAME:ASL_Suppression
//IDNAME:EXISTING:FULL_NAME    //IDName specifies the field to be used for ID field created as the result of matching process
RIDField:rcid
// SourceRIDField:source		(eg Vendor_Id)
// SourceField:src:CONSISTENT[FULL_NAME,ADDRESS,CITY,Z5,ZIP_4] 
INGESTFILE:asl_supp_update:NAMED(American_Student_List.File_american_student_suppression.base)

FIELDTYPE:zip5:ALLOW(0123456789):LENGTHS(0,5):ONFAIL(IGNORE)
FIELDTYPE:hasZip4:ALLOW(0123456789):LENGTHS(0,4):ONFAIL(IGNORE)

FIELD:DATE_FIRST_SEEN:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0
FIELD:DATE_LAST_SEEN:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0
FIELD:DATE_VENDOR_FIRST_REPORTED:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0
FIELD:DATE_VENDOR_LAST_REPORTED:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0
FIELD:FULL_NAME:TYPE(STRING24):0,0
FIELD:ADDRESS_1:TYPE(STRING50):0,0
FIELD:ADDRESS_2:TYPE(STRING24):0,0
FIELD:CITY:TYPE(STRING16):0,0
FIELD:STATE:TYPE(STRING2):0,0
FIELD:Z5:LIKE(zip5):0,0
FIELD:ZIP_4:LIKE(hasZip4):0,0  
