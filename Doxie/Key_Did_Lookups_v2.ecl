import header;

// first portion repeated from Key_Did_Lookups
res1 := exp_lookups;
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

// add in new lookup counts
res3 := lookups_v2;

resrec2 := record
	resrec; 
	unsigned2 corp_affil_count := 0;
	unsigned2 comp_prop_count := 0;
	unsigned2 phonesplus_count := 0;
  unsigned2 nonfares_prop_count := 0;
  unsigned2 nofares_prop_asses_count := 0;
  unsigned2 nofares_prop_deeds_count := 0;
  unsigned2 filler5_count := 0;
  unsigned2 filler6_count := 0;
  unsigned2 filler7_count := 0;
  unsigned2 filler8_count := 0;
  unsigned2 filler9_count := 0;
  unsigned2 filler10_count := 0;	
end;

resrec2 into2(resrec L, res3 R) := transform
	self.did := if (L.did != 0, L.did, R.did);
	self := L;
	self := R;
end;

res_out := join(res,res3,left.did = right.did,into2(LEFT,RIGHT),full outer,hash);

export Key_Did_Lookups_v2 := index(res_out,{did},{res_out},'~thor_data400::key::header_lookups_v2_' + version_superkey);