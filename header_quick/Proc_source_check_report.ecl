import header,header_quick,doxie,BankruptcyV2,LiensV2,STD,ut;

export Proc_source_check_report():= function

h:=      pull(doxie.Key_Header);
qh:=     pull(header_quick.key_DID);
srid:=   pull(header.Key_Rid_SrcID_Prep());
dth:=    pull(header.Key_Src_Death);
em:=     pull(header.Key_Src_EM);
vo:=     pull(header.key_src_voters);
ut:=     pull(header.Key_Src_Util );
for:=    pull(header.Key_Src_For );
nod:=    pull(header.Key_Src_NOD );
prof:=   pull(header.Key_Src_Prof );
targ:=   pull(header.Key_Src_Targus );
dea:=    pull(header.Key_Src_DEA );
sdth:=   pull(header.Key_Src_Statedeath );
airc:=   pull(header.Key_Src_Airc );
ak:=     pull(header.Key_Src_ak );
airm:=   pull(header.Key_Src_airm );
asl:=    pull(header.Key_Src_asl );
atf:=    pull(header.Key_Src_atf );
boater:= pull(header.Key_Src_boater );
ms:=     pull(header.Key_Src_ms );
water:=  pull(header.Key_Src_water );
tn:=     pull(header.Key_Src_tn() );
en:=     pull(header.key_src_experian () );
eq:=     pull(header.key_src_eq () );
veh:=    pull(header.Key_Src_VehV2 () );
dl:=     pull(header.Key_Src_dlV2 () );
pd:=     pull(header.Key_Src_Deed () );
pa:=     pull(header.Key_Src_PropAssess () );
li:=     pull(header.Key_Src_LienV2 () );
ba:=     pull(header.Key_Src_BKv2 ());
lip:=    pull(LiensV2.key_liens_party_ID );
bap:=    pull(BankruptcyV2.key_bankruptcy_search_full());

///////////////////////////////////////////////////////////////////////////////////
d1:=join(distribute(project(h,header.Layout_Header)+project(qh,header.Layout_Header),hash(rid))
				,distribute(srid,hash(rid))
					,left.rid=right.rid
					and left.src=right.src
						,transform({h.did
											,h.rid
											,h.src
											,h.vendor_id
											,h.fname
											,h.lname
											,h.dob
											,h.ssn
											,srid.uid
											}
								,self:=left
								,self:=right)
						,local
						):persist('~thor_data400::persist::rid_uid_src');
///////////////////////////////////////////////////////////////////////////////////

fn_same_initials(string1 lfi,string1 lli,string1 rfi,string1 rli) := function
	return if(rfi<>'' and rli<>'',(lfi=rfi and lli=rli) or (lfi=rli and lli=rfi),false);
end;
///////////////////////////////////////////////////////////////////////////////////

all_de := join(distribute(d1,hash(uid)),distribute(dth,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{dth} de}
						,self:=left
						,self.de:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.death_child[1].fname[1],right.death_child[1].lname[1]))
						,local);					
					
///////////////////////////////////////////////////////////////////////////////////
all_em:=join(distribute(d1,hash(uid)),distribute(em,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					and trim(left.vendor_id)=trim(right.emerge_child[1].source)+trim(right.emerge_child[1].vendor_id)
					and left.ssn=right.emerge_child[1].best_ssn
					,transform({d1,ahit:=false,{em} em}
						,self:=left
						,self.em:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.emerge_child[1].fname[1],right.emerge_child[1].lname[1]))
					,local);
///////////////////////////////////////////////////////////////////////////////////
all_vo:=join(distribute(d1,hash(uid)),distribute(vo,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{vo} vo}
						,self:=left
						,self.vo:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.voters_child[1].fname[1],right.voters_child[1].lname[1]))
					,local);
///////////////////////////////////////////////////////////////////////////////////
all_ut:=join(distribute(d1,hash(uid)),distribute(ut,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false, {ut} ut}
						,self:=left
						,self.ut:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.util_child[1].fname[1],right.util_child[1].lname[1]))
					,local);
