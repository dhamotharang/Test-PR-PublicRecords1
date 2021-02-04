/*

ds_suppressed := LinkingTools.mac_Suppress(ds_sample,,false,'^(rcid|company_fein|duns_number|source|proxid|dotid|lgid3|cnp_name)$'  ,'^(source|cnp_name)$',['rcid','dotid','proxid','lgid3']  ,rcid ,true,false)


*/

import BIPV2_Field_Suppression;

EXPORT mac_gen_suppress_code( 

   pDataset
  ,pSuppressionFile         = 'pull(BIPV2_Field_Suppression.files.Preprocess)'  // 
  ,pOutputGeneratedEcl      = 'false'
  ,pSuppressionFieldFilter  = '\'\''    //use regex to filter for the fields you want to possibly suppress(include context fields if used) and id fields.  ex. '^(company_fein|duns_number|source|proxid|lgid3)$'
  ,pContextFieldFilter      = '\'\''    //use regex to filter for only the fields that are used in context with the suppression fields. ex. '^(source)$'
  ,pSetIDsFieldFilter       = '\'\''    //use set to filter for only the ID fields you want to possibly explode if a suppression is performed on that cluster.  I
                                        //  Include fields that will be used as reset fields, and sort ascendingly by level in hierarchy.  ex. ['dotid','proxid','lgid3']
  ,pRidField                = ''        //rid field
  ,pShouldExplode           = 'true'    //if true, it will explode the clusters where suppression was applied.  false = turn off explosions
  ,pDebug                   = 'false'   //if true, it will add a debug output so you can see the calculations

) :=
functionmacro

  ds_norm_context       := normalize(pSuppressionFile ,left.context ,transform(right));
  ds_norm_context_proj  := project(ds_norm_context ,transform({string context},self.context := left.fieldname));
  ds_context_dedup      := table(ds_norm_context_proj  ,{context}  ,context  ,few);
  ds_context_string     := rollup(ds_context_dedup  ,true ,transform(recordof(left),self.context := trim(left.context) + '|' + trim(right.context)));
  
  // for ids, we need fieldname and fieldvalue.  might have to do two norms, but need to preserve order from low to high id.
  ds_norm_ids       := normalize(pSuppressionFile ,left.IDs_To_Explode ,transform(right));
  ds_norm_ids_proj  := project(ds_norm_ids ,transform({string IDs_To_Explode1 ,string IDs_To_Explode2},self.IDs_To_Explode1 := right.fieldname,self.IDs_To_Explode2 := right.fieldvalue));
  ds_ids_dedup      := table(ds_norm_ids_proj  ,{IDs_To_Explode1  ,IDs_To_Explode2}  ,IDs_To_Explode1 ,IDs_To_Explode2  ,few);
  ds_ids_string     := rollup(ds_ids_dedup  ,true ,transform(recordof(left),self.context := trim(left.context) + '|' + trim(right.context)));
  




  ds_suppressed := LinkingTools.mac_Suppress(ds_sample,,false,'^(rcid|company_fein|duns_number|source|proxid|dotid|lgid3|cnp_name)$'  ,'^(source|cnp_name)$',['rcid','dotid','proxid','lgid3']  ,rcid ,true,false)





  return ;
  

endmacro;

