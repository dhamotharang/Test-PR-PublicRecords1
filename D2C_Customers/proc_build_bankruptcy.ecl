import PromoteSupers, Watchdog, BankruptcyV2;

/********* BANKRUPTCY **********/
//SRC code - 'BA'
//PACER is the only source indicated as bulk and consumer restricted by default (consult legal)
     
EXPORT proc_build_bankruptcy(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   //125M records
   BaseFile := D2C_Customers.Files.BankruptcyDS(mode);
   f_search := distribute(BaseFile(case_number[1..3] <> '449'),hash(case_number,court_code));
   
   //70M records
   BKMainDS :=	bankruptcyV2.file_bankruptcy_main_v3(case_number!='');
   f_main   := distribute(BKMainDS(case_number[1..3] <> '449'),hash(case_number,court_code));

   D2C_Customers.layouts.rBankruptcy JoinSearch_W_Main(BaseFile L, f_main R) := transform
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
    
   inDS := join(distribute(f_search, hash(case_number)),
                distribute(f_main, hash(case_number)),
                (left.case_number = right.case_number) and
                (left.court_code = right.court_code),
                JoinSearch_W_Main(left,right),
                local);

   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 5);
   return res;

END;