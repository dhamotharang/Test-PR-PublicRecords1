IMPORT address, ut, standard;

EXPORT fnCreateBase_Batch(string version = ut.GetDate) := FUNCTION

Current_Base := project(InstantID_Archiving.Files_Base_batch.key_files,
                        transform(InstantID_Archiving.Layout_Base, 
												self.lname := trim(stringlib.stringfindreplace(LEFT.lname, 'NULL', ''), left, right),
												self := left));

InstantID_Key := PROJECT(InstantID_Archiving.Files_Batch.InstantID_Key, 
									TRANSFORM(InstantID_Archiving.Layout_Base,
												SELF.transaction_id_key := HASH(LEFT.transaction_id);
												SELF.product := 'INSTANTID';
												SELF.orig_fname := LEFT.fname;
												SELF.orig_lname := LEFT.lname;
												SELF.orig_address := LEFT.address;
												SELF.orig_city := LEFT.city;
												SELF.orig_state := LEFT.state;
												SELF.orig_zip := LEFT.zip;
												SELF.orig_dob := LEFT.dob;
												SELF.orig_ssn := LEFT.ssn;
												SELF := LEFT;
												SELF := [])):persist('~thor_data400::persist::instantid_archive::batch_instantID_key');
																								
FlexID_Key := PROJECT(InstantID_Archiving.Files_Batch.FlexID_Key, 
									TRANSFORM(InstantID_Archiving.Layout_Base,
												SELF.transaction_id_key := HASH(TRIM(LEFT.transaction_id, LEFT, RIGHT));
												SELF.product := 'FLEXID';
												SELF.orig_fname := LEFT.fname;
												SELF.orig_lname := LEFT.lname;
												SELF.orig_address := LEFT.address;
												SELF.orig_city := LEFT.city;
												SELF.orig_state := LEFT.state;
												SELF.orig_zip := LEFT.zip;
												SELF.orig_dob := LEFT.dob;
												SELF.orig_ssn := LEFT.ssn;
												SELF := LEFT;
												SELF := [])):persist('~thor_data400::persist::instantid_archive::batch_flexID_key');

Key_Files_Concat := FlexID_Key + InstantID_Key;

New_Base := PROJECT(Key_Files_Concat, TRANSFORM(InstantID_Archiving.Layout_Base,
											
												CleanName := address.CleanPerson73_Fields(LEFT.orig_fname + ' ' + trim(stringlib.stringfindreplace(LEFT.orig_lname, 'NULL', ''), left, right));
												SELF.TITLE := CleanName.TITLE;
												SELF.FNAME := CleanName.Fname;
												SELF.LNAME := CleanName.Lname;
												SELF.MNAME := CleanName.Mname;
												SELF.NAME_Suffix := CleanName.NAME_Suffix;											
												SELF.FNAME2 := LEFT.orig_Fname;
												SELF.LNAME2 := LEFT.orig_Lname;
												SELF.SSN := STRINGLIB.STRINGFILTER(LEFT.orig_ssn, '0123456789');
												SELF.DOB := STRINGLIB.STRINGFILTER(LEFT.orig_dob, '0123456789');
												SELF.date_added := STRINGLIB.STRINGFILTER(LEFT.date_added, ' 0123456789');
												
												CleanAddress := Address.CleanAddressParsed(LEFT.orig_address_number + ' ' + LEFT.orig_address, LEFT.orig_city + ' ' + LEFT.orig_state + ' ' + LEFT.orig_zip);
												SELF.prim_range := CleanAddress.prim_range;
												SELF.predir := CleanAddress.predir;
												SELF.prim_name := CleanAddress.prim_name;
												SELF.addr_suffix := CleanAddress.addr_suffix;
												SELF.postdir := CleanAddress.postdir;
												SELF.unit_desig := CleanAddress.unit_desig;
												SELF.sec_range := CleanAddress.sec_range;
												SELF.v_city_name := CleanAddress.v_city_name;
												SELF.st := CleanAddress.st;
												SELF.zip5 := CleanAddress.zip;
												SELF.zip4 := CleanAddress.zip4;
												SELF.addr_rec_type := CleanAddress.rec_type;
												SELF.fips_state := CleanAddress.fips_state;
												SELF.fips_county := CleanAddress.fips_county;
												SELF.geo_lat := CleanAddress.geo_lat;
												SELF.geo_long := CleanAddress.geo_long;
												SELF.geo_blk := CleanAddress.geo_blk;
												SELF.geo_match := CleanAddress.geo_match;
												SELF.err_stat := CleanAddress.err_stat;
													
												ParseAddress := Address.CleanAddressFieldsFips(datalib.AddressClean(LEFT.orig_address_number + ' ' + LEFT.orig_address, LEFT.orig_city + ' ' + LEFT.orig_state + ' ' + LEFT.orig_zip));
												SELF.prim_range2 := ParseAddress.prim_range;
												SELF.predir2 := ParseAddress.predir;
												SELF.prim_name2 := ParseAddress.prim_name;
												SELF.addr_suffix2 := ParseAddress.addr_suffix;
												SELF.postdir2 := ParseAddress.postdir;
												SELF.unit_desig2 := ParseAddress.unit_desig;
												SELF.sec_range2 := ParseAddress.sec_range;
												SELF.v_city_name2 := ParseAddress.p_city_name;
												SELF.st2 := ParseAddress.v_city_name[..2];
												SELF.zip52 := ParseAddress.v_city_name[3..7];
												SELF.zip42 := ParseAddress.v_city_name[8..11];
												SELF.cvi := if(LEFT.cvi = '00', '0', LEFT.cvi);
												SELF.dob_verified := if(LEFT.dob_verified = 'Y', '1', if(LEFT.dob_verified = 'N', '0', LEFT.dob_verified));						
												SELF := LEFT));

Combined_Base := DEDUP(SORT(DISTRIBUTE(New_Base + Current_Base, HASH(transaction_id, product, source, date_added)),
										transaction_id, product, source, date_added, LOCAL),
										transaction_id, product, source, date_added, LOCAL);

RETURN Combined_Base;
END;