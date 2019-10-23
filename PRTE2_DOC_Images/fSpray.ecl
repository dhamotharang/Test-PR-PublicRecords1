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
																																	  STD.File.ClearSuperFile('~thor_200::in::prte_HD_Crim_Off::Lookup::Superfile'),
																																	  STD.File.FinishSuperFileTransaction()
																																	  );
																																	
filename 												:= 'pics_list_arr_doc_'+filedate+'.lookup';
%spray_data% 							:= fileservices.SprayVariable(prte2._Constants().sServerIP,
																																																		prte2._Constants().sDirectory+'prte__DOCKeysImages/'+filename, 
																																																		,
																																																		%sourceCsvSeparator%,
																																																		%sourceCsvTeminator%,
																																																		'',
																																																		%groupname%, 
																																																		'~thor_200::in::prte_HD_Crim_Off::Lookup::'+filename,
																																																		,
																																																		,
																																																		,
																																																		TRUE,
																																																		,
																																																		FALSE);
																																																		
// Do superfile transactions
%super_input% 					:= sequential(STD.File.StartSuperFileTransaction(),
                                	STD.File.AddSuperFile('~thor_200::in::prte_HD_Crim_Off::Lookup::Superfile',	'~thor_200::in::prte_HD_Crim_Off::Lookup::'+filename), 
																																	STD.File.FinishSuperFileTransaction()
																																	);

return sequential(%clear_super%,%spray_data%,%super_input%);
end;
																																																		