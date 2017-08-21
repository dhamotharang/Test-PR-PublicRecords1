import	address,idl_header,ut,watchdog,LN_PropertyV2;

export	fn_patch_search(dataset(LN_PropertyV2.Layout_DID_Out)	pInSearch)	:=
function
	dSearchDist	:=	distribute(pInSearch,hash32(ln_fares_id));
	
	// Property name cleaner issue (comma is tagged to the end of the last name or first name)
	recordof(pInSearch)	tPatchName(recordof(pInSearch)	le)	:=
	transform
		self.dt_first_seen	:=	if(	le.dt_first_seen	>	(integer)le.process_date,
																0,
																le.dt_first_seen
															);
		self.dt_last_seen		:=	if(	le.dt_last_seen	>	(integer)le.process_date,
																0,
																le.dt_last_seen
															);
		self.fname					:=	regexreplace('[,]+$',stringlib.stringcleanspaces(ut.fn_KeepPrintableChars(le.fname)),'');
		self.mname					:=	regexreplace('[,]+$',stringlib.stringcleanspaces(ut.fn_KeepPrintableChars(stringlib.stringfindreplace(le.mname,',ETAL',''))),'');
		self.lname					:=	regexreplace('[,]+$',stringlib.stringcleanspaces(ut.fn_KeepPrintableChars(le.lname)),'');
		self.cname					:=	stringlib.stringcleanspaces(ut.fn_KeepPrintableChars(le.cname));
		self.nameasis				:=	stringlib.stringcleanspaces(ut.fn_KeepPrintableChars(ln_propertyv2.fn_patch_name_field(le.nameasis)));
		self.p_city_name		:=	if(le.st	=	''	and	le.p_city_name	=	'SCHENECTADY','',le.p_city_name);
		self								:=	le;
	end;

	dPatchName	:=	project(dSearchDist,tPatchName(left));
	
	// Bug 31994
	dPropagatedRecs			:=	dPatchName(prop_addr_propagated_ind	=	'P');
	dNotPropagatedRecs	:=	dPatchName(source_code[2]	=	'P'	and	prop_addr_propagated_ind	!=	'P');
	dOthers							:=	dPatchName(~(source_code[2]	=	'P'	and	prop_addr_propagated_ind	!=	'P'));
	
	recordof(pInSearch)	tRemovePropagatedRecs(dNotPropagatedRecs	le,dPropagatedRecs	ri)	:=
	transform
		self	:=	le;
	end;
	
	dRemovePropagatedRecs	:=	join(	dNotPropagatedRecs,
																	dPropagatedRecs,
																	left.ln_fares_id	=	right.ln_fares_id	and
																	left.source_code	=	right.source_code,
																	tRemovePropagatedRecs(left,right),
																	left only,
																	local
																);
	
	dSearchCombined	:=	dPropagatedRecs	+	dRemovePropagatedRecs	+	dOthers;
	
	return dSearchCombined;

end;