import std, PromoteSupers, Watchdog, D2C, doxie_files;

/********* CRIMINAL_RECORDS **********/

EXPORT proc_build_criminals(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   //631M records
   BaseFile := D2C_Customers.Files.CrimsDS(mode);
   //570M records
   courts := doxie_files.file_court_offenses(data_type not in D2C.Constants.DOCRestrictedDataTypes, vendor not in D2C.Constants.DOCRestrictedVendors, D2C_Customers.SRC_Allowed.Check(7, vendor));

   D2C_Customers.layouts.rCrims AddCourt(BaseFile L, courts R) := transform
    self.LexID             := L.did;
    self.Name              := stringlib.stringcleanspaces(L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix);
    self.Address           := stringlib.stringcleanspaces(L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.addr_suffix + ' ' + L.postdir + ', '
                            + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig  <> '' or L.sec_range <> '', ', ', '')
                            + L.p_city_name + ', ' + L.st + ' ' + L.zip5);
    self.County_Of_Origin  := L.County_Of_Origin;
    self.Offense_State     := L.Orig_State;
    self.Source            := L.datasource;
    self.Case_Number       := L.Case_Num;
    self.Doc_Number        := L.Doc_Num;
    self.Fbi_Number        := L.Fbi_Num;
    self.Arresting_Agency  := R.sent_agency_rec_cust;
    self.Arrest_Type       := R.arr_off_desc_1;
    self.Court_Description := R.court_desc;
    self.Court_Offense     := R.court_off_desc_1 + R.court_off_desc_2; 
    self.Court_Plea        := R.court_final_plea;  
    self.Court_Disposition := R.court_disp_desc_1 + R.court_disp_desc_2;
    self.Court_Level       := R.court_off_lev;
    self.Court_Disposition_Date := (unsigned4)R.court_disp_date;
    self.Court_Filing_Date      := (unsigned4)L.file_date;
   end;
   
   inDS := join(distribute(BaseFile, hash(offender_key)),
                distribute(courts, hash(offender_key)),
                left.offender_key = right.offender_key,
                AddCourt(left,right),
                left outer,
                local);
      
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 7);
   return res;

END;