
EXPORT Spray_Files_CW (string sourceip, string targetgroup, string remotelocation, string updatefiledate):= function

return sequential(
			
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'ALABAMA-COUSHATTA_TRIBES_OF_TEXAS'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'CHEYENNE_RIVER_SIOUX_TRIBE'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'COLORADO_BUREAU_OF_INVESTIGATION'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'COLORADO_SOTAR'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'KAIBAB_PAIUTE_TRIBE'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'LUMMI_NATION'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'MUSCOGEE_CREEK_NATION'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'PUEBLO_OF_SANTO_DOMINGO'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'UTE_INDIAN_TRIBE'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'YANKTON_SIOUX_TRIBE'),
					 Hygenics_Soff.Spray_Soff_Files_CW (sourceIP, targetGroup, remoteLocation, 	updateFiledate,'EASTERN_BAND_OF_CHEROKEE_INDIANS'),
						
						);
end;