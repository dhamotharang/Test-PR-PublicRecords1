IMPORT LN_PropertyV2;

EXPORT FCRA_compliance_MAC (isFCRA,in_file,outfile) := MACRO
						 
						 #uniquename(transformed)
			       %transformed% := project(project(in_file,TRANSFORM(
						 
						 
						 {recordof(in_file) or 
									{
										// deeds
										string3	 ln_ownership_rights;
									  string2	 ln_relationship_type;
									  string3	 ln_buyer_mailing_country_code;
									  string3	 ln_seller_mailing_country_code;
										// assessments
										//string3	 ln_ownership_rights;
										//string2	 ln_relationship_type;
										string3	 ln_mailing_country_code;
										string50 ln_property_name;
										string1	 ln_property_name_type;
										string1	 ln_land_use_category;
										string20 ln_lot;
										string20 ln_block;
										string6	 ln_unit;
										string1  ln_subfloor;
										string3  ln_floor_cover;
										string1	 ln_mobile_home_indicator;
										string1	 ln_condo_indicator;
										string1	 ln_property_tax_exemption;
										string1	 ln_veteran_status;
										string1	 ln_old_apn_indicator;
										// search
										string2		ln_party_status :='';
										string6		ln_percentage_ownership :='';
										string2		ln_entity_type := '';
										string8		ln_estate_trust_date :='';
										string1		ln_goverment_type := '';
									}
							}, 
								
									// deeds	 
								  SELF.ln_ownership_rights :='';
								  SELF.ln_relationship_type :='';
								  SELF.ln_buyer_mailing_country_code :='';
								  SELF.ln_seller_mailing_country_code :=''; 
									// assessments
									//SELF.ln_ownership_rights := '';
									//SELF.ln_relationship_type := '';
									SELF.ln_mailing_country_code := '';
									SELF.ln_property_name := '';
									SELF.ln_property_name_type := '';
									SELF.ln_land_use_category := '';
									SELF.ln_lot := '';
									SELF.ln_block := '';
									SELF.ln_unit := '';
									SELF.ln_subfloor := '';
									SELF.ln_floor_cover := '';
									SELF.ln_mobile_home_indicator := '';
									SELF.ln_condo_indicator := '';
									SELF.ln_property_tax_exemption := '';
									SELF.ln_veteran_status := '';
									SELF.ln_old_apn_indicator := '';
									// search
									SELF.ln_party_status :='';
									SELF.ln_percentage_ownership :='';
									SELF.ln_entity_type := '';
									SELF.ln_estate_trust_date :='';
									SELF.ln_goverment_type := '';
									// defaults
									SELF := LEFT;
									SELF := [];
						     
						 
												)),recordof(in_file));
												
						 outfile := if(isFCRA,%transformed%(ln_fares_id[1] !='R' AND ln_fares_id[1..2] !='OM'),in_file);
ENDMACRO;