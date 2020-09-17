import OSHAIR;

// In some files for OSHAIR, the activity_nr field will contain the invalid value of 'activity_'; a misplaced header
// perhaps. We want to filter this out of the file.
EXPORT OptionalInfo_Raw_In_OSHAIR := OSHAIR.Files().input.OptionalInfo.using(activity_nr<>'activity_');