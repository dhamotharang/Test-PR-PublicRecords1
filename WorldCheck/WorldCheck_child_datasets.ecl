import WorldCheck, lib_stringlib, address;

export WorldCheck_child_datasets(string filedate) := function

// Child record layouts
layout_POB           := WorldCheck.Layout_WorldCheck_Cleaned.layout_POB;
layout_Passports     := WorldCheck.Layout_WorldCheck_Cleaned.layout_Passports;
layout_Countries     := WorldCheck.Layout_WorldCheck_Cleaned.layout_Countries;
layout_Companies     := WorldCheck.Layout_WorldCheck_Cleaned.layout_Companies;
layout_Linked_To_IDs := WorldCheck.Layout_WorldCheck_Cleaned.layout_Linked_To_IDs;
layout_Keywords      := WorldCheck.Layout_WorldCheck_Cleaned.layout_Keywords;

layout_Ext_Sources := WorldCheck.Layout_WorldCheck_Ext_Sources;

Layout_WorldCheck_rollup := record, maxlength(30900)
    string  UID;
end;

Layout_out := 	WorldCheck.Layout_WorldCheck_Cleaned.Layout_WorldCheck_Main;

// File from which to have the child datasets constructed
in_file := sort(distribute(WorldCheck.File_WorldCheck_In, hash32(uid)), uid, local);
// File to which the child datasets will be joined upon completion
in_file_normalized := sort(distribute(WorldCheck.File_WorldCheck_In_Normalized, hash32(uid)), uid, local);

// Shared parsing patterns for most
pattern SingleValue   := pattern('[^;]+');

// Invalid values which should be skipped
Invalid_Values        := [''             ,','
						 ,'NONE'         ,'N/A'
						 ,'NOT AVAILABLE','UNAVAILABLE'
						 ,'UNKNOWN'      ,'NONE REPORTED'];

/* Normalize and rollup Places of Birth */
POB_out       := WorldCheck.Normalize_and_Rollup_POBs(filedate);
/* Normalize and rollup Passports */
Passport_out  := WorldCheck.Normalize_and_Rollup_Passports(filedate);
/* Normalize and rollup Countries */
Country_Out   := WorldCheck.Normalize_and_Rollup_Countries(filedate);
/* Normalize and rollup Companies */
Company_Out   := WorldCheck.Normalize_and_Rollup_Companies(filedate);
/* Normalize and rollup Linked To Parties */
Linked_To_out := WorldCheck.Normalize_and_Rollup_Linked_To_IDs(filedate);
/* Normalize and rollup Keywords (including joining to the keyword list) */
Keyword_out   := WorldCheck.Normalize_and_Rollup_Keywords(filedate);

/* Join the various datasets into a single layout */
Layout_Join_Normalized := record, maxlength(30900)
    string  UID;
	unsigned8 key;
	string255 name_orig;
	string1   Name_Type;
    string  Last_Name;
    string  First_Name;
    string  Category;
    string  Title;
    string  Sub_Category;
    string  Position;
    string  Age;
    string  Date_Of_Birth;
    string  Date_Of_Death;
	string  Social_Security_Number;
    string  Location;
    string  E_I_Ind;
    string5000  Further_Information;
    string  Entered;
    string  Updated;
    string  Editor;
    string  Age_As_Of_Date;
end;

/* Join the POB data to the normalized primary records */
	Layout_Join_POB := record, maxlength(30900)
		Layout_Join_Normalized;
		dataset(layout_POB) POB_detail;
	end;

	Layout_Join_POB join_POB(in_file_normalized L
							,POB_out            R) := TRANSFORM
	   self.POB_detail := R.POB_detail;
	   self            := L;
	end;

	jn_POB := JOIN(in_file_normalized
				 ,POB_out
				 ,left.UID = right.UID
				 ,join_POB(left,right)
				 ,LOCAL
				 ,LEFT OUTER);
				 
	j_POB	:= sort(distribute(jn_POB, hash32(uid)), uid, local);
	
/* End join of the POB data*/

/* Join the Passport data to the normalized primary records */
	Layout_Join_Passport := record, maxlength(30900)
		Layout_Join_POB;
		dataset(layout_Passports) Passport_detail;
	end;

	Layout_Join_Passport join_Passport(j_POB        L
							          ,Passport_out R) := TRANSFORM
	   self.Passport_detail := R.Passport_detail;
	   self                 := L;
	end;

	jn_Passport := JOIN(j_POB
					  ,Passport_out
					  ,left.UID = right.UID
					  ,join_Passport(left,right)
				      ,LOCAL
					  ,LEFT OUTER);
					  
	j_Passport	:= sort(distribute(jn_Passport, hash32(uid)), uid, local);
	
/* End join of the Passport data*/

