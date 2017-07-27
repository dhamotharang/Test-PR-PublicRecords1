
Import Data_Services, header,doxie, death_master,ut;

//get infomation from supplemental file based on state_death_id
dMasterSupplemental	:=	header.file_death_master_supplemental;
dDIDMasterV3				:=	Header.File_DID_Death_MasterV3;

// Remove record from Supplemental Key if state_death_id does not exist in V3.
// This removes orphaned records and V3 records which has been resurrected.
dClnResurrections	:=	JOIN(
												DISTRIBUTE(dDIDMasterV3,HASH(state_death_id)),
												DISTRIBUTE(dMasterSupplemental,HASH(state_death_id)),
													LEFT.state_death_id	=	RIGHT.state_death_id,
												TRANSFORM(RECORDOF(RIGHT),SELF:=RIGHT),
												LOCAL
											);
											
//Remove partial SSN and remove rawaid field.
header.layout_death_master_slim_supplemental rmv_partial_ssn(dClnResurrections l) := TRANSFORM
	self.ssn := IF(l.ssn[1..5] = '00000','',l.ssn);
	self := l;
end;

ds_rmv_partialSSN := project(dClnResurrections, rmv_partial_ssn(left));

//distribute and sort by state_death_id
death_supplemental_dist := distribute(ds_rmv_partialSSN, hash(state_death_id));
death_supplemental_sort := sort(death_supplemental_dist,state_death_id, local); 

//build index on state_death_id

export key_death_id_supplemental := index(death_supplemental_sort,
                               {state_death_id},{death_supplemental_sort},
				           Data_Services.Data_location.prefix('Death')+'thor_data400::key::death_id_death_supplemental_'+ doxie.Version_SuperKey);

