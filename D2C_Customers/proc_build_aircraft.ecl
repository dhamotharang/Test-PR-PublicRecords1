import std, PromoteSupers, faa, Watchdog, D2C, Codes;

/********* FAA_AIRCRAFT **********/

//SINGLE src(AR) - ALL allowed

DESC_FIELDS := ['AIRCRAFT_CATEGORY_CODE', 'TYPE_AIRCRAFT', 'AIRCRAFT_WEIGHT'];
sCodes := Codes.File_Codes_V3_In(field_name in DESC_FIELDS);

GetDesc(string fld_name, string cd) := sCodes(field_name = fld_name and code = cd)[1].long_desc;

EXPORT proc_build_aircraft(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   //Records - 5M
   BaseFile := D2C_Customers.Files.AircraftDS(mode);
   //Records - 86K
   Aircraft_info := faa.file_aircraft_info_in;

   D2C_Customers.layouts.rAircraft AddAirCraftInfo(BaseFile L, aircraft_info R) := transform
    self.LexID             := L.did;
    self.Name              := stringlib.stringcleanspaces(L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix);
    self.Address           := stringlib.stringcleanspaces(L.street + ', ' + L.street2 + if(L.street2 <> '', ', ', '')
                            + L.city + ', ' + L.state + ' ' + L.zip_code);
    self.Serial_Number     := L.Serial_Number;
    self.Aircraft_Number   := L.n_Number;
    self.Record_Status     := L.current_flag;
    self.Description       := GetDesc('TYPE_AIRCRAFT', R.AIRCRAFT_CATEGORY_CODE) + GetDesc('TYPE_AIRCRAFT', R.TYPE_AIRCRAFT) + GetDesc('AIRCRAFT_WEIGHT', R.AIRCRAFT_WEIGHT);
    self.Last_Action_Date  := (unsigned6)L.Last_Action_Date;
    self.Manufacturer_Name := L.aircraft_mfr_name;
    self.Type_of_Aircraft  := L.type_aircraft;
    self.Model             := L.model_name;
   end;
   
   inDS := join(BaseFile,
              Aircraft_info,
              left.aircraft_mfr_name = right.aircraft_mfr_name and left.model_name = right.model_name,
              AddAirCraftInfo(left, right),
              left outer,
              lookup
              );
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 10);
   return res;

END;