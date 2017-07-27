EXPORT mac_ID_Integrity_check_V2( 
   pDataset1
  ,pRid
  ,pDid
  ,pUse_Parent = false
  ,pParent_ID  = ''
	,pBuild_Step ='Proxid'                                      // Proxid, Empid, etc
  ,pBuild_SubStep ='Preprocess'
) :=
functionmacro
	import salt30,BIPV2_Tools;
	lay_integrity := BIPV2_strata.layouts.Id_Integrity;
	
	loutputEmpty :=dataset([],lay_integrity);
	
	#IF(STD.Str.ToLowerCase(#TEXT(pBuild_Step))='dotid') //For DOTID
				return loutputEmpty;
	#ELSEIF(  //For bipv2_proxid_preprocess_ID_Integrity_Check
							STD.Str.ToLowerCase(#TEXT(pBuild_Step))='\'proxid\'' and STD.Str.ToLowerCase(#TEXT(pBuild_SubStep))='\'preprocess\'' and 
							NOT(STD.Str.ToLowerCase(#TEXT(pDid))='dotid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='proxid')
					 )
				return loutputEmpty;
	
	#ELSEIF(	//For bipv2_proxidmj6_preprocess_ID_Integrity_Check
							STD.Str.ToLowerCase(#TEXT(pBuild_Step))='\'proxidmj6\'' and STD.Str.ToLowerCase(#TEXT(pBuild_SubStep))='\'preprocess\'' and
							NOT(STD.Str.ToLowerCase(#TEXT(pDid))='dotid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='proxid') and 
						  NOT(STD.Str.ToLowerCase(#TEXT(pDid))='proxid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='seleid')
					 ) 
				return loutputEmpty;
	#ELSEIF(  //For bipv2_proxid_PrePost_ID_Integrity_Check
							STD.Str.ToLowerCase(#TEXT(pBuild_Step))='\'proxid\'' and STD.Str.ToLowerCase(#TEXT(pBuild_SubStep))='\'prepost\'' and
							NOT(STD.Str.ToLowerCase(#TEXT(pDid))='dotid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='proxid') and 
						  NOT(STD.Str.ToLowerCase(#TEXT(pDid))='proxid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='seleid')
						) 
  			return loutputEmpty;
	#ELSEIF(  //For bipv2_hrchy_infile_ID_Integrity_Check
							STD.Str.ToLowerCase(#TEXT(pBuild_Step))='\'hrchy\'' and STD.Str.ToLowerCase(#TEXT(pBuild_SubStep))='\'infile\'' and
					    NOT(STD.Str.ToLowerCase(#TEXT(pDid))='proxid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='seleid')
						)	
				return loutputEmpty;
	#ELSEIF(	//For bipv2_lgid3_preprocess_ID_Integrity_Check
							STD.Str.ToLowerCase(#TEXT(pBuild_Step))='\'lgid3\'' and STD.Str.ToLowerCase(#TEXT(pBuild_SubStep))='\'preprocess\'' and
							NOT(STD.Str.ToLowerCase(#TEXT(pDid))='proxid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='seleid')
						) 
				return loutputEmpty;
	#ELSEIF(  //For bipv2_powid_preprocess_ID_Integrity_Check
							STD.Str.ToLowerCase(#TEXT(pBuild_Step))='\'powid\'' and STD.Str.ToLowerCase(#TEXT(pBuild_SubStep))='\'preprocess\'' and
							NOT(STD.Str.ToLowerCase(#TEXT(pDid))='lgid3' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='seleid') and
						  NOT(STD.Str.ToLowerCase(#TEXT(pDid))='seleid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='orgid') and
						  NOT(STD.Str.ToLowerCase(#TEXT(pDid))='orgid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='ultid')  and
						  NOT(STD.Str.ToLowerCase(#TEXT(pDid))='proxid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='seleid')
						) 
  			return loutputEmpty;
	#ELSEIF(  //For bipv2_empid_preprocess_ID_Integrity_Check
							STD.Str.ToLowerCase(#TEXT(pBuild_Step))='\'empid\'' and STD.Str.ToLowerCase(#TEXT(pBuild_SubStep))='\'preprocess\'' and
							NOT(STD.Str.ToLowerCase(#TEXT(pDid))='powid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='orgid') and
						  NOT(STD.Str.ToLowerCase(#TEXT(pDid))='orgid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='ultid') 
					 ) 
				return loutputEmpty;
  #ELSEIF(  //For bipv2_commonbase_input_ID_Integrity_Check
							STD.Str.ToLowerCase(#TEXT(pBuild_Step))='\'commonbase\'' and STD.Str.ToLowerCase(#TEXT(pBuild_SubStep))='\'input\'' and
							NOT(STD.Str.ToLowerCase(#TEXT(pDid))='empid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='orgid') and
						  NOT(STD.Str.ToLowerCase(#TEXT(pDid))='orgid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='ultid') and
							(NOT(STD.Str.ToLowerCase(#TEXT(pDid))='ultid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='ultimate_proxid') OR
							 NOT(STD.Str.ToLowerCase(#TEXT(pDid))='ultimate_proxid' and STD.Str.ToLowerCase(#TEXT(pParent_ID))='ultid')
							)
						) 
				return loutputEmpty;
  #ELSE
 
 
  ds_dataset    := distribute(table(pDataset1,{pRid,pDid #if(#TEXT(pParent_ID) != '') ,pParent_ID #END})) : independent;							
  countgroup    := count(ds_dataset);
  
  pDid_Unique   := count(table(table(ds_dataset(pDid    != 0   ),{unsigned6 pDid  := pDid   }), {pDid  },pDid  ,merge));

  r := RECORD
    UNSIGNED pDid_null0                 := COUNT(GROUP,(UNSIGNED)ds_dataset.pDid   = 0 );
    UNSIGNED pDid_belowpParent_ID0      := #if(#TEXT(pParent_ID) != '') COUNT(GROUP,(UNSIGNED)ds_dataset.pDid   <(UNSIGNED)ds_dataset.pParent_ID ) #ELSE 0 #END ;
    UNSIGNED pRid_atparent              := COUNT(GROUP,(UNSIGNED)ds_dataset.pDid  =(UNSIGNED)ds_dataset.pRid);
    UNSIGNED pDid_atparent_pParent_ID   := #if(#TEXT(pParent_ID) != '') COUNT(GROUP,(UNSIGNED)ds_dataset.pParent_ID =(UNSIGNED)ds_dataset.pDid  AND (UNSIGNED)ds_dataset.pDid  =(UNSIGNED)ds_dataset.pRid) #ELSE 0 #END ;
  END;
  
  d_null_below := table(ds_dataset,r);
  
  // ----------------------------------------------------------------
  pDid_Clusters   := SALT30.MOD_ClusterStats.Counts(ds_dataset  ,pDid  );
  
  IdCounts := DATASET([
      {SUM(pDid_Clusters,NumberOfClusters)}
  ],{UNSIGNED pDid_Count}
  ); // The counts of each ID
  
  // For deeper debugging; provide the unbased parents
  bases_pDid     := ds_dataset((UNSIGNED)pDid =(UNSIGNED)pRid); // Get the bases
  pDid_Unbased   := JOIN(ds_dataset(pDid <>0) ,bases_pDid  ,LEFT.pDid   = RIGHT.pDid   ,TRANSFORM(LEFT),LEFT ONLY,HASH);
  
 // Children with two parents
	f_thin_pDid_pParent_ID      := #if(#TEXT(pParent_ID) != '') TABLE(ds_dataset(pDid   <> 0  ,pParent_ID <>  0),{pDid   ,pParent_ID },pDid  ,pParent_ID ,MERGE) #ELSE 0 #END ; // HACK
  pDid_Twoparents_pParent_ID  := #if(#TEXT(pParent_ID) != '') DEDUP(JOIN(f_thin_pDid_pParent_ID ,f_thin_pDid_pParent_ID ,LEFT.pDid =RIGHT.pDid  AND LEFT.pParent_ID > RIGHT.pParent_ID,TRANSFORM({SALT30.UIDType pParent_ID1,SALT30.UIDType pDid ,SALT30.UIDType pParent_ID2 },SELF.pParent_ID1 :=LEFT.pParent_ID ,SELF.pParent_ID2 :=RIGHT.pParent_ID  ,SELF.pDid :=LEFT.pDid  ),HASH),WHOLE RECORD,ALL) #ELSE 0 #END ;
 
 // Now compute the more involved consistency checks
    r2 := RECORD
      {d_null_below} ;
      INTEGER pDid_unbased0                 := IdCounts[1].pDid_Count  - d_null_below.pRid_atparent        ;
      INTEGER pDid_Twoparents_pParent_ID0   := #if(#TEXT(pParent_ID) != '') COUNT(pDid_Twoparents_pParent_ID) #ELSE 0 #END;
    END;
  Advanced0 := TABLE(d_null_below,r2);

  d_nb := d_null_below[1];
  d_Ad := Advanced0[1];
  // -----
  pDid_pParent_ID_checks := BIPV2_Tools.idIntegrity().custom(ds_dataset,pRid,pDid ,outPrefix:='',verbose:=false,use_parent:=pUse_Parent  ,pid:=pParent_ID,pOutput_Dataset:=true);
  lOutput := dataset([
    {
       #TEXT(pDid)                                  //Identifier
      ,#TEXT(pParent_ID)                            //Parent_ID
      ,countgroup                                   //countgroup
      ,pDid_Unique                                  //uniques
      ,d_nb.pDid_null0                              //null0  
      ,d_Ad.pDid_unbased0                           //unbased0  
      ,pDid_pParent_ID_checks[1].DuplicateRids0     //DuplicateRids0  
      ,pDid_pParent_ID_checks[1].DidsNoRid0         //DidsNoRid0      
      ,pDid_pParent_ID_checks[1].DidsAboveRid0      //DidsAboveRid0   
      ,d_nb.pDid_belowpParent_ID0                   //belowparent0
      ,d_Ad.pDid_Twoparents_pParent_ID0             //twoparents0
      ,pDid_pParent_ID_checks[1].DidsMultiParent0   //DidsMultiParent0
      ,pDid_pParent_ID_checks[1].ParentNoDid0       //ParentNoDid0    
      ,pDid_pParent_ID_checks[1].ParentAboveDid0    //ParentAboveDid0 
    }                                               
  ],lay_integrity);                                                                                                                                                                                                                                                                                                                                     

  return loutput;
	#END
endmacro;