EXPORT FN_Clean_Decrypted (dataset(Inql_FFD.Layouts.Base) daily_base,
                           dataset(Inql_FFD.Layouts.Input_Decrypted) Input_Decrypted ):= Function
													 
 dBase 			:= distribute(daily_base,hash(transaction_id));
 dDecrypted := distribute(Input_Decrypted, hash(transaction_id));
  
 rJoin:=record
    recordof(dBase);
		recordof(dDecrypted);
 end;
 base_no_decrypted := join(dBase, dDecrypted, 
                                 left.transaction_id = right.transaction_id,
																 transform(rJoin,
											         						self.ssn	:= if(right.transaction_id<>'','',left.ssn);
																					self.drivers_license_number	:= if(right.transaction_id<>'','',left.drivers_license_number);
																					self.drivers_license_state	:= if(right.transaction_id<>'','',left.drivers_license_state);
																					self.name_first	:= if(right.transaction_id<>'','',left.name_first);
																					self.name_last	:= if(right.transaction_id<>'','',left.name_last);
																					self.name_middle	:= if(right.transaction_id<>'','',left.name_middle);
																					self.name_suffix	:= if(right.transaction_id<>'','',left.name_suffix);
																					self.addr_street	:= if(right.transaction_id<>'','',left.addr_street);
																					self.addr_city	:= if(right.transaction_id<>'','',left.addr_city);
																					self.addr_state	:= if(right.transaction_id<>'','',left.addr_state);
																					self.addr_zip5	:= if(right.transaction_id<>'','',left.addr_zip5);
																					self.addr_zip4	:= if(right.transaction_id<>'','',left.addr_zip4);
																					self.dob	:= if(right.transaction_id<>'','',left.dob);
																					self.email_addr	:= if(right.transaction_id<>'','',left.email_addr);
																					self.state_id_number	:= if(right.transaction_id<>'','',left.state_id_number);
																					self.state_id_state	:= if(right.transaction_id<>'','',left.state_id_state);
																					self.eu_company_name	:= if(right.transaction_id<>'','',left.eu_company_name);
																					self.eu_addr_street	:= if(right.transaction_id<>'','',left.eu_addr_street);
																					self.eu_addr_city	:= if(right.transaction_id<>'','',left.eu_addr_city);
																					self.eu_addr_state	:= if(right.transaction_id<>'','',left.eu_addr_state);
																					self.eu_addr_zip5	:= if(right.transaction_id<>'','',left.eu_addr_zip5);
																					self.eu_phone_nbr	:= if(right.transaction_id<>'','',left.eu_phone_nbr);
																					self.phone_nbr	:= if(right.transaction_id<>'','',left.phone_nbr);
																					self.title := if(right.transaction_id<>'','',left.title );
																					self.fname := if(right.transaction_id<>'','',left.fname );
																					self.mname := if(right.transaction_id<>'','',left.mname );
																					self.lname := if(right.transaction_id<>'','',left.lname );
																					//self.name_suffix := if(right.transaction_id<>'','',left.name_suffix );
																					self.name_score := if(right.transaction_id<>'','',left.name_score );
																					self.prim_range  := if(right.transaction_id<>'','',left.prim_range  );
																					self.predir  := if(right.transaction_id<>'','',left.predir  );
																					self.prim_name  := if(right.transaction_id<>'','',left.prim_name  );
																					self.addr_suffix  := if(right.transaction_id<>'','',left.addr_suffix  );
																					self.postdir  := if(right.transaction_id<>'','',left.postdir  );
																					self.unit_desig  := if(right.transaction_id<>'','',left.unit_desig  );
																					self.sec_range  := if(right.transaction_id<>'','',left.sec_range  );
																					self.v_city_name  := if(right.transaction_id<>'','',left.v_city_name  );
																					self.st  := if(right.transaction_id<>'','',left.st  );
																					self.zip5  := if(right.transaction_id<>'','',left.zip5  );
																					self.zip4  := if(right.transaction_id<>'','',left.zip4  );
																					self.addr_rec_type := if(right.transaction_id<>'','',left.addr_rec_type);
																					self.fips_state := if(right.transaction_id<>'','',left.fips_state );
																					self.fips_county := if(right.transaction_id<>'','',left.fips_county );
																					self.geo_lat  := if(right.transaction_id<>'','',left.geo_lat  );
																					self.geo_long  := if(right.transaction_id<>'','',left.geo_long  );
																					self.cbsa  := if(right.transaction_id<>'','',left.cbsa  );
																					self.geo_blk  := if(right.transaction_id<>'','',left.geo_blk  );
																					self.geo_match  := if(right.transaction_id<>'','',left.geo_match  );
																					self.err_stat := if(right.transaction_id<>'','',left.err_stat );
																				  self := left;
																					self := right;),
																 left outer);
return base_no_decrypted;
												 
end;

