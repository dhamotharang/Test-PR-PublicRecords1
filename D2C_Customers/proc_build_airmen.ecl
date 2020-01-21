import std, PromoteSupers, faa, Watchdog, D2C;

/********* FAA_AIRMEN **********/

//SINGLE src(AM) - ALL allowed

EXPORT proc_build_airmen(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //11M records
   BaseFile := D2C_Customers.Files.AirmenDS(mode);   
   //5M records
   cert   := faa.file_airmen_certificate_out;

   //Select the latest records
   cert_d := dedup(sort(cert, letter, unique_id, cer_type, -date_last_seen), letter, unique_id, cer_type);

   D2C_Customers.layouts.rAirmen JoinAirmen_w_Cert(BaseFile L, cert_d R) := transform
    self.LexID         := L.did;
    self.Name          := stringlib.stringcleanspaces(L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix);
    self.Record_Status := L.record_type;  // (Active/Historical/Unknown)
    self.Address       := stringlib.stringcleanspaces(L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.suffix + ' ' + L.postdir + ', '
                + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig <> '' or L.sec_range <> '', ', ', '')
                + L.p_city_name + ', ' + L.st + ' ' + L.zip);
    self.Class              := R.cer_type_mapped;
    self.Expiration_Date    := (unsigned4)R.cer_exp_date;
    self.Region             := L.Region;
    self.Ratings            := R.Ratings;          
   end;
   
   inDS := join(distribute(BaseFile, hash(letter_code, unique_id)),
                distribute(cert_d, hash(letter, unique_id)),
                left.letter_code = right.letter and left.unique_id = right.unique_id,
                JoinAirmen_w_Cert(left, right),
                left outer,
                local
                );
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 11);
   return res;

END;