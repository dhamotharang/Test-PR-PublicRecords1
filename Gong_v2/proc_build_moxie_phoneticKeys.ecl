d 			  := Gong_v2.proc_build_moxie_keybuildprep;
dCity   	  := Gong_v2.proc_build_moxie_keybuildprep2;
base_key_Name := Gong_v2.thor_cluster+'key::moxie::gong.';

layoutphlntbl := record
string13 city:= d.p_city_name[1..13];
string96 advMatch := '';
d.name;
d.name_suffix;
d.prim_range;
d.predir;
d.st_named;
d.sec_range;
d.phoneno;
d.area;
d.p_city_name;
d.county;
d.indvNameMatch;
d.cnameMatch;
d.latlong10;
d.latlong25;
d.pct;
d.pct2;
d.phcn;
d.phln;
d.phln2;
d.pr;
d.pst;
d.pst2;
d.st;
d.z5;
d.__filepos;
string4 normPhcn :='';
end;

phlnTbl  	:= table(d,layoutphlntbl);

phlnTbl norm(phlnTbl L, unsigned1 cnt) := TRANSFORM
self.pct 	:= choose(cnt,L.pct,L.pct2);
self.phln 	:= choose(cnt,L.phln,L.phln2);
self.pst 	:= choose(cnt,L.pst,L.pst2);

self := L;
end;

n_phlnTbl := normalize(phlnTbl,2,norm(left,counter));
//-------------------------------------------------------------
								n_phlnTbl t_recs(n_phlnTbl L, dCity R):= transform
								self.city := if(R.__filepos = L.__filepos,R.p_city_name[1..13],L.p_city_name[1..13]);
								//	names.name_suffix.prim_range.predir.st_name.sec_range.city.st.z5.phone
								self.advMatch		:=  map(L.name[26..29] = 'LLC' => L.name[1..26] + '   ',
															L.name[26..29] = 'LLP' => L.name[1..26] + '   ',
															L.name[26..29] = 'LTD' => L.name[1..26] + '   ',
															L.name[26..29] = ' CO' => L.name[1..26] + '   ',L.name) +
														stringlib.stringtouppercase(L.name_suffix)+
														L.prim_range+
														stringlib.stringtouppercase(L.predir)+
														L.st_named+
														L.sec_range+
														self.city[1..13]+
														stringlib.stringtouppercase(L.st)+
														L.z5+
														L.phoneno;
								
								self := L;
								end;
					

								fullKey := join(n_phlnTbl,dCity,
											left.__filepos = right.__filepos,
											t_recs(left,right),hash);
dd_pct 	:= fullKey(pct <> '');
dd_phln	:= fullKey(phln <> '');
dd_pst 	:= fullKey(pst <> '');


mk1 := buildindex(dedup(dd_phln(area<>''),area,phln,indvNameMatch,__filepos,all),{area,phln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'area.phln.match.key',moxie,overwrite);
mk2 := buildindex(dedup(dd_phln(latlong10<>''),latlong10,phln,indvNameMatch,__filepos,all),{latlong10,phln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'latlong10.phln.match.key',moxie,overwrite);
mk3 := buildindex(dedup(dd_phln(latlong25<>''),latlong25,phln,indvNameMatch,__filepos,all),{latlong25,phln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'latlong25.phln.match.key',moxie,overwrite);
mk4 := buildindex(dedup(dd_phln,phln,indvNameMatch,__filepos,all),{phln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phln.match.key',moxie,overwrite);
mk5 := buildindex(dedup(dd_phln,phln,pr,pst,advMatch,__filepos,all),{phln,pr,pst,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phln.pr.pst.match.key',moxie,overwrite);
mk6 := buildindex(dedup(dd_phln,phln,z5,advMatch,__filepos,all),{phln,z5,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phln.z5.match.key',moxie,overwrite);
mk7 := buildindex(dedup(dd_pct(pr<>''),pr,st,pct,advMatch,__filepos,all),{pr,st,pct,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'pr.st.pct.match.key',moxie,overwrite);
mk8 := buildindex(dedup(fullkey(pr<>''),pr,z5,advMatch,__filepos,all),{pr,z5,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'pr.z5.match.key',moxie,overwrite);
mk9 := buildindex(dedup(dd_phln(st<>''),st,city,phln,indvNameMatch,__filepos,all),{st,city,phln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.city.phln.match.key',moxie,overwrite);								
//-------------------------------------------------------------
mk10 := buildindex(dedup(dd_phln(st<>''),st,county,phln,indvNameMatch,__filepos,all),{st,county,phln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.county.phln.match.key',moxie,overwrite);
mk11 := buildindex(dedup(dd_phln(st<>''),st,phln,indvNameMatch,__filepos,all),{st,phln,indvNameMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.phln.match.key',moxie,overwrite);
mk12 := buildindex(dedup(dd_phln(st<>''),st,phln,pct,advMatch,__filepos,all),{st,phln,pct,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.phln.pct.match.key',moxie,overwrite);

//---------------------------------------------------------------------------

n_phlnTbl norm2(n_phlnTbl L, unsigned1 cnt) := TRANSFORM

self.normPhcn 	:= L.phcn[((cnt-1)*4)+1..((cnt-1)*4)+4];;

self := L;
end;

n_phcnTbl := normalize(n_phlnTbl,length(left.phcn) / 4,norm2(left,counter));
//-------------------------------------------------------------
								n_phcnTbl t_recs2(n_phcnTbl L, dCity R):= transform
								self.city := if(R.__filepos = L.__filepos,R.p_city_name[1..13],L.p_city_name[1..13]);
								//	names.name_suffix.prim_range.predir.st_name.sec_range.city.st.z5.phone
								self.advMatch		:=  map(L.name[26..29] = 'LLC' => L.name[1..26] + '   ',
															L.name[26..29] = 'LLP' => L.name[1..26] + '   ',
															L.name[26..29] = 'LTD' => L.name[1..26] + '   ',
															L.name[26..29] = ' CO' => L.name[1..26] + '   ',L.name) +
														stringlib.stringtouppercase(L.name_suffix)+
														L.prim_range+
														stringlib.stringtouppercase(L.predir)+
														L.st_named+
														L.sec_range+
														self.city[1..13]+
														stringlib.stringtouppercase(L.st)+
														L.z5+
														L.phoneno;
								
								self := L;
								end;
					

								fullKey2 := join(n_phcnTbl,dCity,
											left.__filepos = right.__filepos,
											t_recs2(left,right),hash);
dd_phcn	:= dedup(fullKey2(phcn <> ''),record);
//---------------------------------------------------------------------------								
mk13 := buildindex(dedup(dd_phcn,normPhcn,pr,pst,advMatch,__filepos,all),{normPhcn,pr,pst,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phcn.pr.pst.match.key',moxie,overwrite);								
mk14 := buildindex(dedup(dd_phcn,normPhcn,z5,advMatch,__filepos,all),{normPhcn,z5,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phcn.z5.match.key',moxie,overwrite);
mk15:= buildindex(dedup(dd_phcn(st<>''),st,normPhcn,pct,advMatch,__filepos,all),{st,normPhcn,pct,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.phcn.pct.match.key',moxie,overwrite);							
								
export proc_build_moxie_phoneticKeys := parallel(mk1,mk2,mk3,
mk4,mk5,
mk6,
mk7,
mk8,
mk9,
mk10,mk11,
mk12,mk13,
mk14,mk15);