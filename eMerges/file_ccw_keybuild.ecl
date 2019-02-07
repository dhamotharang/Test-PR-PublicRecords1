import ut;

string_rec := record
	emerges.layout_ccw_out;
  unsigned integer8 __filepos { virtual(fileposition)};
end;

ds_ccw := emerges.Prep_Build.ConCarry('~thor_data400::base::emerges_ccw_building', string_rec);

layout_supress_phone	:= record
	emerges.layout_ccw_out;
	unsigned6	did;
	unsigned8 __filepos;
end;

layout_supress_phone reformat(ds_ccw l) := transform
	self.did				:= (unsigned6) l.did_out;
	self.__filepos	:= l.__filepos;
	self						:= l;
end;

ccw_suppress_in	:= project(ds_ccw,reformat(left));

ut.mac_suppress_by_phonetype(ccw_suppress_in,phone,source_state,tmp_ccw_out1,true,did);
ut.mac_suppress_by_phonetype(tmp_ccw_out1,work_phone,st,tmp_ccw_out2,true,did);
ut.mac_suppress_by_phonetype(tmp_ccw_out2,other_phone,mail_st,ccw_suppress_out,true,did);

ds_ccw reformat1(ccw_suppress_out l) := transform
	self := l;
end;

ccw_out := project(ccw_suppress_out,reformat1(left)); //: persist('~thor_data400::persist::emerges::ccw_phone_suppression');

export file_ccw_keybuild := ccw_out;