import Doxie_Files, doxie_build, Drivers, DriversV2;

//dl_base := dataset('~thor400_88::base::dl_vtsa::qa::DLSearch', DriversV2.Layout_Drivers, flat);
dl_base := dataset('~thor400_92::base::scankdl::qa::dlsearch', DriversV2.Layout_Drivers, flat);

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
	self.ssn    := l.ssn;		//choose(c, l.ssn, l.ssn_safe);
	self.ssn_safe := l.ssn;		// do this for now
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

export File_DL_base_for_Autokeys := dl_norm_base : persist(constants.cluster + 'out::dl_VTSA::Search_base_Autokeys');

