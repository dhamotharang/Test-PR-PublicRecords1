import std, PromoteSupers, faa, Watchdog, D2C;

/********* FAA_AIRMEN **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));

airmen := faa.file_airmen_data_out((unsigned6)did_out > 0 and current_flag = 'A'); //Select ONLY ACTIVE records
cert   := faa.file_airmen_certificate_out;

//Select the latest records
cert_d := dedup(sort(cert, letter, unique_id, cer_type, -date_last_seen), letter, unique_id, cer_type);

EXPORT proc_build_airmen(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   layouts.airmen JoinAirmen_w_Cert(airmen L, cert_d R) := transform
    self.LexID         := (unsigned6)L.did_out;
    self.Name          := L.fname + ' ' + L.mname + ' ' + L.lname;
    self.Record_Status := L.record_type;  // (Active/Historical/Unknown)
    self.Address       := L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.suffix + ' ' + L.postdir + ', '
                + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig <> '' or L.sec_range <> '', ', ', '')
                + L.p_city_name + ', ' + L.st + ' ' + L.zip;
    self.Class              := R.cer_type_mapped;
    self.Certification_Date := 0;    // N/A
    self.Expiration_Date    := (unsigned4)R.cer_exp_date;
    self.Region             := L.Region;
    self.License_Number     := '';   // N/A
    self.Ratings            := R.Ratings;          
   end;
   
   ds := join(airmen, cert_d, left.letter_code = right.letter and left.unique_id = right.unique_id, JoinAirmen_w_Cert(left, right), left outer);
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   outDS_ := map( mode = 1 => fullDS,           //FULL
                  mode = 2 => coreDS,           //QUARTERLY
                  mode = 3 => coreDerogatoryDS  //MONTHLY
                );
   
   outDS := dedup(outDS_, record, all);
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::airmen',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('airmen - INVALID MODE - ' + Mode), doit);


END;