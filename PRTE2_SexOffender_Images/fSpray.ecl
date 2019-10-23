import prte2, std, tools;

EXPORT fSpray(string filedate) := function

#uniquename(groupname)
#uniquename(sourceCsvSeparator)
#uniquename(sourceCsvTeminator)
#uniquename(sourceCsvQuote)
#uniquename(spray_data)
#uniquename(clear_super)
#uniquename(super_input)


%groupname% 									:= tools.fun_Clustername_DFU();
%sourceCsvSeparator% := '/';
%sourceCsvTeminator% := '\\n,\\r\\n';
%sourceCsvQuote% 				:= '\"';

%clear_super%				    := SEQUENTIAL(STD.File.StartSuperFileTransaction(),
																																	  STD.File.ClearSuperFile('~thor_200::in::prte_hd_sex_off::Lookup::Superfile'),
																																	  STD.File.FinishSuperFileTransaction()
																																	  );
																																	
filename 												:= 'pics_list_sexoff_'+filedate+'.lookup';
%spray_data% 							:= fileservices.SprayVariable(prte2._Constants().sServerIP,
																																																		prte2._Constants().sDirectory+'prte__SOKeysImages/'+filename, 
																																																		4000,
																																																		%sourceCsvSeparator%,
																																																		%sourceCsvTeminator%,
																																																		'',
																																																		%groupname%, 
																																																		'~thor_200::in::prte_hd_sex_off::Lookup::'+filename,
																																																		,
																																																		,
																																																		,
																																																		TRUE,
																																																		,
																																																		FALSE);
																																																		
// Do superfile transactions
%super_input% 					:= sequential(STD.File.StartSuperFileTransaction(),
                                	STD.File.AddSuperFile('~thor_200::in::prte_hd_sex_off::Lookup::Superfile',	'~thor_200::in::prte_hd_sex_off::Lookup::'+filename), 
																																	STD.File.FinishSuperFileTransaction()
																																	);

return sequential(%clear_super%,%spray_data%,%super_input%);
end;
																																																		