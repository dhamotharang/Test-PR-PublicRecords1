import std, PromoteSupers;

/********* CONSUMER_FILE **********/

EXPORT proc_build_consumers(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := map( mode = 1 => D2C_Customers.Files.FullInfutorDS,            //FULL
              mode = 2 => D2C_Customers.Files.coreInfutorDS,            //QUARTERLY
              mode = 3 => D2C_Customers.Files.coreInfutorDerogatoryDS   //MONTHLY
              );

   inDS := project(ds, transform(D2C_Customers.layouts.rConsumers,
            self.LexID         := left.did;
            self.Best_Name     := stringlib.stringcleanspaces(left.fname + ' ' + left.mname + ' ' + left.lname + ' ' + left.name_suffix);
            self.Best_Address  := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir + ', '
                                + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig  <> '' or left.sec_range <> '', ', ', '')
                                + left.city_name + ', ' + left.st + ' ' + left.zip);
            self.Best_DOB      := (unsigned4)(((string8)left.dob)[1..6] + '00');   //Last 2 digit(DD) is masked
            self.Derived_Age   := Std.Date.YearsBetween(left.dob ,Std.Date.Today());
            self.Date_of_Death := left.Date_of_Death;
            self.Report_Candidate := 'Y';
            ));
   
   res := MAC_WriteCSVFile(inDS, mode, ver, 'consumers');
   return res;

END;