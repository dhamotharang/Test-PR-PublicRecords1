IMPORT ut,lib_fileservices,_Control,Prof_License_Mari;


EXPORT Missing_Codes  := module

// Looking for codes Missing from translation file
	export	Common_Codes (DATASET(recordof(Prof_License_Mari.layouts.base)) pBaseFile, string	pVersion) := FUNCTION	
	
	shared	translation_file	:=	Prof_License_Mari.files_References.cmvtranslation;
	
// Normalize the file to contain only the raw vendor codes
rLayout := RECORD
	string20 	field_name,
	string5		source_code,
	string80	raw_code

END;	

	rLayout	tNormalizedCodes(pBaseFile L, integer	cnt)	:=
	transform
		self.field_name		:=	choose(	cnt,
																	'PROFCODE',
																	'LIC_TYPE',
																	'LIC_STATUS'
																);
		self.source_code	:=	L.STD_SOURCE_UPD;
		self.raw_code			:=	choose(	cnt,
																	L.STD_PROF_CD,
																	L.RAW_LICENSE_TYPE,
																	L.RAW_LICENSE_STATUS
																);
		self							:=	[];
	end;


	dProfLicRawCodes	:=	normalize(	pBaseFile, 3, tNormalizedCodes(left,counter));


	dProfLicRawCodesDedup	:=	dedup(dProfLicRawCodes(raw_code	!=	''),field_name,source_code,raw_code,all);


	rLayout	tGetCommonCode(dProfLicRawCodesDedup le, translation_file	ri)	:=
	transform
		self	:=	le;
	end;


	// Do a left only join to get the list of codes which don't have a common code
	dLicNoCommonCode	:=	join(	dProfLicRawCodesDedup, translation_file,
																stringlib.stringcleanspaces(left.source_code)	=	stringlib.stringcleanspaces(right.source_upd)	
																and
																(stringlib.stringcleanspaces(left.field_name)	=	stringlib.stringcleanspaces(right.fld_name)		or
															 stringlib.stringcleanspaces(left.field_name)	=	stringlib.stringcleanspaces(right.dm_name1))		
															 and
															(stringlib.stringcleanspaces(left.raw_code)		=	stringlib.stringcleanspaces(right.fld_value)		or
																stringlib.stringcleanspaces(left.raw_code)		=	stringlib.stringcleanspaces(right.dm_value1)),
															tGetCommonCode(left,right),
															left only,
															lookup
														);
														

	outLicNoCommonCode	:=	if(	exists(dLicNoCommonCode),
															sequential(	output(sort(dLicNoCommonCode,source_code,field_name,raw_code),all,named('ProfLic_Mari_Missing_Common_Codes')),
																					fileservices.sendemail('terri.hardy-george@lexisnexis.com','Prof License MARI Missing Codes','Build '	+	pVersion	
																					+	' has missing codes. They are located in workunit '	
																					+	thorlib.wuid())
																				),
															output('No new codes needs to be added')
														);

	return outLicNoCommonCode;
end;
	
	
// Looking for Standardized Codes w/o Description	
	shared	search_file	:=	Prof_License_Mari.file_mari_search;
	
	dSearchFile_type 		:= search_file(std_license_type != '' and std_license_desc = '');
	dSearchFile_status	:= search_file(std_license_status != '' and std_status_desc = '');

  outMissingTypeDesc :=  output(sort(table(dSearchFile_type, 
                                  {STD_LICENSE_TYPE, std_source_upd, license_state, std_prof_cd, 
                                    cnt := count(group)}, 
																		STD_LICENSE_TYPE, std_source_upd, license_state,std_prof_cd),
																			STD_LICENSE_TYPE, std_source_upd, license_state,std_prof_cd),
																				, named('ProfLic_Mari_Missing_Type_Desc'));                             
                              
  outMissingStatusDesc :=  output(sort(table(dSearchFile_status, 
                                    {std_license_status, std_source_upd, license_state,  
                                      cnt := count(group)}, 
                                      std_license_status, std_source_upd, license_state),
                                          std_license_status, std_source_upd, license_state)
                                          , named('ProfLic_Mari_Missing_Status_Desc'));
	
	export Standardized_Codes := parallel(outMissingTypeDesc,outMissingStatusDesc);
end;

