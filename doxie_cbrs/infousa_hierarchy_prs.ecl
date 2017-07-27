import infousa,ut;
keepgoing(string abinum, string parentnum) := if(abinum = parentnum, 1, 0);

k := infousa.Key_ABIUS_ABI_number;

// First get initial abi
abis := CHOOSEN(infousa.Key_ABIUS_Bdid(bdid=doxie_cbrs.subject_BDID),1);
t := JOIN(abis, k, keyed(LEFT.abi_number=RIGHT.abi_number), KEEP(1));

boolean done(string3 s) := (integer)s = 0;

// then traverse a few levels
rec := record
	InfoUSA.Layout_ABIUS_Company_Base.abi_number;
	InfoUSA.Layout_ABIUS_Company_Base.bdid;
	InfoUSA.Layout_ABIUS_Company_Base.Subsidiary_Parent_num;
	InfoUSA.Layout_ABIUS_Company_Base.Ultimate_Parent_num;
	unsigned1 level := 5;
end;

rec tra(k r, unsigned1 rl) := transform
	self.level := rl;
	self.SUBSIDIARY_PARENT_NUM := 
		if(r.SUBSIDIARY_PARENT_NUM = r.abi_number,
			 r.ultimate_PARENT_NUM,
			 r.SUBSIDIARY_PARENT_NUM);
	self := r;
end;

go_up(dataset(rec) ds_pn, unsigned1 rl) := 
	if(exists(ds_pn((integer)SUBSIDIARY_PARENT_NUM > 0)),
		 topn(join(ds_pn, k,
							 left.SUBSIDIARY_PARENT_NUM = right.abi_number, tra(right, rl)),
					1,keepgoing(abi_number, SUBSIDIARY_PARENT_NUM)));

ut.MAC_Slim_Back(t, rec, tr)
up1 := go_up(tr, 4);

up2 := go_up(up1, 3);

up3 := go_up(up2, 2);

up4 := go_up(up3, 1);

up5 := go_up(up4, 0);


unf := sort((up1 + up2 + up3 + up4 + up5)(SUBSIDIARY_PARENT_NUM <> ''), level);
	
doxie_cbrs.layout_hierarchy_prs form(unf l) := transform
	self.name := '';
	self := l;
end;
	
export infousa_hierarchy_prs := project(unf(bdid > 0), form(left));