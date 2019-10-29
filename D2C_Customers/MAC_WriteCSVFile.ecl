import PromoteSupers;

EXPORT MAC_WriteCSVFile(inDS, mode, ver, record_type) := FUNCTIONMACRO
    
	#uniquename(sMode)
	%sMode% := D2C_Customers.Constants.sMode(mode);

    #uniquename(sFile)
	%sFile% := D2C_Customers.Constants.sFile(record_type);

    #uniquename(sortDS)
	%sortDS% := inDS;//if(record_type <> 8, inDS, sort(distribute(inDS, hash(lexid)), lexid, local));

    #uniquename(outDS)
	%outDS% := dedup(%sortDS%, record, all);

    #uniquename(doit)
    //csv with separator(|) and terminator(\n)             
    PromoteSupers.MAC_SF_BuildProcess(
        %outDS%,
        '~thor_data400::output::d2c::' + %sMode% + '::' + %sFile%,
        %doit%,2,true,true,ver,'|',,'\n');
	
    #uniquename(res)
	%res% := sequential(
               output(%sFile% + ' - ' + if(mode not in [1,2,3], 'INVALID', '') + ' MODE - ' + %sMode%)
			  ,%doit%
		   );
    return %res%;

ENDMACRO;