///////////////////////////////////////////////////////////////////////////////////
all_for:=join(distribute(d1,hash(uid)),distribute(for,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{for} for}
						,self:=left
						,self.for:=right
						,self.ahit:=(fn_same_initials(left.fname[1],left.lname[1],right.for_child[1].name1_first[1],right.for_child[1].name1_last[1])
						or fn_same_initials(left.fname[1],left.lname[1],right.for_child[1].name2_first[1],right.for_child[1].name2_last[1])
						or fn_same_initials(left.fname[1],left.lname[1],right.for_child[1].name3_first[1],right.for_child[1].name3_last[1])
						or fn_same_initials(left.fname[1],left.lname[1],right.for_child[1].name4_first[1],right.for_child[1].name4_last[1]))
						
						)
					,local);
///////////////////////////////////////////////////////////////////////////////////

all_nod:=join(distribute(d1,hash(uid)),distribute(nod,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{nod} nod}
						,self:=left
						,self.nod:=right
						,self.ahit:=(fn_same_initials(left.fname[1],left.lname[1],right.nod_child[1].name1_first[1],right.nod_child[1].name1_last[1])
						or fn_same_initials(left.fname[1],left.lname[1],right.nod_child[1].name2_first[1],right.nod_child[1].name2_last[1])
						or fn_same_initials(left.fname[1],left.lname[1],right.nod_child[1].name3_first[1],right.nod_child[1].name3_last[1])
						or fn_same_initials(left.fname[1],left.lname[1],right.nod_child[1].name4_first[1],right.nod_child[1].name4_last[1]))
						
						)
					,local);

///////////////////////////////////////////////////////////////////////////////////
all_prof:=join(distribute(d1,hash(uid)),distribute(prof,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{prof} prof}
						,self:=left
						,self.prof:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.proflic_child[1].fname[1],right.proflic_child[1].lname[1]))
					,local);
///////////////////////////////////////////////////////////////////////////////////
all_targ:=join(distribute(d1,hash(uid)),distribute(targ,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{targ} targ}
						,self:=left
						,self.targ:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.targ_child[1].fname[1],right.targ_child[1].lname[1]))
					,local);
///////////////////////////////////////////////////////////////////////////////////
all_dea:=join(distribute(d1,hash(uid)),distribute(dea,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{dea} dea}
						,self:=left
						,self.dea:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.dea_child[1].fname[1],right.dea_child[1].lname[1]))
					,local);

///////////////////////////////////////////////////////////////////////////////////
all_sdth:=join(distribute(d1,hash(uid)),distribute(sdth,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{sdth} sdth}
						,self:=left
						,self.sdth:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.state_death_child[1].fname[1],right.state_death_child[1].lname[1]))
					,local);
///////////////////////////////////////////////////////////////////////////////////

all_airc:=join(distribute(d1,hash(uid)),distribute(airc,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{airc} airc}
						,self:=left
						,self.airc:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.airc_child[1].fname[1],right.airc_child[1].lname[1]))
					,local);
					
///////////////////////////////////////////////////////////////////////////////////

all_airm:=join(distribute(d1,hash(uid)),distribute(airm,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{airm} airm}
						,self:=left
						,self.airm:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.airm_child[1].fname[1],right.airm_child[1].lname[1]))
					,local);
					
///////////////////////////////////////////////////////////////////////////////////

all_ak:=join(distribute(d1,hash(uid)),distribute(ak,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{ak} ak}
						,self:=left
						,self.ak:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.ak_child[1].first_name[1],right.ak_child[1].last_name[1]))
					,local);

///////////////////////////////////////////////////////////////////////////////////

all_atf:=join(distribute(d1,hash(uid)),distribute(atf,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false}
						,self:=left
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.atf_child[1].license1_fname[1],right.atf_child[1].license1_lname[1])
						or fn_same_initials(left.fname[1],left.lname[1],right.atf_child[1].license2_fname[1],right.atf_child[1].license2_lname[1]))
					,local);

///////////////////////////////////////////////////////////////////////////////////

all_boater:=join(distribute(d1,hash(uid)),distribute(boater,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{boater} boater}
						,self:=left
						,self.boater:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.boater_child[1].fname[1],right.boater_child[1].lname[1]))
					,local);

///////////////////////////////////////////////////////////////////////////////////

