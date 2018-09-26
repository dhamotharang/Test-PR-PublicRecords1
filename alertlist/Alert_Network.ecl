IMPORT Business_Header;

EXPORT Alert_Network := MODULE

/*
////////////////////////// READ ME
////////// 1) Input Dataset logical file name
////////// 2-3) It is possible to pass a threshold for the bdid and did score. Currently this is set to 0.
////////// 4) This is to activate items 2-3
////////// 5) If this is a test run, only do fun_calculate_overlap and set to true. This way you can set the amount of records using #OPTION('TestSampleSize',[]) and re-use the same file with different output logical file names
*/

EXPORT fun_calculate_overlap(//DATASET(alertlist.files.Layout_Batch_Input) pInput = alertlist.files.batch_input, 
														 STRING InFileName = alertlist.constants.prefix + 'in::alertlist::batch_input',
														 UNSIGNED pMindidscore = 70, 
														 UNSIGNED pMinbdidscore = 70, 
														 BOOLEAN ActivateThreshold = false, 
														 BOOLEAN Test = false, STRING FileIdIn) := FUNCTION
														 
        FileID := MAP(LENGTH(TRIM(FileIdIn))>0=>FileIdIn, MAP(~test => InFileName[stringlib.stringfind(InFileName, '::', 3)+2..], WORKUNIT)); //Name output file for despray to batch for customer
				
				pInput := CHOOSEN(DATASET('~'+InFileName,AlertList.Files.Layout_Batch_Input, csv(QUOTE('\''))), IF(TEST, AlertList.Constants.TestSampleSize, CHOOSEN:ALL));


				trimDIDs := TABLE(pInput(DID > 0), 
																					{STRING 		id 				:= Entity_Id, 
																					 STRING10 	lid_type 	:= 'DID',  
																					 UNSIGNED8 	lid 			:= DID,  
																					 UNSIGNED8 	lidscore 	:= DID_Score,  
																					 UNSIGNED8 	minlidscore := pMindidscore,  
																					 original_company_name,
																					 original_company_zip,   
																					 original_fname, 
																					 original_mname, 
																					 original_lname; 
																					 original_name_suffix, 
																					 BOOLEAN 		isActive 	:= Flag1_Active,  
																					 BOOLEAN 		isAlert 	:= Flag2_Alert,
																					 BOOLEAN		did_active_alert := FALSE, 
																					 BOOLEAN		bdid_active_alert := FALSE,
																					 BOOLEAN 		isFlag3 	:= Flag3,
																					 BOOLEAN 		isFlag4 	:= Flag4,
																					 BOOLEAN 		isFlag5 	:= Flag5,
																					 UNSIGNED8	iDID := DID,
																					 UNSIGNED8	iBDID := BDID,
																					 customer_id, product_id});

																					 
				trimBDIDs := TABLE(pInput(BDID > 0), 
																					{STRING 		id 				:= Entity_Id, 
																					 STRING10 		lid_type 	:= 'BDID',  
																					 UNSIGNED8 	lid 			:= BDID,  
																					 UNSIGNED8 	lidscore 	:= BDID_Score,  
																					 UNSIGNED8 	minlidscore := pMinbdidscore,  
																					 original_company_name, 
																					 original_company_zip,   
																					 original_fname, 
																					 original_mname, 
																					 original_lname; 
																					 original_name_suffix, 
																					 BOOLEAN 		isActive 	:= Flag1_Active,  
																					 BOOLEAN 		isAlert 	:= Flag2_Alert,
																					 BOOLEAN 		isFlag3 	:= Flag3,
																					 BOOLEAN 		isFlag4 	:= Flag4,
																					 BOOLEAN 		isFlag5 	:= Flag5,
																					 BOOLEAN		did_active_alert := FALSE, 
																					 BOOLEAN		bdid_active_alert := FALSE,
																					 UNSIGNED8	iDID := DID,
																					 UNSIGNED8	iBDID := BDID,
																					 customer_id, product_id});
																					 
				trimNULLs := TABLE(pInput(BDID + DID = 0), 
																					{STRING 		id 				:= Entity_Id, 
																					 STRING10 		lid_type 	:= 'NULL',  
																					 UNSIGNED8 	lid 			:= 0,  
																					 UNSIGNED8 	lidscore 	:= 0,  
																					 UNSIGNED8 	minlidscore := pMinbdidscore,  
																					 original_company_name, 
																					 original_company_zip,   
																					 original_fname, 
																					 original_mname, 
																					 original_lname; 
																					 original_name_suffix, 
																					 BOOLEAN 		isActive 	:= Flag1_Active,  
																					 BOOLEAN 		isAlert 	:= Flag2_Alert,
																					 BOOLEAN 		isFlag3 	:= Flag3,
																					 BOOLEAN 		isFlag4 	:= Flag4,
																					 BOOLEAN 		isFlag5 	:= Flag5,
																					 BOOLEAN		did_active_alert := FALSE, 
																					 BOOLEAN		bdid_active_alert := FALSE,
																					 UNSIGNED8	iDID := DID,
																					 UNSIGNED8	iBDID := BDID,
																					 customer_id, product_id});
																					 
				dstrInput := trimBDIDs + trimDIDs : INDEPENDENT; //Use to rejoin records at the end
