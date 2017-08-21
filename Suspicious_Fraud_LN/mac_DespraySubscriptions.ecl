/*
mac_DespraySubscriptions: creates a pipe delimited output and desprays to kettle for batch r3 processing.
       sf_file_name => STRING - suspicious fraud subscription output file name
             sf_key =>  INDEX - fully qualified suspicious fraud subscription key to use
 despray_ip_address => STRING - kettle production machine ip address
       despray_path => STRING - kettle working directory to despray into (ie. ${WORKINGDIR}/tmp/)
output_file_cluster => STRING - name of a thor cluster to temporarily hold the delimited suspicious 
                                fraud subscription file
*/
EXPORT mac_DespraySubscriptions(sf_file_name
																,sf_key
																,despray_ip_address
																,despray_path
																,output_file_cluster) :=	FUNCTIONMACRO
	// COMMON DEFINITIONS
	logical_file_stem := '~thor_data400::output::suspicious_fraud::';
	sf_stats_file_name := sf_file_name+'.stats';
	
	// CALCULATE SUSPICOUS RISK CODE STATS
	sf_code_cnts_rec := RECORD
		sf_key.suspicious_risk_code;
		num_of_codes := StringLib.CountWords(sf_key.suspicious_risk_code, ',', FALSE);
		code_cnt := COUNT(GROUP);
	END;
	sf_code_cnts := TABLE(sf_key, sf_code_cnts_rec, suspicious_risk_code, FEW);

	sf_normed_codes_rec := RECORD
		sf_code_cnts_rec;
		STRING code;
	END;	
	sf_normed_codes_rec NormedCodes(sf_code_cnts_rec L, INTEGER C) := TRANSFORM
		SELF := L;
		SELF.code := (StringLib.SplitWords(L.suspicious_risk_code, ',', FALSE))[C];
	END;
	sf_normed_codes := NORMALIZE(sf_code_cnts, LEFT.num_of_codes, NormedCodes(LEFT,COUNTER));

	sf_code_stats_rec := RECORD
		sf_normed_codes.code;
		code_count := SUM(GROUP, sf_normed_codes.code_cnt);
	END;
	sf_code_stats := SORT(TABLE(sf_normed_codes, sf_code_stats_rec, code, FEW), code);

	// COMMON PROCESSES
	output_file(STRING in_file_name) := OUTPUT(sf_key
																						 ,
																						 ,logical_file_stem+in_file_name
																						 ,CSV(HEADING(SINGLE),SEPARATOR('|'),TERMINATOR('\n'),QUOTE('"'))
																						 ,CLUSTER(output_file_cluster)
																						 ,OVERWRITE);

	output_stats_file(STRING in_file_name) := OUTPUT(sf_code_stats
																									 ,
																									 ,logical_file_stem+in_file_name
																									 ,CSV(HEADING(SINGLE),SEPARATOR('|'),TERMINATOR('\n'),QUOTE('"'))
																									 ,CLUSTER(output_file_cluster)
																									 ,OVERWRITE);

	despray_file(STRING in_file_name) := FileServices.DeSpray(logical_file_stem+in_file_name
																														,despray_ip_address
																														,despray_path+in_file_name
																														,-1
																														,
																														,
																														,TRUE); // Allow Overwrite

	delete_file(STRING in_file_name) := FileServices.DeleteLogicalFile(logical_file_stem+in_file_name);

	// EXECUTE PROCESSES
	sf_despray_key := SEQUENTIAL(output_file(sf_file_name), 
															 NOTHOR(despray_file(sf_file_name)), 
															 NOTHOR(delete_file(sf_file_name)));

	sf_despray_stats := SEQUENTIAL(output_stats_file(sf_stats_file_name), 
																 NOTHOR(despray_file(sf_stats_file_name)), 
																 NOTHOR(delete_file(sf_stats_file_name)));

	RETURN PARALLEL(sf_despray_key, sf_despray_stats);
ENDMACRO;
