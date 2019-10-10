import std, PromoteSupers, eMerges, Watchdog, D2C;

/********* CONCEALED_WEAPONS **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
cw := eMerges.file_ccw_base((unsigned6)did_out > 0, Source_Code not in D2C.Constants.CCWRestrictedSources);

EXPORT proc_build_weapons(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(cw, transform(layouts.cwp,
            self.LexID             := (unsigned6)left.did_out;
            self.Name              := left.fname_in + ' ' + left.mname_in + ' ' + left.lname_in;
            self.Address           := left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir + ', '
                                    + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig  <> '' or left.sec_range <> '', ', ', '')
                                    + left.city_name + ', ' + left.st + ' ' + left.zip;
            self.Permit_State      := left.source_state;
            self.Permit_Type       := left.ccwpermtype;
            self.Gender            := left.gender;
            self.Ethnicity         := left.race;
            self.Registration_Date := (unsigned4)left.ccwregdate;
            self.Expiration_Date   := (unsigned4)left.ccwexpdate;
            ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := coreDS;
   
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
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::concealed_weapons',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('concealed_weapons - INVALID MODE - ' + Mode), doit);


END;