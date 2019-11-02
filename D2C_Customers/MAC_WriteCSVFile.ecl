import PromoteSupers;

EXPORT MAC_WriteCSVFile(inDS, mode, ver, record_type) := FUNCTIONMACRO

    TestBuild := false : stored('TestBuild');
    
	#uniquename(sMode)
	%sMode% := D2C_Customers.Constants.sMode(mode);

    #uniquename(sFile)
	%sFile% := D2C_Customers.Constants.sFile(record_type);
   
    #uniquename(sortDS)
#if(record_type not in [4,8])    
	%sortDS% := sort(distribute(inDS, hash(lexid)), lexid, local);
#else
    %sortDS% := inDS;
#end
    #uniquename(outDS)
	%outDS% := choosen(dedup(%sortDS%, record, all), if(TestBuild, 10, CHOOSEN:ALL));

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