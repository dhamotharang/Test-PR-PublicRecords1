import ut;

export fn_append_consumer(dataset(recordof(ibehavior.layout_consumer_search)) int0)
	:=
function

recordof(int0) t_append_puid(recordof(int0) pInput) := transform
self.persistent_record_id 	:= HASH64(TRIM(pInput.IB_Individual_ID)+','
																		+ TRIM(pInput.IB_Household_ID)+','
																		+ TRIM(pInput.title)+','
																		+ TRIM(pInput.fname)+','
																		+ TRIM(pInput.mname)+','
																		+ TRIM(pInput.lname)+','
																		+ TRIM(pInput.name_suffix)+','
																		+ TRIM(pInput.prim_range)+','
																		+ TRIM(pInput.predir)+','
																		+ TRIM(pInput.prim_name)+','
																		+ TRIM(pInput.addr_suffix)+','
																		+ TRIM(pInput.postdir)+','
																		+ TRIM(pInput.unit_desig)+','
																		+ TRIM(pInput.sec_range)+','
																		+ TRIM(pInput.p_city_name)+','
																		+ TRIM(pInput.st)+','
																		+ TRIM(pInput.zip5)+','
																		+ TRIM(pInput.zip4)+','
																		+ TRIM(pInput.cart)+','
																		+ TRIM(pInput.county)+','
																		+ TRIM(pInput.geo_lat)+','
																		+ TRIM(pInput.geo_long)+','
																		+ TRIM(pInput.phone_1)+','
																		+ TRIM(pInput.phone_2));											

		self								:=	pInput;
	END;
										

p_append_puid := project(int0,t_append_puid(left));

return p_append_puid;

end;