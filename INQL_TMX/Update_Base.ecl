import ut;

EXPORT Update_Base 
(
    string filedate, 
    boolean pUseProd = false, 
    boolean pIsFull = false

):= FUNCTION

  //----------------------------------------------------------------------------------------------------------
  // Define a Macro to allow us to handle different resultant data types, one for a FULL build and one for 
  // a DAILY build. The results of which will be returned to the caller in the same return dataset.
  //----------------------------------------------------------------------------------------------------------
	EXPORT MAC_TMX_UpdateBase(pIsFull = false) := FUNCTIONMACRO

    //--------------------------------------------------------------------------------------------------------
    // IF - It is a FULL build. Append the last daily to our FULL key file.
    #if(pIsFull)

        // Take the current DAILY build (the accumulation of all DAILYs to this point), and append this
        // base keyfile to the existing FULL keyfile.

// KJE - IDEAS from review on how to filter out 'aged' records.  
// pre_01a := Files(filedate, pUseProd, pIsFull).base.qa(date>max_age());
        
        dist_base_and_update_pre_01 := INQL_TMX.Files().base.qa + INQL_TMX.Files(filedate, pUseProd, pIsFull).base.qa;
        
    //--------------------------------------------------------------------------------------------------------
    // ELSE - It is a DAILY build. Append the result of our DAILY INPUT to the current DAILY
    #else

        // Call Standardize to process the DAILY INPUT data that will be brought into our build process.
        stdInput := INQL_TMX.Standardize_Input(filedate, pUseProd, pIsFull).ThreatMetrix;

// KJE - IDEAS from review on how to filter out 'aged' records.  
//
// OPTION(1) Flag file on thor for last version released of the FULL build... 
//
// OPTION(2) then use the file date version inside the flag file OR query DOPS production to get the date 
//           (look into other attributes)
//
// IF it is a NEW daily after FULL 
// (a) filter out daily records in current DAILY build SINCE last FULL build.
// (b) Append "filtered" daily records onto NEW daily key file, ergo: 
//      pre_01a := Files(filedate, pUseProd, pIsFull).base.qa(date>min_age_from_FULL()); 

        dist_base_and_update_pre_01 := stdInput + Files(filedate, pUseProd, pIsFull).base.qa;

    #end

    dist_base_and_update := DISTRIBUTE(dist_base_and_update_pre_01, HASH(request_id));
    
    // KJE - FOR TESTING PURPOSE WITH the same small INPUT sample set, return the NON deduped dataset 
    // for now as the test data is a repeat of the same records and we want to make sure that the 
    // record appending process works for DAILIES.
    // ddpd_base_and_update := dedup(dist_base_and_update, record, all);

    RETURN dist_base_and_update;

  ENDMACRO;


  
  return_base := if(pIsFull, MAC_TMX_UpdateBase(true), MAC_TMX_UpdateBase(false));
 
  return return_base;
  
END;