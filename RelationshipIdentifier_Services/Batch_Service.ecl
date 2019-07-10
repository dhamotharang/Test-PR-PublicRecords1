/*--SOAP--
<message name="BatchService">
	<part name="batch_in"                     type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="Include_Neighbors" 	          type="xsd:boolean"/>
  <part name="Include_HistoricalNeighbors"  type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service goes through each and every entity entered up to max of 8 per acctno and ultimately return relationships between 2 entities.*/

// 1. Get input recs
// 2. Project to proper layout  = RelationshipIdentifier_Services.Layouts.Input_Processed
// 3. Make RelationshipIdentifier_Services.Search_Records module call and get exported attr
// 4. Then call the report recs which goes through each and every entity entered (up to max of 8) per acctno
//     and ultimately calls the function to return relationships between 2 entities.

IMPORT autostandardi,BatchShare,doxie,RelationshipIdentifier_Services;
EXPORT Batch_Service() :=
MACRO
		
	ds_batchInReq := DATASET([],RelationshipIdentifier_Services.Layouts.Batch.OrigInput) : STORED('Batch_In');
		
	#STORED('Include_Neighbors',TRUE); // only get current neighbors.
	#STORED('Include_HistoricalNeighbors',TRUE); // only get current neighbors.
	//#stored('MaxNeighborhoods',4); // default for this in comp report is 4
	
  //check if mininum/valid search filters was provided for second entity
	ds_batchInTmp := PROJECT(ds_batchInReq, 
                   TRANSFORM(RelationshipIdentifier_Services.Layouts.Batch.tmp_BatchLayout,
											          isValidInput := (LEFT.did_2!= 0 AND LEFT.IndividualOrBusiness_2 = RelationshipIdentifier_Services.Constants.INDIVIDUAL) 
															   OR (LEFT.ssn_2!='' AND LEFT.IndividualOrBusiness_2 = RelationshipIdentifier_Services.Constants.INDIVIDUAL) 
																 OR (LEFT.name_first_2!='' AND LEFT.name_last_2!='' AND LEFT.prim_range_2!='' AND LEFT.prim_name_2!='' AND ((LEFT.city_name_2!='' AND LEFT.st_2!='') OR LEFT.z5_2!='') AND LEFT.IndividualOrBusiness_2 = RelationshipIdentifier_Services.Constants.INDIVIDUAL)
																 OR (LEFT.tin_2!='' AND LEFT.IndividualOrBusiness_2 = RelationshipIdentifier_Services.Constants.BUSINESS)
																 OR (LEFT.InSELEID_2!=0 AND LEFT.IndividualOrBusiness_2 = RelationshipIdentifier_Services.Constants.BUSINESS)
																 OR (LEFT.comp_name_2!='' AND LEFT.prim_range_2!='' AND LEFT.prim_name_2!='' AND (LEFT.city_name_2!='' AND LEFT.st_2!='') AND LEFT.IndividualOrBusiness_2 = RelationshipIdentifier_Services.Constants.BUSINESS)
																 ;
															 SELF.isValidInput := isValidInput;
											         SELF := LEFT;
											         SELF := []));
	
	good_batchRecs := ds_batchInTmp(isValidInput);
  bad_batchRecs  := ds_batchInTmp(NOT isValidInput);
															
  good_batchRecs_formatted := PROJECT(good_batchRecs, 
																			TRANSFORM(RelationshipIdentifier_Services.Layouts.Batch.OrigInput,
																			SELF := LEFT;
																			SELF := [] ));
			
		// Standardize input
	ds_batchIn := RelationshipIdentifier_Services.Functions.setbatchInput(good_batchRecs_formatted);
	
	BatchShare.MAC_ProcessInput(ds_batchIn,ds_batchInProcessed);
																																					
	batchParams := RelationshipIdentifier_Services.iParam.getBatchParams();	
					
	empty_ds := DATASET([], RelationshipIdentifier_Services.Layouts.Local_tRelationshipIdentifierSearch);
																						
	empty_ds_options := DATASET([],RelationshipIdentifier_Services.Layouts.OptionsLayout)[1];
		
	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
	
  ds_batchSearchResults := RelationshipIdentifier_Services.Search_Records( empty_ds,
                                                                           mod_access,  
																																					 empty_ds_options,		
																																					 ds_batchInProcessed,
																																					 batchParams).ds_results_batch;
				
	ds_RelIndentifierReportResults := RelationshipIdentifier_Services.BatchReport_Records(ds_batchSearchResults,batchParams);
				
	BatchShare.MAC_RestoreAcctno(ds_batchInProcessed,ds_RelIndentifierReportResults,Tmpresults);		
	// "batch_results" attr below: filter out empty rows
	// this is done because inputs are 1 up to 8 entities per acctno and the output results only show
	// the 1-2, 1-3, 1-4, 1-5,1-6, 1-7, 1-8, 2-3, 2-4...7-8 relationships
	// thus the 8-1 relationshiops and so on are already showing in the 1-8 
	//  thus the 8th entity is still there and this filter
	// removes the empty row after macro added back in that row from the original input join
	// in MAC_RestoreAcctno
	batch_results := tmpResults(primaryEntity <> 0);
	
	batchRecs_MissingSecEntity := PROJECT(bad_batchRecs, 
																				TRANSFORM({RECORDOF(batch_results);},
																				SELF.Role := LEFT.Role_1;
																				SELF.PriSsn := LEFT.Ssn_1;
																				SELF.PriDid := (STRING15)LEFT.Did_1;
																				SELF.PriLastName := LEFT.Name_Last_1;
																				SELF.PriFirstName := LEFT.Name_First_1;
																				SELF.PriMiddleName := LEFT.Name_Middle_1;
																				SELF.Pri_Seleid := LEFT.InSeleId_1;
																				SELF.PriTin := LEFT.Tin_1;
																				SELF.PriCompanyName := LEFT.Comp_Name_1;
																				SELF.Prim_Range := LEFT.Prim_Range_1;
																				SELF.PreDir := LEFT.PreDir_1;
																				SELF.Prim_Name := LEFT.Prim_Name_1;
																				SELF.Addr_Suffix := LEFT.Addr_Suffix_1;
																				SELF.PostDir := LEFT.PostDir_1;
																				SELF.Unit_Desig := LEFT.Unit_Desig_1;
																				SELF.Sec_Range := LEFT.Sec_Range_1;
																				SELF.City := LEFT.City_Name_1;
																				SELF.State := LEFT.St_1;
																				SELF.Zip := LEFT.Z5_1;
																				SELF.PriPhone := IF(LEFT.IndividualOrBusiness_1=RelationshipIdentifier_Services.Constants.INDIVIDUAL,LEFT.homephone_1,
																															 IF(LEFT.IndividualOrBusiness_1=RelationshipIdentifier_Services.Constants.BUSINESS,LEFT.workphone_1,
																															 ''));
																				SELF.PriDob := LEFT.DOB_1;
																				
																				SELF.SecRole := LEFT.Role_2;
																				SELF.SecSsn := LEFT.Ssn_2;
																				SELF.SecDid := (STRING15)LEFT.Did_2;
																				SELF.SecLastName := LEFT.Name_Last_2;
																				SELF.SecFirstName := LEFT.Name_First_2;
																				SELF.SecMiddleName := LEFT.Name_Middle_2;
																				SELF.SecSeleid := LEFT.InSeleId_2;
																				SELF.SecTin := LEFT.Tin_2;
																				SELF.SecCompanyName := LEFT.Comp_Name_2;
																				SELF.SecPrim_Range := LEFT.Prim_Range_2;
																				SELF.SecPreDir := LEFT.PreDir_2;
																				SELF.SecPrim_Name := LEFT.Prim_Name_2;
																				SELF.SecAddr_Suffix := LEFT.Addr_Suffix_2;
																				SELF.SecPostDir := LEFT.PostDir_2;
																				SELF.SecUnit_Desig := LEFT.Unit_Desig_2;
																				SELF.SecSec_Range := LEFT.Sec_Range_2;
																				SELF.SecCity := LEFT.City_Name_2;
																				SELF.SecState := LEFT.St_2;
																				SELF.SecZip := LEFT.Z5_2;
																				SELF.SecPhone := IF(LEFT.IndividualOrBusiness_2=RelationshipIdentifier_Services.Constants.INDIVIDUAL,LEFT.homephone_2,
																															 IF(LEFT.IndividualOrBusiness_2=RelationshipIdentifier_Services.Constants.BUSINESS,LEFT.workphone_2,
																															 ''));
																				SELF.SecDob := LEFT.DOB_2;
																				SELF.Error_Code := RelationshipIdentifier_Services.Constants.SECOND_ENTITY_MISSING;
															          SELF := LEFT;
																				SELF := [] ));
		
    results := SORT(batch_results + batchRecs_MissingSecEntity, record);	
  	
  // =============================   DEBUG  =============================		
	// output(ds_batchInReq, named('ds_batchInReq'));
	// output(ds_batchInTmp, named('ds_batchInTmp'));
	// output(good_batchRecs, named('good_batchRecs'));
	// output(bad_batchRecs, named('bad_batchRecs'));
	// output(good_batchRecs_formatted, named('good_batchRecs_formatted'));
	// output(ds_batchIn, named('ds_batchIn'));
	// output(ds_batchInProcessed, named('ds_batchInProcessed'));
	// output(empty_ds, named('empty_ds'));
	// output(empty_ds_options, named('empty_ds_options'));
	// output(ds_batchSearchResults, named('ds_batchSearchResults'));
	// output(ds_RelIndentifierReportResults, named('ds_RelIndentifierReportResults'));
	// =============================  END DEBUG =============================	
		 
	output(results, named('Results'));

