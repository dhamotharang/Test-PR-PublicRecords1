import ut;

string_rec := record
	emerges.layout_hunters_out;
  unsigned integer8 __filepos { virtual(fileposition)};
end;

ds_hunt := emerges.Prep_Build.hunt_fish('~thor_data400::base::emerges_hunt_building', string_rec);

// Function for zero filling
string9	fZeroFill(string pString)	:=	function
	string9	inString	:=	trim(pString, left, right);
	strTrailingSpaces	:=	regexfind('([ ]*)$', inString, 1);
	strZeroFill				:=	regexreplace(' ', strTrailingSpaces, '0');
	strRetVal					:=	if(regexfind('^[0]*$', strZeroFill+inString), '', strZeroFill+inString);
	return	strRetVal;
end;

layout_supress_phone	:= record
	emerges.layout_hunters_out;
	unsigned6	did;
	unsigned8 __filepos;
end;

// Left fill permit number with zero's for AR
layout_supress_phone reformat(ds_hunt l) := transform
	self.HuntFishPerm	:= if(l.source_state = 'AR' and
													StringLib.StringToUpperCase(l.file_id) = 'HUNT' and
													trim(l.HuntFishPerm,left,right) != '' and
													length(trim(l.HuntFishPerm,left,right)) < 9,
													fZeroFill(l.HuntFishPerm),
													l.HuntFishPerm
												 );
	self.did					:= (unsigned6) l.did_out;
	self.__filepos		:= l.__filepos;
	self							:= l;
end;

hunt_suppress_in	:= project(ds_hunt,reformat(left));

ut.mac_suppress_by_phonetype(hunt_suppress_in,phone,HomeState,tmp_hunt_out1,true,did);
ut.mac_suppress_by_phonetype(tmp_hunt_out1,work_phone,st,tmp_hunt_out2,true,did);
ut.mac_suppress_by_phonetype(tmp_hunt_out2,other_phone,mail_st,hunt_suppress_out,true,did);

ds_hunt reformat1(hunt_suppress_out l) := transform
	self := l;
end;

hunt_out := project(hunt_suppress_out,reformat1(left)); //: persist('~thor_data400::persist::emerges::hunt_phone_suppression');

export file_hunters_keybuild := hunt_out;