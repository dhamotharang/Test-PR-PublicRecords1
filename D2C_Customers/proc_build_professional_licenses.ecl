import std, PromoteSupers, prof_licensev2, Watchdog, D2C;

/********* PROFESSIONAL_LICENSES **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
pl := prof_licensev2.File_ProfLic_Base((unsigned6)did > 0);//Unrestricted

EXPORT proc_build_professional_licenses(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(pl, transform(layouts.professional_licenses,
            self.LexID            := (unsigned6)left.did;
            self.License_Number   := left.orig_license_number;
            self.License_State    := left.Source_St;
            self.License_Type     := left.License_Type;
            self.Profession_Board := left.Profession_or_Board;
            self.Issue_Date       := (unsigned4)left.Issue_Date;
            self.Expiration_Date  := (unsigned4)left.Expiration_Date;
            self.License_Status   := left.status;
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
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::professional_licenses',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('professional_licenses - INVALID MODE - ' + Mode), doit);


END;