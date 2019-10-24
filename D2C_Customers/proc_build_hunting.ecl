import std, PromoteSupers, eMerges, Watchdog, D2C;

/********* HUNTING_FISHING_PERMITS **********/

hf	 := eMerges.file_hunters_out((unsigned6)did_out > 0, Source_Code not in D2C.Constants.CCWRestrictedSources);

EXPORT proc_build_hunting(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(hf, transform(D2C_Customers.layouts.rHunting,
            self.LexID         := (unsigned6)left.did_out;
            self.Name          := stringlib.stringcleanspaces(left.fname_in + ' ' + left.mname_in + ' ' + left.lname_in + ' ' + left.name_suffix_in);  //lfm format, contains junk
            self.Address       := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir + ', '
                        + left.unit_desig + ' ' + left.sec_range + ', '
                        + left.p_city_name + ', ' + left.st + ' ' + left.zip);
            self.Gender         := left.Gender;
            self.License_Date   := (unsigned4)left.datelicense;
            self.License_Type   := left.License_Type_mapped;
            self.Home_State     := left.homestate;   
            self.License_State  := left.res_state;
            ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), distribute(D2C_Customers.Files.coresDS, hash(did)), left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   inDS := map(mode = 1 => fullDS,          //FULL
               mode = 2 => coreDS,          //QUARTERLY
               mode = 3 => coreDerogatoryDS //MONTHLY
               );
   
   res := MAC_WriteCSVFile(inDS, mode, ver, 'hunting');
   return res;

END;