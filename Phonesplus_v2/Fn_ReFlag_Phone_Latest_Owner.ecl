import mdr;
//--------Funciton to reflag phones most recent owner 
//        After records have been excludd due to low vendor confidence score

export Fn_ReFlag_Phone_Latest_Owner(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

phones_excluded := phplus_in(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) or Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Deceased')));

phones_not_excluded := phplus_in(~(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) or Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Deceased'))));

most_recent_rec := dedup(sort(distribute(phones_not_excluded(~(Translation_codes.fGet_other_sources_from_bitmap(src_all) in [mdr.sourceTools.src_wired_assets_royalty, mdr.sourceTools.src_wired_assets_owned])), hash(npa+phone7)),npa+phone7, -DateLastSeen, -DateFirstSeen, -DateVendorLastReported, -DateVendorFirstReported, local),npa+phone7, local);

most_recent_royalty := dedup(sort(distribute(phones_not_excluded(Translation_codes.fGet_other_sources_from_bitmap(src_all) in [mdr.sourceTools.src_wired_assets_royalty, mdr.sourceTools.src_wired_assets_owned]), hash(npa+phone7)),npa+phone7, -DateLastSeen, -DateFirstSeen, -DateVendorLastReported, -DateVendorFirstReported, local),npa+phone7, local);

final_recent := join(distribute(most_recent_rec, hash(npa+phone7)),
										 distribute(most_recent_royalty, hash(npa+phone7)),
										 left.npa + left.phone7 = right.npa + right.phone7,
										 transform(Layout_In_Phonesplus.layout_in_common,
										 self := if((left.npa + left.phone7 = right.npa + right.phone7 and (left.append_max_source_conf > 8 or left.DateLastSeen > right.DateLastSeen)) or right.npa + right.phone7 = '' , left,  
																 right)),
										 full outer,
										 local);

recordof(phplus_in) t_flag_most_recent(phones_not_excluded le, final_recent ri) := transform
   self.append_latest_phone_owner_flag := if(le.phone7_did_key = ri.phone7_did_key, true, false);
   self:= le;
end;

most_recent := join(distribute(phones_not_excluded, hash(phone7_did_key)),
				    distribute(final_recent, hash(phone7_did_key)),
					left.phone7_did_key = right.phone7_did_key,
					t_flag_most_recent(left, right),
					local,
					left outer);

return most_recent + phones_excluded;
end;
