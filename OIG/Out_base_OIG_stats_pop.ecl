export Out_base_OIG_stats_pop(String pVersion) := function
import STRATA, OIG;
rPopulationStats_Oig_build:=record
						CountGroup                      				:= count(group);						
						FIRSTNAME_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.FIRSTNAME<>'',1,0));
						MIDNAME_CountNonBlank  									:=sum(group,if(OIG.Files().KeyBase.qa.MIDNAME<>'',1,0));
				 		LASTNAME_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.LASTNAME<>'',1,0));
						BUSNAME_CountNonBlank   								:=sum(group,if(OIG.Files().KeyBase.qa.BUSNAME<>'',1,0));
						GENERAL_CountNonBlank   								:=sum(group,if(OIG.Files().KeyBase.qa.GENERAL<>'',1,0));
						SPECIALTY_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.SPECIALTY<>'',1,0));
						UPIN1_CountNonBlank   									:=sum(group,if(OIG.Files().KeyBase.qa.UPIN1<>'',1,0));
						DOB_CountNonBlank   										:=sum(group,if(OIG.Files().KeyBase.qa.DOB<>'',1,0));
						ADDRESS1_CountNonBlank   								:=sum(group,if(OIG.Files().KeyBase.qa.ADDRESS1<>'',1,0));
						CITY_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa.CITY<>'',1,0));
						STATE_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa.STATE<>'',1,0));
						ZIP_CountNonBlank  											:=sum(group,if(OIG.Files().KeyBase.qa.ZIP<>'',1,0));
						SANCTYPE_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.SANCTYPE<>'',1,0));
						SANCDATE_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.SANCDATE<>'',1,0));
						REINDATE																:=sum(group,if(OIG.Files().KeyBase.qa.REINDATE<>'',1,0));
						ace_aid_CountNonBlank  									:=sum(group,if(OIG.Files().KeyBase.qa.ace_aid<>0,1,0));
						Append_RawAID_CountNonBlank  						:=sum(group,if(OIG.Files().KeyBase.qa.Append_RawAID<>0,1,0));
						Addr_Type_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.Addr_Type<>'',1,0));
						dt_vendor_first_reported_CountNonBlank 	:=sum(group,if(OIG.Files().KeyBase.qa.dt_vendor_first_reported<>'',1,0));
						dt_vendor_last_reported_CountNonBlank  	:=sum(group,if(OIG.Files().KeyBase.qa.dt_vendor_last_reported<>'',1,0));
						dt_first_seen_CountNonBlank  						:=sum(group,if(OIG.Files().KeyBase.qa.dt_first_seen<>'',1,0));
						dt_last_seen_CountNonBlank  						:=sum(group,if(OIG.Files().KeyBase.qa.dt_last_seen<>'',1,0));
						SANCDESC_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.SANCDESC<>'',1,0));
						did_countnonzero  											:=sum(group,if(OIG.Files().KeyBase.qa.did<>0,1,0));
						bdid_countnonzero  					    				:=sum(group,if(OIG.Files().KeyBase.qa.bdid<>0,1,0));
					  ssn_CountNonBlank 											:=sum(group,if(OIG.Files().KeyBase.qa. ssn<>'',1,0));
						title_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa. title<>'',1,0));
				 		fname_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa.fname<>'',1,0));
				 		mname_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa.mname<>'',1,0));
				 		lname_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa.lname<>'',1,0));
				 		name_suffix_CountNonBlank 							:=sum(group,if(OIG.Files().KeyBase.qa.name_suffix<>'',1,0));
				   	ace_fips_st_CountNonBlank  						  :=sum(group,if(OIG.Files().KeyBase.qa.ace_fips_st<>'',1,0));
						fips_county_CountNonBlank  							:=sum(group,if(OIG.Files().KeyBase.qa.fips_county<>'',1,0));
						prim_range_CountNonBlank        				:=sum(group,if(OIG.Files().KeyBase.qa.prim_range<>'',1,0));
				   	predir_CountNonBlank  									:=sum(group,if(OIG.Files().KeyBase.qa.predir<>'',1,0));
				 		prim_name_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.prim_name<>'',1,0));
				   	addr_suffix_CountNonBlank  							:=sum(group,if(OIG.Files().KeyBase.qa.addr_suffix<>'',1,0));
				   	postdir_CountNonBlank  									:=sum(group,if(OIG.Files().KeyBase.qa.postdir<>'',1,0));
				 		unit_desig_CountNonBlank  							:=sum(group,if(OIG.Files().KeyBase.qa.unit_desig<>'',1,0));
				   	sec_range_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.sec_range<>'',1,0));
				 		p_city_name_CountNonBlank  							:=sum(group,if(OIG.Files().KeyBase.qa.p_city_name<>'',1,0));
				 		v_city_name_CountNonBlank  							:=sum(group,if(OIG.Files().KeyBase.qa.v_city_name<>'',1,0));
				   	st_CountNonBlank  											:=sum(group,if(OIG.Files().KeyBase.qa.st<>'',1,0));
				   	cart_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa.cart<>'',1,0));
						cr_sort_sz_CountNonBlank  							:=sum(group,if(OIG.Files().KeyBase.qa.cr_sort_sz<>'',1,0));
				   	lot_CountNonBlank  											:=sum(group,if(OIG.Files().KeyBase.qa.lot<>'',1,0));
					  lot_order_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.lot_order<>'',1,0));
				   	dpbc_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa.dpbc<>'',1,0));
				  	chk_digit_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.chk_digit<>'',1,0));
				   	addr_rec_type_CountNonBlank  						:=sum(group,if(OIG.Files().KeyBase.qa.addr_rec_type<>'',1,0));
				   	fips_state_CountNonBlank  							:=sum(group,if(OIG.Files().KeyBase.qa.fips_state<>'',1,0));
				   	rec_type_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.rec_type<>'',1,0));
				 		county_CountNonBlank  									:=sum(group,if(OIG.Files().KeyBase.qa.county<>'',1,0));
				 		geo_lat_CountNonBlank  									:=sum(group,if(OIG.Files().KeyBase.qa.geo_lat<>'',1,0));
				 		geo_long_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.geo_long<>'',1,0));
				   	cbsa_CountNonBlank  										:=sum(group,if(OIG.Files().KeyBase.qa.cbsa<>'',1,0));
				   	msa_CountNonBlank  											:=sum(group,if(OIG.Files().KeyBase.qa.msa<>'',1,0));
				   	geo_blk_CountNonBlank  									:=sum(group,if(OIG.Files().KeyBase.qa.geo_blk<>'',1,0));
				   	geo_match_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.geo_match<>'',1,0));
				   	err_stat_CountNonBlank  								:=sum(group,if(OIG.Files().KeyBase.qa.err_stat<>'',1,0));
					//BIPV2 fields have been added for Strata
						DotID_CountNonZeros	                 		:= sum(group,if(OIG.Files().KeyBase.qa.DotID<>0,1,0));
						DotScore_CountNonZeros	               	:= sum(group,if(OIG.Files().KeyBase.qa.DotScore<>0,1,0));
						DotWeight_CountNonZeros	             		:= sum(group,if(OIG.Files().KeyBase.qa.DotWeight<>0,1,0));
						EmpID_CountNonZeros	                   	:= sum(group,if(OIG.Files().KeyBase.qa.EmpID<>0,1,0));
						EmpScore_CountNonZeros	             		:= sum(group,if(OIG.Files().KeyBase.qa.EmpScore<>0,1,0));
						EmpWeight_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.EmpWeight<>0,1,0));
						POWID_CountNonZeros	                    := sum(group,if(OIG.Files().KeyBase.qa.POWID<>0,1,0));
						POWScore_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.POWScore<>0,1,0));
						POWWeight_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.POWWeight<>0,1,0));
						ProxID_CountNonZeros	                  := sum(group,if(OIG.Files().KeyBase.qa.ProxID<>0,1,0));
						ProxScore_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.ProxScore<>0,1,0));
						ProxWeight_CountNonZeros	              := sum(group,if(OIG.Files().KeyBase.qa.ProxWeight<>0,1,0));
						SeleID_CountNonZeros	                  := sum(group,if(OIG.Files().KeyBase.qa.SeleID<>0,1,0));
						SeleScore_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.SeleScore<>0,1,0));
						SeleWeight_CountNonZeros	              := sum(group,if(OIG.Files().KeyBase.qa.SeleWeight<>0,1,0));
						OrgID_CountNonZeros	                    := sum(group,if(OIG.Files().KeyBase.qa.OrgID<>0,1,0));
						OrgScore_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.OrgScore<>0,1,0));
						OrgWeight_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.OrgWeight<>0,1,0));
						UltID_CountNonZeros	                    := sum(group,if(OIG.Files().KeyBase.qa.UltID<>0,1,0));
						UltScore_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.UltScore<>0,1,0));
						UltWeight_CountNonZeros	                := sum(group,if(OIG.Files().KeyBase.qa.UltWeight<>0,1,0));
  
end;


dPopulationStats_Oig_build := table(OIG.Files().KeyBase.qa,
																		rPopulationStats_Oig_build, 
																		few);

STRATA.createXMLStats(dPopulationStats_Oig_build,
                       OIG._Dataset().name,
											'OIG_Base',
											pVersion,
											'',
											resultsOut,
											'view',
											'population'
										 );
					 
return resultsOut;
 
end;