import std, PromoteSupers, VotersV2, Watchdog, D2C;

/********* VOTER_REGISTRATION **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));

Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base_new;
vo	:=	dataset('~thor_data400::base::voters_reg',Layout_in,flat)(did > 0);

EXPORT proc_build_voters(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(vo, transform(layouts.voter_registration,
            self.LexID            := (unsigned6)left.did;
            self.Name             := left.first_name + ' ' + left.middle_name + ' ' + left.last_name;
            self.Resident_Address := left.res_addr1 + ', ' + left.res_addr1 + if(left.res_addr1 <> '', ', ','') + left.res_city + ', ' + left.res_state + ' ' + left.res_zip;
            self.Gender           := left.Gender;
            self.Ethnicity        := left.race;
            self.Last_Vote_Date   := (unsigned4)left.lastdatevote;
            self.Registration_Date     := (unsigned4)left.regdate;
            self.Political_Party       := left.Political_Party;
            self.State_of_registration := '';
            self.Status                := left.voter_status;
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
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::voter_registration',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('voter_registration - INVALID MODE - ' + Mode), doit);

END;