//				dstrInput := trimDIDs : INDEPENDENT; //Use to rejoin records at the end

//				LGaccurint_business_contactsCnt := COUNT(filtThreshold(lid > 0 AND lid_type[..4] = 'BDID') /* + ddupDIDRelatedBDIDs */) : independent;
/*				
				LGaccurint_business_contacts := COUNT(LGaccurint_business_contactsCnt) > 5000000;
*/
        accurint_business_contactsSM := JOIN(trimBDIDs(lid > 0 AND lid_type[..4] = 'BDID'), AlertList.Key_Business_Contacts, // + ddupDIDRelatedBDIDs, 
																											LEFT.lid=RIGHT.bdid,
																											TRANSFORM(recordof(LEFT), SELF.idid := right.did, SELF := RIGHT, SELF := LEFT), KEYED, ATMOST(10000));

        accurint_business_contactsLG := JOIN(AlertList.File_Business_Contacts, trimBDIDs(lid > 0 AND lid_type[..4] = 'BDID'),// + ddupDIDRelatedBDIDs, 
																											LEFT.bdid=RIGHT.lid,
																											TRANSFORM(recordof(right), SELF.idid := left.did, SELF := LEFT, SELF := RIGHT), MANY LOOKUP);
/*
							accurint_business_contactsLG := JOIN(AlertList.File_Business_Contacts, filtThreshold(lid > 0 AND lid_type[..4] = 'BDID'),// + ddupDIDRelatedBDIDs, 
																											LEFT.bdid=RIGHT.lid,
																											TRANSFORM(alertlist.files.Layout_Accurint_Business_Contacts, SELF := LEFT, SELF := RIGHT), LOCAL);
*/

        // This is the combination of original people and contacts of original companies.
				
        AlertDids := trimDIDs + accurint_business_contactsSM(idid > 0);

				joinCombBusinessContactDIDsSM := DEDUP(SORT(JOIN(AlertDids, AlertList.Key_Person_Cluster, 
																			LEFT.idid=RIGHT.cluster_id, 
																			TRANSFORM({RECORDOF(dstrInput), RECORDOF(AlertList.File_Person_Cluster)}, 
																									self.cluster_id := right.associated_did, self.associated_did := right.cluster_id,
																									SELF := RIGHT, SELF := LEFT), KEYED, SKEW(1), ATMOST(10000)), cluster_id, lid_type, lid, -degree), cluster_id, lid_type, lid)
																		 : PERSIST('~thordev_socialthor_50::out::social_person_cluster_detail::'+FileID);
        /*
				joinCombBusinessContactDIDsSM := DEDUP(SORT(JOIN(AlertList.File_Person_Cluster, AlertDids, 
																			LEFT.associated_did=RIGHT.idid, 
																			TRANSFORM({RECORDOF(dstrInput), RECORDOF(AlertList.File_Person_Cluster)}, 
																									SELF := LEFT, SELF := RIGHT), LOOKUP, SKEW(1)), cluster_id, lid_type, lid, -degree), cluster_id, lid_type, lid)
																			: PERSIST('~thordev_socialthor_50::out::deleteme::'+FileID);
				*/																				
				social_accurint_did_stats 	:= TABLE(joinCombBusinessContactDIDsSM(idid > 0),
                                       {cluster_id, /*totalcnt, firstdegrees, seconddegrees, cohesivity, 	*/
																			  active_company_count := COUNT(GROUP, lid_type = 'BDID' and isActive), active_company_0 := COUNT(GROUP, lid_type = 'BDID' and isActive AND degree = 0), active_company_1 := COUNT(GROUP, lid_type = 'BDID' and isActive AND degree <= 1), active_company_2 := COUNT(GROUP, lid_type = 'BDID' and isActive AND degree > 1 AND degree <= 2),
                                        alert_company_count  := COUNT(GROUP, lid_type = 'BDID' and isAlert),  alert_company_0  := COUNT(GROUP, lid_type = 'BDID' and isAlert AND degree = 0),  alert_company_1  := COUNT(GROUP, lid_type = 'BDID' and isAlert AND degree <= 1),  alert_company_2  := COUNT(GROUP, lid_type = 'BDID' and isAlert AND degree > 1 AND degree <= 2),
                                        flag3_company_count  := COUNT(GROUP, lid_type = 'BDID' and isFlag3),  flag3_company_0  := COUNT(GROUP, lid_type = 'BDID' and isFlag3 AND degree = 0),  flag3_company_1  := COUNT(GROUP, lid_type = 'BDID' and isFlag3 AND degree <= 1),  flag3_company_2  := COUNT(GROUP, lid_type = 'BDID' and isFlag3 AND degree > 1 AND degree <= 2),
                                        flag4_company_count  := COUNT(GROUP, lid_type = 'BDID' and isFlag4),  flag4_company_0  := COUNT(GROUP, lid_type = 'BDID' and isFlag4 AND degree = 0),  flag4_company_1  := COUNT(GROUP, lid_type = 'BDID' and isFlag4 AND degree <= 1),  flag4_company_2  := COUNT(GROUP, lid_type = 'BDID' and isFlag4 AND degree > 1 AND degree <= 2),
                                        flag5_company_count  := COUNT(GROUP, lid_type = 'BDID' and isFlag5),  flag5_company_0  := COUNT(GROUP, lid_type = 'BDID' and isFlag5 AND degree = 0),  flag5_company_1  := COUNT(GROUP, lid_type = 'BDID' and isFlag5 AND degree <= 1),  flag5_company_2  := COUNT(GROUP, lid_type = 'BDID' and isFlag5 AND degree > 1 AND degree <= 2),
																			  active_person_count := COUNT(GROUP, lid_type = 'DID' and isActive), active_person_0 := COUNT(GROUP, lid_type = 'DID' and isActive AND degree = 0), active_person_1 := COUNT(GROUP, lid_type = 'DID' and isActive AND degree <= 1), active_person_2 := COUNT(GROUP, lid_type = 'DID' and isActive AND degree > 1 AND degree <= 2),
                                        alert_person_count  := COUNT(GROUP, lid_type = 'DID' and isAlert),  alert_person_0  := COUNT(GROUP, lid_type = 'DID' and isAlert AND degree = 0),  alert_person_1  := COUNT(GROUP, lid_type = 'DID' and isAlert AND degree <= 1),  alert_person_2  := COUNT(GROUP, lid_type = 'DID' and isAlert AND degree > 1 AND degree <= 2),
                                        flag3_person_count  := COUNT(GROUP, lid_type = 'DID' and isFlag3),  flag3_person_0  := COUNT(GROUP, lid_type = 'DID' and isFlag3 AND degree = 0),  flag3_person_1  := COUNT(GROUP, lid_type = 'DID' and isFlag3 AND degree <= 1),  flag3_person_2  := COUNT(GROUP, lid_type = 'DID' and isFlag3 AND degree > 1 AND degree <= 2),
                                        flag4_person_count  := COUNT(GROUP, lid_type = 'DID' and isFlag4),  flag4_person_0  := COUNT(GROUP, lid_type = 'DID' and isFlag4 AND degree = 0),  flag4_person_1  := COUNT(GROUP, lid_type = 'DID' and isFlag4 AND degree <= 1),  flag4_person_2  := COUNT(GROUP, lid_type = 'DID' and isFlag4 AND degree > 1 AND degree <= 2),
                                        flag5_person_count  := COUNT(GROUP, lid_type = 'DID' and isFlag5),  flag5_person_0  := COUNT(GROUP, lid_type = 'DID' and isFlag5 AND degree = 0),  flag5_person_1  := COUNT(GROUP, lid_type = 'DID' and isFlag5 AND degree <= 1),  flag5_person_2  := COUNT(GROUP, lid_type = 'DID' and isFlag5 AND degree > 1 AND degree <= 2)
                                       },  
                                       cluster_id)
																			: PERSIST('~thordev_socialthor_50::out::social_person_clusters::'+FileID);

