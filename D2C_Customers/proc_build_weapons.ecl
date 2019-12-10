import std, PromoteSupers, eMerges, Watchdog, D2C;

/********* CONCEALED_WEAPONS **********/
//SRC Code - 'E3'

EXPORT proc_build_weapons(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   //3M records
   BaseFile := D2C_Customers.Files.CCWDS(mode);

   inDS := project(BaseFile, transform(D2C_Customers.layouts.rCWP,
            self.LexID             := left.did;
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

   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 6);
   return res;

END;