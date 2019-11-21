import std, PromoteSupers, SexOffender, Watchdog, D2C;

/********* SEX_OFFENDERS **********/

//1.6M records
offenses := sexoffender.File_offenses_2;
offenses_d := project(dedup(offenses, seisint_primary_key, Offense_description, all)
               ,transform({string60 Seisint_Primary_Key, string900 Offense, unsigned4 Adjudication_Date},
                 self := left;
                 self.Offense := left.Offense_description;
                 self.Adjudication_Date := (unsigned4)left.conviction_date)
                 );

offenses_d rollOffenses(offenses_d L, offenses_d R) := transform        
   self.Offense := L.Offense + ' ; ' + R.Offense;
   self.Adjudication_Date := if(L.Adjudication_Date > R.Adjudication_Date, L.Adjudication_Date, R.Adjudication_Date);
   self := L;
end;
offenses_r := rollup(offenses_d, rollOffenses(left, right), seisint_primary_key);   

EXPORT proc_build_sex_offenders(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
    
   //2M records
   BaseFile := D2C_Customers.Files.SODS(mode);
   rTemp := {D2C_Customers.layouts.rSex_Offenders - [Offense, Adjudication_Date]; string60 Seisint_Primary_Key;};

   rTemp xF(BaseFile L) := transform
    self.LexID         := L.did;
    self.Name          := stringlib.stringcleanspaces(if(L.name_type = '0', L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix, ''));
    self.akas          := stringlib.stringcleanspaces(if(L.name_type <> '0', L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix, ''));
    self.Address       := stringlib.stringcleanspaces(L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.addr_suffix + ' ' + L.postdir + ', '
                + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig <> '' or L.sec_range <> '', ', ', '')
                + L.p_city_name + ', ' + L.st + ' ' + L.zip5);
    self.Height                   := L.Height;
    self.Weight                   := L.Weight;
    self.Race                     := L.Race;
    self.Offender_Status          := L.Offender_Status;
    self.Date_Last_Reported       := (unsigned4)L.dt_last_reported;
    self.Scars                    := L.Scars_marks_tattoos;
    self.DOC_Number               := L.DOC_Number;   
    self.FBI_Number               := L.FBI_Number;
    self.NCIC_Number              := L.NCIC_Number;   
    self.Sex_Offender_Registry_ID := L.Offender_ID; 
    self.Seisint_Primary_Key      := L.Seisint_Primary_Key;
   end;

   main_p := project(BaseFile, xF(left));
   main_d := dedup(main_p, record, except name, all);
   main_s := sort(main_d, LexID, Seisint_Primary_Key, -name);

   main_s rollRecs(main_s L, main_s R) := transform
    self.akas := regexreplace('[\\s]+', L.akas, ' ') + if(L.akas <> '', ' ; ', '') + regexreplace('[\\s]+', R.akas, ' ');
    self := L;
   end;
   main_r := rollup(main_s, rollRecs(left, right), LexID, Seisint_Primary_Key);

   D2C_Customers.layouts.rSex_Offenders AddOffense(main_r L, offenses_r R) := transform
    self := L;
    self := R;
   end;
   
   inDS := join(distribute(main_r, hash(Seisint_Primary_Key)),
                distribute(offenses_d, hash(Seisint_Primary_Key)),
                left.Seisint_Primary_Key = right.Seisint_Primary_Key,
                AddOffense(left, right),
                left outer,
                local
                );
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 18);
   return res;

END;