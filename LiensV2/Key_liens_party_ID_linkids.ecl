import liensv2, Doxie,Data_Services, ut;

/* add integer did field */
d := table(LiensV2.File_Liens_Party_BIPV2, {Liensv2.File_Liens_Party_BIPV2, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d,phone,st,o,true,idid);

/* removed extra field */
get_recs := project(o, transform(LiensV2.Layout_liens_party_SSN_BIPV2, 
														 self.title := if(left.orig_name = 'SPENCER JAMES, ANGELA E','MS',left.title)
														,self.fname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','ANGELA',left.fname)
														,self.mname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','E',left.mname)
														,self.lname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','SPENCER JAMES',left.lname),self := left));

rLayout_liens_party_BIPV2_without_LinkFlags	:=	RECORD
	LiensV2.Layout_liens_party_BIPV2	AND NOT	[
		xadl2_keys_used,
		xadl2_keys_desc,
		xadl2_weight,
		xadl2_Score,
		xadl2_distance,
		xadl2_matches,
		xadl2_matches_desc
	];
 unsigned4	global_sid;//DF-24061 VC
 unsigned8	record_sid;	
 string10 	orig_rmsid;


END;

rLayout_liens_party_BIPV2_without_LinkFlags tformat(liensv2.Layout_liens_party_SSN_BIPV2 L) := transform

self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
self.tax_id := if(L.tax_id <> '', if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
self := L;

end;

get_recs_ssn := project(get_recs, tformat(left));

dist_id := distribute(get_recs_ssn, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);

export 	Key_liens_party_ID_linkids := index(sort_id,{tmsid,RMSID},{sort_id},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::party::tmsid.rmsid_linkids_' + doxie.Version_SuperKey);