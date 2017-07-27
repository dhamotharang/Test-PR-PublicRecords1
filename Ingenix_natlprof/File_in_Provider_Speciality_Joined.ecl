//---------Join Providerspeciality and speciality Address tables-------------------

//###############################Left Table##################################
Provider_Speciality := Ingenix_NatlProf.File_in_providerspeciality;
Dist_Provider_Speciality := distribute(Provider_Speciality,hash(specialityid, filetyp, processdate));
Sort_Provider_Speciality := Sort(Dist_Provider_Speciality,specialityid,filetyp, processdate,local);

//###############################right Table##################################
speciality := Ingenix_NatlProf.File_in_speciality;
Dist_speciality := distribute(speciality,hash(specialityid, filetyp, processdate));
Sort_speciality := Sort(Dist_speciality,specialityid,filetyp, processdate,local);

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
Layout_Providerspeciality Join_providerspeciality(Sort_Provider_Speciality l,Sort_speciality R) := Transform

self := L;
self := R;
end;

Joined_providerspeciality := join(Sort_Provider_Speciality,Sort_speciality,
										left.specialityid = right.specialityid and left.FILETYP = right.FILETYP
										and left.PROCESSDATE = right.PROCESSDATE,
										Join_providerspeciality(left,right), left outer, local);	
									   
									   
//##############################Join Providerspeciality to specialitygroup############################

//#################################Left File##########################################

Dist_ProviderSpeciality := distribute(Joined_providerspeciality,hash(specialitygroupid, filetyp, processdate));
Sort_ProviderSpeciality := Sort(Dist_ProviderSpeciality,specialitygroupid,filetyp, processdate,local);


//###############################Right Table#################################

specialitygroup := Ingenix_NatlProf.File_in_specialitygroup;
Dist_specialitygroup := distribute(specialitygroup, hash(specialitygroupId,filetyp, processdate));
Sort_specialitygroup := Sort(Dist_specialitygroup,specialitygroupId,filetyp, processdate,local);


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

Layout_Providerspecialitygroup Join_providerspecialitygroup(Sort_ProviderSpeciality l,Sort_specialitygroup R) := Transform

self := L;
self := R;
end;


Joined_providerspecialitygroup := join(Sort_ProviderSpeciality,Sort_specialitygroup,
										left.specialitygroupid = right.specialitygroupid and left.FILETYP = right.FILETYP
										and left.PROCESSDATE = right.PROCESSDATE,
										Join_providerspecialitygroup(left,right), left outer, local);	
									   

export File_in_Provider_Speciality_Joined := dedup(Joined_providerspecialitygroup,all);