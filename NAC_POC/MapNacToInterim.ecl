import NAC;
// map to intermediate format
EXPORT MapNacToInterim(DATASET(Nac.Layouts.base) ds) := 
				PROJECT(ds, TRANSFORM(layout_Interim,
								//self.LexId := left.did;
								//self.LexId_Score := left.did_score;
								self.Preferred_First_Name := left.prefname;
								self.clean_ssn := left.clean_ssn;
								self.clean_dob := left.clean_dob;
								//
								//self.city := left.v_city_name;
								//self.zip5 := left.zip;
								self.FIPS_State := left.fips_county;
								self.FIPS_County := left.county;
								//self.longitude := left.geo_long;
								//self.latitude := left.geo_lat;
								//
								//self.Contributing_State := left.Case_State_Abbreviation;
								//
								self.record_id := left.Case_State_Abbreviation + 
											(string)hash64(left.Case_Benefit_Type, left.case_identifier, left.client_identifier);
								self := LEFT;));
						