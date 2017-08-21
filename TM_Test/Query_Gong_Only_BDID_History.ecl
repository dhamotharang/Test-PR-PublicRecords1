f := Business_Header.File_Business_Header;

layout_source := record
f.bdid;
f.source;
end;

bdid_source := table(f, layout_source);
bdid_source_dedup := dedup(bdid_source, all);

// Keep bdids with a gong source
bdid_with_gong := bdid_source_dedup(source in ['GB','GG']);

// Non gong sources
bdid_with_other_sources := bdid_source_dedup(source not in ['GB','GG']);

// get Gong only BDIDs
bdid_gong_only := join(bdid_with_other_sources,
                       bdid_with_gong,
				   left.bdid = right.bdid,
				   transform(layout_source, self := right),
				   right only,
				   hash);
				   
bdid_gong_only_dedup := dedup(bdid_gong_only, all);

count(bdid_gong_only_dedup);

layout_phone := record
layout_source;
unsigned6 phone;
string10 phone10;
string120 company_name;
end;

bdid_phone := join(f(source in ['GB','GG'], phone <> 0),
                   bdid_gong_only_dedup,
			    left.bdid = right.bdid and
				  (INTEGER)(AddrCleanLib.CleanPerson73(left.company_name)[71..73]) >= 85 and
                      Datalib.CompanyClean(left.company_name)[41..120] = '',
			    transform(layout_phone,
			              self.company_name := left.company_name;
			              self.phone := left.phone, self.phone10 := intformat(left.phone, 10, 1), self := right),
			    hash);
			    
bdid_phone_dedup := dedup(bdid_phone, all);

// Check Gong file for change in listing type from business to residential
// Use most recent type for phone

gf := Gong.File_History(publish_code IN ['P','U'], phone10 <> '');

layout_gong_slim := record
gf.phone10;
gf.listed_name;
gf.listing_type_bus;
gf.listing_type_res;
gf.listing_type_gov;
gf.dt_last_seen;
end;

gf_slim := table(gf, layout_gong_slim);
gf_slim_dist := distribute(gf_slim, hash(phone10));
gf_slim_sort := sort(gf_slim_dist, phone10, -dt_last_seen, -listing_type_res, local);
gf_slim_dedup := dedup(gf_slim_sort, phone10, local);

bdid_phone_remove_list := join(gf_slim_dedup(listing_type_bus = '', listing_type_res <> '', listing_type_gov = ''),
                               bdid_phone_dedup,
						 left.phone10 = right.phone10 and
						   left.listed_name = right.company_name,
						 transform(layout_phone, self := right),
						 hash);

bdid_phone_remove_list_dedup := dedup(bdid_phone_remove_list, all);


count(bdid_phone_remove_list_dedup);

// Select records from base file
bdid_phones_to_remove := join(f(source in ['GB','GG'], phone <> 0),
                              bdid_phone_remove_list_dedup,
						left.bdid = right.bdid and
				            left.phone = right.phone and
						  left.company_name = right.company_name,
           				transform(Business_Header.Layout_Business_Header_Base, self := left),
				          hash);
						

bdid_phones_to_remove_dedup := dedup(bdid_phones_to_remove, all);

count(bdid_phones_to_remove_dedup);

output(bdid_phones_to_remove_dedup(phone = 4257937547));

bh_sample := enth(bdid_phones_to_remove_dedup, 200);

output(bh_sample, all);

// output sample from gong history
gong_sample := join(gf,
                    bh_sample,
				(unsigned6)left.phone10 = right.phone and
				  left.listed_name = (string120)right.company_name,
				transform(gong.Layout_history, self := left),
				lookup);
				
output(gong_sample, all);


