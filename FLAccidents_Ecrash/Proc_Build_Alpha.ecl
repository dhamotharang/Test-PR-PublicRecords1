import RoxieKeybuild,Std,PromoteSupers;

Export Proc_Build_Alpha (string filedate) := function 

		AlphaIn := File_KeybuildV2.alpha ; 
		
		PromoteSupers.Mac_SF_BuildProcess(BuildIncidentsExtract,'~thor_data400::base::ecrash_Incidents',buildIncidents_Extract,,,true);
	 PromoteSupers.Mac_SF_BuildProcess(AlphaIn,'~thor_data400::base::accidents_alpha',buildBase,,,true);
					
	 string_rec	:=record
					string10	processdate;
	 end;
		 
	 despray_trigger	:=	sequential(	output(dataset([{filedate}],string_rec),,'~thor_data400::out::ecrash_spversion',overwrite),
															fileservices.Despray(	'~thor_data400::out::ecrash_spversion',Constants.LandingZone,
																											'/data/super_credit/ecrash/alphabuild/despray/ecrashflag_'+filedate+'_'+Std.Date.CurrentTime(TRUE)+'.txt',,,,TRUE)); 

	 
	 
		return sequential(buildIncidents_Extract,buildBase, despray_trigger); 

end; 

