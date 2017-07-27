d 			  := Gong_v2.proc_build_moxie_keybuildprep;
dCity   	  := Gong_v2.proc_build_moxie_keybuildprep2;
base_key_Name := Gong_v2.thor_cluster+'key::moxie::gong.';

layoutPCNtbl := record
d.area;
string13 city := d.p_city_name[1..13];
d.p_city_name;
d.pcn;
d.county;
d.latlong10;
d.latlong25;
d.cnameMatch;
d.st;
d.z5;
d.__filepos;
string5 normPCN := '';

end;

pcnTbl  := table(d,layoutpcntbl);


pcnTbl norm(pcnTbl L, unsigned1 cnt) := TRANSFORM
	self.normPCN := L.pcn[((cnt-1)*5)+1..((cnt-1)*5)+5];
	self 	:= L;
end;




n_pcnTbl := normalize(pcnTbl,length(left.pcn) /5,norm(left,counter));
dd_pcn 	 := dedup(n_pcnTbl(normPCN <> ''),record);

mk1 := buildindex(dedup(dd_pcn(area<>''),area,normPCN,cnameMatch,__filepos,all),{area,normPCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'area.pcn.match.key',moxie,overwrite);
mk2 := buildindex(dedup(dd_pcn(cnameMatch<>''),normPCN,cnameMatch,__filepos,all),{normPCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'pcn.match.key',moxie,overwrite);
mk3 := buildindex(dedup(dd_pcn(latlong10<>''),latlong10,normPCN,cnameMatch,__filepos,all),{latlong10,normPCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'latlong10.pcn.match.key',moxie,overwrite);
mk4 := buildindex(dedup(dd_pcn(latlong25<>''),latlong25,normPCN,cnameMatch,__filepos,all),{latlong25,normPCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'latlong25.pcn.match.key',moxie,overwrite);
//-------------------------------------------------------------
								dd_pcn t_recs(dd_pcn L, dCity R):= transform
								self.city := if(R.__filepos = L.__filepos,R.p_city_name[1..13],L.p_city_name[1..13]);
								
								self := L;
								end;

								fullKey := join(dd_pcn,dCity,
											left.__filepos = right.__filepos,
											t_recs(left,right),hash);
mk5 := buildindex(dedup(fullKey(st<>''),st,city,normPCN,cnameMatch,__filepos,all),{st,city,normPCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.city.pcn.match.key',moxie,overwrite);
//-------------------------------------------------------------
mk6 := buildindex(dedup(dd_pcn(st<>''),st,normPCN,cnameMatch,__filepos,all),{st,normPCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.pcn.match.key',moxie,overwrite);
mk7 := buildindex(dedup(dd_pcn(st<>''),st,county,normPCN,cnameMatch,__filepos,all),{st,county,normPCN,cnameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.county.pcn.match.key',moxie,overwrite);

export proc_build_moxie_pcnKeys := parallel(mk1,mk2,mk3,
mk4,mk5,
mk6,mk7);