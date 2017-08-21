import text_search,ln_propertyv2,roxiekeybuild;

export BWR_Build_Deeds_Boolean(string filedate) := function
	
	STRING stem := '~THOR_DATA400';
	STRING sourceType := 'ln_propertyv2::deeds';	
	info := Text_Search.FileName_Info_Instance(stem, sourceType, filedate);
	
	ds := ln_propertyv2.File_Property_DM_Extract;
	DMPost := LN_PropertyV2.Property_DMPosting(ds);
	dmFile := DMPost.Prop_DM_File;
	posting := DMPost.postings;
	segList := DMPost.SegmentMetaData;
	externalKeys :=DMPost.ExternalKeys;
	
	kwd  := Text_Search.KeywordingFunc(info);
	bld := Text_Search.Build_From_Inversion(info, posting, kwd, FALSE, FALSE, TRUE, segList, externalKeys);
	
	inlkeyname := '~thor_data400::key::ln_propertyv2::deeds::'+filedate+'::doc.fares_id';
	inskeyname := '~thor_data400::key::ln_propertyv2::deeds::qa::doc.fares_id';
	
	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												LN_PropertyV2.Key_DM_Map(dmFile),
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