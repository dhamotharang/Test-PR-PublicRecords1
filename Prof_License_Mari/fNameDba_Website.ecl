IMPORT Prof_License_Mari, ut;

EXPORT fNameDba_Website(DATASET(recordof(Prof_License_Mari.layouts.intermediate)) pDataset) := FUNCTION 


	website_pattern_1 := '(HTTP://|)(WWW\\.)?([^\\.]+)\\.(\\w{2}|(COM|NET|ORG|EDU|INT|MIL|GOV|ARPA|BIZ|AERO|NAME|COOP|INFO|PRO|MUSEUM|TV|US|CO))$';
	website_pattern_2 := '(HTTP://|)(WWW\\.)([^\\,]+)\\,(\\w{2}|(COM|NET|ORG|EDU|INT|MIL|GOV|ARPA|BIZ|AERO|NAME|COOP|INFO|PRO|MUSEUM|TV|US|CO))$';
	
//Identifying Records where websites existin in NAME_DBA	
	// dsBase := DISTRIBUTE(pDataset, HASH(mari_rid)),mari_rid,local);
	dsBase_web_1 := pDataset(regexfind(website_pattern_1, trim(NAME_MARI_DBA)) and not stringlib.stringfind(trim(NAME_MARI_DBA), ' ',1) > 0
														or (regexfind(website_pattern_1, TRIM(NAME_MARI_DBA)) and regexfind('(^DBA )', trim(NAME_MARI_DBA)))
															or (regexfind(website_pattern_2, trim(NAME_MARI_DBA)))
															);

	dsBase_web_2 := pDataset(regexfind(website_pattern_1, trim(NAME_DBA)) and not stringlib.stringfind(trim(NAME_DBA), ' ',1) > 0
															or (regexfind(website_pattern_1, TRIM(NAME_DBA)) and regexfind('(^DBA )', trim(NAME_DBA)))
																	or (regexfind(website_pattern_2, trim(NAME_DBA)))
															);
	//DF-28229 - mari_rid is not populated at this point yet
	dedupBase := dedup(sort(distribute(dsBase_web_1 + dsBase_web_2,hash(primary_key)),primary_key,local), record, local);
	
																	
//Remove Records with Websites Names 
	dsBase_filter := pDataset - dedupBase;


	dsWebSearch_prj 	:= PROJECT(dedupBase,TRANSFORM(Prof_License_Mari.layouts.intermediate,
																 SELF.NAME_DBA 					:= '';
																 SELF.NAME_DBA_SUFX			:= '';
																 SELF.DBA_FLAG					:= 0;
																 SELF.NAME_DBA_ORIG			:= '';
																 SELF.NAME_MARI_DBA 		:= '';
																 // self.NAME_COMPANY_DBA 	:= '';
																 SELF := LEFT));

  dsWebCorrected		:= PROJECT(dsBase_filter, TRANSFORM(Prof_License_Mari.layouts.intermediate,
																strLength	:=	LENGTH(trim(left.name_dba));
																tmpNAME_DBA	:= if(regexfind('(\\.COM$|\\.BIZ$|\\.NET$)', trim(left.name_mari_dba))
																										and not regexfind('(\\.COM$|\\.BIZ$|\\.NET$)', trim(left.name_dba)) 
																										and regexfind('(COM$|BIZ$|NET$)', trim(left.name_dba)),
																																left.name_dba[1..(strLength-3)]+'.'+left.name_dba[(strLength-2)..],
																																left.name_dba);
																 SELF.NAME_DBA					:= tmpNAME_DBA;
																 SELF := LEFT));
															

//Concatenate Search records(w/o website info + Single Single with Website
dsNewBase :=  dsWebCorrected + dsWebSearch_prj;

return dsNewBase; 
end;

