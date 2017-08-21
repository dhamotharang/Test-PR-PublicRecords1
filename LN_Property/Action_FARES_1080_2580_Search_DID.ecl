import header, property;
File_Fares_Search := dataset('~thor_data400::OUT::Property_DID', property.Layout_prop_out, flat);

outrec := record
 LN_Property.Layout_Deed_Mortgage_Property_Search;
end; 

outrec	redefine_fares(property.File_Fares_Search_DID L) := transform
  self.ln_fares_id          := L.fares_id;
  self.cname                := L._company;
  self.vendor_source_flag   := L.vendor;
  self := L;
end;

fares_search_redefined := project(File_Fares_Search, redefine_fares(left));

output(fares_search_redefined,,'~thor_data400::base::property_fares_search_20050523',overwrite);