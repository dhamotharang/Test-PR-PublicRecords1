import Gong,lib_metaphone,lib_KeyLib,Address;
base_key_Name := Gong_v2.thor_cluster+'key::moxie::gong.';

////////////////////////////////////////////////////////////////////////////////
/*gongBuilding  := distribute(Gong_v2.File_Base_Building_Indexes,hash(phoneno));
deletes 	  := distribute(dedup(Gong_v2.file_DailyDeletions,npa,telno,all),hash(npa,telno));

gongBuilding t_deletes(gongBuilding L, deletes R):= transform
self := L;
end;

jrecs := join(gongBuilding,deletes,
			left.phoneno = right.npa+right.telno,
			t_deletes(left,right),local);
			
layoutdeletes := record
jrecs.phoneno;
jrecs.__filepos;
end;
tbldeletes := table(jrecs,layoutdeletes,phoneno,__filepos);

mk1 := buildindex(tbldeletes(phoneno<>''),{phoneno,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'deletes.key',moxie,overwrite);
*/								
////////////////////////////////////////////////////////////////////////////////////////////////////////////
d 			  := Gong_v2.proc_build_moxie_keybuildprep;
dCity   	  := Gong_v2.proc_build_moxie_keybuildprep2;




layoutphonetbl := record
string13 city :=d.p_city_name[1..13];
string96 advMatch := '';
d.name;
d.p_city_name;
d.listing_type_bus;
d.listing_type_gov;
d.company_name;
d.name_first;
d.name_middle;
d.name_last;
d.name_suffix;
d.sec_range;
d.z5;
d.phoneno;
d.phone_h;
d.phone7;
d.st_named;
string12 st_named2:= d.st_named;
d.prim_range;
d.predir; //predird
d.postdir; //postdird
d.sortname;
d.st;
d.suffix; //suffixd
d.__filepos;

end;

phoneTbl  := table(d,layoutphonetbl);

											

mk2 := buildindex(dedup(phoneTbl(phoneno<>''),phone_h,__filepos,all),{phone_h,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phone_h.key',moxie,overwrite);
//-------------------------------------------------------------
								phoneTbl t_recs(phoneTbl L, dCity R):= transform
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
					

								fullKey := join(phoneTbl,dCity,
											left.__filepos = right.__filepos,
											t_recs(left,right),hash);
mk3 := buildindex(dedup(fullKey(phoneno<>''),phoneno,advMatch,__filepos,all),{phoneno,advMatch,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phone.match.key',moxie,overwrite);
//-------------------------------------------------------------
mk4 := buildindex(dedup(phoneTbl(phoneno<>''),phone7,__filepos,all),{phone7,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phone7.key',moxie,overwrite);
mk5 := buildindex(dedup(phoneTbl(phoneno<>''),phoneno,__filepos,all),{phoneno,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phoneno.key',moxie,overwrite);
mk6 := buildindex(dedup(phoneTbl(phoneno<>''),phoneno,sortname,__filepos,all),{phoneno,sortname,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'phoneno.sortname.key',moxie,overwrite);
//
mk7 := buildindex(dedup(fullKey(st<>''),st,city,st_named,prim_range,predir,st_named2,postdir,suffix,phoneno,__filepos,all),{st,city,st_named,prim_range,predir,st_named2,postdir,suffix,phoneno,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.cityd.st_named.prim_range.predird.st_named.postdird.suffixd.phoneno.key',moxie,overwrite);
mk8 := buildindex(dedup(phoneTbl(st<>''),st,phone7,__filepos,all),{st,phone7,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'st.phone7.key',moxie,overwrite);								

////////////////////////////////////////////////////////////////////////////////////////////////////////////
layoutBellID := record
d.bell_id;
d.group_id;
d.group_seq;
d.__filepos;

end;

tblBellID := table(d,layoutBellID,bell_id,group_id,group_seq,__filepos);

mk9 := buildindex(tblBellID(bell_id+group_id+group_seq<>''),{bell_id,group_id,group_seq,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'bell_id.group_id.group_seq.key',moxie,overwrite);
								
layoutRecID := record
d.Recid;
d.__filepos;

end;

tblRecID := table(d,layoutRecID,Recid,__filepos);

mk10 := buildindex(tblRecID(Recid<>''),{Recid,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'recid.key',moxie,overwrite);

export proc_build_moxie_phoneKeys := parallel(//mk1,
mk2,mk3,mk4,mk5,mk6,mk7,mk8,mk9,mk10);