// join back on cluster_id so we only keep the centroids that were given to us or are business contacts of companies given to us.
// i.e. every cluster_id is from the input or business contact from the input.

       all_input_social_accurint_did_stats := JOIN(AlertDids, social_accurint_did_stats, left.idid=right.cluster_id, 
																			TRANSFORM(alertlist.files.Layout_Accurint_Social_Stats, self := left, self := right, self := []), skew(1));

// dedup on lid_type and lid to get the most interesting results for the input.
// in the case of companies it selects the most interesting results for business contacts.
// which should factor in a score of some sort. 

// mini lid score. 
           
			 
       all_input_social_accurint_did_stats_score := 
			                    PROJECT(all_input_social_accurint_did_stats, 
			                      TRANSFORM(recordof(LEFT),
															self.score := (left.alert_company_1 * 0.8) + (left.alert_company_2 * 0.3) + (left.alert_person_1 * 0.8) + (left.alert_person_2 * 0.3), self := LEFT)); 
			 
       input_social_accurint_did_stats := JOIN(dstrInput, sort(all_input_social_accurint_did_stats_score, -score, skew(1)), left.lid_type = right.lid_type and left.lid=right.lid, 
																			TRANSFORM(alertlist.files.Layout_Accurint_Social_Stats, self := left, self := right, self := []), keep(1), left outer);			          

