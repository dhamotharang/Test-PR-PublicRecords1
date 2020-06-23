IMPORT VotersV2, std;

EXPORT fSpray_OptOut(STRING pVersion) := FUNCTION
	
 	pSprayed_name := FileServices.SprayVariable(
										'bctlpedata12.risk.regn.net'
									 ,'/data/temp/mireleaa/voter_opt_out/emerges_(ei)/' + pVersion + '/e*'
									 ,,,,		 
									 ,STD.System.Thorlib.Group( )
									 ,VotersV2.cluster + 'in::Voters::OptOut::sprayed::'+pVersion
									 ,-1,,
									 ,true,
									 ,true);		
	
	RETURN pSprayed_name;

END;


