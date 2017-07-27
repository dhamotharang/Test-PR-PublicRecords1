import doxie,header;
res1 := doxie.Lookups;
res2 := header.LivingSituation;

resrec := record
	res1; 
	unsigned6 hhid;
	//string1	status;
	string1   gender;
	unsigned2 house_size;
	unsigned2 sg_within_7;
	unsigned2 dg_within_7;
	unsigned2 ug_within_7;
	unsigned2 sg_y_8_15;
	unsigned2 dg_y_8_15;
	unsigned2 ug_y_8_15;
	unsigned2 sg_y_16_30;
	unsigned2 dg_y_16_30;
	unsigned2 ug_y_16_30;
	unsigned2 sg_o_8_15;
	unsigned2 dg_o_8_15;
	unsigned2 ug_o_8_15;
	unsigned2 sg_o_16_30;
	unsigned2 dg_o_16_30;
	unsigned2 ug_o_16_30;
	unsigned2 sg_o_30;
	unsigned2 dg_o_30;
	unsigned2 ug_o_30;
	unsigned2 sg_y_30;
	unsigned2 dg_y_30;
	unsigned2 ug_y_30;
	unsigned2 sg;
	unsigned2 dg;
	unsigned2 ug;
	unsigned2	kids;
	unsigned2	parents;
end;

resrec into(res1 L, res2 R) := transform
	self.did := if (l.did != 0, L.did, r.did);
	self := l;
	self := R;
end;

res := join(res1,res2,left.did = right.did,into(Left,right),full outer,hash);


export Key_prep_Did_Lookups := index(res,{res},'~thor_data400::key::header_lookups' + thorlib.wuid());