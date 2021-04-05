import BIPV2_Field_Suppression;


EXPORT mac_Suppress_Hierarchy( 

   pDataset
  ,pSuppressionFieldFilter      = '\'^(rid|src|id|parent_id|ultimate_id|hq_id|name|proxid)$\''  //use regex to filter for the fields you want to possibly suppress(include context fields if used) and id fields.  ex. '^(company_fein|duns_number|source|proxid|lgid3)$'
  ,pContextFieldFilter          = '\'^(rid|src|name|proxid)$\''                                 //use regex to filter for only the fields that are used in context with the suppression fields. ex. '^(source)$'
  ,pSetIDsFieldFilter           = '[]'                                                          //use set to filter for only the ID fields you want to possibly explode if a suppression is performed on that cluster.  I
                                                                                                              //  Include fields that will be used as reset fields, and sort ascendingly by level in hierarchy.  ex. ['dotid','proxid','lgid3']
  ,pRidField                    = 'rid'                                                                      //rid field

  ,pSuppressionFile             = 'pull(BIPV2_Field_Suppression.files.Hierarchy_Suppression)'                 // 
  ,pReturnDebugFields           = 'false'                                                                     //if true, it will keep the extra fields.  false = return same layout as supplied

  ,pDebug                       = 'false'                                                                     //if true, it will add a debug output so you can see the calculations
  ,pTurnOffExtraOutputs         = 'true'                                                                      //if true, it will not output anything else except for returning the suppressed dataset, false it will do the outputs
  ,pOutputGeneratedEcl          = 'false'
  ,pForceExplosion              = 'false'    //if true, it will force the suppressed clusters to be exploded even if they have already been.  false = normal explosion if necessary.
  
) :=
functionmacro


  import LinkingTools;
  
  do_suppression_explosion :=  LinkingTools.mac_Suppress( 

     pDataset
    ,pSuppressionFile             
    ,pOutputGeneratedEcl          
    ,pSuppressionFieldFilter      
    ,pContextFieldFilter          
    ,pSetIDsFieldFilter           
                                  
    ,pRidField                    
    ,false                   //should explode               
    ,pDebug                       
    ,pTurnOffExtraOutputs         
    ,pShouldIncrementFile    
    ,pReturnDebugFields
    ,false                   // force explosion
  );

  return do_suppression_explosion;

endmacro;