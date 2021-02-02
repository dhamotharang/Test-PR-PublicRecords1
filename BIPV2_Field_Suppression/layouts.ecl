EXPORT layouts :=
module


  // export Suppression_in  := {string fieldname ,string fieldvalue ,string comment};

  // export Suppression_out := {string fieldname ,string fieldvalue ,string date_added ,string userid  ,string comment};

// so maybe you could pass in two different layouts.  one simplified for just specific field values with no context
// the other could also have context
// i could differentiate them by looking for certain fields in the macro.
// this would make this easy to run, but it could be more powerful if necessary
// 

  export Suppression_field := {string fieldname ,string fieldvalue};

  export Suppression_in := 
    {
       dataset(Suppression_field) suppressed_field_values  
      ,string                     comment
      ,dataset(Suppression_field) context                 := dataset([],Suppression_field)  //optional
    };

  export Suppression_out := 
    {
       unsigned6                  suppressionid  
      ,dataset(Suppression_field) context  
      ,dataset(Suppression_field) suppressed_field_values  
      ,string                     date_added 
      ,string                     userid  
      ,string                     comment
    };

end;