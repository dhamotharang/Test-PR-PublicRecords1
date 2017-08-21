FileBase := nac_v2.Files().Base2;

collisions := NAC_V2.Mod_Collisions2(FileBase).AllCollisions;
lfn := Nac_V2.Superfile_List().sfCollisions + '::' + workunit;

SEQUENTIAL(
	OUTPUT(collisions,,lfn,COMPRESSED,OVERWRITE),
	nac_V2.Promote_Superfiles(Nac_V2.Superfile_List().sfCollisions, lfn)
);	
