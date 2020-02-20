import standard,ut,Infutor,Relationship, doxie;

export	relative_names(GROUPED	DATASET(doxie.layout_references)	dids,boolean	glb_ok,boolean	consumerflag)	:=
FUNCTION

	num	:=	(integer)thorlib.getenv('NumberOfRelatives',(varstring)(rollup_limits.relatives_names));

	ret	:=
	RECORD
		doxie.layout_references;
		DATASET(Standard.Name_DID) names {MAXCOUNT(rollup_limits.relatives_names)};
	END;
	
	// Use relationship proc to retrieve relative recs
	rdid_ds := UNGROUP(project(dids,transform(Relationship.Layout_GetRelationship.DIDs_layout,SELF:=LEFT,SELF := [])));
	rel_recs := Relationship.proc_GetRelationshipNeutral(rdid_ds,TRUE,TRUE,FALSE,FALSE,ut.limits.DEFAULT,ut.limits.RELATIVES_PER_PERSON,TRUE).result;
	rel_dids := GROUP(rel_recs(isRelative),did1);
	
	// eliminate minors as necessary
	ut.PermissionTools.GLB.mac_FilterOutMinors(rel_dids,rel_dids_filt,did2)

	rel_picked	:=	SORT(rel_dids_filt,did2,-rel_dt_last_seen,-total_score,did2);
	rel_choosen	:=	DEDUP(rel_picked,true,keep(num*2));

	// Get their names
	// need to get the names for the person2 field (the relatives of the subject)
	rel_proj	:=	project(rel_choosen,TRANSFORM(doxie.layout_references,self.did	:=	left.did2));

	choosend_dids	:=	dedup(sort(rel_proj,did),did);

	// since we do not have a separate Consumer relatives file,join against the Consumer header file
	// and only keep the relative DIDs that exist there if we're getting Consumer relatives
	consumer_dids	:=	join(	choosend_dids,
													Infutor.Key_Header_Infutor_Knowx,
													keyed(left.did = right.s_did),
													transform(left),
													limit(0),
													keep(1)
												);
  // No suppression by source for CCPA needed as we’re only selecting dids.
	dids_use	:=	if(consumerflag,consumer_dids,choosend_dids);

	doxie.mac_best_records(dids_use,did,best_names,true,glb_ok,,doxie.DataRestriction.fixed_DRM,consumerflag);	

	with_names0	:=	join(	rel_choosen,
												best_names,
												left.did2 = right.did,
												transform(	ret,
																		SELF.names := PROJECT(right,TRANSFORM(Standard.Name_DID,SELF := right,SELF.name_score := ''));
																		SELF.did := left.did1;
																		SELF := left;
																	)
											); 

	with_names	:=	group(sort(with_names0,did),did);

	// Roll up the names																													
	ret roller(ret	le,DATASET(ret)	ri)	:=
	TRANSFORM
		n	:=	NORMALIZE(ri,LEFT.names,TRANSFORM(RIGHT));
		
		SELF.names	:=	CHOOSEN(DEDUP(SORT(n,lname,fname,-mname),lname,fname,mname),num);
		SELF				:=	le;
	END;

	roll_names	:=	ROLLUP(with_names,GROUP,roller(LEFT,ROWS(LEFT)));

	RETURN	roll_names;

END;
