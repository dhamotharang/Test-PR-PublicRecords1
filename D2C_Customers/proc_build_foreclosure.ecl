import PromoteSupers, Watchdog;

/********* FORECLOSURE **********/
//SRC code - 'FR'
     
EXPORT proc_build_foreclosure(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   //125M records
   BaseFile := D2C_Customers.Files.ForeclosureDS(mode);

   D2C_Customers.layouts.rForeClosure NormIt(BaseFile L) := transform
    self.LexID          := (unsigned6)L.did;
    self.Owner          := stringlib.stringcleanspaces(L.name_first + ' ' + L.name_middle + ' ' + L.name_last + ' ' + L.name_suffix);
    self.Lender         := stringlib.stringcleanspaces(if(L.lender_beneficiary_company_name <> '', L.lender_beneficiary_company_name, L.lender_beneficiary_first_name + L.lender_beneficiary_last_name));
    self.Site_Address   := '';//starts at situs_house_number_prefix_1 – property_address_sip_code_1

    stringlib.stringcleanspaces(L.prim_range + ' ' + L.predir + ' ' + L.prim_name + ' ' + L.suffix + ' ' + L.postdir + ', '
                    + L.unit_desig + ' ' + L.sec_range + if(L.unit_desig <> '' or L.sec_range <> '', ', ', '')
                    + L.city_name + ', ' + L.st + ' ' + L.zip);

    self.Deed_Type      := L.deed_category;
    self.Recording_Date := (unsigned4)L.recording_date;
    self.Attorney       := L.attorney_name;
    self.Plaintiff1      := L.plaintiff_1 ;
    self.Plaintiff2      := L.plaintiff_2 ;
    self.title_company  := L.title_company_name;
    self.filing_date    := (unsigned4)L.filing_date;
    self.auction_date   := (unsigned4)L.auction_date;
    self.date_of_default:= (unsigned4)L.date_of_default;   
   end;
    
   NormOwners := NORMALIZE(BaseFile, 4 ,NormIt(LEFT,COUNTER));


   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 23);
   return res;

END;