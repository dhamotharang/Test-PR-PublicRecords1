IMPORT data_services,dops,std,tools,Roxiekeybuild;

EXPORT FN_Update_Keys_SF(string pVersion) := Module 

FS:= fileservices;

getList(string pSFgen, string sVersion='') := function
       d:= INQL_v2.Keynames(true,false,sVersion).nonfcra_daily;
       SFList:= table(d,{logicalname,string SFname:=STD.Str.FindReplace(templatename, '@version@',pSFgen)});
			 return SFList;
end;


updateSF(dataset({string logicalname, string SFname}) SFList)  := function

      return sequential(			
												FS.StartSuperFileTransaction(),	
														nothor(apply(SFList,
																				 FS.ClearSuperFile(SFname, false),
																				 FS.AddSuperFile(SFname, logicalname))),
												FS.FinishSuperFileTransaction()
												);
end;		

PromotefromFatherToDelete (dataset({string logicalname, string SFname}) SFList)  := function

      return 	nothor(apply(SFList,
																	STD.File.PromoteSuperFileList([	SFName,
																																	STD.Str.FindReplace(SFname, 'father','grandfather'),
																																	STD.Str.FindReplace(SFname, 'father', 'delete')
																																]
																																,logicalname
																																,true)
										 ));
end;		

export run := sequential(
													updateSF(getList('built', pVersion));
													updateSF(getList('qa', INQL_V2._Versions.dops_nonfcra_update_keys_certQA));
													updateSF(getList('prod', INQL_V2._Versions.dops_nonfcra_update_keys_prod));
													PromoteFromFatherToDelete(getList('father',INQL_V2._Versions.dops_nonfcra_update_keys_father)) 
												);


end;	


