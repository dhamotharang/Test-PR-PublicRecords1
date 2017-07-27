IMPORT bipv2_build,BIPV2_Files, BIPV2_Seleid_Relative,tools,bipv2;

EXPORT Proc_build (

   string                             pversion    = bipv2.KeySuffix
	,DATASET(BIPV2.CommonBase.Layout  ) pInput      = bipv2.CommonBase.DS_CLEAN  //default to this 
  ,boolean                            pPromote2QA = true

) := 
function

		build_key  := tools.macf_WriteIndex('BIPV2_Seleid_Relative.keys(pInput).ASSOC, BIPV2_Seleid_Relative.keynames(pversion).assoc.logical');
				
		runIter := sequential(
       build_key
      ,BIPV2_Seleid_Relative.Promote(pversion).New2Built
      ,if(pPromote2QA = true  ,BIPV2_Seleid_Relative.Promote(pversion).Built2QA)
    ) 
    : SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'Seleid Relative')), 
			FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'Seleid Relative'));
			
    return runIter;
END;
