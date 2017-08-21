export proc_midex_build(string filedate) := function


		//Spray export xml files
		Spray_File := sequential(
				proc_midex_Sprayxml('INCIDENTDATA',fileDate),
				proc_midex_Sprayxml('PARTYDATA',fileDate),
				proc_midex_Sprayxml('INCIDENTTEXT',fileDate),
				proc_midex_Sprayxml('INCIDENTCODE',fileDate),
				proc_midex_Sprayxml('PARTYTEXT',fileDate),
				proc_midex_Sprayxml('AKADBA',fileDate),
			);
			
			return sequential(Spray_File);
end;