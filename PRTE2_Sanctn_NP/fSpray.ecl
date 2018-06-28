import ut, std, prte2;

EXPORT fSpray := function
	return parallel(prte2.SprayFiles.Spray_Raw_Data('sanctn_np_incident__base','incident','sanctn_np'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn_np_incident_code','incidentcode','sanctn_np'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn_np_incident_text','incidenttext','sanctn_np'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn_np_party__base','party','sanctn_np'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn_np_party_text','partytext','sanctn_np'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn_np_party_aka_dba','party_aka_dba','sanctn_np')
									);
end;									