ENDMACRO;	

/*
Below is input layout : Note there is 1 acctno field input for 2 entity's
but the RelationshipIdentifier_Services.Functions.setbatchInput call
makes it into...1 acctno field per each entity for processing
 
	    STRING30  acctno;
      STRING50  Role_1;                           
      STRING1   IndividualOrBusiness_1; 
      UNSIGNED6 did_1;
      STRING8   DOB_1;
      string20  name_first_1;
      string20  name_middle_1;
      string20  name_last_1;
      string5   name_suffix_1;
      string9   ssn_1;
      string10  homephone_1;
      STRING120 comp_name_1;
      STRING9   tin_1;                                
      UNSIGNED6 InSELEID_1;
      STRING10  prim_range_1;
      STRING2   predir_1;
      STRING28  prim_name_1;
      STRING4   addr_suffix_1;
      STRING2   postdir_1;
      STRING10  unit_desig_1;
      STRING8   sec_range_1;
      STRING25  city_name_1;
      STRING2   st_1;
      STRING5   z5_1;
      STRING4   zip4_1;                             
      STRING10  workphone_1;
      STRING50  Role_2;
      STRING1   IndividualOrBusiness_2;           
      UNSIGNED6 did_2;
      STRING8   DOB_2;
      string20  name_first_2;
      string20  name_middle_2;
      string20  name_last_2;
      string5   name_suffix_2;
      string9   ssn_2;
      string10  homephone_2;
      STRING120 comp_name_2;
      STRING9   tin_2;                                
      UNSIGNED6 InSELEID_2;
      STRING10  prim_range_2;
      STRING2   predir_2;
      STRING28  prim_name_2;
      STRING4   addr_suffix_2;
      STRING2   postdir_2;
      STRING10  unit_desig_2;
      STRING8   sec_range_2;
      STRING25  city_name_2;
      STRING2   st_2;
      STRING5   z5_2;
      STRING4   zip4_2;                             
      STRING10  workphone_2
*/

