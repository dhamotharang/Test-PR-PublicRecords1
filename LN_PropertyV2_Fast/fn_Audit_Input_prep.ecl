IMPORT LN_PropertyV2_Fast,STD;
EXPORT fn_Audit_Input_prep(string process_date) := FUNCTION

		rawSuperFileNames := dataset([LN_PropertyV2_Fast.FileNames.raw.bk.assessment,
											  LN_PropertyV2_Fast.FileNames.raw.bk.assessment_repl,
												LN_PropertyV2_Fast.FileNames.raw.bk.deed,
												LN_PropertyV2_Fast.FileNames.raw.bk.deed_repl,
												LN_PropertyV2_Fast.FileNames.raw.bk.mortgage,
												LN_PropertyV2_Fast.FileNames.raw.bk.mortgage_repl,
												LN_PropertyV2_Fast.FileNames.raw.frs.deed,
												LN_PropertyV2_Fast.FileNames.raw.frs.assessment,
												LN_PropertyV2_Fast.FileNames.raw.frs.assessment_ptu
												],{string rawSuperFileName});

rec := record
string rawSuperFileName;
dataset({string name}) subfilename;
end;

rec tnew( rawSuperFileNames l ) := transform
self.subfilename := fileservices.SuperFileContents(l.rawSuperFileName);
self := l;
end;

newrawSuperFileNames := nothor(project(global(rawSuperFileNames,few),tnew(left)));

rec1 := record
string rawSuperFileName;
string filename;
end;

rec1 tnew1( newrawSuperFileNames l,integer c ) := transform
self.filename := l.subfilename[c].name;
self := l;
end;

newds := NORMALIZE(newrawSuperFileNames,left.subfilename,tnew1(left,counter));




subInSuperFile(string super,string sub) := function
 return  if( ~(sub in  set(fileservices.SuperFileContents(super,true),name)) ,
           Sequential(                
								fileservices.StartSuperFileTransaction(),
										 fileservices.AddSuperFile(super,'~'+sub),
										 fileservices.FinishSuperFileTransaction() 
										)
						);
		end;

		
return	Sequential(	
               nothor(
		                apply(
							             global(newds,few),
							             subInSuperFile(rawSuperFileName+'_reporting',filename)
											
												     
        					       )
							            
						         ),
					LN_PropertyV2_Fast.fn_Audit_Input(process_date)
					     );
end;