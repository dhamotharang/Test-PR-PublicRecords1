d 			  := Gong_v2.proc_build_moxie_keybuildprep;
dCity   	  := Gong_v2.proc_build_moxie_keybuildprep2;
base_key_Name := Gong_v2.thor_cluster+'key::moxie::gong.';

layoutlfmnametbl := record
string13 city := d.p_city_name[1..13];
d.addr;
d.lfmname;
d.lfmname2;
d.lfmname3;
d.lfmname4;
d.neighbor;
d.p_city_name;
d.prim_name;
d.prim_range;
d.st;
d.z3;
d.z5;
d.__filepos;
end;

lfmnameTbl  := table(d,layoutlfmnametbl);


lfmnameTbl normlfmname(lfmnameTbl L, unsigned1 cnt) := TRANSFORM
self.lfmname 		:= choose(cnt,L.lfmname,L.lfmname2,L.lfmname3,L.lfmname4);

self := L;
end;

n_lfmnameTbl := normalize(lfmnameTbl,4,normlfmname(left,counter));
dd_lfmname 	:= dedup(n_lfmnameTbl(lfmname <> ''),record);

mk1 := buildindex(dedup(dd_lfmname(lfmname<>''),lfmname,__filepos,all),{lfmname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'lfmname.key',moxie,overwrite);
mk2 := buildindex(dedup(dd_lfmname(st<>''),st,lfmname,__filepos,all),{st,lfmname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.lfmname.key',moxie,overwrite);

//-------------------------------------------------------------
								dd_lfmname t_recs(dd_lfmname L, dCity R):= transform
								self.city := if(R.__filepos = L.__filepos,R.p_city_name[1..13],L.p_city_name[1..13]);
								
								self := L;
								end;

								fullKey := join(dd_lfmname,dCity,
											left.__filepos = right.__filepos,
											t_recs(left,right),hash);
mk3 := buildindex(dedup(fullKey(st<>''),st,city,lfmname,__filepos,all),{st,city,lfmname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.p_city_name.lfmname.key',moxie,overwrite);//doesn't seem to aggree with gongv1 def comments but using full p_city_name causes keylength mismatch.
mk4 := buildindex(dedup(fullKey(st<>''),st,prim_name,prim_range,lfmname,city,__filepos,all),{st,prim_name,prim_range,lfmname,city,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.prim_name.prim_range.lfmname.city.key',moxie,overwrite);
//-------------------------------------------------------------
mk5 := buildindex(dedup(dd_lfmname(z3<>''),z3,lfmname,__filepos,all),{z3,lfmname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'z3.lfmname.key',moxie,overwrite);
mk6 := buildindex(dedup(dd_lfmname(z5<>''),z5,lfmname,__filepos,all),{z5,lfmname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'z5.lfmname.key',moxie,overwrite);
mk7 := buildindex(dedup(dd_lfmname(z5<>''),z5,addr,lfmname,__filepos,all),{z5,addr,lfmname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'z5.addr.lfmname.key',moxie,overwrite);
mk8 := buildindex(dedup(dd_lfmname(z5<>''),z5,neighbor,lfmname,__filepos,all),{z5,neighbor,lfmname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'z5.neighbor.lfmname.key',moxie,overwrite);
mk9 := buildindex(dedup(dd_lfmname(z5<>''),z5,prim_name,prim_range,lfmname,__filepos,all),{z5,prim_name,prim_range,lfmname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'z5.prim_name.prim_range.lfmname.key',moxie,overwrite);

export proc_build_moxie_lfmnameKeys := parallel(mk1,
mk2,mk3,mk4
,mk5,mk6,mk7,mk8,mk9);