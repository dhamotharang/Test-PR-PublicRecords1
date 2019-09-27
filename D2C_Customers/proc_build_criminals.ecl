import std, PromoteSupers, Watchdog, D2C, doxie_files;

/********* CIVIL_CRIMINAL_RECORDS **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
crims := doxie_files.File_Offenders((unsigned6)did > 0, data_type not in D2C.Constants.DOCRestrictedDataTypes, vendor not in D2C.Constants.DOCRestrictedVendors);
courts := doxie_files.file_court_offenses(data_type not in D2C.Constants.DOCRestrictedDataTypes, vendor not in D2C.Constants.DOCRestrictedVendors);

EXPORT proc_build_criminals(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   layouts.crims AddCourt(crims L, courts R) := transform
    self.LexID             := (unsigned6)L.did;
    self.Name              := L.fname + ' ' + L.mname + ' ' + L.lname;
    self.Address           := L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.addr_suffix + ' ' + L.postdir + ', '
                            + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig  <> '' or L.sec_range <> '', ', ', '')
                            + L.p_city_name + ', ' + L.st + ' ' + L.zip5;
    self.County_Of_Origin  := L.County_Of_Origin;
    self.Offense_State     := L.Orig_State;
    self.Source            := L.datasource;
    self.Case_Number       := L.Case_Num;
    self.Doc_Number        := L.Doc_Num;
    self.Fbi_Number        := L.Fbi_Num;
    self.Ncic_Number       := '';
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
   
   ds := join(distribute(crims, hash(offender_key)), distribute(courts, hash(offender_key)), left.offender_key = right.offender_key, AddCourt(left,right), left outer, local);
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := coreDS;
   
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
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::civil_criminal_records',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('civil_criminal_records - INVALID MODE - ' + Mode), doit);


END;