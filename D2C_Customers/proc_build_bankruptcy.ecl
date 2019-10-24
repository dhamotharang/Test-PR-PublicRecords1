import PromoteSupers, Watchdog, BankruptcyV2;

/********* BANKRUPTCY **********/

BKSearchDS := bankruptcyV2.file_bankruptcy_search_v3(name_type='D' and lname!='' and prim_name!='');
BKMainDS   :=	bankruptcyV2.file_bankruptcy_main_v3(case_number!='');

f_search := distribute(BKSearchDS(case_number[1..3] <> '449'),hash(case_number,court_code));
f_main   := distribute(BKMainDS(case_number[1..3] <> '449'),hash(case_number,court_code));
    
D2C_Customers.layouts.rBankruptcy JoinSearch_W_Main(f_search L, f_main R) := transform
    self.LexID              := (unsigned6)L.did;    
    self.Debtor_Name        := stringlib.stringcleanspaces(if(L.name_type = 'D', L.orig_name, ''));
    self.Filing_Address     := stringlib.stringcleanspaces(L.orig_addr1	+ ' ' + L.orig_addr2);
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
   coreDS := join(distribute(ds, hash(LexID)), distribute(D2C_Customers.Files.coresDS, hash(did)), left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := coreDS;
    
   inDS := map(mode = 1 => fullDS,            //FULL
               mode = 2 => coreDS,            //QUARTERLY
               mode = 3 => coreDerogatoryDS   //MONTHLY
               );
            
   res := MAC_WriteCSVFile(inDS, mode, ver, 'bankruptcy');
   return res;

END;