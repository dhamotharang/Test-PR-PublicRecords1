import PromoteSupers;

EXPORT MAC_WriteCSVFile(inDS, mode, ver, filetype) := FUNCTIONMACRO
    
	#uniquename(sMode)
	%sMode% := map(mode = 1 => 'full',
                   mode = 2 => 'core',
                   mode = 3 => 'derogatory',
                   ''
                  );

    #uniquename(outDS)
	%outDS% := dedup(inDS, record, all);

    #uniquename(doit)
    //csv with separator(|) and terminator(\n)             
    PromoteSupers.MAC_SF_BuildProcess(
        %outDS%,
        '~thor_data400::output::d2c::' + %sMode% + '::' + filetype,
        %doit%,2,true,true,ver,'|',,'\n');
	
    #uniquename(res)
	%res% := sequential(
               output(filetype + ' - ' + if(mode not in [1,2,3], 'INVALID', '') + ' MODE - ' + %sMode%)
			  ,%doit%
		   );
    return %res%;

ENDMACRO;