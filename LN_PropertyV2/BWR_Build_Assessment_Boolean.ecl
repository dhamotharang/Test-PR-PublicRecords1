import text_search,ln_propertyv2,roxiekeybuild;

export BWR_Build_Assessment_Boolean(string filedate) := function
	STRING stem := '~THOR_DATA400';
	STRING sourceType := 'ln_propertyv2::assessment';
	info := Text_Search.FileName_Info_Instance(stem, sourceType, filedate);
	
	ds := ln_propertyv2.File_Property_A_Extract;
	APost := LN_PropertyV2.Property_APosting(ds);
	
	AFile := APost.Prop_A_File;
	posting := 	APost.postings;
	segList := 	APost.SegmentMetaData;		
	externalKeys :=APost.ExternalKeys;
	kwd  := Text_Search.KeywordingFunc(info);
	bld := Text_Search.Build_From_Inversion(info, posting, kwd, FALSE, FALSE, TRUE, segList,externalKeys);

	inlkeyname := '~thor_data400::key::ln_propertyv2::assessment::'+filedate+'::doc.fares_id';
	inskeyname := '~thor_data400::key::ln_propertyv2::assessment::qa::doc.fares_id';

	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												LN_PropertyV2.Key_Assessment_Map(AFile),
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