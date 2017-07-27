import header;
export File_Fares_Search_DID := dataset('~thor_data400::OUT::Property_DID', property.Layout_prop_out, flat);

outrec := record
 LN_Property.Layout_Deed_Mortgage_Property_Search;
 string9  ssn;
 string12 did;
 string12 bdid;
 string12 pgid;
end; 

outrec	redefine_fares(File_Fares_Search_DID L) := transform
  self.ln_fares_id          := L.fares_id;
  self.cname                := L._company;
  self.vendor_source_flag   := L.vendor;
  self.ssn                  := '';
  self.pgid                 := '';
  self := L;
end;

fares_search_redefined := project(File_Fares_Search_DID, redefine_fares(left));

output(fares_search_redefined,,'~thor_data400::out::ln_fares_20050609_1080_2580_DID',overwrite);