import header;

//DeathMaster stores DID as a string12
deathmaster_did_rec := record
 unsigned6 did;
end;

deathmaster_did_rec redefine_deathmaster_did(header.Layout_Did_Death_Master l) := transform
 self.did := (unsigned6)l.did;
end;

deathmaster_dids := distribute(dedup(project(header.File_Did_Death_Master,redefine_deathmaster_did(left))(did<>0),did,all),hash(did));

first_data.layout_fatrec filter_dids_found_in_deathmaster(first_data.layout_fatrec l, deathmaster_did_rec r) := transform
 self := l;
end;

people_after_deathmaster_join := join(first_data.Append_Mktg_Best_To_Additional_Members,deathmaster_dids,
                                      left.did=right.did,
								      filter_dids_found_in_deathmaster(left,right),
								      left only,local
								     );

//Stat ran in December, 2006 revealed about 700k people indicated as dead in the
//Marketing Header but were not found in the DeathMaster file
living_people := people_after_deathmaster_join(trim(mktg_dod)='');

export Remove_Dead_People := living_people;