all_ms:=join(distribute(d1,hash(uid)),distribute(ms,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{ms} ms}
						,self:=left
						,self.ms:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.mswork_child[1].claim_name_first[1],right.mswork_child[1].claim_name_last[1]))
					,local);
					
///////////////////////////////////////////////////////////////////////////////////
all_water:=join(distribute(d1,hash(uid)),distribute(water,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{water} water}
						,self:=left
						,self.water:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.watercraft_child[1].fname[1],right.watercraft_child[1].lname[1]))
					,local);

///////////////////////////////////////////////////////////////////////////////////
///////////////////////////Fast Header Sources/////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

all_tn:=join(distribute(d1,hash(uid)),distribute(tn,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{tn} tn}
						,self:=left
						,self.tn:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.tn_child[1].fname[1],right.tn_child[1].lname[1]))
					,local);
					
///////////////////////////////////////////////////////////////////////////////////

all_en:=join(distribute(d1,hash(uid)),distribute(en,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{en} en}
						,self:=left
						,self.en:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.experian_child[1].fname[1],right.experian_child[1].lname[1]))
					,local);

///////////////////////////////////////////////////////////////////////////////////

all_eq:=join(distribute(d1,hash(uid)),distribute(eq,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{eq} eq}
						,self:=left
						,self.eq:=right
						,self.ahit:=
						((((StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].first_name),'0','O'),',&/\'-\\='),
				    STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 )
						and 
						(StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 ))
						or

						((StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 )
						and 
						(StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 ))

						or

						((StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_first_name2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_first_name2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_middle_initial2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_middle_initial2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_last_name2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_last_name2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 ) 

						and 

						(StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_first_name2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_first_name2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_middle_initial2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_middle_initial2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_last_name2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].former_last_name2),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0)) 

						or

						((StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.fname),'0','O'),',&/\'-\\='),2),1)>0 )

						and

						(StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_first_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_middle_initial),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 or
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),1),1)>0 or 
						StringLib.StringFind(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(right.eq_child[1].aka_last_name),'0','O'),',&/\'-\\='),
						STD.STr.GetNthWord(STD.Str.FilterOut(STD.Str.FindReplace(STD.Str.ToUpperCase(left.lname),'0','O'),',&/\'-\\='),2),1)>0 )))
						))
					,local);

///////////////////////////////////////////////////////////////////////////////////

all_veh := join(distribute(d1,hash(uid)),distribute(veh,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{veh} veh}
						,self:=left
						,self.veh:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.veh_child[1].append_clean_name.fname[1],right.veh_child[1].append_clean_name.lname[1]))
						,local);

///////////////////////////////////////////////////////////////////////////////////
all_dl:=join(distribute(d1,hash(uid)),distribute(dl,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{dl} dl}
						,self:=left
						,self.dl:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.dl_child[1].fname[1],right.dl_child[1].lname[1]))
					,local);

///////////////////////////////////////////////////////////////////////////////////
// all_deeds:=join(distribute(d1,hash(uid)),distribute(pd,hash(uid))
					// ,left.uid=right.uid
					// and left.src=right.src
					// ,transform({d1,ahit:=false,{pd} pd}
						// ,self:=left
						// ,self.pd:=right
						// ,self.ahit:=
						// ((StringLib.StringFind(right.deeds_child[1].buyer1,STD.Str.CleanSpaces(left.fname),1)>0 and 
						// StringLib.StringFind(right.deeds_child[1].buyer1,STD.Str.CleanSpaces(left.lname),1)>0)
						// or (StringLib.StringFind(right.deeds_child[1].buyer2,STD.Str.CleanSpaces(left.fname),1)>0 and 
						// StringLib.StringFind(right.deeds_child[1].buyer2,STD.Str.CleanSpaces(left.lname),1)>0)
						// or (StringLib.StringFind(right.deeds_child[1].borrower1,STD.Str.CleanSpaces(left.fname),1)>0 and 
						// StringLib.StringFind(right.deeds_child[1].borrower1,STD.Str.CleanSpaces(left.lname),1)>0)
						// or (StringLib.StringFind(right.deeds_child[1].borrower2,STD.Str.CleanSpaces(left.fname),1)>0 and 
						// StringLib.StringFind(right.deeds_child[1].borrower2,STD.Str.CleanSpaces(left.lname),1)>0)
						// or (StringLib.StringFind(right.deeds_child[1].seller1,STD.Str.CleanSpaces(left.fname),1)>0 and 
						// StringLib.StringFind(right.deeds_child[1].seller1,STD.Str.CleanSpaces(left.lname),1)>0)
						// or (StringLib.StringFind(right.deeds_child[1].seller2,STD.Str.CleanSpaces(left.fname),1)>0 and 
						// StringLib.StringFind(right.deeds_child[1].seller2,STD.Str.CleanSpaces(left.lname),1)>0)
					// )),local);
