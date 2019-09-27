import PromoteSupers, header;

/********* ADDRESS_HISTORY **********/

layouts.address_hist xf(header.Layout_Header L) := transform
    self.LexID         := L.did;
    self.Address       := L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.suffix + ' ' + L.postdir + ', '
                        + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig <> '' or L.sec_range <> '', ', ', '')
                        + L.city_name + ', ' + L.st + ' ' + L.zip;
    self.Date_First_Seen  := L.dt_first_seen;
    self.Date_Last_Seen   := L.dt_last_seen;
end;
     
EXPORT proc_build_addresses(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := map( mode = 1 => Files.FullHdrDS,            //FULL
              mode = 2 => Files.coreHdrDS,            //QUARTERLY
              mode = 3 => Files.coreHdrDerogatoryDS   //MONTHLY              
            );
   
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
             
   ds_p  := project(ds, xf(left))(Date_First_Seen <> 0 or Date_Last_Seen <> 0);   // need to discuss
   outDS := dedup(ds_p, record, all);
   
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::address_history',doit,2,,true, ver);
   return if(Mode not in [1,2,3], output('address_history - INVALID MODE - ' + Mode), doit);

END;                                         