

export Out_Activity := 
					output(Activity_Joined(offender_key[1..4] not in CrimSrch.Sex_Offenders_Not_Updating
           and vendor not in CrimSrch.sCourt_Vendors_To_Omit
					 and vendor != '99'
					 and source_file != 'AR-DOC              '
					 and source_file != 'NJ-DOC-INMATE-OBCIS ' 
					 and source_file != 'PA STATEWIDE CRIM CT'
					 and source_file != 'PA_STATEWIDE_HIS(CV)'
					 and source_file != 'FL-DOC              '
					 and source_file != 'TX-DOC-Inmate-HIST  '
					 and source_file != 'NM-BernalilloCtyArr '
					 and source_file != 'AZ-MaricopaArrest   ')
					 //and source_file != 'FL-ALACHUA-CNTY-CRIM')
					 ,,'~thor_data400::base::fcra_criminal_activity_' + CrimSrch.Version.Development,overwrite, __compressed__);

