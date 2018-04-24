import ut,data_services;
//Layout with scrubbits added at the end
file_base := dataset(Watercraft.Cluster + 'base::watercraft_search',Watercraft.Layout_Scrubs.Search_Base,thor);

SrtBase	:= SORT(file_base, watercraft_key, persistent_record_id, -date_vendor_last_reported);
												 
recordof(SrtBase) tRollupDuplicates(SrtBase pLeft, SrtBase pRight) :=
  transform
	self.date_vendor_first_reported	:=	IF(pLeft.date_vendor_first_reported > pRight.date_vendor_first_reported, pRight.date_vendor_first_reported, pLeft.date_vendor_first_reported);
	self.date_vendor_last_reported	:=	IF(pLeft.date_vendor_last_reported > pRight.date_vendor_last_reported, pLeft.date_vendor_last_reported, pRight.date_vendor_last_reported);
	self.date_first_seen					  :=	IF(pLeft.date_first_seen > pRight.date_first_seen, pRight.date_first_seen, pLeft.date_first_seen);
	self.date_last_seen							:=	IF(pLeft.date_last_seen > pRight.date_last_seen, pLeft.date_last_seen, pRight.date_last_seen);
	self														:=	pRight;
end;

dJoinedRollup	:=	rollup(SrtBase,
												 tRollupDuplicates(left,right),
												 state_origin,
												 source_code,
												 watercraft_key,
												 persistent_record_id,
												 orig_name,
												 orig_name_last,
												 orig_name_first,
												 orig_name_middle,
												 orig_name_suffix,
												 orig_state,
												 orig_city,
												 orig_address_1,
												 orig_address_2,
												 dob
												);

//Layout expected by the keys 
export File_Base_Search_Dev := project(dJoinedRollup, Watercraft.Layout_Watercraft_Search_Base);

 