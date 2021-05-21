// -- Add field suppression candidates

// -- SUPPRESSED FIELD VALUES
ds_suppressed_field_values := dataset([
  {'company_fein*' ,'^(000000000|111111111|999999999)$'}
 ,{'company_fein' ,'123456788'}
 
]  ,BIPV2_Field_Suppression.layouts.Suppression_field);

// -- CONTEXT VALUES
ds_context := dataset([
  // {'source'    ,mdr.sourcetools.src_cortera }
 // ,{'cnp_name*' ,'BERKOWITZ'                 }
  
]  ,BIPV2_Field_Suppression.layouts.Suppression_field);

// -- ID VALUES to explode -- 'HY' hierarchy does not explode right now so this should be null
ds_IDS := dataset([
  {'proxid' ,'dotid'}
 ,{'lgid3'  ,'proxid'}
  
]  ,BIPV2_Field_Suppression.layouts.Suppression_field);

// -- CONSTRUCT SUPPRESSED RECORD
ds_suppressions := 
  dataset([
    { ds_suppressed_field_values   ,'BH-845 -- improve fein matching in lgid3. regex fein, explode proxid to dotid' ,'FSE'  ,ds_context ,ds_IDS} // -- examples
  ]  ,BIPV2_Field_Suppression.layouts.Suppression_in);  

// -- PERFORM SUPPRESSION
BIPV2_Field_Suppression.Add_Candidates(ds_suppressions,'IL'  /*,'HY' for hierarchy*/);
