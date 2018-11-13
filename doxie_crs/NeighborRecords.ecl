Import autostandardI, ut, doxie, doxie_crs;
  // updated Feb 2017.
	// *****************************************************************************
	// *** PLS NOTE DO NOT USE THIS FUNCTION to find neighbors for Relationship    *
	// Identifier service if count of the                                          *
	// input ds of input dids is more than 2                                       *
	// *****************************************************************************
	// This function attribute is very similar to doxie_crs.nbr_records
	// except that it allows as input a Dataset of did's (ONLY 2 at max) to be passed
	// as input param to find particular neighbors for
	//
	// Input: dids DS which is layout of doxie.layout_references
	// Output: same output layout as the doxie.nbr_records
	// 
	// this version doesn't call either of these legacy macros
	// doxie.MAC_Selection_Declare(), doxie.MAC_Header_Field_Declare();
	// but gets values from stored
	//
	// attribute designed to be called by another attribute and return neighbor information
	// based on did(s) DS that is passed in as a param.
	
	// One can test this code by running this type of setup
	//
	//		dids := dataset([{123456789},{987654321}], doxie.layout_references);
	// ///////////////////////////////////////////////
	// and setting these values which are used below.
	// more documentation is found in this attr:  doxie_crs.nbr_records
	///////////////////////////////////////////////////
  // #stored('Include_Neighbors',TRUE); // only get current neighbors.
	// #stored('Include_HistoricalNeighbors',TRUE); // only get current neighbors.
	// #stored('Max_Neighborhoods',4); // default for this in comp report is 4
	// for this purpose set to size of incoming dataset.
	// #stored('GLBPurpose',defaultvalue of roxie service);
	// #stored('DPPAPurpose',defaultvalue of roxie service);	
	// #stored('DataRestrictionMask','00000000000000000000'); //// all 0's.
	// results := doxie_crs.NeighBorRecords(dids);
	// output(results);
	
	export NeighborRecords(dataset(doxie.layout_references) dids, 
	                       unsigned1 InModDPPAPurpose,
												 unsigned1 InmodGLBPurpose,
												 string InModDRM,
												 string6 SSN_Mask,												 
												 isFCRA=false) := FUNCTION
	
		boolean include_gong := true; //true,			
    //unsigned2 address_limit := 300; // 1000) :=
		unsigned2 addresses_PerSubject := 300;			
		unsigned3 MAX_Neighborhoods := 10; // count(dids);
		///////////////////////
		// params for 		
					
    unsigned1 Neighbors_PerAddress := 20 : stored('NeighborsPerAddress');
		unsigned1 Neighbors_Per_NA := 6 : stored('NeighborsPerNA');
		unsigned1 Neighbor_Recency := 3 : stored('NeighborRecency');								

    gmod := AutoStandardI.GlobalModule (isFCRA);
    mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (gmod))
      EXPORT unsigned1 glb := inmodGLBPurpose;
      EXPORT unsigned1 dppa := inmodDPPAPurpose;
      EXPORT string DataRestrictionMask := InmodDRM;
      EXPORT string ssn_mask := ^.SSN_Mask; 
    END;
    glb_ok := mod_access.isValidGLB ();
    dppa_ok := mod_access.isValidDPPA ();

    unsigned1 dial_contactprecision_value := AutoStandardI.InterfaceTranslator.dial_contactprecision_value.val(project(gmod,
		              AutoStandardI.InterfaceTranslator.dial_contactprecision_value.params)); 
 								 
		boolean Include_Neighbors := false : stored('Include_Neighbors');
		boolean Include_Neighbors_val := include_neighbors;
		
		boolean Include_HistoricalNeighbors := false : stored('Include_HistoricalNeighbors');		
		boolean Include_HistoricalNeighbors_val := Include_HistoricalNeighbors;
		// generally, the radius of neighbors' units: houses, or appartments or etc.
		unsigned1 neighbors_proximity := 15 : stored('NeighborsProximityRadius');
		////////////////		

		// step #1  -> do equivalent to doxie_crs.nbr_records;
		// and use results to then call equivalent of this : doxie_crs.nbr_records
	  csa := doxie.Comp_Subject_Addresses(dids,, dial_contactprecision_value, Addresses_PerSubject, mod_access);
    // 
	  headerRecs := csa.addresses;
	  // convert to target record type
	  rawTargetRecs := project(headerRecs, doxie.layout_nbr_targets);
	   //OUTPUT(rawTargetRecs, named('rawTargetRecs')); // DEBUG

	  // quick reduction if we really don't want to be here
	  filtHR := rawTargetRecs(Neighbors_PerAddress>0);

	  // reduce header recs down to targets
	  targetRecs := doxie.nbr_records_targets(filtHR, Max_Neighborhoods);
	  //OUTPUT(targetRecs, named('targetRecs')); // DEBUG

	  // then find the corresponding neighbor records
	  nbr_records_mode(string1 mode) := doxie.nbr_records(
		  targetRecs,
		  mode,
	  // attrs declared in doxie.MAC_Selection_Declare
		  Max_Neighborhoods,
		  Neighbors_PerAddress,
		  Neighbors_Per_NA,
		  Neighbor_Recency,
		  mod_access.industry_class,
		  mod_access.glb,
		  mod_access.dppa,
		  mod_access.probation_override,
		  mod_access.no_scrub,
		  glb_ok,
		  dppa_ok,
	  // attrs declared in doxie.MAC_Header_Field_Declare
		  mod_access.ssn_mask,,,
		  neighbors_proximity // generally, the radius of neighbors' units: houses, or appartments or etc.
    );

// generate current/historic neighbors as specified
noResults := DATASET([], doxie.layout_nbr_records);
nbr_records_curr := IF(
	Include_Neighbors_val,
	nbr_records_mode('C'),
	noResults
);
nbr_records_hist := IF(
	Include_HistoricalNeighbors_val, 
	nbr_records_mode('H'),
	noResults
);

both := nbr_records_curr + nbr_records_hist;
ut.PermissionTools.GLB.mac_FilterOutMinors(both,bothfil,,,dob)
ds_neighborsMultDidInput := bothfil;
//output(	Max_Neighborhoods, named('Max_Neighborhoods'));
return(ds_neighborsMultDidInput);
END;																						 	
