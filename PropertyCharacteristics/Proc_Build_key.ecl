import	RoxieKeyBuild;

export	Proc_Build_key(string	pVersion)	:=
function
	SuperKeyName	:= '~thor_data400::key::propertyinfo::@version@::';
	BaseKeyName		:= '~thor_data400::key::propertyinfo::'	+	pVersion	+	'::';
	
	// Build payload and data keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	PropertyCharacteristics.Key_PropChar_Address,
																							SuperKeyName	+	'address',
																							BaseKeyName		+	'address',
																							key1
																						);
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	PropertyCharacteristics.Key_PropChar_RID,
																							SuperKeyName	+	'rid',
																							BaseKeyName		+	'rid',
																							key2
																						);

	// Move to built
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	SuperKeyName	+	'address',
																					BaseKeyName		+	'address',
																					mv_built1
																				);
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	SuperKeyName	+	'rid',
																					BaseKeyName		+	'rid',
																					mv_built2
																				);

	// Move to QA
	RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName	+	'address','Q',mv_qa1,2);
	RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName	+	'rid','Q',mv_qa2,2);
	
	updateDops	:=	RoxieKeyBuild.updateversion('PropertyInformationKeys',pVersion,'terri.hardy-george@lexisnexis.com',,'N');
	
	//Update idops -- DF-28209
    updateiDops	:=	 RoxieKeyBuild.updateversion('PropertyInformationKeys',pVersion,'terri.hardy-george@lexisnexis.com',,'N',,,'A');
	return	ordered(	
											parallel(key1,key2),
											parallel(mv_built1,mv_built2),
											parallel(mv_qa1,mv_qa2),
											updateDops,
											updateiDops
										);
	
end;