import ut, crim_header;

co := crimsrch.offender_joined;
//
// start of crim header based append - 
//		"wimpy" method = append dids from ch if no dids on any records for an offender_key
//
ch_ofk_did_appends_do := dedup(sort(crim_header.ch_as_did_append,offender_key,local),offender_key,local);
co_do := distribute(co,hash(offender_key));
//
co_ofk_with_dids_do := dedup(sort(co_do((unsigned6) did<>0),offender_key,local),offender_key,local);
crimsrch.layout_moxie_offender to_split_co(co_do l,co_ofk_with_dids_do r) := transform
self := l;
end;
co_matchset_use_not_do := join(co_do,co_ofk_with_dids_do,left.offender_key=right.offender_key,to_split_co(left,right), local);
co_matchset_use_do 		 := join(co_do,co_ofk_with_dids_do,left.offender_key=right.offender_key,to_split_co(left,right), left only, local);
//
crimsrch.layout_moxie_offender to_patch(co_matchset_use_do l,ch_ofk_did_appends_do r) := transform
self.did := if(r.did<>0,intformat(r.did,12,1),'');
self := l;
end;
co_dids_appended_do := join(co_matchset_use_do,ch_ofk_did_appends_do,left.offender_key=right.offender_key,to_patch(left,right), left outer,local);
//
export Offender_Joined_plus
 :=	 co_dids_appended_do +co_matchset_use_not_do
 :	persist('~thor_data400::persist::CrimSrch_Offender_Joined_plus' ,'Thor400_84')
 ;