///////////////////////////////////////////////////////////////////////////////////
all_asses:=join(distribute(d1,hash(uid)),distribute(pa,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,transform({d1,ahit:=false,{pa} pa}
						,self:=left
						,self.pa:=right
						,self.ahit:= ((StringLib.StringFind(right.asses_child[1].assessee_name,STD.Str.CleanSpaces(left.fname),1)>0 and 
						StringLib.StringFind(right.asses_child[1].assessee_name,STD.Str.CleanSpaces(left.lname),1)>0)

						or (StringLib.StringFind(right.asses_child[1].second_assessee_name,STD.Str.CleanSpaces(left.fname),1)>0 and 
						StringLib.StringFind(right.asses_child[1].second_assessee_name,STD.Str.CleanSpaces(left.lname),1)>0)
						
						or  (StringLib.StringFind(right.asses_child[1].mailing_care_of_name,STD.Str.CleanSpaces(left.fname),1)>0 and 
						StringLib.StringFind(right.asses_child[1].mailing_care_of_name,STD.Str.CleanSpaces(left.lname),1)>0)

						or (StringLib.StringFind(right.asses_child[1].fares_seller_name,STD.Str.CleanSpaces(left.fname),1)>0 and 
						StringLib.StringFind(right.asses_child[1].fares_seller_name,STD.Str.CleanSpaces(left.lname),1)>0)
					)),local);
///////////////////////////////////////////////////////////////////////////////////
li_tmsid:=join(distribute(d1,hash(uid)),distribute(li,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,local
					);


li_party:=join(distribute(li_tmsid,hash(lienv2_child[1].tmsid)),distribute(lip,hash(tmsid))
					,left.lienv2_child[1].tmsid=right.tmsid
					,transform({li_tmsid,ahit:=false,{lip} party}
						,self:=left
						,self.party:=right
						,self.ahit:=fn_same_initials(STD.Str.CleanSpaces(left.fname)[1],left.lname[1],right.fname[1],right.lname[1])
					)
					,local
					);

possible_bad_li:=table(li_party,{li_party,mxHit:=max(group,ahit)},lienv2_child[1].tmsid,local)(mxHit=false);
good_li:=table(li_party,{li_party,mxHit:=max(group,ahit)},lienv2_child[1].tmsid,local)(mxHit=true);
///////////////////////////////////////////////////////////////////////////////////
ba_tmsid:=join(distribute(d1,hash(uid)),distribute(ba,hash(uid))
					,left.uid=right.uid
					and left.src=right.src
					,local
					);

ba_party:=join(distribute(ba_tmsid,hash(bk_child[1].tmsid)),distribute(bap,hash(tmsid))
					,left.bk_child[1].tmsid=right.tmsid
					,transform({ba_tmsid,ahit:=false,{bap} party}
						,self:=left
						,self.party:=right
						,self.ahit:=fn_same_initials(left.fname[1],left.lname[1],right.fname[1],right.lname[1])
					)					
					,local
					);


possible_bad_bk:=table(ba_party,{ba_party,mxHit:=max(group,ahit)},bk_child[1].tmsid,local)(mxHit=false);
good_bk:=table(ba_party,{ba_party,mxHit:=max(group,ahit)},bk_child[1].tmsid,local)(mxHit=true);

return parallel (

					output('///////////////////////////////////////////////////////////////////////////////////'),
					output('///////////////////////////Possible bad Sources/////////////////////////////////////'),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output(count(all_for(ahit=false))	,named('possible_bad_for_cnt')),
					output(all_for(ahit=false)	,named('possible_bad_for_smp')),
					output(count(all_de(ahit=false))	,named('possible_bad_death_cnt')),
					output(all_de	(ahit=false),named('possible_bad_death_smp')),
					output(count(all_em(ahit=false))	,named('possible_bad_emerges_cnt')),
					output(all_em(ahit=false)	,named('possible_bad_emerges_smp')),
					output(count(all_vo(ahit=false))	,named('possible_bad_voters_cnt')),
					output(all_vo(ahit=false)	,named('possible_bad_voters_smp')),
					output(count(all_ut(ahit=false))	,named('possible_bad_util_cnt')),
					output(all_ut(ahit=false)	,named('possible_bad_util_smp')),
					output(count(all_nod(ahit=false))	,named('possible_bad_nod_cnt')),
					output(all_nod(ahit=false)	,named('possible_bad_nod_smp')),
					output(count(all_prof(ahit=false))	,named('possible_bad_prof_cnt')),
					output(all_prof(ahit=false)	,named('possible_bad_prof_smp')),
					output(count(all_targ(ahit=false))	,named('possible_bad_targ_cnt')),
					output(all_targ(ahit=false)	,named('possible_bad_targ_smp')),
					output(count(all_dea(ahit=false))	,named('possible_bad_dea_cnt')),
					output(all_dea(ahit=false)	,named('possible_bad_dea_smp')),
					output(count(all_sdth(ahit=false))	,named('possible_bad_sdth_cnt')),
					output(all_sdth(ahit=false)	,named('possible_bad_sdth_smp')),
					output(count(all_airc(ahit=false))	,named('possible_bad_airc_cnt')),
					output(all_airc(ahit=false)	,named('possible_bad_airc_smp')),
					output(count(all_airm(ahit=false))	,named('possible_bad_airm_cnt')),
					output(all_airm(ahit=false)	,named('possible_bad_airm_smp')),
					output(count(all_ak(ahit=false))	,named('possible_bad_ak_cnt')),
					output(all_ak(ahit=false)	,named('possible_bad_ak_smp')),
					output(count(all_atf(ahit=false))	,named('possible_bad_atf_cnt')),
					output(all_atf(ahit=false)	,named('possible_bad_atf_smp')),
					output(count(all_boater(ahit=false))	,named('possible_bad_boater_cnt')),
					output(all_boater(ahit=false)	,named('possible_bad_boater_smp')),
					output(count(all_ms(ahit=false))	,named('possible_bad_ms_cnt')),
					output(all_ms(ahit=false)	,named('possible_bad_ms_smp')),
					output(count(all_water(ahit=false))	,named('possible_bad_water_cnt')),
					output(all_water(ahit=false)	,named('possible_bad_water_smp')),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output('///////////////////////////Fast Header Sources/////////////////////////////////////'),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output(count(all_tn(ahit=false))	,named('possible_bad_tn_cnt')),
					output(all_tn(ahit=false)	,named('possible_bad_tn_smp')),
					output(count(all_en(ahit=false))	,named('possible_bad_en_cnt')),
					output(all_en(ahit=false)	,named('possible_bad_en_smp')),
					output(count(all_eq(ahit=false))	,named('possible_bad_eq_cnt')),
					output(all_eq(ahit=false)	,named('possible_bad_eq_smp')),
					output(count(all_veh(ahit=false))	,named('possible_bad_veh_cnt')),
					output(all_veh(ahit=false)	,named('possible_bad_veh_smp')),
					output(count(all_dl(ahit=false))	,named('possible_bad_dl_cnt')),
					output(all_dl(ahit=false)	,named('possible_bad_dl_smp')),
					// output(count(all_deeds(ahit=false))	,named('possible_bad_deeds_cnt')),
					// output(all_deeds(ahit=false)	,named('possible_bad_deeds_smp')),
					output(count(all_asses(ahit=false))	,named('possible_bad_asses_cnt')),
					output(all_asses(ahit=false)	,named('possible_bad_asses_smp')),
					output(count(possible_bad_li)	,named('possible_bad_lien_cnt')),
					output(possible_bad_li	,named('possible_bad_lien_smp')),
					output(count(possible_bad_bk)	,named('possible_bad_bk_cnt')),
					output(possible_bad_bk	,named('possible_bad_bk_smp')),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output('//////////////////////////////////Good Sources/////////////////////////////////////'),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output(count(all_for(ahit=true))	,named('good_for_cnt')),
					output(all_for(ahit=true)	,named('good_for_smp')),
					output(count(all_de(ahit=true))	,named('good_death_cnt')),
					output(all_de(ahit=true)	,named('good_death_smp')),
					output(count(all_em(ahit=true))	,named('good_emerges_cnt')),
					output(all_em(ahit=true)	,named('good_emerges_smp')),
					output(count(all_vo(ahit=true))	,named('good_voters_cnt')),
					output(all_vo(ahit=true)	,named('good_voters_smp')),
					output(count(all_ut(ahit=true))	,named('good_util_cnt')),
					output(all_ut(ahit=true)	,named('good_util_smp')),
					output(count(all_nod(ahit=true))	,named('good_nod_cnt')),
					output(all_nod(ahit=true)	,named('good_nod_smp')),
					output(count(all_prof(ahit=true))	,named('good_prof_cnt')),
					output(all_prof(ahit=true)	,named('good_prof_smp')),
					output(count(all_targ(ahit=true))	,named('good_targ_cnt')),
					output(all_targ(ahit=true)	,named('good_targ_smp')),
					output(count(all_dea(ahit=true))	,named('good_dea_cnt')),
					output(all_dea(ahit=true)	,named('good_dea_smp')),
					output(count(all_sdth(ahit=true))	,named('good_sdth_cnt')),
					output(all_sdth(ahit=true)	,named('good_sdth_smp')),
					output(count(all_airc(ahit=true))	,named('good_airc_cnt')),
					output(all_airc(ahit=true)	,named('good_airc_smp')),
					output(count(all_airm(ahit=true))	,named('good_airm_cnt')),
					output(all_airm(ahit=true)	,named('good_airm_smp')),
					output(count(all_ak(ahit=true))	,named('good_ak_cnt')),
					output(all_ak(ahit=true)	,named('good_ak_smp')),
					output(count(all_atf(ahit=true))	,named('good_atf_cnt')),
					output(all_atf(ahit=true)	,named('good_atf_smp')),
					output(count(all_boater(ahit=true))	,named('good_boater_cnt')),
					output(all_boater(ahit=true)	,named('good_boater_smp')),
					output(count(all_ms(ahit=true))	,named('good_ms_cnt')),
					output(all_ms(ahit=true)	,named('good_ms_smp')),
					output(count(all_water(ahit=true))	,named('good_water_cnt')),
					output(all_water(ahit=true)	,named('good_water_smp')),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output('///////////////////////////Fast Header Sources/////////////////////////////////////'),
					output('///////////////////////////////////////////////////////////////////////////////////'),
					output(count(all_tn(ahit=true))	,named('good_tn_cnt')),
					output(all_tn(ahit=true)	,named('good_tn_smp')),
					output(count(all_en(ahit=true))	,named('good_en_cnt')),
					output(all_en(ahit=true)	,named('good_en_smp')),
					output(count(all_eq(ahit=true))	,named('good_eq_cnt')),
					output(all_eq(ahit=true)	,named('good_eq_smp')),
					output(count(all_veh(ahit=true))	,named('good_veh_cnt')),
					output(all_veh(ahit=true)	,named('good_veh_smp')),
					output(count(all_dl(ahit=true))	,named('good_dl_cnt')),
					output(all_dl(ahit=true)	,named('good_dl_smp')),
					// output(count(all_deeds(ahit=true))	,named('good_deeds_cnt')),
					// output(all_deeds(ahit=true)	,named('good_deeds_smp')),
					output(count(all_asses(ahit=true))	,named('good_asses_cnt')),
					output(all_asses(ahit=true)	,named('good_asses_smp')),
					output(count(good_li)	,named('good_lien_cnt')),
					output(good_li	,named('good_lien_smp')),
					output(count(good_bk)	,named('good_bk_cnt')),
					output(good_bk	,named('good_bk_smp'))
					);
end;