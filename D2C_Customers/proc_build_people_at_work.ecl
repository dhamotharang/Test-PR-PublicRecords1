import std, PromoteSupers, paw, Watchdog, D2C;

/********* PEOPLE_AT_WORK **********/

pawBase := paw.files().base.built((unsigned6)did > 0, score>'003');

EXPORT proc_build_people_at_work(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(pawBase, transform(D2C_Customers.layouts.rPeople_At_Work,
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
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), distribute(D2C_Customers.Files.coresDS, hash(did)), left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   inDS := map(mode = 1 => fullDS,          //FULL
               mode = 2 => coreDS,          //QUARTERLY
               mode = 3 => coreDerogatoryDS //MONTHLY
               );
   
   res := MAC_WriteCSVFile(inDS, mode, ver, 'people_at_work');
   return res;

END;