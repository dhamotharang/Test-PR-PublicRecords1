
Layout_Infile := American_student_list.layout_american_student_with_process_date;

layout_american_student_base MyTransform(Layout_Infile input) := transform
	self.KEY 							:= 0;
	self.DID                            := 0;
	self.Process_Date 					:= input.Process_Date;
	self.Date_First_Seen 				:= '';
	self.Date_Last_Seen  				:= '';
	self.Date_Vendor_First_Reported 	:= Self.Process_Date;
	self.Date_Vendor_Last_Reported 		:= Self.Process_Date;
	self.HISTORICAL_FLAG			:=	'C';
	self.First_Name 					:= input.First_Name;
	self.Last_Name 						:= input.Last_Name;
	self.Full_Name 						:= input.Name;
	
	self.ADDRESS_1 						:= input.ADDRESS_1;
	self.ADDRESS_2        				:= input.ADDRESS_2;
	self.CITY        					:= input.CITY;
	self.STATE        					:= input.STATE;
	self.Z5	        					:= input.Z5;
	self.ZIP_4        					:= input.ZIP_4;
	self.CRRT_CODE        				:= input.CRRT_CODE;
	self.DELIVERY_POINT_BARCODE     	:= input.DELIVERY_POINT_BARCODE;
	self.ZIP4_CHECK_DIGIT        		:= input.ZIP4_CHECK_DIGIT;
	self.ADDRESS_TYPE_CODE        		:= input.ADDRESS_TYPE;
	self.ADDRESS_TYPE        			:= map(trim(input.ADDRESS_TYPE,left,right) = 'G' => 'General Delivery',
												trim(input.ADDRESS_TYPE,left,right) = 'H' => 'High-rise Dwelling',
												trim(input.ADDRESS_TYPE,left,right) = 'R' => 'Rural Route',
												trim(input.ADDRESS_TYPE,left,right) = 'P' => 'Post Office Box',
												trim(input.ADDRESS_TYPE,left,right) = 'S' => 'Single Family Dwelling',
												'');
	self.COUNTY_NUMBER        			:= input.COUNTY_NUMBER;
	self.COUNTY_NAME        			:= input.COUNTY_NAME;
	self.GENDER_CODE        			:= input.GENDER;
	self.GENDER        					:= if(trim(input.GENDER,left,right) = '1', 'MALE',
											  if(trim(input.GENDER,left,right) = '2', 'FEMALE', 
											  ''));
	self.AGE        					:= input.AGE;
	self.BIRTH_DATE        				:= input.BIRTH_DATE;
	
	self.DOB_FORMATTED        			:= map(LENGTH(trim(input.BIRTH_DATE,left,right)) = 2 => if (trim(input.BIRTH_DATE,left,right) > '40', 
																									 '19' + trim(input.BIRTH_DATE,left,right) + '0000',
																									 '20' + trim(input.BIRTH_DATE,left,right) + '0000'),
											   LENGTH(trim(input.BIRTH_DATE,left,right)) = 4 => if (input.BIRTH_DATE[1..2] > '40',
																									'19' + trim(input.BIRTH_DATE,left,right) + '00',
																									'20' + trim(input.BIRTH_DATE,left,right) + '00'),
											   LENGTH(trim(input.BIRTH_DATE,left,right)) = 6 => if (input.BIRTH_DATE[1..2] > '40',
																									'19' + trim(input.BIRTH_DATE,left,right),
																									'20' + trim(input.BIRTH_DATE,left,right)),
											   '');
											   
		
	self.TELEPHONE        				:= input.TELEPHONE;
	self.CLASS        					:= input.CLASS;
	self.COLLEGE_CLASS        			:= input.COLLEGE_CLASS;
	self.COLLEGE_NAME        			:= input.COLLEGE_NAME;
	self.COLLEGE_MAJOR       			:= input.COLLEGE_MAJOR;
	self.COLLEGE_CODE        			:= input.COLLEGE_CODE;
	self.COLLEGE_CODE_EXPLODED     		:= map(trim(input.COLLEGE_CODE,left,right) = '2' => 'Two Year College',
												trim(input.COLLEGE_CODE,left,right) = '4' => 'Four Year College',
												trim(input.COLLEGE_CODE,left,right) = '1' => 'Graduate School',
												'');
	self.COLLEGE_TYPE        			:= input.COLLEGE_TYPE;
	self.COLLEGE_TYPE_EXPLODED      	:= map(trim(input.COLLEGE_TYPE,left,right) = 'S' => 'Public/State School',
												trim(input.COLLEGE_TYPE,left,right) = 'P' => 'Private School',
												trim(input.COLLEGE_TYPE,left,right) = 'R' => 'Church/Religious School',
												'');
	self.HEAD_OF_HOUSEHOLD_FIRST_NAME	:= input.HEAD_OF_HOUSEHOLD_FIRST_NAME;
	self.HEAD_OF_HOUSEHOLD_GENDER_CODE  := input.HEAD_OF_HOUSEHOLD_GENDER;
	self.HEAD_OF_HOUSEHOLD_GENDER   	:= if(trim(input.HEAD_OF_HOUSEHOLD_GENDER,left,right) = '1', 'MALE',
											  if(trim(input.HEAD_OF_HOUSEHOLD_GENDER,left,right) = '2', 'FEMALE', 
											  ''));
	self.INCOME_LEVEL_CODE        		:= input.INCOME_LEVEL;
	self.INCOME_LEVEL        			:= map(trim(input.INCOME_LEVEL,left,right) = 'A' => '$1-$9,999',
												trim(input.INCOME_LEVEL,left,right) = 'B' => '$10,000-$19,999',
												trim(input.INCOME_LEVEL,left,right) = 'C' => '$20,000-$29,999',
												trim(input.INCOME_LEVEL,left,right) = 'D' => '$30,000-$39,999',
												trim(input.INCOME_LEVEL,left,right) = 'E' => '$40,000-$49,999',
												trim(input.INCOME_LEVEL,left,right) = 'F' => '$50,000-$59,999',
												trim(input.INCOME_LEVEL,left,right) = 'G' => '$60,000-$69,999',
												trim(input.INCOME_LEVEL,left,right) = 'H' => '$70,000-$79,999',
												trim(input.INCOME_LEVEL,left,right) = 'I' => '$80,000-$89,999',
												trim(input.INCOME_LEVEL,left,right) = 'J' => '$90,000-$99,999',
												trim(input.INCOME_LEVEL,left,right) = 'K' => '$100,000 + Over',
												'');
	self.FILE_TYPE        				:= input.FILE_TYPE;
	self := [];
end;

										
export Map_american_student := project(American_student_list.File_american_student_uncleaned,MyTransform(left));
                                 

