IMPORT ut;

/* The only files that are compared to previous data are the property addl files. This is to avoid parsing names because their names are uncleaned. */

EXPORT proc_BuildData(STRING pVersion = ut.GetDate, UNSIGNED sample_amt = -1) := FUNCTION

ut.MAC_SF_BuildProcess(relative_avb.func_CombineFiles(sample_amt),'~thor_data400::out::relative_avb',relative_avb_out,,,true, pVersion);
/* (thedataset, basename, seq_name, numgenerations = '3', csvout = 'false', pCompress = 'false', pVersion	=	'\'\'', pSeparator	=	'\',\'') */

RETURN relative_avb_out;
END;