/* Join the Country data to the normalized primary records */
	Layout_Join_Country := record, maxlength(30900)
		Layout_Join_Passport;
		dataset(layout_Countries) Country_detail;
	end;

	Layout_Join_Country join_Country(j_Passport  L
							        ,Country_out R) := TRANSFORM
	   self.Country_detail := R.Country_detail;
	   self                := L;
	end;

	jn_Country := JOIN(j_Passport
					  ,Country_out
					  ,left.UID = right.UID
					  ,join_Country(left,right)
				      ,LOCAL
					  ,LEFT OUTER);
	
	j_Country	:= sort(distribute(jn_Country, hash32(uid)), uid, local);
	
/* End join of the Country data*/

/* Join the Company data to the normalized primary records */
	Layout_Join_Company := record, maxlength(30900)
		Layout_Join_Country;
		dataset(layout_Companies) Company_detail;
	end;

	Layout_Join_Company join_Company(j_Country   L
							        ,Company_out R) := TRANSFORM
	   self.Company_detail := R.Company_detail;
	   self                := L;
	end;

	jn_Company := JOIN(j_Country
					 ,Company_out
					 ,left.UID = right.UID
					 ,join_Company(left,right)
				     ,LOCAL
					 ,LEFT OUTER);
					 
	j_Company := sort(distribute(jn_Company, hash32(uid)), uid, local);				 
	
/* End join of the Company data*/

/* Join the Linked To data to the normalized primary records */
	Layout_Join_Linked_To := record, maxlength(30900)
		Layout_Join_Company;
		dataset(layout_Linked_To_IDs) Linked_To_detail;
	end;

	Layout_Join_Linked_To join_Linked_To(j_Company     L
							            ,Linked_To_out R) := TRANSFORM
	   self.Linked_To_detail := R.Linked_To_detail;
	   self                  := L;
	end;

	jn_Linked_To := JOIN(j_Company
					   ,Linked_To_out
					   ,left.UID = right.UID
					   ,join_Linked_To(left,right)
				       ,LOCAL
					   ,LEFT OUTER);
					   
	j_Linked_To := sort(distribute(jn_Linked_To, hash32(uid)), uid, local);				   
	
/* End join of the Linked To data*/

/* Join the Keyword data to the normalized primary records */
	Layout_Join_Keyword := record, maxlength(30900)
		Layout_Join_Linked_To;
		dataset(layout_Keywords) Keyword_detail;
	end;

	Layout_Join_Keyword join_Keyword(j_Linked_To L
							        ,Keyword_out R) := TRANSFORM
	   self.Keyword_detail := R.Keyword_detail;
	   self                := L;
	end;

	j_all_data := JOIN(j_Linked_To
					  ,Keyword_out
					  ,left.UID = right.UID
					  ,join_Keyword(left,right)
				      ,LOCAL
					  ,LEFT OUTER);
/* End join of the Keyword data*/

// output(j_all_data,,'~thor_data400::eschel::temp::joined_worldcheck',overwrite);

