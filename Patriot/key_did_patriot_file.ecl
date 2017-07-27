import doxie;

layout_pat_keybuild := record
	patriot.Layout_Patriot;
	unsigned8	__fpos {virtual(fileposition)};
end;

ds := dataset('~thor_data400::in::patriot_file',Layout_Pat_keybuild,flat);

xl :=
RECORD
	unsigned6 did;
	layout_pat_keybuild;
END;

xl appendDid(patriot.Dids_With_Namehook le, ds ri) :=
TRANSFORM
	SELF.did := le.did;
	SELF := ri;
END;
j := JOIN(patriot.Dids_With_Namehook,ds,LEFT.fname=RIGHT.fname AND
								LEFT.mname=RIGHT.mname AND
								LEFT.lname=RIGHT.lname, appendDid(LEFT,RIGHT), HASH);

d := DEDUP(j,ALL);

export key_did_patriot_file := INDEX(d,{did},{j},'~thor_data400::key::patriot_did_file_'+doxie.Version_SuperKey);