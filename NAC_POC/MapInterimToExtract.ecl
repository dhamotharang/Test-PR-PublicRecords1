EXPORT MapInterimToExtract(DATASET(NAC_POC.Layout_Interim) ds) := 
						PROJECT(ds, TRANSFORM(NAC_POC.Layout_Extract,
											self.LexId := Intformat(left.LexId, 12, 0);
											self.LexId_Score := Intformat(left.did_score, 3, 0);
											self.Preferred_First_Name := left.Preferred_First_Name;
											self.Clean_Client_SSN := left.clean_ssn;
											self.Clean_Client_DOB := (string)left.clean_dob;
											//
											self.city := left.v_city_name;
											self.zip5 := left.zip;
											self.longitude := left.geo_long;
											self.latitude := left.geo_lat;
											//
											self.Contributing_State := left.Case_State_Abbreviation;
											//
											self := LEFT;)
									);
