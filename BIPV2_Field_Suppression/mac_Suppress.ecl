import BIPV2_Field_Suppression;


EXPORT mac_Suppress( 

   pDataset
  ,pShouldExplode               = 'true'                                                                      //if true, it will explode the clusters where suppression was applied.  false = turn off explosions
  ,pSuppressionFieldFilter      = '\'^(rcid|company_fein|duns_number|active_duns_number|source|proxid|dotid|lgid3|cnp_name)$\''  //use regex to filter for the fields you want to possibly suppress(include context fields if used) and id fields.  ex. '^(company_fein|duns_number|source|proxid|lgid3)$'
  ,pContextFieldFilter          = '\'^(source|cnp_name)$\''                                                   //use regex to filter for only the fields that are used in context with the suppression fields. ex. '^(source)$'
  ,pSetIDsFieldFilter           = '[\'rcid\',\'dotid\',\'proxid\',\'lgid3\']'                                 //use set to filter for only the ID fields you want to possibly explode if a suppression is performed on that cluster.  I
                                                                                                              //  Include fields that will be used as reset fields, and sort ascendingly by level in hierarchy.  ex. ['dotid','proxid','lgid3']
  ,pRidField                    = 'rcid'                                                                      //rid field

  ,pSuppressionFile             = 'pull(BIPV2_Field_Suppression.files.Suppression)'                           // 
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
    ,pShouldExplode               
    ,pDebug                       
    ,pTurnOffExtraOutputs         
    ,pShouldIncrementFile    
    ,pReturnDebugFields
    ,pForceExplosion
  );

  return do_suppression_explosion;

endmacro;