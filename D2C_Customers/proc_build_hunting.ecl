import std, PromoteSupers, eMerges, Watchdog, D2C;

/********* HUNTING_FISHING_PERMITS **********/
//SRC Code - 'E2','E1'

EXPORT proc_build_hunting(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //165M records
   BaseFile := D2C_Customers.Files.HuntingDS(mode);

   inDS := project(BaseFile, transform(D2C_Customers.layouts.rHunting,
            self.LexID         := left.did;
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
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 12);
   return res;

END;