shared pversion := '20171016';
shared pFilter := '';
shared pNewFilter := '';
shared dfilenames		:=  //Filenames				().dAll_filenames
												/*+*/ prte2_bipv2_busheader.Keynames(pversion).dAll_filenames
												;
shared filter				:= if(pFilter 		= ''	,true
																						,regexfind(pFilter		,dfilenames.templatename		,nocase)
											);
shared newfilter		:= if(pNewFilter	= ''	,true
																						,regexfind(pNewFilter	,dfilenames.templatenameNew	,nocase)
											);

shared dfilestorollback := dfilenames(filter,newfilter);

nothor(Tools.fun_ClearfilesFromSupers(project(dfilenames, transform(Tools.Layout_Names,self.name := left.logicalname)), false))