Layout_out t_clean_out(j_all_data L) := TRANSFORM
    // Capture the clean name values
    string temp_pname  := if(L.e_i_ind = 'I'
	                        ,address.CleanPersonLFM73(L.Name_Orig)
							,'');
    // Find the comma within the full names for parsing into first and last when not already parsed
    unsigned integer4 name_comma := if(L.e_i_ind = 'I'
	                                  ,lib_stringlib.StringLib.StringFind(L.Name_Orig
	                                                                     ,','
																		 ,1)
		                              ,0);
    // Strip stray commas from the end of company names and change them to all capitals
	string temp_cname  :=  if(L.e_i_ind = 'E'
	                         ,regexreplace(',$',trim(lib_stringlib.StringLib.StringToUpperCase(L.Name_Orig),left,right),'')
							 ,'');
	// Determine the location of the values needed to parse and process the location information
	unsigned integer4 tilda_one := lib_stringlib.StringLib.StringFind(L.Location
	                                                                    ,'~'
																		,1);
    unsigned integer4 comma     := lib_stringlib.StringLib.StringFind(L.Location
	                                                                    ,','
	                                                                    ,1);
    unsigned integer4 tilda_two := lib_stringlib.StringLib.StringFind(L.Location
	                                                                    ,'~'
	                                                                    ,2);
	string temp_Address_1  := trim(L.location[1..tilda_one - 1],left,right);
	string temp_Address_2  := trim(L.location[tilda_one + 1..comma - 1],left,right);
	string temp_Address_3  := trim(lib_stringlib.StringLib.StringFilterOut(L.location[comma + 1..tilda_two - 1],'~,'),left,right);
    string30 temp_Address1 := if(lib_stringlib.StringLib.StringFind(temp_Address_1,',',1) > 0
	                            ,''
								,temp_Address_1); 
    string30  temp_Address2 := if(lib_stringlib.StringLib.StringFind(temp_Address_1,',',1) > 0
	                             ,trim(temp_Address_1[1..lib_stringlib.StringLib.StringFind(temp_Address_1,',',1)-1],left,right)
				  				 ,temp_Address_2);
		temp_Addr_Country := trim(L.location[tilda_two + 1..],left,right);
	string30 temp_address_country := if(DataLib.StringFind(temp_Addr_Country, ',', 1) > 0,
										trim(temp_Addr_Country[DataLib.StringFind(temp_Addr_Country, ',', 1)+1..length(trim(temp_Addr_Country, left, right))], left, right),
										temp_Addr_Country);
	// Capture the clean address values
	string182 tempAddressReturn    := address.CleanAddress182(temp_Address1
	                                                                            ,temp_Address2 + ' ' + temp_Address_3 + ' ' + temp_Address_Country);
	
    self.UID             := (integer)L.UID;
	self.WC_Title        := L.Title;
	self.date_of_birth   := if(trim(L.age_as_of_date,left,right)<>'' 
							and trim(L.date_of_birth,left,right)='' 
							and trim(L.age,left,right) between '18' and '95'
							and (trim(L.age_as_of_date,left,right)[1..2] between '19' and '20') 
							and length(trim(L.age_as_of_date[1..4],left,right))=4,
							(string)((integer)L.age_as_of_date[1..4]-(integer)L.age),
							lib_stringlib.StringLib.StringFilterOut(L.date_of_birth,'/'));
	self.date_of_death   := lib_stringlib.StringLib.StringFilterOut(L.date_of_death,'/');
	self.entered         := lib_stringlib.StringLib.StringFilterOut(L.entered,'/');
	self.updated         := lib_stringlib.StringLib.StringFilterOut(L.updated,'/');
	self.Last_Name       := lib_stringlib.StringLib.StringToUpperCase(if(L.E_I_Ind    = 'I' 
	                                                                 AND name_comma   >  0
																	 AND L.name_type != '0'
	                                                                    ,trim(L.Name_Orig[1..name_comma-1],left,right)
																		,if(L.E_I_Ind    = 'I' 
	                                                                    AND name_comma   =  0
																		AND L.name_type != '0'
																		   ,trim(L.Name_Orig,left,right)
																		   ,if(L.name_type = '0'
																		   AND L.E_I_Ind   = 'I'
																		      ,L.Last_Name
																			  ,''))));
	self.First_Name      := lib_stringlib.StringLib.StringToUpperCase(if(L.E_I_Ind    = 'I' 
	                                                                 AND name_comma   >  0
																	 AND L.name_type != '0'
	                                                                    ,trim(L.Name_Orig[name_comma+1..255],left,right)
																		,if(L.name_type = '0'
																		AND L.E_I_Ind   = 'I'
																		   ,L.First_Name
																		   ,'')));

    self.title           := temp_pname[1..5];
	self.fname           := temp_pname[6..25];
	self.mname           := temp_pname[26..45];
	self.lname           := temp_pname[46..65];
	self.name_suffix     := temp_pname[66..70];
	self.name_score      := temp_pname[71..73];
	self.cname           := temp_cname;
	self.Address_1       := temp_Address1;
	self.Address_2       := temp_Address_2;
	self.Address_3       := if(trim(temp_Address_3,left,right) = trim(temp_Address_2,left,right)
	                          ,''
							  ,temp_Address_3);
	self.Address_Country := temp_Address_Country;
	self.prim_range      := tempAddressReturn[1..10];
	self.predir 	     := tempAddressReturn[11..12];
	self.prim_name 	  	 := tempAddressReturn[13..40];
	self.addr_suffix  	 := tempAddressReturn[41..44];
	self.postdir 	     := tempAddressReturn[45..46];
	self.unit_desig   	 := tempAddressReturn[47..56];
	self.sec_range 	  	 := tempAddressReturn[57..64];
	self.p_city_name  	 := tempAddressReturn[65..89];
	self.v_city_name  	 := tempAddressReturn[90..114];
	self.st 			 := tempAddressReturn[115..116];
	self.zip5		     := tempAddressReturn[117..121];
	self.zip4 		     := tempAddressReturn[122..125];
	self.cart 		     := tempAddressReturn[126..129];
	self.cr_sort_sz   	 := tempAddressReturn[130];
	self.lot 		     := tempAddressReturn[131..134];
	self.lot_order 	  	 := tempAddressReturn[135];
	self.dpbc 		     := tempAddressReturn[136..137];
	self.chk_digit 	  	 := tempAddressReturn[138];
	self.addr_rec_type   := tempAddressReturn[139..140];
	self.fips_state  	 := tempAddressReturn[141..142];
	self.fips_county  	 := tempAddressReturn[143..145];
	self.geo_lat 	     := tempAddressReturn[146..155];
	self.geo_long 	  	 := tempAddressReturn[156..166];
	self.cbsa 		     := tempAddressReturn[167..170];
	self.geo_blk   	  	 := tempAddressReturn[171..177];
	self.geo_match 	  	 := tempAddressReturn[178];
	self.err_stat 	  	 := tempAddressReturn[179..182];
	self                 := L;
end;

final_output := project(j_all_data, t_clean_out(LEFT));

// return output(final_output,,'~thor_data400::out::WorldCheck::' + filedate + '::Main_Cleaned',overwrite);
return final_output;

end;