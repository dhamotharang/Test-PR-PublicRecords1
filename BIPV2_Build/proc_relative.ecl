IMPORT BIPV2_Files, BIPV2_Relative,tools,bipv2;

EXPORT proc_relative (

   string                             pversion    = bipv2.KeySuffix
	,DATASET(BIPV2_Files.layout_proxid) pInput      = BIPV2_Relative.In_DOT_Base  //default to this 
  ,boolean                            pPromote2QA = true

) := 
function

		build_key  := tools.macf_WriteIndex('BIPv2_Relative.keys(pInput).ASSOC, BIPV2_Relative.keynames(pversion).assoc.logical');
				
		runIter := sequential(
       build_key
      ,BIPv2_Relative.Promote(pversion).New2Built
      ,if(pPromote2QA = true  ,BIPv2_Relative.Promote(pversion).Built2QA)
    ) 
    : SUCCESS(mod_email.SendSuccessEmail(,'BIPv2', , 'Proxid Relative')), 
			FAILURE(mod_email.SendFailureEmail(,'BIPv2', failmessage, 'Proxid Relative'));
	
  return runIter;
  
END;
