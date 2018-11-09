EXPORT fn_ToFlat(DATASET(Layout_XGX) src) := FUNCTION
fs := U'§';		// field separator
AKAs := normalize(src,left.aka_list.aka,transform({Layout_generic,	UniqueId.Layout_Watchlist.layout_aliases},
									self.primarykey := LEFT.primarykey;
									self.info := TRIM(right.type)+fs+TRIM(right.category)+fs+TRIM(right.first_name)+fs+TRIM(right.middle_name)+fs+TRIM(right.last_name)+fs+TRIM(right.generation)+fs+TRIM(right.full_name)+fs+TRIM(right.comments);
									self := RIGHT;));

Addresses := normalize(src,left.address_list.address,transform({Layout_generic,UniqueId.Layout_Watchlist.layout_addresses},
									self.primarykey := LEFT.primarykey;
									self.info := TRIM(right.type)+fs+TRIM(right.street_1)+fs+TRIM(right.street_2)+fs+TRIM(right.city)+fs+TRIM(right.state)+fs+TRIM(right.postal_code)+fs+TRIM(right.country)+fs+TRIM(right.comments);
									self := RIGHT;));

info := normalize(src,left.additional_info_list.additionalinfo,transform({Layout_generic,UniqueId.Layout_Watchlist.layout_addlinfo},
									self.primarykey := LEFT.primarykey;
									self.info := TRIM(right.type)+fs+TRIM(right.information)+fs+TRIM(right.parsed)+fs+TRIM(right.comments);
									self := RIGHT;));

ids := normalize(src,left.identification_list.identification,transform({Layout_generic,UniqueId.Layout_Watchlist.layout_sp},
									self.primarykey := LEFT.primarykey;
									self.info := TRIM(right.type)+fs+TRIM(right.label)+fs+TRIM(right.number)+fs+TRIM(right.date_issued)+fs+TRIM(right.date_expires)+fs+TRIM(right.comments);
									self := RIGHT;));

phones := normalize(src,left.phone_number_list.phones,transform({Layout_generic,UniqueId.Layout_Watchlist.layout_phones},
									self.primarykey := LEFT.primarykey;
									self.info := TRIM(right.type)+fs+TRIM(right.address_id)+fs+TRIM(right.number)+fs+TRIM(right.comments);
									self := RIGHT;));


list1 := fnRollupAndJoin(DISTRIBUTE(src,primarykey), akas, akas);
list2 := fnRollupAndJoin(list1, Addresses, addresses);
list3 := fnRollupAndJoin(list2, info, infos);
list4 := fnRollupAndJoin(list3, ids, ids);
list5 := fnRollupAndJoin(list4, phones, phones);

return list5;
END;