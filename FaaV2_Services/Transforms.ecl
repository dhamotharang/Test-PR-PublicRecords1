  
	
	import doxie_crs, BIPV2, FFD;
	// doxie_crs.layout_Faa_Aircraft_records;
	
	export Transforms := MODULE

			export batch_view := MODULE
			
			   
				  shared format_AC_cert(String ac) := FUNCTION
					   cert := TRIM(ac)[1];
						 RETURN MAP((cert='1')=>'STANDARD'
						           ,(cert='2')=>'LIMITED'
						           ,(cert='3')=>'RESTRICTED'
						           ,(cert='4')=>'EXPERIMENTAL'
						           ,(cert='5')=>'PROVISIONAL'
	                     ,'');
    				END;

				  shared format_AC_weight(String class, string desc) := FUNCTION
					   RETURN TRIM(class)+IF(TRIM(desc)<>'',' ('+TRIM(desc)+' lbs)','');
					END;
					
					shared format_AC_status(string flag) := FUNCTION
					   status := TRIM(FLAG);
					   RETURN MAP((status='A')=>'ACTIVE'
						           ,(status='H')=>'HISTORICAL'
	                     ,'');
					ENd;
					
					shared format_AC_RegType(string rt) := FUNCTION
						 reg := TRIM(rt);
						 RETURN MAP((reg='1')=>'Individual'
						           ,(reg='2')=>'Partnership'
						           ,(reg='3')=>'Corporation'
						           ,(reg='4')=>'Co-Owned'
						           ,(reg='5')=>'Government'
						           ,(reg='6')=>'Non Citizen Corporation'
						           ,(reg='7')=>'Non Citizen Co-Owned'
	                     ,'');
					END;
					
					shared format_AC_region(string rg) := FUNCTION
						region := TRIM(rg);
					  RETURN MAP((region='1')=>'EASTERN'
						           ,(region='2')=>'SOUTHWESTERN'
						           ,(region='3')=>'CENTRAL'
						           ,(region='4')=>'WESTERN PACIFIC'
						           ,(region='5')=>'ALASKA'
						           ,(region='7')=>'SOUTHERN'
						           ,(region='8')=>'EUROPEAN'
						           ,(region='C')=>'GREAT LAKES'
						           ,(region='S')=>'NORTHWEST MOUNTAIN'
						           ,(region='E')=>'NEW ENGLAND'
	                     ,'');
    				END;
					
					export out_layout(dataset(doxie_crs.layout_Faa_Aircraft_records) inp,
                            string1 BIPFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID) := FUNCTION
							
							t_rec := RECORD
								DATASET (FFD.Layouts.ConsumerStatementBatch) stmts;
							END;
							
							t_rec xFormStatement (doxie_crs.layout_Faa_Aircraft_records L, INTEGER C) := TRANSFORM
								section_id_val := 'aircraft_'+C;
								SELF.stmts := PROJECT (L.StatementIds, FFD.InitializeConsumerStatementBatch (LEFT, FFD.Constants.RecordType.RS,section_id_val, FFD.Constants.DataGroups.AIRCRAFT, C,'', (unsigned6)L.did_out))
										+ IF(l.isDisputed, ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, section_id_val, FFD.Constants.DataGroups.AIRCRAFT, C,'', (unsigned6)L.did_out)));
							END;
							
							FFD.Layouts.ConsumerStatementBatch normAircraftStaments(FFD.Layouts.ConsumerStatementBatch R) := TRANSFORM
								SELF := R
							END;
						
							FaaV2_Services.Layouts.batch_out_pre xfm_aircrafts(doxie_crs.layout_Faa_Aircraft_records L,DATASET(doxie_crs.layout_Faa_Aircraft_records) R ) := TRANSFORM
								aircrafts := CHOOSEN(R, 5);
								eng_info := CHOOSEN(PROJECT(R.engine_info,doxie_crs.layout_FAR_engine),5);
								ac_info := CHOOSEN(PROJECT(R.craft_info,doxie_crs.layout_FAR_aircraft),5);
                SELF.current_flag_1 := format_AC_status(R[1].current_flag) ;
								SELF.n_number_1  :=  R[1].n_number ;
								SELF.serial_number_1  :=  R[1].serial_number ;
								SELF.mfr_mdl_code_1  :=  R[1].mfr_mdl_code ;
								SELF.year_mfr_1  :=  R[1].year_mfr ;
								SELF.last_action_date_1  :=  R[1].last_action_date ;
								SELF.cert_issue_date_1  :=  R[1].cert_issue_date ;
								SELF.certification_1  :=  format_AC_cert(R[1].certification) ;
								SELF.mode_s_code_1  :=  R[1].mode_s_code ;	
                
								
								SELF.aircraft_mfr_model_code_1  := ac_info[1].aircraft_mfr_model_code ;
								SELF.aircraft_mfr_name_1  := ac_info[1].aircraft_mfr_name ;
								SELF.ac_model_name_1  := ac_info[1].model_name ;
								SELF.number_of_engines_1  := ac_info[1].number_of_engines ;
								SELF.number_of_seats_1  := ac_info[1].number_of_seats ;
								SELF.aircraft_weight_1  := format_AC_weight(ac_info[1].aircraft_weight , ac_info[1].aircraft_weight_mapped);
								SELF.aircraft_cruising_speed_1  := ac_info[1].aircraft_cruising_speed ;
								SELF.engine_type_mapped_1  := ac_info[1].engine_type_mapped ;
								SELF.aircraft_type_mapped_1  := ac_info[1].aircraft_type_mapped ;
								SELF.category_mapped_1  := ac_info[1].category_mapped ;
								SELF.amateur_certification_mapped_1  := ac_info[1].amateur_certification_mapped ;

								SELF.engine_mfr_model_code_1  := eng_info[1].engine_mfr_model_code ;
								SELF.engine_mfr_name_1  := eng_info[1].engine_mfr_name ;
								SELF.eng_model_name_1  := eng_info[1].model_name ;
								SELF.engine_hp_or_thrust_1  := eng_info[1].engine_hp_or_thrust ;
								SELF.fuel_consumed_1  := eng_info[1].fuel_consumed ;
								
								SELF.current_flag_2 := format_AC_status(R[2].current_flag) ;
								SELF.n_number_2  :=  R[2].n_number ;
								SELF.serial_number_2  :=  R[2].serial_number ;
								SELF.mfr_mdl_code_2  :=  R[2].mfr_mdl_code ;
								SELF.year_mfr_2  :=  R[2].year_mfr ;
								SELF.last_action_date_2  :=  R[2].last_action_date ;
								SELF.cert_issue_date_2  :=  R[2].cert_issue_date ;
								SELF.certification_2  :=  format_AC_cert(R[2].certification) ;
								SELF.mode_s_code_2  :=  R[2].mode_s_code ;									
								
								SELF.aircraft_mfr_model_code_2  := ac_info[2].aircraft_mfr_model_code ;
								SELF.aircraft_mfr_name_2  := ac_info[2].aircraft_mfr_name ;
								SELF.ac_model_name_2  := ac_info[2].model_name ;
								SELF.number_of_engines_2  := ac_info[2].number_of_engines ;
								SELF.number_of_seats_2  := ac_info[2].number_of_seats ;
								SELF.aircraft_weight_2  := format_AC_weight(ac_info[2].aircraft_weight , ac_info[2].aircraft_weight_mapped);
								SELF.aircraft_cruising_speed_2  := ac_info[2].aircraft_cruising_speed ;
								SELF.engine_type_mapped_2  := ac_info[2].engine_type_mapped ;
								SELF.aircraft_type_mapped_2  := ac_info[2].aircraft_type_mapped ;
								SELF.category_mapped_2  := ac_info[2].category_mapped ;
								SELF.amateur_certification_mapped_2  := ac_info[2].amateur_certification_mapped ;
								// SELF.aircraft_weight_mapped_2  := ac_info[2].aircraft_weight_mapped ;

								SELF.engine_mfr_model_code_2  := eng_info[2].engine_mfr_model_code ;
								SELF.engine_mfr_name_2  := eng_info[2].engine_mfr_name ;
								SELF.eng_model_name_2  := eng_info[2].model_name ;
								SELF.engine_hp_or_thrust_2  := eng_info[2].engine_hp_or_thrust ;
								SELF.fuel_consumed_2  := eng_info[2].fuel_consumed ;
								
								SELF.current_flag_3 := format_AC_status(R[3].current_flag) ;
								SELF.n_number_3  :=  R[3].n_number ;
								SELF.serial_number_3  :=  R[3].serial_number ;
								SELF.mfr_mdl_code_3  :=  R[3].mfr_mdl_code ;
								SELF.year_mfr_3  :=  R[3].year_mfr ;
								SELF.last_action_date_3  :=  R[3].last_action_date ;
								SELF.cert_issue_date_3  :=  R[3].cert_issue_date ;
								SELF.certification_3  :=  format_AC_cert(R[3].certification) ;
								SELF.mode_s_code_3  :=  R[3].mode_s_code ;									

								SELF.aircraft_mfr_model_code_3  := ac_info[3].aircraft_mfr_model_code ;
								SELF.aircraft_mfr_name_3  := ac_info[3].aircraft_mfr_name ;
								SELF.ac_model_name_3  := ac_info[3].model_name ;
								SELF.number_of_engines_3  := ac_info[3].number_of_engines ;
								SELF.number_of_seats_3  := ac_info[3].number_of_seats ;
								SELF.aircraft_weight_3  := format_AC_weight(ac_info[3].aircraft_weight , ac_info[3].aircraft_weight_mapped);
								SELF.aircraft_cruising_speed_3  := ac_info[3].aircraft_cruising_speed ;
								SELF.engine_type_mapped_3  := ac_info[3].engine_type_mapped ;
								SELF.aircraft_type_mapped_3  := ac_info[3].aircraft_type_mapped ;
								SELF.category_mapped_3  := ac_info[3].category_mapped ;
								SELF.amateur_certification_mapped_3  := ac_info[3].amateur_certification_mapped ;
								// SELF.aircraft_weight_mapped_3  := ac_info[3].aircraft_weight_mapped ;

								SELF.engine_mfr_model_code_3  := eng_info[3].engine_mfr_model_code ;
								SELF.engine_mfr_name_3  := eng_info[3].engine_mfr_name ;
								SELF.eng_model_name_3  := eng_info[3].model_name ;
								SELF.engine_hp_or_thrust_3  := eng_info[3].engine_hp_or_thrust ;
								SELF.fuel_consumed_3  := eng_info[3].fuel_consumed ;
								
								SELF.current_flag_4 := format_AC_status(R[4].current_flag) ;
								SELF.n_number_4  :=  R[4].n_number ;
								SELF.serial_number_4  :=  R[4].serial_number ;
								SELF.mfr_mdl_code_4  :=  R[4].mfr_mdl_code ;
								SELF.year_mfr_4  :=  R[4].year_mfr ;
								SELF.last_action_date_4  :=  R[4].last_action_date ;
								SELF.cert_issue_date_4  :=  R[4].cert_issue_date ;
								SELF.certification_4  :=  format_AC_cert(R[4].certification) ;
								SELF.mode_s_code_4  :=  R[4].mode_s_code ;									

								SELF.aircraft_mfr_model_code_4  := ac_info[4].aircraft_mfr_model_code ;
								SELF.aircraft_mfr_name_4  := ac_info[4].aircraft_mfr_name ;
								SELF.ac_model_name_4  := ac_info[4].model_name ;
								SELF.number_of_engines_4  := ac_info[4].number_of_engines ;
								SELF.number_of_seats_4  := ac_info[4].number_of_seats ;
								SELF.aircraft_weight_4  := format_AC_weight(ac_info[4].aircraft_weight , ac_info[4].aircraft_weight_mapped);
								SELF.aircraft_cruising_speed_4  := ac_info[4].aircraft_cruising_speed ;
								SELF.engine_type_mapped_4  := ac_info[4].engine_type_mapped ;
								SELF.aircraft_type_mapped_4  := ac_info[4].aircraft_type_mapped ;
								SELF.category_mapped_4  := ac_info[4].category_mapped ;
								SELF.amateur_certification_mapped_4  := ac_info[4].amateur_certification_mapped ;
								// SELF.aircraft_weight_mapped_4  := ac_info[4].aircraft_weight_mapped ;

								SELF.engine_mfr_model_code_4  := eng_info[4].engine_mfr_model_code ;
								SELF.engine_mfr_name_4  := eng_info[4].engine_mfr_name ;
								SELF.eng_model_name_4  := eng_info[4].model_name ;
								SELF.engine_hp_or_thrust_4  := eng_info[4].engine_hp_or_thrust ;
								SELF.fuel_consumed_4  := eng_info[4].fuel_consumed ;

								SELF.current_flag_5 := format_AC_status(R[5].current_flag) ;
								SELF.n_number_5  :=  R[5].n_number ;
								SELF.serial_number_5  :=  R[5].serial_number ;
								SELF.mfr_mdl_code_5  :=  R[5].mfr_mdl_code ;
								SELF.year_mfr_5  :=  R[5].year_mfr ;
								SELF.last_action_date_5  :=  R[5].last_action_date ;
								SELF.cert_issue_date_5  :=  R[5].cert_issue_date ;
								SELF.certification_5  :=  format_AC_cert(R[5].certification) ;
								SELF.mode_s_code_5  :=  R[5].mode_s_code ;	
								
								SELF.aircraft_mfr_model_code_5  := ac_info[5].aircraft_mfr_model_code ;
								SELF.aircraft_mfr_name_5  := ac_info[5].aircraft_mfr_name ;
								SELF.ac_model_name_5  := ac_info[5].model_name ;
								SELF.number_of_engines_5  := ac_info[5].number_of_engines ;
								SELF.number_of_seats_5  := ac_info[5].number_of_seats ;
								SELF.aircraft_weight_5  := format_AC_weight(ac_info[5].aircraft_weight , ac_info[5].aircraft_weight_mapped);
								SELF.aircraft_cruising_speed_5  := ac_info[5].aircraft_cruising_speed ;
								SELF.engine_type_mapped_5  := ac_info[5].engine_type_mapped ;
								SELF.aircraft_type_mapped_5  := ac_info[5].aircraft_type_mapped ;
								SELF.category_mapped_5  := ac_info[5].category_mapped ;
								SELF.amateur_certification_mapped_5  := ac_info[5].amateur_certification_mapped ;
								// SELF.aircraft_weight_mapped_5  := ac_info[5].aircraft_weight_mapped ;

								SELF.engine_mfr_model_code_5  := eng_info[5].engine_mfr_model_code ;
								SELF.engine_mfr_name_5  := eng_info[5].engine_mfr_name ;
								SELF.eng_model_name_5  := eng_info[5].model_name ;
								SELF.engine_hp_or_thrust_5  := eng_info[5].engine_hp_or_thrust ;
								SELF.fuel_consumed_5  := eng_info[5].fuel_consumed ;
								
								SELF.best_ssn := IF(TRIM(L.best_ssn)<>'',L.best_ssn[1..3]+'-'+L.best_ssn[4..5]+'-'+L.best_ssn[6..9],'');
								SELF.type_registrant := format_AC_RegType(L.type_registrant);
								SELf.region := format_AC_Region(L.region);
								
								// FFD 
								
								aircraft_stmts_disputes := NORMALIZE(PROJECT(aircrafts, xFormStatement(LEFT,COUNTER)), left.stmts, normAircraftStaments(RIGHT));

								// Ugliness... but can't project eng_info or else left dataset not active when deploying...
								engine_stids := eng_info[1].StatementIDs+eng_info[2].StatementIDs+eng_info[3].StatementIDs+eng_info[4].StatementIDs+eng_info[5].StatementIDs;
								engine_dispute_flag := eng_info[1].isDisputed or eng_info[2].isDisputed or eng_info[3].isDisputed or eng_info[4].isDisputed or eng_info[5].isDisputed;							
								detail_stids := ac_info[1].StatementIDs + ac_info[2].StatementIDs + ac_info[3].StatementIDs + ac_info[4].StatementIDs + ac_info[5].StatementIDs;
								detail_dispute_flag := ac_info[1].isDisputed or ac_info[2].isDisputed or ac_info[3].isDisputed or ac_info[4].isDisputed or ac_info[5].isDisputed;
								
								engine_stmts := PROJECT(engine_stids, 
									FFD.InitializeConsumerStatementBatch(LEFT, FFD.Constants.RecordType.RS, 'engine_'+COUNTER, FFD.Constants.DataGroups.AIRCRAFT_ENGINE, 0, '', (unsigned6)L.did_out)); 
								engine_dispute_stmts := IF(engine_dispute_flag, 
									ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, 'engine', FFD.Constants.DataGroups.AIRCRAFT_ENGINE, 0, '', (unsigned6)L.did_out)));
								
								detail_stmts := PROJECT(detail_stids, 
									FFD.InitializeConsumerStatementBatch(LEFT, FFD.Constants.RecordType.RS, 'engine_details_'+COUNTER, FFD.Constants.DataGroups.AIRCRAFT_DETAILS, 0, '', (unsigned6)L.did_out));
								detail_dispute_stmts := IF(detail_dispute_flag, 
									ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, 'engine_details', FFD.Constants.DataGroups.AIRCRAFT_DETAILS, 0, '', (unsigned6)L.did_out)));
								
								all_stmts := aircraft_stmts_disputes + engine_stmts + engine_dispute_stmts + detail_stmts + detail_dispute_stmts;
								SELF.statements := all_stmts(RecordType<>'');
								
								SELF := L;
								SELF := [];
							END;

              // Partition the input according to the way records were fetched;
              // in each case we will dedup by aircraft number, and then group by DID, BDID or LinkID

							faa_did := DEDUP (SORT (inp (did_out<>'' and source = FaaV2_Services.Constants.autokey_src), did_out, n_number, -date_last_seen), did_out, n_number);
							did_g := GROUP (SORT (faa_did, did_out, -date_last_seen), did_out);

							faa_bdid := DEDUP (SORT (inp (bdid_out<>'' and source = FaaV2_Services.Constants.autokey_src), bdid_out, n_number, -date_last_seen), bdid_out, n_number);
							bdid_g := GROUP (SORT (faa_bdid, bdid_out, -date_last_seen), bdid_out);

              // link ids grouping depends on the input, so we have to apply special processing
              linkid_rec := RECORD (doxie_crs.layout_Faa_Aircraft_records)
                unsigned6 UltID_out := 0;
                unsigned6 OrgID_out := 0;
                unsigned6 SeleID_out := 0;
                unsigned6 ProxID_out := 0;
                unsigned6 PowID_out := 0;
                unsigned6 EmpID_out := 0;
                unsigned6 DotID_out := 0;
              END;
              linkid_rec SetTempLinkIDs (doxie_crs.layout_Faa_Aircraft_records L) := TRANSFORM
                SELF.OrgID_out := IF(BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  l.OrgID, 0),
                SELF.SeleID_out := IF(BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, l.SeleID, 0),
                SELF.ProxID_out := IF(BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, l.ProxID, 0),
                SELF.PowID_out := IF(BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_PowID_And_Down,  l.PowID, 0),
                SELF.EmpID_out := IF(BipFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_EmpID_And_Down,  l.EmpID, 0),
                SELF.DotID_out := IF(BipFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_DotID_And_Down,  l.DotID, 0),
                SELF := L;
              END;
              linkid_temp := PROJECT (inp (ultid<>0 and source = FaaV2_Services.Constants.linkid_src), SetTempLinkIDs (LEFT));


							faa_linkid := DEDUP (SORT (linkid_temp, UltID_out, OrgID_out, SeleID_out, ProxID_out, PowID_out, EmpID_out, DotID_out, n_number, -date_last_seen),
                                                      UltID_out, OrgID_out, SeleID_out, ProxID_out, PowID_out, EmpID_out, DotID_out, n_number);
							
							linkid_g := GROUP (SORT (faa_linkid, ultID_out, orgID_out, SeleID_out, ProxID_out, PowID_out, EmpID_out, DotID_out, -date_last_seen),
                                                   ultID_out, orgID_out, SeleID_out, ProxID_out, PowID_out, EmpID_out, DotID_out);

              // Now create a flat output using up to 5 aircrafts from each group
							did_r := ROLLUP(did_g,group,xfm_aircrafts(LEFT,ROWS(LEFT)));
							bdid_r := ROLLUP(bdid_g,group,xfm_aircrafts(LEFT,ROWS(LEFT)));
							linkid_r := ROLLUP(linkid_g,group,xfm_aircrafts(LEFT,ROWS(LEFT)));
							
							out := did_r +bdid_r + linkid_r;
						  return out;
					
					END;
				
			END;


  END;