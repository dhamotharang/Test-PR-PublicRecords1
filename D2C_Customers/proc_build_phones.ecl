import std, PromoteSupers, Phonesplus_v2, Watchdog, D2C, ut;

/********* PHONES **********/

f_phonesplus := Phonesplus_v2.File_phonesplus_base(
                 did > 0,
                 current_rec,
                 D2C_Customers.SRC_Allowed.Check(16, vendor)
                 );
ut.mac_suppress_by_phonetype(f_phonesplus,cellphone,state,_fphonesplus_cell,true,did);
_keybuild_phonesplus_base := f_phonesplus(cellphone<>'');
ph := _keybuild_phonesplus_base(vendor not in D2C.Constants.PhonesPlusV2RestrictedSources);

EXPORT proc_build_phones(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := project(ph, transform(D2C_Customers.layouts.rPhones,
            self.LexID         := (unsigned6)left.did;
            self.Name          := stringlib.stringcleanspaces(left.fname + ' ' + left.mname + ' ' + left.lname + ' ' + left.name_suffix);
            self.Address       := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.addr_suffix + ' ' + left.postdir + ', '
                        + left.unit_desig + ' ' + left.sec_range + ', '
                        + left.p_city_name + ', ' + left.state + ' ' + left.zip5);
            self.Phone         := left.orig_Phone;
            self.Phone_Type    := left.orig_Phone_Type;
            self.Phone_Product := left.company;  //this will be the manufactures name and not the carrier name
            ));
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), distribute(D2C_Customers.Files.coresDS, hash(did)), left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   inDS := map(mode = 1 => fullDS,          //FULL
               mode = 2 => coreDS,          //QUARTERLY
               mode = 3 => coreDerogatoryDS //MONTHLY
               );
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 16);
   return res;


END;