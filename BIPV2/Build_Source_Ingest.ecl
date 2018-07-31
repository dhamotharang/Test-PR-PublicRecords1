
import Business_Header, AID_Build, ut, mdr, tools,wk_ut,std,BIPV2_Build,BIPV2_Tools, Scrubs, Scrubs_BIPV2;

EXPORT Build_Source_Ingest(

	 string																				pversion                = bipv2.KeySuffix
	,boolean																			pIsTesting		          = false
	,dataset(BIPV2.Layout_Business_Linking_Full)	pBusiness_Sources_init	= BIPV2.BL_Init() // dataset([],BIPV2.Layout_Business_Linking_Full)
	,dataset(BIPV2.CommonBase.layout           )	pPrevious_Base_File	    = BIPV2.CommonBase.DS_STATIC
	,boolean																			pWriteFileOnly	        = false
  ,string                                       pEmailList              = BIPV2_Build.mod_email.emaillist

) :=
function

		tools.mac_WriteFile(Filenames(pversion).Source_Ingest.new	,pBusiness_Sources_init	,Build_Base_File	,pShouldExport := false);

    kick_copy2_storage_thor := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2.Filenames().Source_Ingest.father)[1].name),pversion,'Build_Source_Ingest');

    // -- email omitted sources
    ds_omitted_sources := join(table(pPrevious_Base_File,{source},source,merge)  ,table(pBusiness_Sources_init,{source},source,merge) ,left.source = right.source ,transform({string source},self.source := mdr.sourceTools.translatesource(left.source)) ,left only ,lookup);
    ds_omitted_sort    := sort(ds_omitted_sources,source);
    ds_omitted_proj    := project(ds_omitted_sort,transform({string sources},self.sources := '\t' + left.source));
    ds_omitted_rollup  := rollup(ds_omitted_proj,true,transform(recordof(left),self.sources := left.sources + '\n' + right.sources));
    
    email_subject := 'BIPV2.Build_Source_Ingest ' + pversion + ' ALERT!!! Please confirm the sources omitted from the Source Ingest!';
    email_body    :=    
                        'The following sources have been omitted from the source ingest for this ' + pversion + ' build:\n' 
                      + ds_omitted_rollup[1].sources
                      + '\n\n'
                      + 'http://' + wk_ut._constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary'
                      ;
    email_alert := if(exists(ds_omitted_sources)  ,STD.System.Email.SendEmail ( pEmailList, email_subject, email_body));
    // -- email omitted sources

		return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
         email_alert
				,Build_Base_File
				,Scrubs.ScrubsPlus('BIPV2','Scrubs_BIPV2','Scrubs_BIPV2_Ingest', 'Ingest', pversion, pEmailList, false)
				,if(not pWriteFileOnly	,Promote(pversion,'source_ingest').buildfiles.New2Built	)
				,if(not pWriteFileOnly	,Promote(pversion,'source_ingest').buildfiles.Built2Qa	)
        ,wk_ut.Strata_Orbit_Item_list(workunit,'BIPV2','Full_Build'  ,pversion ,pEmailNotifyList := BIPV2_Build.mod_email.emailList,pIsTesting := false)
        // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2.Filenames().Source_Ingest.father)[1].name)  ,pDeleteSourceFile  := true))  //copy father file to storage thor
        ,if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')))  //copy father file to storage thor

			)		
			,output('No Valid version parameter passed, skipping BIPV2.Build_Source_Ingest attribute') 
		);
	
end;