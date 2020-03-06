import std, PromoteSupers, Phonesplus_v2, D2C, ut;

/********* PHONES **********/
//SRC code - 'GO','WP','PN','GN'

EXPORT proc_build_phones(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //11B records
   BaseFile := D2C_Customers.Files.PhonesDS(mode);

   inDS := project(BaseFile, transform(D2C_Customers.layouts.rPhones,
            self.LexID         := left.did;
            self.Name          := stringlib.stringcleanspaces(left.fname + ' ' + left.mname + ' ' + left.lname + ' ' + left.name_suffix);
            self.Address       := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.addr_suffix + ' ' + left.postdir + ', '
                        + left.unit_desig + ' ' + left.sec_range + ', '
                        + left.p_city_name + ', ' + left.state + ' ' + left.zip5);
            self.Phone         := left.orig_Phone;
            self.Phone_Type    := left.orig_Phone_Type;
            self.Phone_Product := left.company;  //this will be the manufactures name and not the carrier name
            ));
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 16);
   return res;


END;