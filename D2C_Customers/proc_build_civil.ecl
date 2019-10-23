import Watchdog, PromoteSupers, civil_court;

Wdog   := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));
party  := civil_court.File_Moxie_party_Prod;
matter := civil_court.File_Moxie_matter_Prod;

matter_t := sort(table(matter, {case_key, disposition_date, filing_date}), case_key);
matter_t roll(matter_t L, matter_t R) := transform
   self.case_key := L.case_key;
   self.disposition_date := if(L.disposition_date > R.disposition_date, L.disposition_date, R.disposition_date); //keep the latest
   self.filing_date := if(L.filing_date < R.filing_date, L.filing_date, R.filing_date); //keep the earliest
end;

matter_r := rollup(matter_t, roll(left, right), case_key);
civil := join(party, matter_r, left.case_key = right.case_key, left outer, local);

EXPORT proc_build_civil(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
   
   D2C_Customers.layouts.rCivil AddCivil(civil L) := TRANSFORM
        self.LexId := (unsigned6)0;
        self.Name := L.e1_fname1 + ' ' + L.e1_lname1 + ' ' + L.e1_mname1;
        self.Address := L.prim_range1 + ' ' + L.predir1 + ' ' + L.prim_name1 + ' ' + L.addr_suffix1 + ' ' + L.postdir1 + ', '
                      + L.unit_desig1 + ' ' + L.sec_range1 + if(L.unit_desig1  <> '' or L.sec_range1 <> '', ', ', '')
                      + L.p_city_name1 + ', ' + L.st1 + ' ' + L.zip1;
        self.state_origin := L.state_origin;
        self.case_number := L.case_number;
        self.case_type := L.case_type;
        self.case_type_code := L.case_type_code;
        self.entity_type_description_1_orig := L.entity_type_description_1_orig;
        self.entity_nm_format_1 := L.entity_nm_format_1;
        self.court := L.court;
        self.court_code := L.court_code;
        self.Court_Disposition_Date := (unsigned4)L.disposition_date;
        self.Court_Filing_Date := (unsigned4)L.filing_date;
	END;

    ds := project(civil, AddCivil(left));

    fullDS := ds;
    coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
    coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
    outDS := map( mode = 1 => fullDS,          //FULL
                 mode = 2 => coreDS,          //QUARTERLY
                 mode = 3 => coreDerogatoryDS //MONTHLY
               );
   
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::civil',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('phones - INVALID MODE - ' + Mode), doit);

END;