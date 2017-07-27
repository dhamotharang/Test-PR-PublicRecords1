import Business_Header, AID_Build, ut, mdr, tools,wk_ut,std;

EXPORT Build_Source_Ingest(

	 string																				pversion
	,boolean																			pIsTesting		          = false
	,dataset(BIPV2.Layout_Business_Linking_Full)	pBusiness_Sources_init	= BIPV2.BL_Init()
	,boolean																			pWriteFileOnly	        = false

) :=
function
		tools.mac_WriteFile(Filenames(pversion).Source_Ingest.new	,pBusiness_Sources_init	,Build_Base_File	,pShouldExport := false);
		
		return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
				 Build_Base_File
				,if(not pWriteFileOnly	,Promote(pversion,'source_ingest').buildfiles.New2Built	)
				,if(not pWriteFileOnly	,Promote(pversion,'source_ingest').buildfiles.Built2Qa	)
        ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2.Filenames().Source_Ingest.father)[1].name)  ,pDeleteSourceFile  := true))  //copy father file to storage thor

			)		
			,output('No Valid version parameter passed, skipping BIPV2.Build_Source_Ingest attribute') 
		);
	
end;