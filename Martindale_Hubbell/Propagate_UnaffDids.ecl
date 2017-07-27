export Propagate_UnaffDids(

	 dataset(layouts.temporary.unaff_redid	) punaff
	,dataset(layouts.temporary.aff_redid		) paff
	
) :=
function

	dmhaff_withdid 		:= paff(did != 0);
	dmhaff_withoutdid := paff(did  = 0);

	dmhunaff_withdid 		:= punaff(did != 0);
	dmhunaff_withoutdid := punaff(did  = 0);

	dimproveunaffdids := join(
		 dmhunaff_withoutdid
		,dmhaff_withdid
		,left.rawfields.INDIV_AUDIT_ISLN = right.rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN
		,transform(
			layouts.temporary.unaff_redid
			,self.did 			:= right.did;
			 self.did_score := right.did_score;
			 self						:= left;
		)
		,left outer
		,keep(1)
	);

	dconcatunaff 							:= dmhunaff_withdid + dimproveunaffdids;
	dconcatunaff_withisln 		:= dconcatunaff(rawfields.INDIV_AUDIT_ISLN != '');
	dconcatunaff_withoutisln 	:= dconcatunaff(rawfields.INDIV_AUDIT_ISLN  = '');

	diterateunaff := iterate(group(sort(distribute(dconcatunaff_withisln, hash64(rawfields.INDIV_AUDIT_ISLN)), rawfields.INDIV_AUDIT_ISLN, -did, -score,local), rawfields.INDIV_AUDIT_ISLN, local),transform(
		 layouts.temporary.unaff_redid
		,self.did := if(left.rawfields.INDIV_AUDIT_ISLN = '', right.did,left.did);
		 self 		:= right;
	));

	diterateunaff2 := iterate(group(sort(distribute(dconcatunaff_withoutisln, hash64(rawfields.INDIV_AUDIT_ATTYNO)), rawfields.INDIV_AUDIT_ATTYNO, -did, -score,local), rawfields.INDIV_AUDIT_ATTYNO, local),transform(
		 layouts.temporary.unaff_redid
		,self.did := if(left.rawfields.INDIV_AUDIT_ATTYNO = '', right.did,left.did);
		 self 		:= right;
	));

	dimprovedunaff := group(diterateunaff) + group(diterateunaff2);
	
	return project(dimprovedunaff,layouts.base.Unaffiliated_Individuals);

end;