d 			  := Gong_v2.proc_build_moxie_keybuildprep;
dCity   	  := Gong_v2.proc_build_moxie_keybuildprep2;
base_key_Name := Gong_v2.thor_cluster+'key::moxie::gong.';

layoutCNtbl := record
string13 city:=d.p_city_name[1..13];
d.area;
d.p_city_name;
d.cn;
d.county;
d.latlong10;
d.latlong25;
d.cnameMatch;
d.st;
d.z5;
d.__filepos;
string10 normCN := '';

end;


cnTbl  := table(d,layoutCNtbl);

cnTbl norm(cnTbl L, unsigned1 cnt) := TRANSFORM
	self.normCN := L.cn[((cnt-1)*10)+1..((cnt-1)*10)+10];
	self 	:= L;
end;
n_cnTbl := normalize(cnTbl,length(left.cn) / 10,norm(left,counter));
dd_cn 	:= dedup(n_cnTbl(normCN <> ''),record,all);

mk1 := buildindex(dedup(dd_cn(area<>''),area,normCN,cnameMatch,all),{area,normCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'area.cn.match.key',moxie,overwrite);
mk2 := buildindex(dedup(dd_cn(cnameMatch<>''),normCN,cnameMatch,all),{normCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'cn.match.key',moxie,overwrite);
mk3 := buildindex(dedup(dd_cn(latlong10<>''),latlong10,normCN,cnameMatch,all),{latlong10,normCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'latlong10.cn.match.key',moxie,overwrite);
mk4 := buildindex(dedup(dd_cn(latlong25<>''),latlong25,normCN,cnameMatch,all),{latlong25,normCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'latlong25.cn.match.key',moxie,overwrite);
//-------------------------------------------------------------
								dd_cn t_recs(dd_cn L, dCity R):= transform
								self.city := if(R.__filepos = L.__filepos,R.p_city_name[1..13],L.p_city_name[1..13]);
								self := L;
								end;

								fullKey := join(dd_cn,dCity,
											left.__filepos = right.__filepos,
											t_recs(left,right),hash);
					
mk5 := buildindex(dedup(fullKey(st<>''),st,city,normCN,cnameMatch,__filepos,all),{st,city,normCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.city.cn.match.key',moxie,overwrite);
//-------------------------------------------------------------
mk6 := buildindex(dedup(dd_cn(st<>''),st,normCN,cnameMatch,all),{st,normCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.cn.match.key',moxie,overwrite);
mk7 := buildindex(dedup(dd_cn(st<>''),st,county,normCN,cnameMatch,all),{st,county,normCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.county.cn.match.key',moxie,overwrite);

export proc_build_moxie_cnKeys := parallel(mk1,mk2,mk3,mk4,mk5,mk6,mk7);