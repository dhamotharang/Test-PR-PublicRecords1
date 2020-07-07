import lib_WORKUNITSERVICES,STD;
export fn_Validate_cru (string filedate)  := function
crubase := Files.base.accidents_alpha;

//father base files
crubase_father := Files.base.accidents_alpha_father;

cru_threshold := 1000000;

boolean ecrashcru_check := count(crubase) - count(crubase_father) between 1000 AND  cru_threshold;

string_rec	:=record
					string10	processdate;
	 end;

despray_trigger	:=	sequential(	output(dataset([{filedate}],string_rec),,'~thor_data400::out::ecrash_spversion',overwrite),
															fileservices.Despray(	'~thor_data400::out::ecrash_spversion',Constants.LandingZone,
																											'/data/super_credit/ecrash/alphabuild/despray/ecrashflag_'+filedate+'_'+Std.Date.CurrentTime(TRUE)+'.txt',,,,TRUE)); 


countchk := if ( ecrashcru_check   ,Sequential( Output('ECrash CRU Base Build looks good'), despray_trigger) , 
 FileServices.SendEmail( 'sudhir.kasavajjala@lexisnexis.com; DataDevelopment-InsRiskeCrash@lexisnexisrisk.com',
													'ECRASH CRU KEY BUILD IS ON HOLD --'+filedate,
													'eCrash cru Key build is on hold as base file counts dropped')
		                  );


return countchk;
		
end;