import bipv2,bipv2_files,tools,bipv2_tools,wk_ut,std,mdr,BIPV2_Strata,strata, linkingtools,BIPV2_ForceLink,BIPV2_Field_Suppression;

l_common  := BIPV2.CommonBase.Layout;
l_base    := BIPV2_Files.files_lgid3.Layout_LGID3;

EXPORT _Preprocess(
   string                              pversion          = bipv2.KeySuffix  
  ,dataset(l_common                )   pDataset          = BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING
  ,boolean                             pIsTesting        = false
  ,string                              pFilename         = BIPV2_Files.files_hrchy.FILENAME_HRCY_BASE_LF_FULL_BUILDING  //should be the filename from the above dataset
  ,boolean                             pDoStrata         = BIPV2_LGID3._Constants().doStrata
  ,boolean                             pCopy2StorageThor = BIPV2_LGID3._Constants().copy2storagethor
  ,boolean                             pDoSuperfileStuff = true
) := 
function
	
  ds_hrchy := pDataset;

	/* ---------------------- Logical Files ------------------------------- */
	f_init								:= BIPv2_Files.files_lgid3.FILE_INIT + '::' + pversion;

	/* ---------------------- Pre-processing ---------------------------- */
  l_base toBase(l_common L) := TRANSFORM
    isLegal	:= (L.company_name_type_derived='LEGAL' or (L.company_name_type_derived='FBN' and mdr.sourcetools.sourceisCorpV2(L.source)));
    SELF.company_name				:= if(isLegal, L.company_name, '');	// BLANK except for Legal Names
    SELF.cnp_number					:= if(isLegal, L.cnp_number, '');		// BLANK except for legal Names
    self.sbfe_id            := if(mdr.sourceTools.SourceIsBusiness_Credit(l.source) ,l.vl_id ,'');
    SELF.seleid							:= if(L.seleid > 0, L.seleid, L.lgid3);
    SELF.orgid							:= if(L.orgid > 0, L.orgid, L.lgid3);
    SELF.ultid							:= if(L.ultid > 0, L.ultid, L.lgid3);
    SELF.nodes_below_st			:= (string10)L.nodes_below;
    SELF.Lgid3IfHrchy				:= if(L.nodes_total>1,(string20)L.LGID3,'');
    
    SELF.OriginalSeleId			:= if(L.nodes_total>1, L.seleid, 0); //each hierarchy node get these two
    SELF.OriginalOrgId			:= if(L.nodes_total>1, L.orgid, 0);
    self.duns_number        := if(L.deleted_key = '' and mdr.sourceTools.SourceIsDunn_Bradstreet(l.source),L.duns_number  ,''  ); //blank out deleted duns numbers.  they will come back in the postprocess
    self.company_fein       := if(mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(l.source) and l.ingest_status = 'Old'  ,''  ,L.company_fein  ); //blank out deleted duns numbers.  they will come back in the postprocess
    //Suggested by Chad, the leafnode LGID3 should initialize to SeleID:
    //self.LGID3							:=if(L.nodes_total>1 and L.nodes_below=0 and L.seleid>0, L.seleid, L.LGID3);
    SELF := L;
  END;
		
  ds_init           := BIPV2_Tools.initParentID(ds_hrchy, proxid, lgid3) : persist('~persist::BIPV2_LGID3::_Preprocess::ds_init');

  // -- patch lgid3 underlinks outside of salt
  ds_patch_Underlinks := BIPV2_ForceLink.mac_ForceLink_Lgid3 (ds_init);

  // -- Suppress overlinks.  turn off explosion(2nd param) because it has already been done in the proxid preprocess.
  ds_suppress := BIPV2_Field_Suppression.mac_Suppress(ds_patch_Underlinks,false) ;

  preprocessResult  := PROJECT(ds_suppress,toBase(LEFT));	
  
  kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(pFilename)[1].name) ,pversion ,'lgid3_preprocess');
  copy2StorageThor         := if(pCopy2StorageThor = true ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor
  
  doStrata := if(pDoStrata = true ,BIPV2_Strata.mac_BIP_ID_Check(ds_hrchy,'LGID3','Preprocess',pversion,pIsTesting));
  
	return_results := sequential(
     doStrata 
		,if(pDoSuperfileStuff = true  ,BIPV2_Files.files_lgid3.clearBuilding)
		,BIPV2_LGID3._getInitialChanges(pversion,ds_hrchy, preprocessResult)
		,OUTPUT(preprocessResult,,f_init,COMPRESSED,OVERWRITE)
		,if(pDoSuperfileStuff = true  ,BIPV2_Files.files_lgid3.updateBuilding(f_init))
    ,copy2StorageThor
  );
  
  return return_results;
  
end;
