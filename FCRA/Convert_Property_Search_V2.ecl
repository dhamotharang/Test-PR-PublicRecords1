export Convert_Property_Search_V2 := function



kf := dedup(sort(dataset ('~thor_data400::base::override::fcra::qa::property_search_v2',
               FCRA.Layout_Override_Property_Search_In, flat,opt),-flag_file_id),except flag_file_id,keep(1));


// This is practically LN_PropertyV2/layout_search_building, with a few fields defined in a different order

FCRA.Layout_Override_Property_Search_Out proj_rec(kf l) := transform
	self.dt_first_seen := (unsigned3)l.dt_first_seen;
	self.dt_last_seen := (unsigned3)l.dt_last_seen;
	self.dt_vendor_first_reported := (unsigned3)l.dt_vendor_first_reported;
	self.dt_vendor_last_reported := (unsigned3)l.dt_vendor_last_reported;
	self.did := (unsigned6)l.did;
	self.bdid := (unsigned6)l.bdid;
	self.__internal_fpos__ := (unsigned8)l.__internal_fpos__;
	self := l;
end;

proj_out := project(kf,proj_rec(left));

return proj_out;

end;