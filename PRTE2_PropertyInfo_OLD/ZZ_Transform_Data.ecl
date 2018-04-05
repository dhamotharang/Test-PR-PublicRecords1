// PRTE2_PropertyInfo.Transform_Data
// Splitting out a LOT code that was cluttering up the NEW_process_build_propertyinfo logic.

IMPORT address, ut;

EXPORT Transform_Data := MODULE

		PropertyInfoRecN := Layouts.PropertyExpandedRec;
		string8 today_date := ut.GetDate; 

		//........................ BIG TRANSFORM .....................................
		EXPORT PropertyInfoRecN  Reformat_TESTDS (layouts.batch_in L, Integer C) := TRANSFORM
				string clean_address := address.CleanAddress182(trim(l.i_address), trim(l.p_city_name) + ' ' + trim(l.st) + ' ' + trim(l.zip) );

				SELF.property_rid   		:= (unsigned) Constants.RID_CONSTANT + C;
				SELF.dt_vendor_first_reported := (unsigned)today_date;
				SELF.dt_vendor_last_reported  := (unsigned)today_date;
				SELF.vendor_source 			:= L.i_datasource;
				SELF.tax_sortby_date 		:= l.AssessmentRecordingDate;
				SELF.deed_sortby_date 	:= L.DeedRecordingDate;
				SELF.fares_unformatted_apn := l.ApnNumber;
				SELF.prim_name  				:= clean_address [13..40];
				SELF.prim_range					:= clean_address [1..10];
				self.predir     				:= clean_address[11..12];
				self.addr_suffix 				:= clean_address [41..44];
				self.postdir       			:= clean_address [45..46];
				self.unit_desig    			:= clean_address [47..56];
				SELF.sec_range  				:= L.Apt;
				SELF.p_city_name 				:= clean_address[65..89];
				SELF.v_city_name 				:= clean_address[90..114];
				SELF.st         				:= IF(clean_address [115..116] > ' ',clean_address [115..116],L.st);

				z1 						 					:= clean_address[117..121];
				z2         		 					:= (integer) z1; 
				self.zip    		 				:= (string5) INTFORMAT(z2,5,1);
				self.zip4       				:= (string) clean_address[122..125];
				SELF.property_street_address := TRIM(self.prim_range) + ' ' + TRIM(self.prim_name) + '' +TRIM(self.addr_suffix);
				SELF.property_city_state_zip := TRIM(self.v_city_name) + ' ' + TRIM(self.st) + ' ' + TRIM(self.zip);
				SELF.msa        				:= clean_address [167..170];
				SELF.err_stat   				:= clean_address[179..182];
				SELF.cart       				:= clean_address[126..129];
				SELF.cr_sort_sz 				:= clean_address[130];
				SELF.lot        				:= clean_address[131..134];
				SELF.lot_order  				:= clean_address[135];
				SELF.dbpc       				:= clean_address[136..137];
				SELF.chk_digit  				:= clean_address[138];
				SELF.rec_type   				:= clean_address[139..140];
				SELF.county     				:= clean_address[141..145];
				self.geo_lat    				:= clean_address[146..155];
				self.geo_long   				:= clean_address[156..166];
				SELF.geo_blk    				:= clean_address[171..177];
				SELF.geo_match  				:= clean_address[178];
				SELF.src_latitude 			:= MAP(l.cf1_latitude = '300' => 'FARES',
																			l.cf1_latitude = '200' => 'OKCTY',
																			'');
				SELF.src_longitude			:= MAP(l.cf1_longitude = '300' => 'FARES',
																			l.cf1_longitude = '200' => 'OKCTY',
																			'');
					
				SELF.building_square_footage := (string) l.buildingareasf;
				SELF.src_building_square_footage := MAP(l.cf1_buildingsquarefootage = '300' => 'FARES',
																						l.cf1_buildingsquarefootage = '200' => 'OKCTY',
																						'');
		
				SELF.air_conditioning_type := MAP(l.c1 = '001' => l.m1,
																				 l.c2 = '001' => l.m2,
																				 l.c3 = '001' => l.m3,
																				 l.c4 = '001' => l.m4,
																				 l.c5 = '001' => l.m5,
																				 l.c6 = '001' => l.m6,
																				 l.c7 = '001' => l.m7,
																				 l.c8 = '001' => l.m8,
																				 l.c9 = '001' => l.m9,
																				 l.c10 = '001' => l.m10,
																				 l.c11 = '001' => l.m11,
																				 l.c12 = '001' => l.m12,
																				 l.c13 = '001' => l.m13,
																				 l.c14 = '001' => l.m14,
																				 l.c15 = '001' => l.m15,
																				 '');

				SELF.src_air_conditioning_type := MAP (l.cf1_airconditioningtypecode = '300' => 'FARES',
																					 l.cf1_airconditioningtypecode = '200' => 'OKCTY',
																					 '');
														 
											 
				SELF.basement_finish := MAP (l.c1 = '013' => l.m1,
																		 l.c2 = '013' => l.m2,
																		 l.c3 = '013' => l.m3,
																		 l.c4 = '013' => l.m4,
																		 l.c5 = '013' => l.m5,
																		 l.c6 = '013' => l.m6,
																		 l.c7 = '013' => l.m7,
																		 l.c8 = '013' => l.m8,
																		 l.c9 = '013' => l.m9,
																		 l.c10 = '013' => l.m10,
																		 l.c11 = '013' => l.m11,
																		 l.c12 = '013' => l.m12,
																		 l.c13 = '013' => l.m13,
																		 l.c14 = '013' => l.m14,
																		 l.c15 = '013' => l.m15,
																		 '');
				SELF.src_basement_finish := MAP(l.cf1_basementfinishtype = '300' => 'FARES',
																		l.cf1_basementfinishtype = '200' => 'OKCTY',
																		'');
																	 
				SELF.construction_type := MAP (l.c1 = '022' => l.m1,
																	 l.c2 = '022' => l.m2,
																	 l.c3 = '022' => l.m3,
																	 l.c4 = '022' => l.m4,
																	 l.c5 = '022' => l.m5,
																	 l.c6 = '022' => l.m6,
																	 l.c7 = '022' => l.m7,
																	 l.c8 = '022' => l.m8,
																	 l.c9 = '022' => l.m9,
																	 l.c10 = '022' => l.m10,
																	 l.c11 = '022' => l.m11,
																	 l.c12 = '022' => l.m12,
																	 l.c13 = '022' => l.m13,
																	 l.c14 = '022' => l.m14,
																	 l.c15 = '022' => l.m15,
																	 '');
				SELF.src_construction_type := MAP (l.cf1_constructiontype = '300' => 'FARES',
																					 l.cf1_constructiontype = '200' => 'OKCTY',
																					 '');

																		 
				SELF.exterior_wall := MAP (l.c1 = '005' => l.m1,
														 l.c2 = '005' => l.m2,
														 l.c3 = '005' => l.m3,
														 l.c4 = '005' => l.m4,
														 l.c5 = '005' => l.m5,
														 l.c6 = '005' => l.m6,
														 l.c7 = '005' => l.m7,
														 l.c8 = '005' => l.m8,
														 l.c9 = '005' => l.m9,
														 l.c10 = '005' => l.m10,
														 l.c11 = '005' => l.m11,
														 l.c12 = '005' => l.m12,
														 l.c13 = '005' => l.m13,
														 l.c14 = '005' => l.m14,
														 l.c15 = '005' => l.m15,
														 '');
																 
				SELF.src_exterior_wall := MAP (l.cf1_exteriorwalltype = '300' => 'FARES',
																			 l.cf1_exteriorwalltype = '200' => 'OKCTY',
																			 '');
																	 
				SELF.fireplace_ind 		:= l.fireplaceindicator;	
				
				SELF.src_fireplace_ind := MAP (l.cf1_fireplaceindicator = '300' => 'FARES',
																			 l.cf1_fireplaceindicator = '200' => 'OKCTY',
																			 '');					
				
				
				SELF.fireplace_type := MAP (l.c1 = '008' => l.m1,
														 l.c2 = '008' => l.m2,
														 l.c3 = '008' => l.m3,
														 l.c4 = '008' => l.m4,
														 l.c5 = '008' => l.m5,
														 l.c6 = '008' => l.m6,
														 l.c7 = '008' => l.m7,
														 l.c8 = '008' => l.m8,
														 l.c9 = '008' => l.m9,
														 l.c10 = '008' => l.m10,
														 l.c11 = '008' => l.m11,
														 l.c12 = '008' => l.m12,
														 l.c13 = '008' => l.m13,
														 l.c14 = '008' => l.m14,
														 l.c15 = '008' => l.m15,
														 '');
																 
				SELF.src_fireplace_type := MAP (l.cf1_fireplacetype = '300' => 'FARES',
																				l.cf1_fireplacetype = '200' => 'OKCTY',
																				'');
				SELF.flood_zone_panel   := l.FloodZonePanelNumber;
				SELF.src_flood_zone_panel := MAP(l.cf1_floodzonepanelnumber = '300' => 'FARES',
																				 l.cf1_floodzonepanelnumber = '200' => 'OKCTY',
																				 '');
																				 
				
				SELF.garage := MAP (l.c1 = '021' => l.m1,
														 l.c2 = '021' => l.m2,
														 l.c3 = '021' => l.m3,
														 l.c4 = '021' => l.m4,
														 l.c5 = '021' => l.m5,
														 l.c6 = '021' => l.m6,
														 l.c7 = '021' => l.m7,
														 l.c8 = '021' => l.m8,
														 l.c9 = '021' => l.m9,
														 l.c10 = '021' => l.m10,
														 l.c11 = '021' => l.m11,
														 l.c12 = '021' => l.m12,
														 l.c13 = '021' => l.m13,
														 l.c14 = '021' => l.m14,
														 l.c15 = '021' => l.m15,
														 '');
				SELF.src_garage := MAP(l.cf1_garagecarporttype = '300' => 'FARES',
															 l.cf1_garagecarporttype = '200' => 'OKCTY',
															 '');

				SELF.first_floor_square_footage := (string) l.groundfloorareasf;
				SELF.src_first_floor_square_footage := MAP(l.cf1_groundfloorsquarefootage = '300' => 'FARES',
																									 l.cf1_groundfloorsquarefootage = '200' => 'OKCTY',
																									 '');
																									 
				
				SELF.living_area_square_footage := l.LivingAreaSF;
				SELF.src_living_area_square_footage := MAP(l.cf1_livingareasquarefootage = '300' => 'FARES',
																									 l.cf1_livingareasquarefootage = '200' => 'OKCTY',
																									 '');
				SELF.heating := MAP (l.c1 = '024' => l.m1,
														 l.c2 = '024' => l.m2,
														 l.c3 = '024' => l.m3,
														 l.c4 = '024' => l.m4,
														 l.c5 = '024' => l.m5,
														 l.c6 = '024' => l.m6,
														 l.c7 = '024' => l.m7,
														 l.c8 = '024' => l.m8,
														 l.c9 = '024' => l.m9,
														 l.c10 = '024' => l.m10,
														 l.c11 = '024' => l.m11,
														 l.c12 = '024' => l.m12,
														 l.c13 = '024' => l.m13,
														 l.c14 = '024' => l.m14,
														 l.c15 = '024' => l.m15,
														 '');
																 
				SELF.src_heating     := MAP(l.cf1_heatingtype = '300' => 'FARES',
																	 l.cf1_heatingtype = '200' => 'OKCTY',
																	 '');
																				 
				SELF.no_of_baths 			:=   l.baths;
				SELF.src_no_of_baths	:= MAP(l.cf1_numberofbaths = '300' => 'FARES',
																	 l.cf1_numberofbaths = '200' => 'OKCTY',
																	 '');
				SELF.no_of_bedrooms 	:=   l.bedrooms;
				SELF.src_no_of_bedrooms := MAP(l.cf1_numberofbedrooms = '300' => 'FARES',
																			l.cf1_numberofbedrooms = '200' => 'OKCTY',
																			'');
				SELF.no_of_fireplaces :=  l.fireplaces;
				SELF.src_no_of_fireplaces := MAP(l.cf1_numberoffireplaces = '300' => 'FARES',
																				l.cf1_numberoffireplaces = '200' => 'OKCTY',
																				'');
				SELF.no_of_full_baths :=  (string) l.fullbaths;
				SELF.src_no_of_full_baths := MAP(l.cf1_numberoffullbaths = '300' => 'FARES',
																				l.cf1_numberoffullbaths = '200' => 'OKCTY',
																				'');
																				
				SELF.no_of_half_baths :=  (string) l.halfbaths;
				SELF.src_no_of_half_baths := MAP(l.cf1_numberofhalfbaths = '300' => 'FARES',
																				l.cf1_numberofhalfbaths = '200' => 'OKCTY',
																				'');
				SELF.no_of_stories    :=  l.stories;
				SELF.src_no_of_stories := MAP(l.cf1_numberofstories = '300' => 'FARES',
																			l.cf1_numberofstories = '200' => 'OKCTY',
																			'');
	 
				SELF.parking_type := MAP (l.c1 = '012' => l.m1,
																 l.c2 = '012' => l.m2,
																 l.c3 = '012' => l.m3,
																 l.c4 = '012' => l.m4,
																 l.c5 = '012' => l.m5,
																 l.c6 = '012' => l.m6,
																 l.c7 = '012' => l.m7,
																 l.c8 = '012' => l.m8,
																 l.c9 = '012' => l.m9,
																 l.c10 = '012' => l.m10,
																 l.c11 = '012' => l.m11,
																 l.c12 = '012' => l.m12,
																 l.c13 = '012' => l.m13,
																 l.c14 = '012' => l.m14,
																 l.c15 = '012' => l.m15,
																 '');
				SELF.src_parking_type := MAP(l.cf1_parkingtype = '300' => 'FARES',
																		l.cf1_parkingtype = '200' => 'OKCTY',
																		'');
				SELF.pool_indicator  	:= l.pool;
				SELF.src_pool_indicator := MAP(l.cf1_poolindicator ='300' => 'FARES',
																		l.cf1_poolindicator = '200' => 'OKCTY',
																		'');
		
				SELF.pool_type := MAP (l.c1 = '027' => l.m1,
																 l.c2 = '027' => l.m2,
																 l.c3 = '027' => l.m3,
																 l.c4 = '027' => l.m4,
																 l.c5 = '027' => l.m5,
																 l.c6 = '027' => l.m6,
																 l.c7 = '027' => l.m7,
																 l.c8 = '027' => l.m8,
																 l.c9 = '027' => l.m9,
																 l.c10 = '027' => l.m10,
																 l.c11 = '027' => l.m11,
																 l.c12 = '027' => l.m12,
																 l.c13 = '027' => l.m13,
																 l.c14 = '027' => l.m14,
																 l.c15 = '027' => l.m15,
																 '');
				SELF.src_pool_type := MAP(l.cf1_pooltype = '300' => 'FARES',
																		l.cf1_pooltype = '200' => 'OKCTY',
																		'');													 
				SELF.roof_cover := MAP (l.c1 = '006' => l.m1,
																	 l.c2 = '006' => l.m2,
																	 l.c3 = '006' => l.m3,
																	 l.c4 = '006' => l.m4,
																	 l.c5 = '006' => l.m5,
																	 l.c6 = '006' => l.m6,
																	 l.c7 = '006' => l.m7,
																	 l.c8 = '006' => l.m8,
																	 l.c9 = '006' => l.m9,
																	 l.c10 = '006' => l.m10,
																	 l.c11 = '006' => l.m11,
																	 l.c12 = '006' => l.m12,
																	 l.c13 = '006' => l.m13,
																	 l.c14 = '006' => l.m14,
																	 l.c15 = '006' => l.m15,
																	 '');	
				SELF.src_roof_cover := MAP(l.cf1_roofcovertype = '300' => 'FARES',
																		l.cf1_roofcovertype = '200' => 'OKCTY',
																		'');
						
						
				SELF.year_built    		:= (string) l.yearbuilt;
				SELF.src_year_built := MAP(l.cf1_yearbuilt = '300' => 'FARES',
																	 l.cf1_yearbuilt = '200' => 'OKCTY',
																	'');

				SELF.foundation := MAP (l.c1 = '007' => l.m1,
																 l.c2 = '007' => l.m2,
																 l.c3 = '007' => l.m3,
																 l.c4 = '007' => l.m4,
																 l.c5 = '007' => l.m5,
																 l.c6 = '007' => l.m6,
																 l.c7 = '007' => l.m7,
																 l.c8 = '007' => l.m8,
																 l.c9 = '007' => l.m9,
																 l.c10 = '007' => l.m10,
																 l.c11 = '007' => l.m11,
																 l.c12 = '007' => l.m12,
																 l.c13 = '007' => l.m13,
																 l.c14 = '007' => l.m14,
																 l.c15 = '007' => l.m15,
																 '');
				SELF.src_foundation   := MAP(l.cf1_foundationtype = '300' => 'FARES',
																		 l.cf1_foundationtype = '200' => 'OKCTY',
																			'');
				
				SELF.basement_square_footage := (string) l.basementareasf;
				SELF.src_basement_square_footage := MAP(l.cf1_basementsquarefootage = '300' => 'FARES',
																								l.cf1_basementsquarefootage = '200' => 'OKCTY',
																								'');
				
				SELF.effective_year_built := (string) l.effectiveyearbuilt;
				SELF.src_effective_year_built := MAP(l.cf1_effectiveyearbuilt = '300' => 'FARES',
																						 l.cf1_effectiveyearbuilt = '200' => 'OKCTY',
																							'');
					
				
				SELF.garage_square_footage := (string) l.garageareasf;
				SELF.src_garage_square_footage :=  MAP(l.cf1_garagesquarefootage = '300' => 'FARES',
																							l.cf1_garagesquarefootage = '200' => 'OKCTY',
																							'');
					
				SELF.stories_type     := l.storiestype;
				SELF.src_stories_type := MAP(l.cf1_storiestype = '300' => 'FARES',
																		 l.cf1_storiestype = '200' => 'OKCTY',
																			'');
					
				SELF.census_tract     := l.censustract;
				SELF.src_census_tract := MAP(l.cf1_censustract = '300' => 'FARES',
																		 l.cf1_censustract = '200' => 'OKCTY',
																			'');
					
				
				SELF.range            := l.rangeno;
				SELF.src_range 				:= MAP(l.cf1_range = '300' => 'FARES',
																		 l.cf1_range = '200' => 'OKCTY',
																			'');
			
				SELF.block_number     := l.blocknumber;
				SELF.src_block_number := MAP(l.cf1_blocknumber = '300' => 'FARES',
																 l.cf1_blocknumber = '200' => 'OKCTY',
																	'');
				
				SELF.county_name      := l.county;
				SELF.src_county_name	:= MAP(l.cf1_county = '300' => 'FARES',
																	l.cf1_county = '200' => 'OKCTY',
																	'');
			
				SELF.apn_number       := l.ApnNumber;
				SELF.src_apn_number   := MAP(l.cf1_apnnumber = '300' => 'FARES',
																l.cf1_apnnumber = '200' => 'OKCTY',
																'');
			
		
				SELF.zoning           := l.ZoningDesc;
				SELF.src_zoning			  := MAP(l.cf1_zoningdescription = '300' => 'FARES',
																l.cf1_zoningdescription = '200' => 'OKCTY',
																'');
			
				SELF.fips_code        := l.FipsCode;
				SELF.src_fips_code	  := MAP(l.cf1_fipscode = '300' => 'FARES',
																l.cf1_fipscode = '200' => 'OKCTY',
																'');
			
				SELF.subdivision      := l.SubDivisionName;
				SELF.src_subdivision  := MAP(l.cf1_subdivisionname = '300' => 'FARES',
																l.cf1_subdivisionname = '200' => 'OKCTY',
																'');
			
				SELF.municipality     := l.MunicipalityName;
				SELF.src_municipality := MAP(l.cf1_municipalityname = '300' => 'FARES',
																 l.cf1_municipalityname = '200' => 'OKCTY',
																	'');
			
				SELF.township         := l.TownshipName;
				SELF.src_township	 := MAP(l.cf1_townshipname = '300' => 'FARES',
															l.cf1_townshipname = '200' => 'OKCTY',
															'');
			
				SELF.homestead_exemption_ind  := l.HomesteadExemption;
				SELF.src_homestead_exemption_ind := MAP(l.cf1_homesteadexemptionindicator = '300' => 'FARES',
																						l.cf1_homesteadexemptionindicator = '200' => 'OKCTY',
																						'');
			
				SELF.land_use_code    := l.LandUseCode;
				SELF.src_land_use_code := MAP(l.cf1_landusecode = '300' => 'FARES',
																	l.cf1_landusecode = '200' => 'OKCTY',
																	'');
			
				SELF.location_influence_code  := l.LocationOfInfluenceCode;
				SELF.src_location_influence_code := MAP(l.cf1_locationofinfluencecode = '300' => 'FARES',
																								l.cf1_locationofinfluencecode = '200' => 'OKCTY',
																								'');
				SELF.acres            := l.acres;
				SELF.src_acres 			  := MAP(l.cf1_acres = '300' => 'FARES',
																		l.cf1_acres = '200' => 'OKCTY',
																		'');
			
				SELF.lot_depth_footage := l.lotdepthfootage;
				SELF.src_lot_depth_footage := MAP(l.cf1_lotdepthfootage = '300' => 'FARES',
																				l.cf1_lotdepthfootage = '200' => 'OKCTY',
																			'');
			
				SELF.lot_front_footage := l.lotfrontfootage;
				SELF.src_lot_front_footage := MAP(l.cf1_lotfrontfootage = '300' => 'FARES',
																				l.cf1_lotfrontfootage = '200' => 'OKCTY',
																				'');
			
				SELF.lot_number       := l.LotNumber;
				SELF.src_lot_number		:= MAP(l.cf1_lotnumber = '300' => 'FARES',
																		l.cf1_lotnumber = '200' => 'OKCTY',
																		'');
		
				SELF.lot_size         := l.lotsize;
				SELF.property_type_code := l.PropertyTypeCode;
				SELF.src_property_type_code	:= MAP(l.cf1_propertytypecode = '300' => 'FARES',
																				l.cf1_propertytypecode = '200' => 'OKCTY',
																				'');

				SELF.water			 := MAP (l.c1 = '016' => l.m1,
														 l.c2 = '016' => l.m2,
														 l.c3 = '016' => l.m3,
														 l.c4 = '016' => l.m4,
														 l.c5 = '016' => l.m5,
														 l.c6 = '016' => l.m6,
														 l.c7 = '016' => l.m7,
														 l.c8 = '016' => l.m8,
														 l.c9 = '016' => l.m9,
														 l.c10 = '016' => l.m10,
														 l.c11 = '016' => l.m11,
														 l.c12 = '016' => l.m12,
														 l.c13 = '016' => l.m13,
														 l.c14 = '016' => l.m14,
														 l.c15 = '016' => l.m15,
														 '');
				SELF.src_water	 := MAP(l.cf1_watertype = '300' => 'FARES',
															l.cf1_watertype = '200' => 'OKCTY',
															'');													 
			
				SELF.sewer		 := MAP (l.c1 = '026' => l.m1,
														 l.c2 = '026' => l.m2,
														 l.c3 = '026' => l.m3,
														 l.c4 = '026' => l.m4,
														 l.c5 = '026' => l.m5,
														 l.c6 = '026' => l.m6,
														 l.c7 = '026' => l.m7,
														 l.c8 = '026' => l.m8,
														 l.c9 = '026' => l.m9,
														 l.c10 = '026' => l.m10,
														 l.c11 = '026' => l.m11,
														 l.c12 = '026' => l.m12,
														 l.c13 = '026' => l.m13,
														 l.c14 = '026' => l.m14,
														 l.c15 = '026' => l.m15,
														 '');
																	
				SELF.src_sewer	 := MAP(l.cf1_sewertype = '300' => 'FARES',
																l.cf1_sewertype = '200' => 'OKCTY',
																'');
																 
																 
				SELF.assessed_land_value   := l.AssessedLandValue;
				SELF.src_assessed_land_value	 := MAP(l.cf1_assessedlandvalue = '300' => 'FARES',
																							l.cf1_assessedlandvalue = '200' => 'OKCTY',
																							'');
				SELF.assessed_year       := l.AssessedYear;
				SELF.src_assessed_year	 := MAP(l.cf1_assessedyear = '300' => 'FARES',
																				l.cf1_assessedyear = '200' => 'OKCTY',
																				'');
				SELF.tax_amount      := l.TaxAmount;
				SELF.src_tax_amount	 := MAP(l.cf1_taxamount = '300' => 'FARES',
																		l.cf1_taxamount = '200' => 'OKCTY',
																		'');
				SELF.tax_year      := l.TaxBillingYear;
				SELF.src_tax_year	 := MAP(l.cf1_taxbillingyear = '300' => 'FARES',
																	l.cf1_taxbillingyear = '200' => 'OKCTY',
																	'');
				SELF.market_land_value 		 := l.MarketLandValue;
				SELF.src_market_land_value := MAP(l.cf1_marketlandvalue = '300' => 'FARES',
																				l.cf1_marketlandvalue = '200' => 'OKCTY',
																				'');
				SELF.improvement_value     := l.ImprovementValue;
				SELF.src_improvement_value := MAP(l.cf1_improvementvalue = '300' => 'FARES',
																				l.cf1_improvementvalue = '200' => 'OKCTY',
																				'');
				SELF.percent_improved      := (udecimal5_2)l.PercentImproved;
				SELF.src_percent_improved	 := MAP(l.cf1_percentimproved = '300' => 'FARES',
																					l.cf1_percentimproved = '200' => 'OKCTY',
																					'');
				SELF.total_assessed_value  := l.TotalAssessedValue;
				SELF.src_total_assessed_value	 := MAP(l.cf1_totalassessedvalue = '300' => 'FARES',
																						l.cf1_totalassessedvalue = '200' => 'OKCTY',
																						'');
				SELF.total_calculated_value := l.TotalCalculatedValue;
				SELF.src_total_calculated_value	 := MAP(l.cf1_totalcalculatedvalue = '300' => 'FARES',
																								l.cf1_totalcalculatedvalue = '200' => 'OKCTY',
																								'');
				SELF.total_land_value      := l.TotalLandValue;
				SELF.src_total_land_value	 := MAP(l.cf1_totallandvalue = '300' => 'FARES',
																					l.cf1_totallandvalue = '200' => 'OKCTY',
																					'');
				SELF.total_market_value    := l.TotalMarketValue;
				SELF.src_total_market_value := MAP(l.cf1_totalmarketvalue = '300' => 'FARES',
																					l.cf1_totalmarketvalue = '200' => 'OKCTY',
																					'');
				
				SELF.floor_type := MAP (l.c1 = '003' => l.m1,
														 l.c2 = '003' => l.m2,
														 l.c3 = '003' => l.m3,
														 l.c4 = '003' => l.m4,
														 l.c5 = '003' => l.m5,
														 l.c6 = '003' => l.m6,
														 l.c7 = '003' => l.m7,
														 l.c8 = '003' => l.m8,
														 l.c9 = '003' => l.m9,
														 l.c10 = '003' => l.m10,
														 l.c11 = '003' => l.m11,
														 l.c12 = '003' => l.m12,
														 l.c13 = '003' => l.m13,
														 l.c14 = '003' => l.m14,
														 l.c15 = '003' => l.m15,
														 '');
				SELF.src_floor_type	 := MAP(l.cf1_floortype = '300' => 'FARES',
																		l.cf1_floortype = '200' => 'OKCTY',
																		'');																		 
																 
				SELF.no_of_bath_fixtures     := (string) l.BathFixtures;
				SELF.src_no_of_bath_fixtures := MAP(l.cf1_numberofbathfixtures = '300' => 'FARES',
																						l.cf1_numberofbathfixtures = '200' => 'OKCTY',
																						'');																
				
				SELF.no_of_rooms       := (string) l.rooms;
				SELF.src_no_of_rooms	 := MAP(l.cf1_numberofrooms = '300' => 'FARES',
																		l.cf1_numberofrooms = '200' => 'OKCTY',
																		'');																
				SELF.no_of_units       := (string) l.units;
				SELF.src_no_of_units	 := MAP(l.cf1_numberofunits = '300' => 'FARES',
																			l.cf1_numberofunits = '200' => 'OKCTY',
																			'');																
				SELF.style_type		 := MAP (l.c1 = '019' => l.m1,
														 l.c2 = '019' => l.m2,
														 l.c3 = '019' => l.m3,
														 l.c4 = '019' => l.m4,
														 l.c5 = '019' => l.m5,
														 l.c6 = '019' => l.m6,
														 l.c7 = '019' => l.m7,
														 l.c8 = '019' => l.m8,
														 l.c9 = '019' => l.m9,
														 l.c10 = '019' => l.m10,
														 l.c11 = '019' => l.m11,
														 l.c12 = '019' => l.m12,
														 l.c13 = '019' => l.m13,
														 l.c14 = '019' => l.m14,
														 l.c15 = '019' => l.m15,
														 '');
				SELF.src_style_type	 := MAP(l.cf1_styletype = '300' => 'FARES',
																		l.cf1_styletype = '200' => 'OKCTY',
																		'');																
														 
																 
				SELF.assessment_document_number  := l.AssessmentDocumentNumber;
				SELF.src_assessment_document_number	 := MAP(l.cf1_assessmentdocumentnumber = '300' => 'FARES',
																										l.cf1_assessmentdocumentnumber = '200' => 'OKCTY',
																										'');																
				SELF.assessment_recording_date   := l.AssessmentRecordingDate;
				SELF.src_assessment_recording_date	 := MAP(l.cf1_assessmentrecordingdate = '300' => 'FARES',
																										l.cf1_assessmentrecordingdate = '200' => 'OKCTY',
																										'');																
				SELF.deed_document_number     := l.DeedDocumentNumber;
				SELF.src_deed_document_number	:= MAP(l.cf2_deeddocumentnumber = '300' => 'FARES',
																						l.cf2_deeddocumentnumber = '200' => 'OKCTY',
																						'');																
				
				SELF.deed_recording_date      := l.DeedRecordingDate;
				SELF.src_deed_recording_date	:= MAP(l.cf2_deedrecordingdate = '300' => 'FARES',
																						l.cf2_deedrecordingdate = '200' => 'OKCTY',
																						'');																
				SELF.full_part_sale      := l.SalesFullPart;
				SELF.src_full_part_sale	 := MAP(l.cf2_salefullorpart = '300' => 'FARES',
																		l.cf2_salefullorpart = '200' => 'OKCTY',
																		'');																
				SELF.sale_amount       := l.SalesAmount;
				SELF.src_sale_amount	 := MAP(l.cf2_salesamount = '300' => 'FARES',
																			l.cf2_salesamount = '200' => 'OKCTY',
																		'');																
				SELF.sale_date         := l.SalesDate;
				SELF.src_sale_date		 := MAP(l.cf2_salesdate = '300' => 'FARES',
																			l.cf2_salesdate = '200' => 'OKCTY',
																			'');																
				SELF.sale_type_code     := l.SalesTypeCode;
				SELF.src_sale_type_code	:= MAP(l.cf2_salestypecode = '300' => 'FARES',
																			l.cf2_salestypecode = '200' => 'OKCTY',
																			'');																
				SELF.mortgage_company_name     := l.MortgCN1;
				SELF.src_mortgage_company_name := MAP(l.cf2_mortgagecompanyname = '300' => 'FARES',
																							l.cf2_mortgagecompanyname = '200' => 'OKCTY',
																							'');																
				SELF.loan_amount       := l.LoanAmt1;
				SELF.src_loan_amount	 := MAP(l.cf2_loanamount = '300' => 'FARES',
																			l.cf2_loanamount = '200' => 'OKCTY',
																			'');																
				SELF.second_loan_amount 		:= L.LoanAmt2;
				SELF.src_second_loan_amount	:= MAP(l.cf2_secondloanamount = '300' => 'FARES',
																					l.cf2_secondloanamount = '200' => 'OKCTY',
																					'');																
				SELF.loan_type_code      := l.loanamtcd1;
				SELF.src_loan_type_code	 := MAP(l.cf2_loantypecode = '300' => 'FARES',
																				l.cf2_loantypecode = '200' => 'OKCTY',
																				'');																
				SELF.interest_rate_type_code     := l.InterestRTCD1;
				SELF.src_interest_rate_type_code := MAP(l.cf2_interestratetypecode = '300' => 'FARES',
																								l.cf2_interestratetypecode = '200' => 'OKCTY',
																								'');																

				SELF.structure_quality       := l.QualityofStructCode;
				SELF.src_structure_quality	 := MAP(l.cf1_qualityofstructurecode = '300' => 'FARES',
																						l.cf1_qualityofstructurecode = '200' => 'OKCTY',
																						'');
				
				SELF := L;
				SELF := [];
		END;
		//END: ........................ BIG TRANSFORM .....................................

END;