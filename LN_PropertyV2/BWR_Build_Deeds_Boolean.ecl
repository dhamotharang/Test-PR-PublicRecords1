import text_search,ln_propertyv2,roxiekeybuild;

export BWR_Build_Deeds_Boolean(string filedate) := function
	info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'ln_propertyv2::deeds', filedate);
	
	ret := ln_propertyv2.Convert_Deed_Func : persist('~thor_data400::persist::ln_propertyv2::deeds::boolean');

	inlkeyname := '~thor_data400::key::ln_propertyv2::deeds::'+filedate+'::doc.fares_id';
	inskeyname := '~thor_data400::key::ln_propertyv2::deeds::qa::doc.fares_id';

	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												LN_Propertyv2.Key_Deed_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

	retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::ln_propertyv2::deeds::boolean')
									);


	return retval;
end;