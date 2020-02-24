import PromoteSupers, Watchdog;

/********* FORECLOSURE **********/
//SRC code - 'FR'
import Header, Suppress;
     
EXPORT proc_build_foreclosure(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   //125M records
   BaseFile := D2C_Customers.Files.ForeclosureDS(mode);
   rFR := record
      D2C_Customers.layouts.rForeClosure - [LexID];
      unsigned6 did;
   end;

   rFR NormIt(BaseFile L, INTEGER C) := transform
    self.did := (unsigned6)case(C, 1 => L.name1_did
                                 , 2 => L.name2_did
                                 , 3 => L.name3_did
                                 , 4 => L.name4_did
                                 , '');
    self.Owner := stringlib.stringcleanspaces(
                  case(C, 1 => L.name1_first + ' ' + L.name1_middle + ' ' + L.name1_last + ' ' + L.name1_suffix
                        , 2 => L.name2_first + ' ' + L.name2_middle + ' ' + L.name2_last + ' ' + L.name2_suffix
                        , 3 => L.name3_first + ' ' + L.name3_middle + ' ' + L.name3_last + ' ' + L.name3_suffix
                        , 4 => L.name4_first + ' ' + L.name4_middle + ' ' + L.name4_last + ' ' + L.name4_suffix
                        , ''));
    self.Lender         := stringlib.stringcleanspaces(if(L.lender_beneficiary_company_name <> '', L.lender_beneficiary_company_name, L.lender_beneficiary_first_name + L.lender_beneficiary_last_name));
    self.Site_Address   := stringlib.stringcleanspaces(L.situs1_prim_range + ' ' + L.situs1_predir + ' ' + L.situs1_prim_name + ' ' + L.situs1_addr_suffix + ' ' + L.situs1_postdir + ', '
                    + L.situs1_unit_desig + ' ' + L.situs1_sec_range + if(L.situs1_unit_desig <> '' or L.situs1_sec_range <> '', ', ', '')
                    + L.situs1_p_city_name + ', ' + L.situs1_st + ' ' + L.situs1_zip);

    self.Deed_Type      := L.deed_category;
    self.Recording_Date := (unsigned4)L.recording_date;
    self.Attorney       := L.attorney_name;
    self.Plaintiff1     := L.plaintiff_1 ;
    self.Plaintiff2     := L.plaintiff_2 ;
    self.title_company  := L.title_company_name;
    self.filing_date    := (unsigned4)L.filing_date;
    self.auction_date   := (unsigned4)L.auction_date;
    self.date_of_default:= (unsigned4)L.date_of_default;   
   end;
    
   NormOwners := NORMALIZE(BaseFile, 4 ,NormIt(LEFT,COUNTER));
   uniqDS := dedup(NormOwners, record, all);

   Foreclosure := D2C_Customers.MAC_BaseFile(uniqDS, mode, 23);
   inDS := project(Foreclosure, transform(D2C_Customers.layouts.rForeClosure, self.lexid := left.did; self := left;));

   res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 23);
   return res;

END;