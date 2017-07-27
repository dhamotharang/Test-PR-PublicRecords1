export Out_Activity := 
					output(Activity_Joined(offender_key[1..4] not in Hygenics_Search.Sex_Offenders_Not_Updating.SO_By_Key
							and vendor not in Hygenics_Search.Sex_Offenders_Not_Updating.SO_By_Source)
							,,'~thor_data400::base::fcra_criminal_activity_' + Version.Development, overwrite, __compressed__);