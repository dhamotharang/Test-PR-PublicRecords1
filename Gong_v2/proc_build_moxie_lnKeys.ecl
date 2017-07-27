d 			  := Gong_v2.proc_build_moxie_keybuildprep;
dCity   	  := Gong_v2.proc_build_moxie_keybuildprep2;
base_key_Name := Gong_v2.thor_cluster+'key::moxie::gong.';

layoutlNtbl := record
string13 city := d.p_city_name[1..13];
d.p_city_name;
d.area;
d._ln;
d.county;
d.latlong10;
d.latlong25;
d.indvNameMatch;
d.st;
d.z5;
d.__filepos;

end;

lnTbl  := table(d,layoutlntbl)(_ln<>'');

mk1 := buildindex(dedup(lnTbl(area<>''),area,_ln,indvNameMatch,__filepos,all),{area,_ln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'area.ln.match.key',moxie,overwrite);
mk2 := buildindex(dedup(lnTbl(_ln<>''),_ln,indvNameMatch,__filepos,all),{_ln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'ln.match.key',moxie,overwrite);
mk3 := buildindex(dedup(lnTbl(latlong10<>''),latlong10,_ln,indvNameMatch,__filepos,all),{latlong10,_ln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'latlong10.ln.match.key',moxie,overwrite);
mk4 := buildindex(dedup(lnTbl(latlong25<>''),latlong25,_ln,indvNameMatch,__filepos,all),{latlong25,_ln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'latlong25.ln.match.key',moxie,overwrite);
//-------------------------------------------------------------
								lnTbl t_recs(lnTbl L, dCity R):= transform
								self.city := if(R.__filepos = L.__filepos,R.p_city_name[1..13],L.p_city_name[1..13]);
								
								self := L;
								end;

								fullKey := join(lnTbl,dCity,
											left.__filepos = right.__filepos,
											t_recs(left,right),hash);
mk5 := buildindex(dedup(fullKey(st<>''),st,city,_ln,indvNameMatch,__filepos,all),{st,city,_ln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.city.ln.match.key',moxie,overwrite);
//-------------------------------------------------------------
mk6 := buildindex(dedup(lnTbl(st<>''),st,_ln,indvNameMatch,__filepos,all),{st,_ln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.ln.match.key',moxie,overwrite);
mk7 := buildindex(dedup(lnTbl(st<>''),st,county,_ln,indvNameMatch,__filepos,all),{st,county,_ln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.county.ln.match.key',moxie,overwrite);

export proc_build_moxie_lnKeys := parallel(mk1,
mk2,mk3,mk4,mk5,
mk6,mk7);