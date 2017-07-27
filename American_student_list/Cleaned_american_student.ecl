import Address, lib_stringlib;


American_student_list.layout_american_student_base CleanAmericanStudent(American_student_list.layout_american_student_base InputRecord) := transform
	string73 tempName := stringlib.StringToUpperCase(if(trim(trim(InputRecord.First_Name,left,right) + ' ' +
															 trim(InputRecord.Last_Name,left,right),left,right) <> '',
														 Address.CleanPerson73(trim(trim(InputRecord.Last_Name,left,right) + ', ' +
		                                                                            trim(InputRecord.First_Name,left,right),left,right)),
														if(trim(InputRecord.Full_Name,left,right) <> '',
														    Address.CleanPerson73(trim(InputRecord.Full_Name,left,right)),
															'')));
															
	string182 tempAddress := stringlib.StringToUpperCase(if(InputRecord.ADDRESS_1 <> '' or 
	                                                        InputRecord.ADDRESS_2 <> '' or
															InputRecord.CITY <> '' or
															InputRecord.STATE <> '' or
															InputRecord.ZIP <> '',
														 Address.CleanAddress182(trim(trim(InputRecord.Address_1,left,right) + ' ' + 
														                              trim(InputRecord.Address_2,left,right),
																					  left,right),
														                         trim(trim(InputRecord.City,left,right) + ', ' +
																				      trim(InputRecord.State,left,right) + ' ' +
																					  trim(InputRecord.ZIP,left,right) +
																					  trim(InputRecord.ZIP_4,left,right),left,right)),
																			    ''));
		
	self.title			      		:= tempName[1..5];
	self.fname			      		:= tempName[6..25];
	self.mname			      		:= tempName[26..45];
	self.lname			      		:= tempName[46..65];
	self.name_suffix	    		:= tempName[66..70];
	self.name_score					:= tempName[71..73];
	self.prim_range    				:= tempAddress[1..10];
	self.predir 	      			:= tempAddress[11..12];
	self.prim_name 	  				:= tempAddress[13..40];
	self.addr_suffix   				:= tempAddress[41..44];
	self.postdir 	    			:= tempAddress[45..46];
	self.unit_desig 	  			:= tempAddress[47..56];
	self.sec_range 	  				:= tempAddress[57..64];
	self.p_city_name	  			:= tempAddress[65..89];
	self.v_city_name	  			:= tempAddress[90..114];
	self.st 			      		:= tempAddress[115..116];
	self.zip 		      			:= tempAddress[117..121];
	self.zip4 		      			:= tempAddress[122..125];
	self.cart 		      			:= tempAddress[126..129];
	self.cr_sort_sz 	 		 	:= tempAddress[130];
	self.lot 		      			:= tempAddress[131..134];
	self.lot_order 	  				:= tempAddress[135];
	self.dpbc 		      			:= tempAddress[136..137];
	self.chk_digit 	  				:= tempAddress[138];
	self.rec_type		  			:= tempAddress[139..140];
	self.ace_fips_st	  			:= tempAddress[141..142];
	self.fips_county 	  			:= tempAddress[143..145];
	self.geo_lat 	    			:= tempAddress[146..155];
	self.geo_long 	    			:= tempAddress[156..166];
	self.msa 		      			:= tempAddress[167..170];
	self.geo_match 	  				:= tempAddress[178];
	self.err_stat 	    			:= tempAddress[179..182];
	self.KEY                        := hash64(stringlib.StringToUpperCase(trim(trim(InputRecord.LAST_NAME,left,right) + 
	                                                                    trim(InputRecord.FIRST_NAME,left,right) +
																		lib_stringlib.stringlib.stringfilter(trim(InputRecord.DOB_FORMATTED,left,right),'0123456789'))));
	self.PROCESS_DATE               := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Process_Date,left,right),'0123456789');
	self.DATE_FIRST_SEEN            := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Date_First_Seen,left,right),'0123456789');
	self.DATE_LAST_SEEN             := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Date_Last_Seen,left,right),'0123456789');
	self.DATE_VENDOR_FIRST_REPORTED := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Date_Vendor_First_Reported,left,right),'0123456789');
	self.DATE_VENDOR_LAST_REPORTED  := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Date_Vendor_Last_Reported,left,right),'0123456789');
	self.LAST_NAME        			:= stringlib.StringToUpperCase(trim(InputRecord.Last_Name,left,right));
	self.FIRST_NAME       			:= stringlib.StringToUpperCase(trim(InputRecord.First_Name,left,right));
	self.FULL_NAME        			:= stringlib.StringToUpperCase(trim(InputRecord.Full_Name,left,right));
	self.ADDRESS_1        			:= stringlib.StringToUpperCase(trim(InputRecord.ADDRESS_1,left,right));
	self.ADDRESS_2        			:= stringlib.StringToUpperCase(trim(InputRecord.ADDRESS_2,left,right));
	self.CITY        				:= stringlib.StringToUpperCase(trim(InputRecord.CITY,left,right));
	self.STATE        				:= stringlib.StringToUpperCase(trim(InputRecord.STATE,left,right));
	self.Z5	        				:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.Z5,left,right),'0123456789');
	self.ZIP_4        				:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.ZIP_4,left,right),'0123456789');
	self.CRRT_CODE        			:= stringlib.StringToUpperCase(trim(InputRecord.CRRT_CODE,left,right));
	self.DELIVERY_POINT_BARCODE     := lib_stringlib.stringlib.stringfilter(trim(InputRecord.DELIVERY_POINT_BARCODE,left,right),'0123456789');
	self.ZIP4_CHECK_DIGIT        	:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.ZIP4_CHECK_DIGIT,left,right),'0123456789');
	self.ADDRESS_TYPE_CODE        	:= stringlib.StringToUpperCase(trim(InputRecord.ADDRESS_TYPE_CODE,left,right));
	self.ADDRESS_TYPE        		:= stringlib.StringToUpperCase(trim(InputRecord.ADDRESS_TYPE,left,right));
	self.COUNTY_NUMBER        		:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.COUNTY_NUMBER,left,right),'0123456789');
	self.COUNTY_NAME        		:= lib_stringlib.stringlib.stringfilterout(stringlib.StringToUpperCase(trim(InputRecord.COUNTY_NAME,left,right)),'0123456789');
	self.GENDER_CODE        		:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.GENDER_CODE,left,right),'0123456789');
	self.GENDER        				:= stringlib.StringToUpperCase(trim(InputRecord.GENDER,left,right));
	self.AGE        				:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.AGE,left,right),'0123456789');
	self.BIRTH_DATE        			:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.BIRTH_DATE,left,right),'0123456789');
	self.DOB_FORMATTED        		:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.DOB_FORMATTED,left,right),'0123456789');
	self.TELEPHONE        			:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.TELEPHONE,left,right),'0123456789');
	self.CLASS        				:= stringlib.StringToUpperCase(trim(InputRecord.CLASS,left,right));
	self.COLLEGE_CLASS        		:= stringlib.StringToUpperCase(trim(InputRecord.COLLEGE_CLASS,left,right));
	self.COLLEGE_NAME        		:= stringlib.StringToUpperCase(trim(InputRecord.COLLEGE_NAME,left,right));
	self.COLLEGE_CODE        		:= lib_stringlib.stringlib.stringfilter(trim(InputRecord.COLLEGE_CODE,left,right),'0123456789');
	self.COLLEGE_CODE_EXPLODED      := stringlib.StringToUpperCase(trim(InputRecord.COLLEGE_CODE_EXPLODED,left,right));
	self.COLLEGE_TYPE        		:= stringlib.StringToUpperCase(trim(InputRecord.COLLEGE_TYPE,left,right));
	self.COLLEGE_TYPE_EXPLODED      := stringlib.StringToUpperCase(trim(InputRecord.COLLEGE_TYPE_EXPLODED,left,right));
	self.HEAD_OF_HOUSEHOLD_FIRST_NAME	:= stringlib.StringToUpperCase(trim(InputRecord.HEAD_OF_HOUSEHOLD_FIRST_NAME,left,right));
	self.HEAD_OF_HOUSEHOLD_GENDER_CODE  := lib_stringlib.stringlib.stringfilter(trim(InputRecord.HEAD_OF_HOUSEHOLD_GENDER_CODE,left,right),'0123456789');
	self.HEAD_OF_HOUSEHOLD_GENDER   := stringlib.StringToUpperCase(trim(InputRecord.HEAD_OF_HOUSEHOLD_GENDER,left,right));
	self.INCOME_LEVEL_CODE        	:= stringlib.StringToUpperCase(trim(InputRecord.INCOME_LEVEL_CODE,left,right));
	self.INCOME_LEVEL        		:= stringlib.StringToUpperCase(trim(InputRecord.INCOME_LEVEL,left,right));
	self.FILE_TYPE        			:= stringlib.StringToUpperCase(trim(InputRecord.FILE_TYPE,left,right));
	self := InputRecord;
end;

export Cleaned_american_student := project(Map_american_student,CleanAmericanStudent(left));
