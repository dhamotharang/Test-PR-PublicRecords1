import ut;

bf4:=project(basefile_flcrash4,transform(	{
											basefile_flcrash4
											,unsigned6 temp_did
											},self.temp_did:=(integer)left.did,self:=left));

ut.mac_suppress_by_phonetype(bf4,driver_phone_nbr,st,flc4,true,temp_did);

export flc4_Keybuild := project(flc4,transform({basefile_flcrash4},self:=left));