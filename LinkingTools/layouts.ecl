EXPORT layouts :=
module


  // export Suppression_in  := {string fieldname ,string fieldvalue ,string comment};

  // export Suppression_out := {string fieldname ,string fieldvalue ,string date_added ,string userid  ,string comment};

// so maybe you could pass in two different layouts.  one simplified for just specific field values with no context
// the other could also have context
// i could differentiate them by looking for certain fields in the macro.
// this would make this easy to run, but it could be more powerful if necessary
// 

/*  // -- just for suppressions only.  no explosions here.
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
      ,string                     wuid 
      ,string                     userid  
      ,string                     comment
    };
*/



 // -- keep this for now.  I will test the suppression with the above layouts first. 
  export Suppression_field := {string fieldname ,string fieldvalue};

  export Suppression_in := 
    {
       dataset(Suppression_field) suppressed_field_values  
      ,string                     comment
      ,string                     operation               := 'FSE'                          //'FSE' field suppression + explosion, 'FS' = field suppression only  ,'E' Explosion only of cluster containing field values, 'RS' = record suppression
      ,dataset(Suppression_field) context                 := dataset([],Suppression_field)  //optional
      ,dataset(Suppression_field) IDs_To_Explode          := dataset([],Suppression_field)  //field name is ID to explode, fieldvalue is the value to explode it to.  ''(blank means zero), 0 means zero, otherwise you can specify another field.  
      ,
    };

  export Suppression_out := 
    {
       unsigned6                  suppressionid  
      ,dataset(Suppression_field) context  
      ,dataset(Suppression_field) suppressed_field_values  
      ,string                     wuid 
      ,string                     userid  
      ,string                     comment
      ,string                     operation                   //'FSE' field suppression + explosion, 'FS' = field suppression only  ,'E' Explosion only of cluster containing field values, 'RS' = record suppression
      ,dataset(Suppression_field) IDs_To_Explode              //field name is ID to explode, fieldvalue is the value to explode it to.  ''(blank means zero), 0 means zero, otherwise you can specify another field.  
      ,unsigned                   suppression_counter         //set to zero when record is added to suppression file.  increments each time this suppression is performed.  if = 1, then perform explosion.  otherwise don't

      // -- these are for the future.
      // ,real8                      maintain_persistence_pct    // make sure to maintain this level of persistence.  do not explode too many/too large clusters that will cause persistence to drop below this number
      // ,unsigned2                  explosion_phase_counter     // phase number we are on for explosions--how do I know which clusters have already been exploded from the last build so i don't explode them again?
      // ,unsigned2                  total_explosion_phases      // total phases for this explosion.

      // ,string                     date_suppressed
      // ,string                     date_exploded     
      // ,unsigned2                  count_explosion_phases
      // ,unsigned2                  last_explosion_phase
    };

end;

/*
  1. straight suppression of fields 'FS'
  2. suppression of fields + explosion of the clusters containing them.  probably the default 'FSE'
  3. just cluster explosion without suppression? -- maybe 'E'
  4. suppression of complete records?  maybe operation = 'RS' .  could specify rcids, or any other criteria??
  5. how to specify the cluster fields to explode?  and how to explode them?  do we just zero them out, or set them to a lower id, or set them to rcid???
     and should it be specific to each suppression record, or can you specify it at the suppression macro level to apply to all suppression records?
     a. ability to specify clusters to explode within the suppression input dataset
        1. child dataset of cluster id fields to explode.  will have optional extra field that can contain the field name that it will be set to.
        2. can also have an optional parameter to specify this when calling the suppression macro.  this might mean that a single suppression file could be used for multiple ID explosions 
           just by calling the macro with a diff id passed in.
        3. 
          
  6. how can we do explosion in phases?  maybe would have to only put specific values in each build.....maybe optional phased_explosion_
      a.  optional phased_explosion_pct = percent of total clusters that contain suppressions to explode each build
      b. OR number of builds to split the cluster explosions over
  7. 


  So, some thoughts on design:
  1. macro to perform field level suppressions only.  it will flag which records/clusters have had suppressions supplied
  2. macro to perform cluster explosions only.    it will flag which clusters have been exploded
  3. macro to perform record level suppression only.  
*/