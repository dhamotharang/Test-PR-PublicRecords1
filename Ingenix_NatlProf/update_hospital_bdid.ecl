import ingenix_natlprof,ut;



Provider_Hospital 		:= 	distribute(Ingenix_NatlProf.File_in_ProviderHospital.Allsrc(trim(HospitalID,left,right)<>''),hash(filetyp,hospitalID));

Hospital_Affiliation	:=	distribute(Ingenix_NatlProf.File_in_HospitalAffiliation.Allsrc,hash(filetyp,hospitalID));

Ingenix_NatlProf.Layout_in_ProviderHospitalAffiliation trfBlankFields(Provider_Hospital l) := Transform
	self 														:= L;
	self 														:= [];
end;

Provider_Rest			:=  project(Ingenix_NatlProf.File_in_ProviderHospital.Allsrc(trim(HospitalID,left,right)=''),trfBlankFields(left));

Ingenix_NatlProf.Layout_in_ProviderHospitalAffiliation Join_HospitalAffiliation(Provider_Hospital l,Hospital_Affiliation R) := Transform
	self 														:= R;
	self 														:= L;
end;

Joined_HospitalAffiliation := 	join(	Provider_Hospital,
																			Hospital_Affiliation,
																			left.FILETYP = right.FILETYP and 
																			left.HospitalID = right.HospitalID,
																			Join_HospitalAffiliation(left,right),
																			left outer,
																			local
																			);	
																			
combinedFiles		:= Joined_HospitalAffiliation + Provider_Rest;																					

file_dist := distribute(combinedFiles, hash(FILETYP, ProviderID));
file_sort := sort(file_dist,FILETYP, ProviderID, HospitalName, -ProcessDate, local);

Ingenix_NatlProf.Layout_in_ProviderHospitalAffiliation  rollupXform(Ingenix_NatlProf.Layout_in_ProviderHospitalAffiliation l, Ingenix_NatlProf.Layout_in_ProviderHospitalAffiliation r) := transform
		self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

export update_hospital_bdid := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP,ProviderID,HospitalName,local);
                                