// Join cohesivity and cluster stats 
  
       social_accurint_stats1  := join(input_social_accurint_did_stats, AlertList.File_Person_Cluster_Attributes, left.cluster_id=right.cluster_id, 
			                                transform(recordof(left), self := right, self := left), keep(1), hash)
																			: PERSIST('~thordev_socialthor_50::out::alert_person_clusters::'+FileID);
																			
			
       forSrt(STRING pfield) := FUNCTION
          field := TRIM(pfield, LEFT, RIGHT);
          spaces := '                              ';
          lng := LENGTH(field);
          new := spaces[1..30-lng]+field;
				RETURN IF(LENGTH(stringlib.stringfilterout(field, '0123456789')) > 0, field, new);
       END;
			 
// Sort output for batch..

       social_accurint_stats 			:= DEDUP(SORT(SORT(social_accurint_stats1, forSrt(id)), customer_id, lid, cluster_id), customer_id, lid, cluster_id);

// Score the bads 

				AlertBads := topn(dedup(sort(social_accurint_stats(cohesivity < 1.6 and totalcnt < 600), lid_type, lid, original_company_name), lid_type, lid, original_company_name), 200, -score);

				// Distribution of Scores Summary.
				h1 := dataset([{1, 'Alert Company', 'Total'}], {unsigned seq, string Label, string Total});

				AlertCompanyDist := table(sort(dedup(sort(AlertBads, lid_type, lid, original_company_name), lid_type, lid, original_company_name), alert_company_count, skew(1)), {unsigned seq := 2, string Label := (string)alert_company_count, string Total := (string)count(group)}, alert_company_count, few, skew(1.2));

				h2 := dataset([{3, 'Alert Company 1', 'Total'}], {unsigned seq, string Label, string Total});
				AlertCompany1Dist := table(sort(dedup(sort(AlertBads, lid_type, lid, original_company_name), lid_type, lid, original_company_name), alert_company_1, skew(1)), {unsigned seq := 4, string Label := (string)alert_company_1, string Total := (string)count(group)}, alert_company_1, few, skew(1.2));

				DistributionsOutput := sort(h1 + topn(AlertCompanyDist, 100, Label) + h2 + topn(AlertCompany1Dist, 100, Label), seq);

