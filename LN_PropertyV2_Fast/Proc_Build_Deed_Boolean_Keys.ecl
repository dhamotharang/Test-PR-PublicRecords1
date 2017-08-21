import text_search,ln_propertyv2,roxiekeybuild;
export Proc_Build_Deed_Boolean_Keys(string filedate, boolean isFast) := function
	
	superKeyPrefix := if (isFast,'property_fast','ln_propertyV2');
	
	STRING stem := '~THOR_DATA400';
	STRING sourceType := superKeyPrefix+'::deeds';	
	info := Text_Search.FileName_Info_Instance(stem, sourceType, filedate);

	ds := LN_PropertyV2_Fast.File_Property_DM_Extract(isFast);
	DMPost := LN_PropertyV2.Property_DMPosting(ds); // no reference to specific input files
	dmFile := DMPost.Prop_DM_File;
	posting := DMPost.postings;
	segList := DMPost.SegmentMetaData;
	externalKeys :=DMPost.ExternalKeys;
	
	kwd  := Text_Search.KeywordingFunc(info);
	bld := Text_Search.Build_From_Inversion(info, posting, kwd, FALSE, FALSE, TRUE, segList,externalKeys);
	
	inlkeyname := '~thor_data400::key::'+superKeyPrefix+'::deeds::'+filedate+'::doc.fares_id';
	inskeyname := '~thor_data400::key::'+superKeyPrefix+'::deeds::qa::doc.fares_id';
	
	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												LN_PropertyV2_Fast.Key_DM_Map(dmFile),
												'superkey',
												inlkeyname,
												build_key	
												);
								
	retval := sequential(
									bld,
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname)
									);
	return retval;
end;