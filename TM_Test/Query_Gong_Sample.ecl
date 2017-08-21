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

// Output some samples

bdid_gong_only_sample := enth(bdid_gong_only_dedup, 200);

bdid_sample := join(f,
                    bdid_gong_only_sample,
				left.bdid = right.bdid,
				transform(Business_Header.Layout_Business_Header_Base, self := left),
				lookup);
				
output(bdid_sample, all);

bdid_people := join(f,
                    bdid_gong_only_dedup,
				left.bdid = right.bdid and
				  (INTEGER)(AddrCleanLib.CleanPerson73(left.company_name)[71..73]) >= 85 and
                      Datalib.CompanyClean(left.company_name)[41..120] = '',
				transform(Business_Header.Layout_Business_Header_Base, self := left),
				hash);
				
count(bdid_people);
bdid_people_sample := enth(bdid_people, 200);

output(bdid_people_sample,all);

// Now check Gong file for listing type
gb := Gong.File_History(bdid <> 0, publish_code IN ['P','U'], current_record_flag = 'Y');

bdid_gong := join(gb,
                  bdid_people,
			   left.bdid = right.bdid,
			   transform(Gong.Layout_history, self := left),
			   hash);
			   
layout_stat := record
bdid_gong.listing_type_bus;
bdid_gong.listing_type_res;
bdid_gong.listing_type_gov;
cnt := count(group);
end;
                  
bdid_gong_stat := table(bdid_gong, layout_stat, listing_type_bus, listing_type_res, listing_type_gov, few);

output(bdid_gong_stat, all);

// Output sample from Gong
bdid_gong_sample := join(gb,
                         bdid_people_sample,
					left.bdid = right.bdid,
					transform(Gong.Layout_history, self := left),
					hash);

output(bdid_gong_sample, all);
