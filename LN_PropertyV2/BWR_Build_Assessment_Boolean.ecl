import text_search,ln_propertyv2,roxiekeybuild;

export BWR_Build_Assessment_Boolean(string filedate) := function
	info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'ln_propertyv2::assessment', filedate);
	
	Text_assess_Record := record(Text_Search.Layout_Document)
		string12 ln_fares_id;
	end;

	ret := ln_propertyv2.Convert_Assess_Func : persist('~thor_data400::persist::ln_propertyv2::assessment::boolean');

	inlkeyname := '~thor_data400::key::ln_propertyv2::assessment::'+filedate+'::doc.fares_id';
	inskeyname := '~thor_data400::key::ln_propertyv2::assessment::qa::doc.fares_id';

	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												LN_Propertyv2.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

	retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::ln_propertyv2::assessment::boolean')
									);


return retval;


end;