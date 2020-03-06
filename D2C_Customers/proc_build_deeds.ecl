import std, PromoteSupers, ln_propertyv2, ln_property, Watchdog, D2C;

/********* DEEDS_MORTGAGES **********/
//SRC code - 'LP'

EXPORT proc_build_deeds(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   //20B records in property search
   BaseFile := D2C_Customers.Files.DeedsDS(mode);
   //Will include up to 10 years of deed & mortgage data
   Property_for_10yrs := BaseFile(
                        Std.Date.YearsBetween((unsigned4)process_date,
                        Std.Date.Today()) < 10 and source_code = 'OP' and ln_fares_id[1..2] <> 'OM'
                        );

   //1B records in property deed
   //Recs filtered based on ln_fares_id[1..2]
   dLNPropertyDeed   := ln_propertyv2.File_Deed;

   dPD  := distribute(dLNPropertyDeed,hash(ln_fares_id));
   dPS  := distribute(Property_for_10yrs,hash(ln_fares_id));

   {D2C_Customers.layouts.rDeeds_Mortgages, string12 ln_fares_id} AddDeed(dPS L, dPD R) := transform
        self.LexID             := L.did;
        self.ln_fares_id       := L.ln_fares_id;
        self.State             := R.State;
        self.County            := R.County_name;
        self.APN               := R.fares_unformatted_apn;
        self.Property_Address  := stringlib.stringcleanspaces(R.property_full_street_address + ', ' + R.property_address_unit_number + if(R.property_address_unit_number <> '', ', ', '') + R.property_address_citystatezip);
        self.Owner_Address     := stringlib.stringcleanspaces(R.mailing_street + ', ' + R.mailing_unit_number + if(R.mailing_unit_number <> '', ', ', '') + R.mailing_csz); 
        self.Owner_Name        := R.name1 + R.name2;
        self.Seller_Name       := R.seller1 + R.seller2;
        self.Document_Number   := R.Document_Number;
        self.Document_Type     := R.Document_Type_Code;
        self.Recorder_Book     := R.Recorder_Book_number;
        self.Recorder_Page     := R.Recorder_Page_number;
        self.Recording_Date    := (unsigned4)R.Recording_Date;
        self.Sale_Date         := (unsigned4)R.contract_date;
        self.Sale_Price        := R.Sales_Price;
        self.Loan_Amount       := R.first_td_loan_amount;
        self.Loan_Type         := R.first_td_loan_type_code;   
        self.Interest_Rate     := R.first_td_interest_rate;
        self.Term              := R.loan_term_years;
        self.Due_Date          := (unsigned4)R.first_td_due_date;
        self.Lender            := R.lender_name; 
        self.Lender_Type       := R.first_td_lender_type_code; 
        self.Rate_Change       := R.rate_change_frequency; 
        self.Title_Company     := R.title_company_name;
        self.Type_Financing    := R.Type_Financing;
        self.Adjustable_Index  := R.adjustable_rate_index;
        self.Change_Index      := R.change_index;
        self.Property_Use      := R.property_use_code; 
        self.Land_Use          := R.assessment_match_land_use_code; 
        self.Lot_Size          := R.land_lot_size; 
        self.Legal_Description := R.legal_brief_description	;            
   end; 
   
   inDS := join(dPS, dPD,
         left.ln_fares_id=right.ln_fares_id,
         AddDeed(left,right),
         local
        );

   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 20);
   return res;

END;