import faa,strata;

export Out_Base_Dev_Stats(string version) :=
function
	ds_reg  := faa.file_aircraft_registration_out;
	ds_cert := faa.file_airmen_certificate_out;
	ds_data := faa.file_airmen_data_out;

	rPopulationStats_ds_reg
	 :=
		record
			string3  grouping                             := 'ALL';
			CountGroup                                    := count(group);
			d_score_CountNonBlank                         := sum(group,if(ds_reg.d_score<>'',1,0));
			best_ssn_CountNonBlank                        := sum(group,if(ds_reg.best_ssn<>'',1,0));
			did_out_CountNonBlank                         := sum(group,if(ds_reg.did_out<>'',1,0));
			bdid_out_CountNonBlank                        := sum(group,if(ds_reg.bdid_out<>'',1,0));
			date_first_seen_CountNonBlank                 := sum(group,if(ds_reg.date_first_seen<>'',1,0));
			date_last_seen_CountNonBlank                  := sum(group,if(ds_reg.date_last_seen<>'',1,0));
			current_flag_CountNonBlank                    := sum(group,if(ds_reg.current_flag<>'',1,0));
			n_number_CountNonBlank                        := sum(group,if(ds_reg.n_number<>'',1,0));
			serial_number_CountNonBlank                   := sum(group,if(ds_reg.serial_number<>'',1,0));
			mfr_mdl_code_CountNonBlank                    := sum(group,if(ds_reg.mfr_mdl_code<>'',1,0));
			eng_mfr_mdl_CountNonBlank                     := sum(group,if(ds_reg.eng_mfr_mdl<>'',1,0));
			year_mfr_CountNonBlank                        := sum(group,if(ds_reg.year_mfr<>'',1,0));
			type_registrant_CountNonBlank                 := sum(group,if(ds_reg.type_registrant<>'',1,0));
			name_CountNonBlank                            := sum(group,if(ds_reg.name<>'',1,0));
			street_CountNonBlank                          := sum(group,if(ds_reg.street<>'',1,0));
			street2_CountNonBlank                         := sum(group,if(ds_reg.street2<>'',1,0));
			city_CountNonBlank                            := sum(group,if(ds_reg.city<>'',1,0));
			state_CountNonBlank                           := sum(group,if(ds_reg.state<>'',1,0));
			zip_code_CountNonBlank                        := sum(group,if(ds_reg.zip_code<>'',1,0));
			region_CountNonBlank                          := sum(group,if(ds_reg.region<>'',1,0));
			orig_county_CountNonBlank                     := sum(group,if(ds_reg.orig_county<>'',1,0));
			country_CountNonBlank                         := sum(group,if(ds_reg.country<>'',1,0));
			last_action_date_CountNonBlank                := sum(group,if(ds_reg.last_action_date<>'',1,0));
			cert_issue_date_CountNonBlank                 := sum(group,if(ds_reg.cert_issue_date<>'',1,0));
			certification_CountNonBlank                   := sum(group,if(ds_reg.certification<>'',1,0));
			type_aircraft_CountNonBlank                   := sum(group,if(ds_reg.type_aircraft<>'',1,0));
			type_engine_CountNonBlank                     := sum(group,if(ds_reg.type_engine<>'',1,0));
			status_code_CountNonBlank                     := sum(group,if(ds_reg.status_code<>'',1,0));
			mode_s_code_CountNonBlank                     := sum(group,if(ds_reg.mode_s_code<>'',1,0));
			fract_owner_CountNonBlank                     := sum(group,if(ds_reg.fract_owner<>'',1,0));
			aircraft_mfr_name_CountNonBlank               := sum(group,if(ds_reg.aircraft_mfr_name<>'',1,0));
			model_name_CountNonBlank                      := sum(group,if(ds_reg.model_name<>'',1,0));
			prim_range_CountNonBlank                      := sum(group,if(ds_reg.prim_range<>'',1,0));
			predir_CountNonBlank                          := sum(group,if(ds_reg.predir<>'',1,0));
			prim_name_CountNonBlank                       := sum(group,if(ds_reg.prim_name<>'',1,0));
			addr_suffix_CountNonBlank                     := sum(group,if(ds_reg.addr_suffix<>'',1,0));
			postdir_CountNonBlank                         := sum(group,if(ds_reg.postdir<>'',1,0));
			unit_desig_CountNonBlank                      := sum(group,if(ds_reg.unit_desig<>'',1,0));
			sec_range_CountNonBlank                       := sum(group,if(ds_reg.sec_range<>'',1,0));
			p_city_name_CountNonBlank                     := sum(group,if(ds_reg.p_city_name<>'',1,0));
			v_city_name_CountNonBlank                     := sum(group,if(ds_reg.v_city_name<>'',1,0));
			st_CountNonBlank                              := sum(group,if(ds_reg.st<>'',1,0));
			zip_CountNonBlank                             := sum(group,if(ds_reg.zip<>'',1,0));
			z4_CountNonBlank                              := sum(group,if(ds_reg.z4<>'',1,0));
			cart_CountNonBlank                            := sum(group,if(ds_reg.cart<>'',1,0));
			cr_sort_sz_CountNonBlank                      := sum(group,if(ds_reg.cr_sort_sz<>'',1,0));
			lot_CountNonBlank                             := sum(group,if(ds_reg.lot<>'',1,0));
			lot_order_CountNonBlank                       := sum(group,if(ds_reg.lot_order<>'',1,0));
			dpbc_CountNonBlank                            := sum(group,if(ds_reg.dpbc<>'',1,0));
			chk_digit_CountNonBlank                       := sum(group,if(ds_reg.chk_digit<>'',1,0));
			rec_type_CountNonBlank                        := sum(group,if(ds_reg.rec_type<>'',1,0));
			ace_fips_st_CountNonBlank                     := sum(group,if(ds_reg.ace_fips_st<>'',1,0));
			county_CountNonBlank                          := sum(group,if(ds_reg.county<>'',1,0));
			geo_lat_CountNonBlank                         := sum(group,if(ds_reg.geo_lat<>'',1,0));
			geo_long_CountNonBlank                        := sum(group,if(ds_reg.geo_long<>'',1,0));
			msa_CountNonBlank                             := sum(group,if(ds_reg.msa<>'',1,0));
			geo_blk_CountNonBlank                         := sum(group,if(ds_reg.geo_blk<>'',1,0));
			geo_match_CountNonBlank                       := sum(group,if(ds_reg.geo_match<>'',1,0));
			err_stat_CountNonBlank                        := sum(group,if(ds_reg.err_stat<>'',1,0));
			title_CountNonBlank                           := sum(group,if(ds_reg.title<>'',1,0));
			fname_CountNonBlank                           := sum(group,if(ds_reg.fname<>'',1,0));
			mname_CountNonBlank                           := sum(group,if(ds_reg.mname<>'',1,0));
			lname_CountNonBlank                           := sum(group,if(ds_reg.lname<>'',1,0));
			name_suffix_CountNonBlank                     := sum(group,if(ds_reg.name_suffix<>'',1,0));
			compname_CountNonBlank                        := sum(group,if(ds_reg.compname<>'',1,0));
			lf_CountNonBlank                              := sum(group,if(ds_reg.lf<>'',1,0));
			//BIPV2 fields have been added for Strata
			source_rec_id_CountNonZeros	   								:= sum(group,if(ds_reg.source_rec_id<>0,1,0));
			DotID_CountNonZeros	 													:= sum(group,if(ds_reg.DotID<>0,1,0));
			DotScore_CountNonZeros	   										:= sum(group,if(ds_reg.DotScore<>0,1,0));
			DotWeight_CountNonZeros	 											:= sum(group,if(ds_reg.DotWeight<>0,1,0));
			EmpID_CountNonZeros	   												:= sum(group,if(ds_reg.EmpID<>0,1,0));
			EmpScore_CountNonZeros	 											:= sum(group,if(ds_reg.EmpScore<>0,1,0));
			EmpWeight_CountNonZeros	 									    := sum(group,if(ds_reg.EmpWeight<>0,1,0));
			POWID_CountNonZeros	                          := sum(group,if(ds_reg.POWID<>0,1,0));
			POWScore_CountNonZeros	                      := sum(group,if(ds_reg.POWScore<>0,1,0));
			POWWeight_CountNonZeros	                      := sum(group,if(ds_reg.POWWeight<>0,1,0));
			ProxID_CountNonZeros	                        := sum(group,if(ds_reg.ProxID<>0,1,0));
			ProxScore_CountNonZeros	                      := sum(group,if(ds_reg.ProxScore<>0,1,0));
			ProxWeight_CountNonZeros	                    := sum(group,if(ds_reg.ProxWeight<>0,1,0));
      SELEID_CountNonZeros	                        := sum(group,if(ds_reg.SELEID<>0,1,0));
		  SELEScore_CountNonZeros	                      := sum(group,if(ds_reg.SELEScore<>0,1,0));
		  SELEWeight_CountNonZeros	                    := sum(group,if(ds_reg.SELEWeight<>0,1,0));
			OrgID_CountNonZeros	                          := sum(group,if(ds_reg.OrgID<>0,1,0));
			OrgScore_CountNonZeros	                      := sum(group,if(ds_reg.OrgScore<>0,1,0));
			OrgWeight_CountNonZeros	                      := sum(group,if(ds_reg.OrgWeight<>0,1,0));
			UltID_CountNonZeros	                          := sum(group,if(ds_reg.UltID<>0,1,0));
			UltScore_CountNonZeros	                      := sum(group,if(ds_reg.UltScore<>0,1,0));
			UltWeight_CountNonZeros	                      := sum(group,if(ds_reg.UltWeight<>0,1,0));

		end;

	rPopulationStats_ds_cert
	 :=
		record
			string3  grouping                            := 'ALL';	
			CountGroup                                   := count(group);
			date_first_seen_CountNonBlank                := sum(group,if(ds_cert.date_first_seen<>'',1,0));
			date_last_seen_CountNonBlank                 := sum(group,if(ds_cert.date_last_seen<>'',1,0));
			current_flag_CountNonBlank                   := sum(group,if(ds_cert.current_flag<>'',1,0));
			letter_CountNonBlank                         := sum(group,if(ds_cert.letter<>'',1,0));
			unique_id_CountNonBlank                      := sum(group,if(ds_cert.unique_id<>'',1,0));
			rec_type_CountNonBlank                       := sum(group,if(ds_cert.rec_type<>'',1,0));
			cer_type_CountNonBlank                       := sum(group,if(ds_cert.cer_type<>'',1,0));
			cer_type_mapped_CountNonBlank                := sum(group,if(ds_cert.cer_type_mapped<>'',1,0));
			cer_level_CountNonBlank                      := sum(group,if(ds_cert.cer_level<>'',1,0));
			cer_level_mapped_CountNonBlank               := sum(group,if(ds_cert.cer_level_mapped<>'',1,0));
			cer_exp_date_CountNonBlank                   := sum(group,if(ds_cert.cer_exp_date<>'',1,0));
			ratings_CountNonBlank                        := sum(group,if(ds_cert.ratings<>'',1,0));
			filler_CountNonBlank                         := sum(group,if(ds_cert.filler<>'',1,0));
			lfcr_CountNonBlank                           := sum(group,if(ds_cert.lfcr<>'',1,0));
		end;

	rPopulationStats_ds_data
	 :=
		record
			string3  grouping                           := 'ALL';
			CountGroup                                  := count(group);
			d_score_CountNonBlank                       := sum(group,if(ds_data.d_score<>'',1,0));
			best_ssn_CountNonBlank                      := sum(group,if(ds_data.best_ssn<>'',1,0));
			did_out_CountNonBlank                       := sum(group,if(ds_data.did_out<>'',1,0));
			date_first_seen_CountNonBlank               := sum(group,if(ds_data.date_first_seen<>'',1,0));
			date_last_seen_CountNonBlank                := sum(group,if(ds_data.date_last_seen<>'',1,0));
			current_flag_CountNonBlank                  := sum(group,if(ds_data.current_flag<>'',1,0));
			record_type_CountNonBlank                   := sum(group,if(ds_data.record_type<>'',1,0));
			letter_code_CountNonBlank                   := sum(group,if(ds_data.letter_code<>'',1,0));
			unique_id_CountNonBlank                     := sum(group,if(ds_data.unique_id<>'',1,0));
			orig_rec_type_CountNonBlank                 := sum(group,if(ds_data.orig_rec_type<>'',1,0));
			orig_fname_CountNonBlank                    := sum(group,if(ds_data.orig_fname<>'',1,0));
			orig_lname_CountNonBlank                    := sum(group,if(ds_data.orig_lname<>'',1,0));
			street1_CountNonBlank                       := sum(group,if(ds_data.street1<>'',1,0));
			street2_CountNonBlank                       := sum(group,if(ds_data.street2<>'',1,0));
			city_CountNonBlank                          := sum(group,if(ds_data.city<>'',1,0));
			state_CountNonBlank                         := sum(group,if(ds_data.state<>'',1,0));
			zip_code_CountNonBlank                      := sum(group,if(ds_data.zip_code<>'',1,0));
			country_CountNonBlank                       := sum(group,if(ds_data.country<>'',1,0));
			region_CountNonBlank                        := sum(group,if(ds_data.region<>'',1,0));
			med_class_CountNonBlank                     := sum(group,if(ds_data.med_class<>'',1,0));
			med_date_CountNonBlank                      := sum(group,if(ds_data.med_date<>'',1,0));
			med_exp_date_CountNonBlank                  := sum(group,if(ds_data.med_exp_date<>'',1,0));
			prim_range_CountNonBlank                    := sum(group,if(ds_data.prim_range<>'',1,0));
			predir_CountNonBlank                        := sum(group,if(ds_data.predir<>'',1,0));
			prim_name_CountNonBlank                     := sum(group,if(ds_data.prim_name<>'',1,0));
			suffix_CountNonBlank                        := sum(group,if(ds_data.suffix<>'',1,0));
			postdir_CountNonBlank                       := sum(group,if(ds_data.postdir<>'',1,0));
			unit_desig_CountNonBlank                    := sum(group,if(ds_data.unit_desig<>'',1,0));
			sec_range_CountNonBlank                     := sum(group,if(ds_data.sec_range<>'',1,0));
			p_city_name_CountNonBlank                   := sum(group,if(ds_data.p_city_name<>'',1,0));
			v_city_name_CountNonBlank                   := sum(group,if(ds_data.v_city_name<>'',1,0));
			st_CountNonBlank                            := sum(group,if(ds_data.st<>'',1,0));
			zip_CountNonBlank                           := sum(group,if(ds_data.zip<>'',1,0));
			zip4_CountNonBlank                          := sum(group,if(ds_data.zip4<>'',1,0));
			cart_CountNonBlank                          := sum(group,if(ds_data.cart<>'',1,0));
			cr_sort_sz_CountNonBlank                    := sum(group,if(ds_data.cr_sort_sz<>'',1,0));
			lot_CountNonBlank                           := sum(group,if(ds_data.lot<>'',1,0));
			lot_order_CountNonBlank                     := sum(group,if(ds_data.lot_order<>'',1,0));
			dpbc_CountNonBlank                          := sum(group,if(ds_data.dpbc<>'',1,0));
			chk_digit_CountNonBlank                     := sum(group,if(ds_data.chk_digit<>'',1,0));
			rec_type_CountNonBlank                      := sum(group,if(ds_data.rec_type<>'',1,0));
			ace_fips_st_CountNonBlank                   := sum(group,if(ds_data.ace_fips_st<>'',1,0));
			county_CountNonBlank                        := sum(group,if(ds_data.county<>'',1,0));
			county_name_CountNonBlank                   := sum(group,if(ds_data.county_name<>'',1,0));
			geo_lat_CountNonBlank                       := sum(group,if(ds_data.geo_lat<>'',1,0));
			geo_long_CountNonBlank                      := sum(group,if(ds_data.geo_long<>'',1,0));
			msa_CountNonBlank                           := sum(group,if(ds_data.msa<>'',1,0));
			geo_blk_CountNonBlank                       := sum(group,if(ds_data.geo_blk<>'',1,0));
			geo_match_CountNonBlank                     := sum(group,if(ds_data.geo_match<>'',1,0));
			err_stat_CountNonBlank                      := sum(group,if(ds_data.err_stat<>'',1,0));
			title_CountNonBlank                         := sum(group,if(ds_data.title<>'',1,0));
			fname_CountNonBlank                         := sum(group,if(ds_data.fname<>'',1,0));
			mname_CountNonBlank                         := sum(group,if(ds_data.mname<>'',1,0));
			lname_CountNonBlank                         := sum(group,if(ds_data.lname<>'',1,0));
			name_suffix_CountNonBlank                   := sum(group,if(ds_data.name_suffix<>'',1,0));
			oer_CountNonBlank                           := sum(group,if(ds_data.oer<>'',1,0));
		end;  

	tStats_reg  := table(ds_reg, rPopulationStats_ds_reg, few);
	tStats_cert := table(ds_cert,rPopulationStats_ds_cert,few);
	tStats_data := table(ds_data,rPopulationStats_ds_data,few);

	zOrig_Stats_reg  := output(choosen(tStats_reg,all));
	zOrig_Stats_cert := output(choosen(tStats_cert,all));
	zOrig_Stats_data := output(choosen(tStats_data,all));

	STRATA.createXMLStats(tStats_reg ,'FAA','Aircraft Registration BaseFile',version,'kgummadi@seisint.com,jtrost@seisint.com',zPopulation_Stats_reg, 'View','Population')
	STRATA.createXMLStats(tStats_cert,'FAA','Airmen Certificate',   version,'kgummadi@seisint.com,jtrost@seisint.com',zPopulation_Stats_cert,'View','Population')
	STRATA.createXMLStats(tStats_data,'FAA','Airmen Data',          version,'kgummadi@seisint.com,jtrost@seisint.com',zPopulation_Stats_data,'View','Population')

	STRATA.createAsHeaderStats(faa.aircraft_as_header(faa.aircraft_registration_did_ssn),'FAA','Aircraft Registration',version,'kgummadi@seisint.com,jtrost@seisint.com',zAs_Header_Stats_reg)
	STRATA.createAsHeaderStats(faa.airmen_as_header(faa.file_airmen_data_out),           'FAA','Airmen Data',          version,'kgummadi@seisint.com,jtrost@seisint.com',zAs_Header_Stats_data)
	STRATA.CreateAsBusinessHeaderStats(faa.fFAA_aircraft_reg_as_business_header(faa.file_aircraft_registration_out),'FAA','Data',version,'kgummadi@seisint.com,jtrost@seisint.com',zRunAsBusinessHeaderStats)

	return parallel(zOrig_Stats_reg
									,zOrig_Stats_cert
									,zOrig_Stats_data
									,zPopulation_Stats_reg
									,zPopulation_Stats_cert
									,zPopulation_Stats_data
									,zAs_Header_Stats_reg
									,zAs_Header_Stats_data
									,zRunAsBusinessHeaderStats
									);
end;