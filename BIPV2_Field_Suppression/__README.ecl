/*
    // -- Relevant Functions and their uses
    BIPV2_Field_Suppression._BWR_Add_Candidates                   -- Add candidates to custom Suppression/Explosion file.  Will work for all clusters/fields.
    BIPV2_Field_Suppression._BWR_Remove_Candidates                -- Remove Candidates from custome suppression/explosion file.
    BIPV2_Field_Suppression._BWR_Initialize_Suppression_Counter   -- initialize suppression counter for suppression file to zero.  This will make the next suppression call using this file explode the clusters too.
    BIPV2_Field_Suppression._BWR_Increment_Suppression_Counter    -- increment the suppression counter in the suppression file + 1.  This will make the next suppression call not explode the clusters.
    BIPV2_Field_Suppression._BWR_Decrement_Suppression_Counter    -- decrement the suppression counter in the suppression file - 1.  This will basically return the suppression back to before the last call of it.  
                                                                      Good for rollbacks where you need to rerun the code that calls the suppression.
    BIPV2_Field_Suppression.mac_Suppress                          -- Suppression macro call.  Will need to modify this to add fields/context/id fields if we add new fields to the suppression file.
                                                                     Future improvement is to generate the code from the suppression file to call this macro.
  // -- Typical Usage in a build
  1. Call the LinkingTools.mac_Suppression_File_Management macro.  this will generate the code for maintaining the suppression file based on your filemask.  Example: 
        BIPV2_Field_Suppression._Config

  2. add suppression candidates to the file using 
        BIPV2_Field_Suppression._BWR_Add_Candidates

  3. Call the suppression macro in your build(BIPV2_ProxID._Preprocess).
        BIPV2_Field_Suppression.mac_Suppress
           Make sure to include all fields including suppression, context, ID, and rid fields in your regex for the pSuppressionFieldFilter parameter that are in the suppression file.
           Make sure to include all context fields used in the suppression file in the pContextFieldFilter regex.
           Make sure to include all ID fields that exist in the IDs_To_Explode child dataset(fieldname and fieldvalue) in your suppression file in the pSetIDsFieldFilter regex.  Also include the rid field.
            sort them by ascending hierarchy.  So, for example, in BIP we want to explode lgid and proxid clusters.  our rid is rcid.  we explode the proxid to the dotid, and the lgid3 to the proxid.
            So, our pSetIDsFieldFilter = ['rcid','dotid','proxid','lgid3'].  our rid, rcid is the lowest id, then comes dotid, then proxid, and then lgid3 is the top.
           Also pass in the rid field into the pRidField parameter.

  4. immediately after calling the suppression macro, increment the suppression counter in that suppression file.(also in BIPV2_ProxID._Preprocess).  This will make sure that the explosions for particular suppressions will only happen once.
        BIPV2_Field_Suppression.Increment_Suppression_Counter()
  
        

*/