import PromoteSupers, header;

/********* AKAS **********/

layouts.akas xf(header.Layout_Header L) := transform
    self.LexID       := L.did;
    self.Title       := L.title;
    self.Name        := L.fname + ' ' + L.mname + ' ' + L.lname;
end;
     
EXPORT proc_build_akas(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

    ds := map( mode = 1 => Files.FullHdrDS,            //FULL
               mode = 2 => Files.coreHdrDS,            //QUARTERLY
               mode = 3 => Files.coreHdrDerogatoryDS   //MONTHLY
            );
            
   ds_p  := project(ds, xf(left));
   outDS := dedup(ds_p, record, all);
   
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::akas',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('akas - INVALID MODE - ' + Mode), doit);


END;