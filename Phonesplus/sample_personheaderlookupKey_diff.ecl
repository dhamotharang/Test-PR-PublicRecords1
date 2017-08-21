import doxie, ut;

OldKeyFile	:=	INDEX(Doxie.Key_Did_Lookups_v2,ut.foreign_prod+'~thor_data400::key::header_lookups_v2_father');
NewKeyFile	:=	pull(Doxie.Key_Did_Lookups_v2);

bothkeys0:=OldKeyFile+NewKeyFile;
bothkeys:=dedup(sort(distribute(bothkeys0,hash(did)),did,local),record,local);

r:=record
	bothkeys.did,
	cnt:=count(group);
end;

changedRecs:=table(bothkeys,r,did,local);

dsample := sample(changedRecs(cnt>1),100000,1);

export sample_personheaderlookupKey_diff := output(choosen(dsample,1000),{did});

