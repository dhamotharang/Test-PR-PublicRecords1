//---------Join Providerspeciality and speciality Address tables-------------------

//###############################Left Table##################################
Provider_Speciality := Ingenix_NatlProf.update_providerspeciality;

//###############################right Table##################################
speciality := Ingenix_NatlProf.update_speciality;

//############################Layout for the Output##########################

Layout_Providerspeciality := {
string  FILETYP;
string  PROCESSDATE;  
string	ProviderID;
string	SpecialityID;
string	SpecialtyCompanyCount;
string	SpecialtyTierTypeID;
string	SpecialityName;
string	SpecialityGroupID;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;

};

//#######################Transform for first Join################################################
Layout_Providerspeciality Join_providerspeciality(Provider_Speciality l,speciality R) := Transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);	
self := L;
self := R;
end;

Joined_providerspeciality := join(Provider_Speciality,speciality,
										left.specialityid = right.specialityid and left.FILETYP = right.FILETYP,
										Join_providerspeciality(left,right), left outer, local);	
									   
									   
//##############################Join Providerspeciality to specialitygroup############################

//#################################Left File##########################################

Dist_ProviderSpeciality := distribute(Joined_providerspeciality,hash(filetyp,specialitygroupid));
Sort_ProviderSpeciality := Sort(Dist_ProviderSpeciality,filetyp,specialitygroupid,local);


//###############################Right Table#################################

specialitygroup := Ingenix_NatlProf.update_specialitygroup;

//############################Layout for the Output##########################

Layout_Providerspecialitygroup := {
string  FILETYP;
string  PROCESSDATE;  
string	ProviderID;
string	SpecialityID;
string	SpecialtyCompanyCount;
string	SpecialtyTierTypeID;
string	SpecialityName;
string	SpecialityGroupID;
string	SpecialityGroupName;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;

};

//#######################Transform for first Join################################################

Layout_Providerspecialitygroup Join_providerspecialitygroup(Sort_ProviderSpeciality l,specialitygroup R) := Transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);	
self := L;
self := R;
end;


Joined_providerspecialitygroup := join(Sort_ProviderSpeciality,specialitygroup,
										left.specialitygroupid = right.specialitygroupid and left.FILETYP = right.FILETYP,
										Join_providerspecialitygroup(left,right), left outer, local);	
									   

export File_in_Provider_Speciality_Joined := dedup(Joined_providerspecialitygroup,all):persist('~thor_data400::persist::Ingenix_provider_specialitygroup_joined');