import RoxieKeybuild,ut;

Export Proc_Build_Alpha (string filedate) := function 

	AlphaIn := File_KeybuildV2.alpha ; 

	ut.MAC_SF_BuildProcess(AlphaIn,'~thor_data400::base::accidents_alpha',buildBase,,,true);

	string_rec	:=
		record
			string10	processdate;
		end;

	despray_trigger	:=	sequential(	output(dataset([{filedate}],string_rec),,'~thor_data400::out::ecrash_spversion',overwrite),
													fileservices.Despray(	'~thor_data400::out::ecrash_spversion','edata12-bld.br.seisint.com',
																									'/super_credit/ecrash/alphabuild/ecrashflag_'+filedate+'_'+ut.gettime()+'.txt',,,,TRUE)); 
 
 
return sequential(buildBase, despray_trigger); 

end; 

