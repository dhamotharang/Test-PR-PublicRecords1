import std, PromoteSupers, Email_Data, Watchdog, D2C;

/********* EMAIL_ADDRESSES **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
em	 := Email_Data.Key_Did(did > 0, email_src not in D2C.Constants.EmailRestrictedSources);

//keeping ONLY 3 email address per did based on latest date_last_seen
em_d  := dedup(sort(distribute(em, hash(did)), did, clean_email, -date_last_seen, local), did, clean_email, all, local);  
em_g  := group(em_d, did);
em_t  := topn(em_g, 3, did);
em_ug := group(em_t);

EXPORT proc_build_emails(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(em_ug, transform(layouts.email_addresses,
            self.LexID         := (unsigned6)left.did;
            self.Email_Address := left.clean_email;       
            ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   outDS_ := map( mode = 1 => fullDS,           //FULL
                  mode = 2 => coreDS,           //QUARTERLY
                  mode = 3 => coreDerogatoryDS  //MONTHLY
               );
   outDS := dedup(outDS_, record, all); 
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::emails',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('emails - INVALID MODE - ' + Mode), doit);


END;