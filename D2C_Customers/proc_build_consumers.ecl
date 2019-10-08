import std, PromoteSupers;

/********* CONSUMER_FILE **********/

EXPORT proc_build_consumers(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := map( mode = 1 => Files.FullInfutorDS,            //FULL
              mode = 2 => Files.coreInfutorDS,            //QUARTERLY
              mode = 3 => Files.coreInfutorDerogatoryDS   //MONTHLY
              );

   ds_p := project(ds, transform(layouts.consumers,
            self.LexID         := left.did;
            self.Best_Name     := left.fname + ' ' + left.mname + ' ' + left.lname;
            self.Best_Address  := left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir + ', '
                                + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig  <> '' or left.sec_range <> '', ', ', '')
                                + left.city_name + ', ' + left.st + ' ' + left.zip;
            self.Best_DOB      := (unsigned4)(left.dob[1..6] + '00');   //Last 2 digit(DD) is masked
            self.Derived_Age   := Std.Date.YearsBetween(left.dob ,Std.Date.Today());
            self.Date_of_Death := left.Date_of_Death;
            self.Report_Candidate := 'Y';
            ));
   outDS := dedup(ds_p, record, all); 
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
   
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::consumer_file',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('consumer_file - INVALID MODE - ' + Mode), doit);

END;