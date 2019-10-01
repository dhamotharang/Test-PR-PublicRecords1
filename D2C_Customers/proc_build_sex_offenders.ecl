import std, PromoteSupers, SexOffender, Watchdog, D2C;

/********* SEX_OFFENDERS **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
main     := sexoffender.file_Main;
offenses := sexoffender.File_offenses_2;

offenses_d := project(dedup(offenses, seisint_primary_key, Offense_description, all)
               ,transform({string60 Seisint_Primary_Key, string900 Offense}, self := left; self.Offense := left.Offense_description));

offenses_d rollOffense(offenses_d L, offenses_d R) := transform        
   self.Offense := L.Offense + ' ; ' + R.Offense;
   self := L;
end;
offenses_r := rollup(offenses_d, rollOffense(left, right), seisint_primary_key);

r := {layouts.sex_offenders - [Offense]; string60 Seisint_Primary_Key;};

r xf(main L) := transform
    self.LexID         := (unsigned6)L.did;
    self.Name          := if(L.name_type = '0', L.fname + ' ' + L.mname + ' ' + L.lname, '');
    self.akas          := if(L.name_type <> '0', L.fname + ' ' + L.mname + ' ' + L.lname, '');
    self.Address       := L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.addr_suffix + ' ' + L.postdir + ', '
                + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig <> '' or L.sec_range <> '', ', ', '')
                + L.p_city_name + ', ' + L.st + ' ' + L.zip5;
    self.Height                   := L.Height;
    self.Weight                   := L.Weight;
    self.Race                     := L.Race;
    self.Offender_Status          := L.Offender_Status;
    self.Date_Last_Reported       := (unsigned4)L.dt_last_reported;
    self.Scars                    := L.Scars_marks_tattoos;
    self.Adjudication             := '';  //N/A 
    self.Adjudication_Date        := 0;   //N/A
    self.DOC_Number               := L.DOC_Number;   
    self.FBI_Number               := L.FBI_Number;
    self.NCIC_Number              := L.NCIC_Number;   
    self.Sex_Offender_Registry_ID := L.Offender_ID; 
    self.Seisint_Primary_Key      := L.Seisint_Primary_Key;
end;
   
main_p := project(main, xf(left));
main_d := dedup(main_p, record, except name, all);
main_s := sort(main_d, LexID, Seisint_Primary_Key, -name);

main_s rollRecs(main_s L, main_s R) := transform
    self.akas := regexreplace('[\\s]+', L.akas, ' ') + if(L.akas <> '', ' ; ', '') + regexreplace('[\\s]+', R.akas, ' ');
    self := L;
end;

main_r := rollup(main_s, rollRecs(left, right), LexID, Seisint_Primary_Key);

EXPORT proc_build_sex_offenders(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   layouts.sex_offenders AddOffense(main_r L, offenses_r R) := transform
    self.Offense := R.Offense;
    self := L;
   end;
   
   ds := join(main_r, offenses_d, left.Seisint_Primary_Key = right.Seisint_Primary_Key, AddOffense(left, right), left outer);
   
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
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::sex_offenders',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('sex_offenders - INVALID MODE - ' + Mode), doit);

END;