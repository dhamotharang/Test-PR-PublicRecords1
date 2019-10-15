import std, PromoteSupers, eMerges, Watchdog, D2C;

/********* HUNTING_FISHING_PERMITS **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
hf	 := eMerges.file_hunters_out((unsigned6)did_out > 0, Source_Code not in D2C.Constants.CCWRestrictedSources);

EXPORT proc_build_hunting(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(hf, transform(layouts.hf,
            self.LexID         := (unsigned6)left.did_out;
            self.Name          := left.fname_in + ' ' + left.mname_in + ' ' + left.lname_in;  //lfm format, contains junk
            self.Address       := left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir + ', '
                        + left.unit_desig + ' ' + left.sec_range + ', '
                        + left.p_city_name + ', ' + left.st + ' ' + left.zip;
            self.Gender         := left.Gender;
            self.License_Date   := (unsigned4)left.datelicense;
            self.License_Number := ''; //can't find
            self.License_Type   := left.License_Type_mapped;
            self.Home_State     := left.homestate;   
            self.License_State  := left.res_state;
            ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   outDS_ := map( mode = 1 => fullDS,          //FULL
                  mode = 2 => coreDS,          //QUARTERLY
                  mode = 3 => coreDerogatoryDS //MONTHLY
                );
   
   outDS := dedup(outDS_, record, all);
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::hunting_fishing',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('hunting_fishing - INVALID MODE - ' + Mode), doit);


END;