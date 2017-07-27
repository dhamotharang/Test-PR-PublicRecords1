import  _Validate, header, doxie,Data_Services, NID;

//records with valid dod8
df := Death_Master.File_DeathMaster_Building(_Validate.Date.fIsValid(dob8));

//slim down and dedup
rec := record
	df.dob8;
	df.state;
	string20 dph_lname;
	string25 pfname;
	df.state_death_id;
end;

fk := dedup(project(df, transform(rec,
																	self := left,
																	self.dph_lname := metaphonelib.DMetaPhone1(left.lname),
																	self.pfname := NID.PreferredFirstVersionedStr(left.fname, NID.version))
						), all);

//build index on fname and dod8 
export key_dob := index(
fk,
{dob8, state, dph_lname, pfname},
{state_death_id},
Data_Services.Data_location.prefix('Death')+'thor_data400::key::dob_death_masterV2_' + doxie.Version_SuperKey
);