RETURN sequential(
													
												/*
												output(choosen(pInput, 100), named('Sample_Input_File')),
												output(topn(sanitycheck(lid_active_count > 0 AND lid_alert_count > 0), 200, -lid_count), named('Sanity_Check_NoMixMatchRecords'));
												
												if(~fileservices.fileexists('~thordev_socialthor_50::out::social_alert_business_contacts::'+FileID),
														sequential(
															output(accurint_business_contacts,,'~thordev_socialthor_50::out::social_alert_business_contacts::'+FileID, __compressed__, overwrite, named('Accurint_Business_Contacts'));
															fileservices.addsuperfile('~thordev_socialthor_50::out::social_alert_business_contacts', '~thordev_socialthor_50::out::social_alert_business_contacts::'+FileID)));
															
												if(~fileservices.fileexists('~thordev_socialthor_50::out::social_alert_clusters::'+FileID),
														sequential(
															output(social_accurint(degree = 0),,'~thordev_socialthor_50::out::social_alert_clusters::'+FileID, __compressed__, overwrite, named('Social_Accurint'));
															fileservices.addsuperfile('~thordev_socialthor_50::out::social_alert_clusters', '~thordev_socialthor_50::out::social_alert_clusters::'+FileID)));
												*/		
												if(~fileservices.fileexists('~thordev_socialthor_50::out::social_alert_results::'+FileID),
														sequential(
															output(social_accurint_stats,,'~thordev_socialthor_50::out::social_alert_results::'+FileID, __compressed__, overwrite, named('Accurint_Social_Stats'));
															output(AlertBads,,'~thordev_socialthor_50::out::social_alert_bads::'+FileID, __compressed__, overwrite, named('Accurint_Alert_Bads'));
															output(DistributionsOutput,,'~thordev_socialthor_50::out::social_alert_distributions::'+FileID, __compressed__, overwrite, named('Accurint_Alert_Distributions'));
															output(joinCombBusinessContactDIDsSM,,'~thordev_socialthor_50::out::social_person_cluster_detail::'+FileID, __compressed__, overwrite, named('Accurint_Alert_Detail'));
															/*fileservices.addsuperfile('~thordev_socialthor_50::out::social_alert_results', '~thordev_socialthor_50::out::social_alert_results::'+FileID)*/))
												);
                        

END;

END;

/* TEST OUTPUTS */
												
												// output(choosen(filtThreshold, 100));
												// output(choosen(accurint_business_contacts, 100));
												// output(choosen(Social_Accurint, 100));
												// output(choosen(social_accurint_did_stats, 100));
												// output(choosen(social_accurint_bdid_stats, 100));
												// output(choosen(social_accurint(did > 0 AND bdid = 0 and cluster_id in [111022043, 4241112]), 100));
												// output(choosen(social_accurint_did_stats(cluster_id in [111022043, 4241112]), 100));
												// output(choosen(jnsocial_accurint_stats(cluster_id in [111022043, 4241112]), 100));
												// output(choosen(jnsocial_accurint_ids(cluster_id in [111022043, 4241112]), 100));
												// output(choosen(social_accurint_stats(cluster_id in [111022043, 4241112]), 100));
