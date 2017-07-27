import DriversV2, ut, Roxiekeybuild;

export Proc_Build_wildcard_search(string filedate) := function

	Base := DriversV2.file_dl_search;	

	Layout_DL_Wildcard tMap(Layout_Drivers l) :=	transform
		self.dl_number				:= l.dl_number;
		self.dl_seq						:= l.dl_seq;
		self.orig_state				:= ut.St2Code(l.orig_state);
		self.gender 					:= l.sex_flag;
		self.years_since_1900	:= (integer)l.dob div 10000 - 1900;
	end;
		
	dsWildcard := project(Base, tMap(left));
		
	wcDedup	:= dedup((sort((distribute(dsWildcard, hash(dl_seq,dl_number))), record, local)), record, local);
		
	Roxiekeybuild.MAC_SF_BuildProcess(wcDedup
																		,'~thor_data400::data::dl2::wildcard'
																		,'~thor_data400::data::dl2::'+filedate+'::wildcard'
																		,	c1);

	build_wildcard := c1;

	return build_wildcard ;
end;
