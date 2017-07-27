Import Data_Services, doxie;

base_recs_seeded := MXD_MXDocket.FileKeyBuild;

MXDocketParty := record
  unsigned8		entity_id;
  unsigned8		rec_id;
  unsigned1		partytype;
  string1			partynumber;
  unicode50		firstname;
  unicode50		middlename1;
  unicode20		middlename2;
  unicode20		middlename3;
  unicode20		middlename4;
  unicode20		middlename5;
  unicode50		lastname;
  unicode50		matronymic;
  unicode50		husbandslastname;
  unicode50		patronymic;
  unicode50		partyalias;
  string1			gender;  	
  unicode200	partyoriginal;
end;

dsDocketParties	:=	dedup(sort(project(base_recs_seeded, MXDocketParty),record,local),record,local);

export Key_DocketParty := index(	dsDocketParties,
																	{entity_id, rec_id},															 
																	{partytype, partynumber, firstname, middlename1, middlename2, middlename3, middlename4, middlename5,
																		lastname, matronymic, husbandslastname, patronymic, partyalias, gender, partyoriginal},
																	Data_Services.Data_location.Prefix('MXData')+'thor_data400::key::mxd_mxdocket::'+doxie.Version_SuperKey+'::docket_party_idx'
																	);