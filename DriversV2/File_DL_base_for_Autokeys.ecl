import Doxie_Files, Drivers, DriversV2;

dl_base    := DriversV2.File_DL_Search;



DriversV2.Layout_Drivers  StateTrans(dl_base l) := transform
	self.st := l.orig_state;
	self :=l;
end;

xtrarows := project(dl_base(orig_state <> '' and orig_state <> st),StateTrans(LEFT));
dl_state_norm_base := dl_base + xtrarows;



Layout_DL_AutoKeys  := record
	DriversV2.Layout_Drivers;
	unsigned1 zero  := 0;
	string1   blank := '';
end;

//capture all ssn's
Layout_DL_AutoKeys  NormSsn(dl_state_norm_base l, integer c) := transform
	self.ssn    := choose(c, l.ssn, l.ssn_safe);
	self.zero   := 0;
	self.blank  := '';
	self        := l;
end;

// Normalize the appended ssn
dl_norm_base := normalize(dl_state_norm_base, 
						  if(trim(left.ssn_safe,left,right) <> trim(left.ssn,left,right) and 
							 trim(left.ssn_safe,left,right) <> '' and
							 (integer)left.ssn_safe <> 0 and
							 length(trim(left.ssn_safe,left,right)) = 9, 2,1),
						  NormSsn(left, counter));

export File_DL_base_for_Autokeys := dl_norm_base : persist('~thor_data400::persist::DL2::Search_base_Autokeys');