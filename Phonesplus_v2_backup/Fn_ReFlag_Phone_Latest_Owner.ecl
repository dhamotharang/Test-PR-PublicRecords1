//--------Funciton to reflag phones most recent owner 
//        After records have been excludd due to low vendor confidence score

export Fn_ReFlag_Phone_Latest_Owner(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

phones_excluded := phplus_in(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')));

phones_not_excluded := phplus_in(~Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')));

most_recent_rec := dedup(sort(distribute(phones_not_excluded, hash(npa+phone7)),npa+phone7, -dt_last_seen, -dt_first_seen, -dt_vendor_last_reported, -dt_vendor_first_reported, local),npa+phone7, local);

recordof(phplus_in) t_flag_most_recent(phones_not_excluded le, most_recent_rec ri) := transform
   self.append_latest_phone_owner_flag := if(le.phone7_did_key = ri.phone7_did_key, true, false);
   self:= le;
end;

most_recent := join(distribute(phones_not_excluded, hash(phone7_did_key)),
				    distribute(most_recent_rec, hash(phone7_did_key)),
					left.phone7_did_key = right.phone7_did_key,
					t_flag_most_recent(left, right),
					local,
					left outer);

return most_recent + phones_excluded;
end;
