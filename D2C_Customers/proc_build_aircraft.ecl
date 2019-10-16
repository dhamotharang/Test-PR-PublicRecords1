import std, PromoteSupers, faa, Watchdog, D2C, Codes;

/********* FAA_AIRCRAFT **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
aircraft_reg  := faa.file_aircraft_registration_out((unsigned6)did_out > 0);
aircraft_info := dataset('~thor_data400::base::faa_aircraft_info_built',FAA.layout_aircraft_info,flat);

DESC_FIELDS := ['AIRCRAFT_CATEGORY_CODE', 'TYPE_AIRCRAFT', 'AIRCRAFT_WEIGHT'];
codes := Codes.File_Codes_V3_In(field_name in DESC_FIELDS);

GetDesc(string fld_name, string cd) := codes(field_name = fld_name and code = cd)[1].long_desc;

EXPORT proc_build_aircraft(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   layouts.faa_aircraft AddAirCraftInfo(aircraft_reg L, aircraft_info R) := transform
    self.LexID             := (unsigned6)L.did_out;
    self.Name              := L.fname + ' ' + L.mname + ' ' + L.lname;
    self.Address := L.street + ', ' + L.street2 + if(L.street2 <> '', ', ', '')
                  + L.city + ', ' + L.state + ' ' + L.zip_code;
    self.Serial_Number     := L.Serial_Number;
    self.Aircraft_Number   := L.n_Number;
    self.Record_Status     := L.current_flag;
    self.Description       := GetDesc('TYPE_AIRCRAFT', R.AIRCRAFT_CATEGORY_CODE) + GetDesc('TYPE_AIRCRAFT', R.TYPE_AIRCRAFT) + GetDesc('AIRCRAFT_WEIGHT', R.AIRCRAFT_WEIGHT);
    self.Last_Action_Date  := (unsigned6)L.Last_Action_Date;
    self.Manufacturer_Name := L.aircraft_mfr_name;
    self.Type_of_Aircraft  := L.type_aircraft;
    self.Model             := L.model_name;
   end;      
   
   ds := join(aircraft_reg, aircraft_info, left.aircraft_mfr_name = right.aircraft_mfr_name and left.model_name = right.model_name, AddAirCraftInfo(left, right), left outer);
   
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   outDS_ := map( mode = 1 => fullDS,          //FULL
                  mode = 2 => coreDS,          //QUARTERLY
                  mode = 3 => coreDerogatoryDS //MONTHLY
                );
   
   outDS := dedup(outDS_, record, all);
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::aircraft',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('aircraft - INVALID MODE - ' + Mode), doit);


END;