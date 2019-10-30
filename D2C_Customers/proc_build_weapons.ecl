import std, PromoteSupers, eMerges, Watchdog, D2C;

/********* CONCEALED_WEAPONS **********/

cw := eMerges.file_ccw_base((unsigned6)did_out > 0, Source_Code not in D2C.Constants.CCWRestrictedSources);

EXPORT proc_build_weapons(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(cw, transform(D2C_Customers.layouts.rCWP,
            self.LexID             := (unsigned6)left.did_out;
            self.Name              := stringlib.stringcleanspaces(left.fname_in + ' ' + left.mname_in + ' ' + left.lname_in + ' ' + left.name_suffix_in);
            self.Address           := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir + ', '
                                    + left.unit_desig + ' ' + left.sec_range + if(left.unit_desig  <> '' or left.sec_range <> '', ', ', '')
                                    + left.city_name + ', ' + left.st + ' ' + left.zip);
            self.Permit_State      := left.source_state;
            self.Permit_Type       := left.ccwpermtype;
            self.Gender            := left.gender;
            self.Ethnicity         := left.race;
            self.Registration_Date := (unsigned4)left.ccwregdate;
            self.Expiration_Date   := (unsigned4)left.ccwexpdate;
            ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), distribute(D2C_Customers.Files.coresDS, hash(did)), left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := coreDS;
   
   inDS := map(mode = 1 => fullDS,          //FULL
               mode = 2 => coreDS,          //QUARTERLY
               mode = 3 => coreDerogatoryDS //MONTHLY
               );

   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 6);
   return res;

END;