import doxie;

df := Inquiry_AccLogs.File_Inquiry_Base.history( (unsigned)person_q.ssn > 0 and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] );

export Key_Inquiry_SSN := INDEX(df, {string9 ssn := person_q.SSN}, {df},
						'~thor_data400::key::inquiry_table::ssn_' + doxie.version_superkey );