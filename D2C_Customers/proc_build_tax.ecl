import std, PromoteSupers, ln_propertyv2, ln_property, Watchdog, D2C;

/********* TAX_ASSESSMENTS **********/

//Will include the latest tax record for each property owned over the last 10 years 
Property_for_10yrs := ln_propertyv2.File_Search_DID(did > 0, Std.Date.YearsBetween((unsigned4)process_date ,Std.Date.Today()) < 10);
DedupFields := 'prim_range, zip, prim_name, sec_range';

LatestProperty  := dedup(sort(distribute(Property_for_10yrs, hash(#EXPAND(DedupFields))), #EXPAND(DedupFields), -process_date, local), #EXPAND(DedupFields), local);

dPT	 :=	distribute(ln_propertyv2.File_Assessment, hash(ln_fares_id));
dPAT :=	distribute(ln_propertyv2.File_addl_Fares_tax, hash(ln_fares_id));
dPS  :=	distribute(LatestProperty(source_code = 'OP'),hash(ln_fares_id));

EXPORT proc_build_tax(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   {D2C_Customers.layouts.rTax_Assessments, string12 ln_fares_id} AddTax(dPS L, dPT R) := transform
        self.LexID             := (unsigned6)L.did;
        self.ln_fares_id       := L.ln_fares_id;
        self.State             := R.State_code;
        self.County            := R.County_name;
        self.APN               := R.apna_or_pin_number;
        self.Property_Address  := stringlib.stringcleanspaces(R.property_full_street_address + ', ' + R.property_city_state_zip);
        self.Owner_Address     := stringlib.stringcleanspaces(R.mailing_full_street_address + ', ' + R.mailing_city_state_zip);
        self.Owner_Name        := R.assessee_name;
        self.Tax_Year          := R.Tax_Year;
        self.Tax_Amount        := R.Tax_Amount;
        self.Total_Assessed_Value := R.assessed_total_value;
        self.Assessed_Improvement_Value := R.Assessed_Improvement_Value;
        self.Assessed_Land_Value := R.Assessed_Land_Value;
        self.Assessment_Year     := R.assessed_value_year;
        self.Total_Market_Value  := R.market_total_value;
        self.Market_Improvement_Value := R.market_improvement_value;
        self.Market_Land_Value        := R.market_land_value;
        self.Market_Value_Year        := R.market_value_year;        
        self.Document_Number   := R.recorder_Document_Number;
        self.Document_Type     := R.Document_Type;
        self.Recorder_Book     := R.recorder_book_number;
        self.Recorder_Page     := R.recorder_page_number;
        self.Recording_Date    := (unsigned4)R.Recording_Date;
        self.Sale_Date         := (unsigned4)R.Sale_Date;        
        self.Sale_Price        := R.Sales_Price;
        self.Exemption         := R.homestead_homeowner_exemption;
        self.land_use          := R.ln_land_use_category;
        self.subdivision_name  := R.legal_subdivision_name;
        self.Year_Built        := (unsigned2)R.Year_Built;        
        self.Stories           := R.no_of_stories;
        self.Bedrooms          := R.no_of_bedrooms;
        self.Baths             := R.no_of_baths;
        self.Total_Rooms        := R.no_of_rooms;
        self.Fireplace_Indicator:= R.fireplace_indicator;
        self.Garage_Type        := R.garage_type_code;
        self.Garage_Size        := R.parking_no_of_cars;
        self.Pool_Spa           := R.pool_code;
        self.Style              := R.style_code;
        self.Air_Conditioning   := R.air_conditioning_code;
        self.Heating            := R.heating_code;
        self.Construction       := R.type_construction_code;
        self.Basement           := R.basement_code;
        self.Exterior_Walls     := R.exterior_walls_code;
        self.Foundation         := R.foundation_code;
        self.Roof               := R.roof_type_code;
        self.Elevator           := R.elevator;
        self.Property_Lot_Size  := R.lot_size;
        self.Building_Area      := R.building_area;
        self.Legal_Description  := R.legal_brief_description;            
   end;
   
   ds := join(dPS, dPT,
         left.ln_fares_id=right.ln_fares_id,
         AddTax(left,right),
         local
        );
        
   fullDS := ds;
   coreDS := join(distribute(ds, hash(LexID)), distribute(D2C_Customers.Files.coresDS, hash(did)), left.LexID = right.did, transform(left), local);
   coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
   inDS := map(mode = 1 => fullDS,          //FULL
               mode = 2 => coreDS,          //QUARTERLY
               mode = 3 => coreDerogatoryDS //MONTHLY
               );
   
   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 21);
   return res;

END;