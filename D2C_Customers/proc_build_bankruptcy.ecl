import PromoteSupers, Watchdog, BankruptcyV2;

/********* BANKRUPTCY **********/

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));

BKSearchDS := dataset('~thor_data400::base::bankruptcy::search_v3',BankruptcyV2.layout_bankruptcy_search_v3_supp_bip,flat)
				(name_type='D' and lname!='' and prim_name!='');

BKMainDS :=	dataset('~thor_data400::base::bankruptcy::main_v3',bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp,flat)
				(case_number!='');

f_search := distribute(BKSearchDS(case_number[1..3] <> '449'),hash(case_number,court_code));
f_main   := distribute(BKMainDS(case_number[1..3] <> '449'),hash(case_number,court_code));
    
layouts.bankruptcy JoinSearch_W_Main(f_search L, f_main R) := transform
    self.LexID              := (unsigned6)L.did;    
    self.Debtor_Name        := if(L.name_type = 'D', L.orig_name, '');
    self.Filing_Address     := L.orig_addr1	+ ' ' + L.orig_addr2;
    self.Date_Filed         := (unsigned4)L.date_filed;
    self.Court_Location     := R.Court_Location;
    self.Filing_Status      := R.Filing_Status;
    self.Chapter            := L.Chapter;
    self.Disposition_Date   := (unsigned4)L.discharged;
    self.Disposition_Status := L.disposition;
    self.Trustee_Name       := R.trusteename;
    self.Trustee_Address    := R.trusteeaddress;    
end;
     
EXPORT proc_build_bankruptcy(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION
    
   ds := join(f_search,
              f_main,
			 (left.case_number = right.case_number) and
			 (left.court_code = right.court_code),
			  JoinSearch_W_Main(left,right),
              local);
    
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := coreDS;
    
   outDS_ := map( mode = 1 => fullDS,            //FULL
                  mode = 2 => coreDS,            //QUARTERLY
                  mode = 3 => coreDerogatoryDS   //MONTHLY
                );
            
   outDS := dedup(outDS_, record, all);
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::bankruptcy',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('bankruptcy - INVALID MODE - ' + Mode), doit);


END;