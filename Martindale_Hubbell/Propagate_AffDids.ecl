export Propagate_AffDids(

	 dataset(layouts.temporary.aff_redid		) paff
	,dataset(layouts.temporary.unaff_redid	) punaff
	
) :=
function

	dmhaff_withdid 		:= paff(did != 0);
	dmhaff_withoutdid := paff(did  = 0);

	dmhunaff_withdid 		:= punaff(did != 0);
	dmhunaff_withoutdid := punaff(did  = 0);

	//propagate dids by isln to each file.
	dimproveaffdids := join(
		 dmhaff_withoutdid
		,dmhunaff_withdid
		,left.rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = right.rawfields.INDIV_AUDIT_ISLN
		,transform(
			layouts.temporary.aff_redid
			,self.did 			:= right.did;
			 self.did_score := right.did_score;
			 self						:= left;
		)
		,left outer
		,keep(1)
	);

	dconcataff 							:= dmhaff_withdid + dimproveaffdids;
	dconcataff_withisln 		:= dconcataff(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN != '');
	dconcataff_withoutisln 	:= dconcataff(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN  = '');

	diterateaff := iterate(group(sort(distribute(dconcataff_withisln, hash64(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN)), rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN, -did, -score,local), rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN, local),transform(
		 layouts.temporary.aff_redid
		,self.did := if(left.rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = '', right.did,left.did);
		 self 		:= right;
	));

	diterateaff2 := iterate(group(sort(distribute(dconcataff_withoutisln, hash64(rawfields.header_aff_indiv_indiv_audit_attyno)), rawfields.header_aff_indiv_indiv_audit_attyno, -did, -score,local), rawfields.header_aff_indiv_indiv_audit_attyno, local),transform(
		 layouts.temporary.aff_redid
		,self.did := if(left.rawfields.header_aff_indiv_indiv_audit_attyno = '', right.did,left.did);
		 self 		:= right;
	));

	dimprovedaff := group(diterateaff) + group(diterateaff2);
	
	return project(dimprovedaff,layouts.base.Affiliated_Individuals);

end;