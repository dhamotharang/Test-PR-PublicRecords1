import did_add, PromoteSupers;

EXPORT HeaderInfo := module
	
	shared ProdVer	:= did_add.get_EnvVariable('header_build_version')[1..8] : INDEPENDENT;
	shared dsVer		:= dataset(bair.Superfile_List().NewHeader,{string8 Prod_Ver},flat,opt);
	
	EXPORT IsNew 		:= if(nothor(fileservices.fileExists(bair.Superfile_List().NewHeader)), ProdVer <> dsVer[1].Prod_Ver, true);
	
	PromoteSupers.MAC_SF_BuildProcess(dataset([{ProdVer}],{string8 Prod_Ver}), bair.Superfile_List().NewHeader, PostNewHeader ,2,,true);
	EXPORT Post 		:= if(IsNew
											,sequential(PostNewHeader, output('header_build_version Changed', named('HeaderInfoChanged')))
											,sequential(output('header_build_version Not Changed', named('HeaderInfoNotChanged')))
											);	
	
END;