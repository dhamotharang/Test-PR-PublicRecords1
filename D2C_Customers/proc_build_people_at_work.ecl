import std, PromoteSupers, paw, Watchdog, D2C;

/********* PEOPLE_AT_WORK **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
paw := paw.files().base.built((unsigned6)did > 0, score>'003');

EXPORT proc_build_people_at_work(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(paw, transform(layouts.people_at_work,
            self.LexID           := (unsigned6)left.did;
            self.Company         := left.Company_name;
            self.Address         := left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.addr_suffix + ' ' + left.postdir + ', '
                                  + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig <> '' or left.sec_range <>'', ', ', '')
                                  + left.city + ', ' + left.state + ' ' + left.zip;
            self.Phone           := left.Phone;
            self.Title           := left.Title;
            self.Date_First_Seen := (unsigned4)left.Dt_First_Seen;
            self.Date_Last_Seen  := (unsigned4)left.Dt_Last_Seen;
            ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   outDS := map( mode = 1 => fullDS,          //FULL
                 mode = 2 => coreDS,          //QUARTERLY
                 mode = 3 => coreDerogatoryDS //MONTHLY
               );
   
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::people_at_work',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('people_at_work - INVALID MODE - ' + Mode), doit);


END;