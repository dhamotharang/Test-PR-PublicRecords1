IMPORT LN_PropertyV2; 
EXPORT proc_dproptx (STRING pversion = workunit[2..7]
                     ,STRING iter = '1' 
                     ,dataset(LN_PropertyV2.Layout_DID_Out			)       pSearch  	= LN_PropertyV2.File_Search_DID	                          
                     ,dataset(LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs	) pDeed		= LN_PropertyV2.Files.Base.DeedMortgage	 
) 
:= FUNCTION

  Prepit    := proc_preprocess(pversion,pSearch,pDeed);
  Iterit    := proc_iterprocess(pversion,iter);
  // Copy salt output to salt input sf for next iteration if more than 1 iteration  
  Postit    := proc_postprocess(pversion,iter);
  // Run Specificty keys after the build takes 8-9 hours 
  //SpecMod   := InsuranceHeader_Property_Transactions_DeedsMortgages.specificities(InsuranceHeader_Property_Transactions_DeedsMortgages.In_Property_Transaction);
  //SpecMod.Build;
  
RETURN SEQUENTIAL(Prepit,Iterit,Postit);

END;