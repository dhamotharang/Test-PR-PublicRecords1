import PromoteSupers, Watchdog, BankruptcyV2;

/********* FORECLOSURE **********/
//SRC code - 'FR'
     
EXPORT proc_build_foreclosure(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   //125M records
   BaseFile := D2C_Customers.Files.BankruptcyDS(mode);
   f_search := distribute(BaseFile(case_number[1..3] <> '449'),hash(case_number,court_code));
   
   //70M records
   BKMainDS :=	bankruptcyV2.file_bankruptcy_main_v3(case_number!='');
   f_main   := distribute(BKMainDS(case_number[1..3] <> '449'),hash(case_number,court_code));

   D2C_Customers.layouts.rForeClosure JoinSearch_W_Main(BaseFile L, f_main R) := transform
    self.LexID          := (unsigned6)L.did;
    self.Owner          := stringlib.stringcleanspaces(L.);
    self.Lender         := L.;
    self.Site_Address   := stringlib.stringcleanspaces(L.);
    self.Deed_Type      := L.;
    self.Recording_Date := (unsigned4)L.;
    self.Attorney       := L.;
    self.Plaintiff      := L.;
    self.title_company  := L.;
    self.filing_date    := (unsigned4)L.;
    self.auction_date   := L.;
    self.date_of_default:= (unsigned4)L.;   
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