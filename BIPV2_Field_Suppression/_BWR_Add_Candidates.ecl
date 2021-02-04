// -- Add field suppression candidates
/*
  export Suppression_field := {string fieldname ,string fieldvalue};

  export Suppression_in := 
    {
       dataset(Suppression_field) suppressed_field_values  
      ,string                     comment
      ,dataset(Suppression_field) context                 := dataset([],Suppression_field)  //optional
    };
*/
ds_suppressed_field_values := dataset([
  {'company_fein' ,'999999999'}
 ,{'company_fein' ,'000000000'}
 ,{'company_fein' ,'111111111'}
 ,{'company_fein' ,'123456789'}
]  ,BIPV2_Field_Suppression.layouts.Suppression_field);

ds_context := dataset([
  
]  ,BIPV2_Field_Suppression.layouts.Suppression_field);

ds_suppressions := 
  dataset([
    { ds_suppressed_field_values   ,'BH-845 -- improve fein matching in lgid3' ,ds_context} // -- examples
  ]  ,BIPV2_Field_Suppression.layouts.Suppression_in);  
  
BIPV2_ForceLink.Add_Candidates(ds_suppressions);