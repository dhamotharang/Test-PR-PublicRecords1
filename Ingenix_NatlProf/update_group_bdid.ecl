import ingenix_natlprof,ut;


Provider_Group 		:= 	distribute(File_in_ProviderGroup.Allsrc(trim(GroupPracticeID,left,right)<>''),hash(FILETYP, GroupPracticeID));

Group_Affiliation	:=	distribute(File_in_GroupAffiliation.Allsrc,hash(FILETYP, GroupPracticeID));

Ingenix_NatlProf.Layout_in_ProviderGroupAffiliation trfBlankFields(Provider_Group L) := Transform
	self 														:= L;
	self 														:= [];
end;

Provider_Rest			:=  project(File_in_ProviderGroup.Allsrc(trim(GroupPracticeID,left,right)=''),trfBlankFields(left));

Ingenix_NatlProf.Layout_in_ProviderGroupAffiliation Join_GroupAffiliation(Provider_Group L,Group_Affiliation R) := Transform
	self 														:= R;
	self 														:= L;
end;

Joined_GroupAffiliation := 	join(	Provider_Group,
																	Group_Affiliation,
																	left.FILETYP = right.FILETYP and 
																	left.GroupPracticeID = right.GroupPracticeID,
																	Join_GroupAffiliation(left,right), 
																	left outer,
																	local
																	);	

combinedFiles		:= Joined_GroupAffiliation + Provider_Rest;																

file_dist := distribute(combinedFiles, hash(FILETYP, ProviderID));
file_sort := sort(file_dist,FILETYP, ProviderID, GroupName, -processdate, local);

Ingenix_NatlProf.Layout_in_ProviderGroupAffiliation  rollupXform(Ingenix_NatlProf.Layout_in_ProviderGroupAffiliation l, Ingenix_NatlProf.Layout_in_ProviderGroupAffiliation r) := transform
		self.Processdate    					:= if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_First_Seen 						:= if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  						:= if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self 													:= l;
end;

export update_group_bdid := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP,ProviderID,GroupName,local);                            
