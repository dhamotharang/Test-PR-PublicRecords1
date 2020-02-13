import std, PromoteSupers, paw, Watchdog, D2C;

/********* PEOPLE_AT_WORK **********/

EXPORT proc_build_people_at_work(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //4B records
   BaseFile := D2C_Customers.Files.PawDS(mode);

   inDS := project(BaseFile, transform(D2C_Customers.layouts.rPeople_At_Work,
            self.LexID           := (unsigned6)left.did;
            self.Company         := left.Company_name;
            self.Address         := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.addr_suffix + ' ' + left.postdir + ', '
                                  + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig <> '' or left.sec_range <>'', ', ', '')
                                  + left.city + ', ' + left.state + ' ' + left.zip);
            self.Phone           := left.Phone;
            self.Title           := left.Title;
            self.Date_First_Seen := (unsigned4)left.Dt_First_Seen;
            self.Date_Last_Seen  := (unsigned4)left.Dt_Last_Seen;
            ));
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 15);
   return res;

END;