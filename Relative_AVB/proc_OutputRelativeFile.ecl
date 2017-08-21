IMPORT ut;

/* The only files that are compared to previous data are the property addl files. This is to avoid parsing names because their names are uncleaned. */

EXPORT proc_OutputRelativeFile() := FUNCTION

LogicalFileName := nothor(fileservices.superfilecontents(ut.foreign_prod_boca + 'thor_data400::out::relative_avb'))[1].name;
Version := LogicalFileName[stringlib.stringfind(LogicalFileName, '_', 3) + 1..];

OldLogicalFileName := nothor(fileservices.superfilecontents('~thor_data400::out::relative_avb'))[1].name;
OldVersion := OldLogicalFileName[stringlib.stringfind(OldLogicalFileName, '_', 3) + 1..];

boca_file := DISTRIBUTE(DATASET(ut.foreign_prod_boca + 'thor_data400::out::relative_avb', Relative_AVB.Layout_Combined.Layout_Relationship, thor), HASH(person_key));

ut.MAC_SF_BuildProcess(boca_file,'~thor_data400::out::relative_avb',relative_avb_out,2,,true);
/*(thedataset, basename, seq_name, numgenerations = '3', csvout = 'false', pCompress = 'false')*/

RETURN IF(OLDVersion <> Version, relative_avb_out, OUTPUT('Same Version: ' + OldLogicalFileName));
END;
