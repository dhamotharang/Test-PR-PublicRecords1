import std, PromoteSupers, doxie_build, Watchdog, mdr, infutor, Relationship;

/********* RELATIVES **********/
    
EXPORT proc_build_relatives(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

    inDS := D2C_Customers.get_universe(mode).get_relative_pairs_2;
   
    TestBuild := false : stored('TestBuild');
   
    sMode := D2C_Customers.Constants.sMode(mode);
    sFile := D2C_Customers.Constants.sFile(4);
    outDS := if(TestBuild, choosen(inDS, 10), inDS);

    //csv with separator(|) and terminator(\n)             
    PromoteSupers.MAC_SF_BuildProcess(
        outDS,
        '~thor_data400::output::d2c::' + sMode + '::' + sFile,
        doit,2,true,true,ver,'|',,'\n');
        
    res := sequential(
               output(sFile + ' - ' + if(mode not in [1,2,3], 'INVALID', '') + ' MODE - ' + sMode)
			  ,doit
		   );
    return res;

END;