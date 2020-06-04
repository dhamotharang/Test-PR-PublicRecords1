IMPORT STD, MedicaidSanctions;

EXPORT ProcBuildAll(
               STRING  pVersion = (STRING)STD.Date.Today(),
               STRING  pTargetIP = '_control.IPAddress.bctlpedata12',
               //STRING  pTargetPath= '/data/Builds/build/MedicaidSanctions/', // user cookie cutter Linux version
							 STRING  pTargetPath= '/data/hds_3/MedicaidSanctions/', // old school Linux version
               STRING  pContact='jason.allerdings@lexisnexisrisk.com',
							 STRING  pFileName='filestart'+pVersion+'filetail',
               BOOLEAN pOverwrite = FALSE
) := FUNCTION
								//No Spray - uses files on HPCC already
							MedicaidSanctions.BWR_BuildMedicaidSanctions(pVersion);
               //Despray
							 return	STD.File.Despray('~thor::bridger::medicaid::hc_med_sanc_extract_'+ pversion +'.tab',	
																				pTargetIP, 
																				pTargetPath + 'output/' + 'hc_med_sanctions'+pversion+'.tab',	
																				allowoverwrite := true)
							 //dfileservices.Despray('~thor::bridger::medicaid::hc_med_sanc_extract_'+ pversion +'.tab', _Control.IPAddress.bctlpedata10, pTargetPath + 'output/hc_med_sanctions'+pversion+'.tab',,,,true);
END;
