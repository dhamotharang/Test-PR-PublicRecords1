//Eleven autokeys are addressed in this macro
//All of them are built using the mapping information for FDN
//there are no fields which are not without permutations in Nameb2 auto key(for FDN). 
//Author: Vikram Pareddy
EXPORT validateAutoKeys( dsName, parentFile, buildVersion, autoKeyValidationSummary, addressAutoKey='', 
																					addressb2AutoKey='', cityStNameAutoKey='', cityStNameb2AutoKey='', nameAutoKey='', 
																					phone2AutoKey='', phoneb2AutoKey='', ssn2AutoKey='', stNameAutoKey='', 
																					stNameb2AutoKey='', zipAutoKey='', zipb2AutoKey='', isDev=true) := macro
import keyValidation;

addressSummary := keyValidation.validateKeysMacrov2(dsName, 'Address', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																						 parentFile, addressAutoKey, 
																																						 ['prim_name', 'prim_range', 'st', 'zip', 'sec_range', 'did'], 
																																						 ['ut.StripOrdinal(left.clean_address.prim_name)', 
																																						 'TRIM(ut.CleanPrimRange(left.clean_address.prim_range),left)', 
																																						 'left.clean_address.st',  'left.clean_address.zip', 
																																						 'left.clean_address.sec_range', 'left.fakeid'], 
																																						 ['city_code', 'dph_lname', ' lname', ' pfname', ' fname', ' states', 
																																						 ' lname1', ' lname2', ' lname3', ' lookups', ' qa_defined_empty'],  ['did'], isDev);
																					 
addressb2Summary := keyValidation.validateKeysMacrov2(dsName, 'Addressb2', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																							 parentFile, addressb2AutoKey, 
																																							 ['prim_name', 'prim_range', 'st', 'zip', 'sec_range', 'bdid'], 
																																							 ['ut.StripOrdinal(left.clean_address.prim_name)', 
																																							 'TRIM(ut.CleanPrimRange(left.clean_address.prim_range),left)', 
																																							 'left.clean_address.st',  'left.clean_address.zip', 
																																							 'left.clean_address.sec_range', 'left.fakeid'], 
																																							 ['city_code', 'cname_indic', ' cname_sec', ' lookups', 
																																							 ' qa_defined_empty'],  ['bdid'], isDev);
																					 
cityStNameSummary := keyValidation.validateKeysMacrov2(dsName, 'CityStName', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																			 parentFile, cityStNameAutoKey, 
																																			 ['st', 'fname', 'dob', 'did'], 
																																			 [ 'left.clean_address.st', 'left.cleaned_name.fname', 
																																			 '(integer)left.dob', 'left.fakeid'], 
																																			 ['city_code', ' lname', ' dph_lname', ' pfname', 
																																			 ' states', ' lname1', ' lname2', ' lname3', ' city1', ' city2', 
																																			 ' city3', ' rel_fname1', ' rel_fname2', ' rel_fname3', 
																																			 ' lookups', ' qa_defined_empty'], 
																																				['did'], isDev);

cityStNameb2Summary := keyValidation.validateKeysMacrov2(dsName, 'CityStNameb2', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																			 parentFile, cityStNameb2AutoKey, 
																																			 ['st', 'bdid'], 
																																			 ['left.clean_address.st', 'left.fakeid'], 
																																			 ['city_code', ' cname_indic', ' cname_sec', 
																																			 ' lookups', ' qa_defined_empty'],  ['bdid'], isDev);
																					 
nameSummary := keyValidation.validateKeysMacrov2(dsName, 'Name', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																			parentFile, nameAutoKey, 
																																			['fname', 'minit', 's4',  'dob',  'did'], 
																																			[ 'left.cleaned_name.fname', 'left.cleaned_name.mname[1]', 
																																			'(unsigned)(((string)left.ssn)[6..9])', '(integer)left.dob', 'left.fakeid'], 
																																			['dph_lname', ' lname', ' pfname', ' yob', ' states', ' lname1', ' lname2', 
																																			' lname3', ' city1', ' city2', ' city3', ' rel_fname1', ' rel_fname2', 
																																			' rel_fname3', ' lookups', ' qa_defined_empty'], 
																																			['did'], isDev);											

phone2Summary := keyValidation.validateKeysMacrov2(dsName, 'Phone2', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																		 parentFile, phone2AutoKey, 
																																		 ['p7', 'p3', 'st', 'did'], 
																																		 [ 'left.phone_number[4..10]', 
																																		 'left.phone_number[1..3]', 'left.clean_address.st', 'left.fakeid'], 
																																		 ['dph_lname', ' pfname', ' lookups', ' qa_defined_empty'], 
																																			['did'], isDev);

// phoneb2Summary := keyValidation.validateKeysMacrov2(dsName, 'Phoneb2', 'Auto Key', 'Payload Auto Key', buildVersion,  
																					 // parentFile, phoneb2AutoKey, ['p7', 'p3', 'st', 'bdid'], 
																					 // [ 'left.phone_number[4..10]', 'left.phone_number[1..3]', 'left.clean_address.st', 'left.fakeid'], 
																					 // '[cname_indic, cname_sec, lookups, qa_defined_empty]', 
																					  // ['bdid']);

																					 
ssn2Summary := keyValidation.validateKeysMacrov2(dsName, 'SSN2', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																		 parentFile, ssn2AutoKey, 
																																		 ['s1','s2','s3','s4','s5','s6','s7','s8','s9', 'did'], 
																																		 [ 'left.ssn[1]', 'left.ssn[2]', 'left.ssn[3]', 'left.ssn[4]', 
																																		 'left.ssn[5]', 'left.ssn[6]', 'left.ssn[7]', 'left.ssn[8]', 'left.ssn[9]', 'left.fakeid'], 
																																		 ['dph_lname', ' pfname', ' lookups', ' qa_defined_empty'], 
																																			['did'], isDev);
																					 
stNameSummary := keyValidation.validateKeysMacrov2(dsName, 'StName', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																		 parentFile, stNameAutoKey, 
																																		 ['st', 'fname','minit', 's4', 'zip', 'dob',  'did'], 
																																		 [ 'left.clean_address.st', 'left.cleaned_name.fname', 
																																		 'left.cleaned_name.mname[1]', '(unsigned)(((string)left.ssn)[6..9])', 
																																		 '(integer4)left.clean_address.zip',  '(integer4)left.dob', 'left.fakeid'], 
																																		 ['dph_lname', ' lname', ' pfname', ' yob', ' states', ' lname1', 
																																		 ' lname2', ' lname3', ' city1', ' city2', ' city3', ' rel_fname1', 
																																		 ' rel_fname2', ' rel_fname3', ' lookups', ' qa_defined_empty'], 
																																			['did'], isDev);		
																					 
stNameb2Summary := keyValidation.validateKeysMacrov2(dsName, 'StNameb2', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																		 parentFile, stNameb2AutoKey, 
																																		 ['st', 'bdid'], 
																																		 ['left.clean_address.st', 'left.fakeid'], 
																																		 ['cname_indic', ' cname_sec', 
																																		 ' lookups', ' qa_defined_empty'],  ['bdid'], isDev);
																
zipSummary := keyValidation.validateKeysMacrov2(dsName, 'Zip', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																		 parentFile, zipAutoKey, 
																																		 [ 'fname','minit', 's4', 'dob',  'did'], 
																																		 [ 'left.cleaned_name.fname', 'left.cleaned_name.mname[1]', 
																																		 '(unsigned)(((string)left.ssn)[6..9])', '(integer4)left.dob', 'left.fakeid'], 
																																		 ['dph_lname', ' lname', ' pfname', ' yob', ' states', ' lname1', 
																																		 ' lname2', ' lname3', ' city1', ' city2', ' city3', ' rel_fname1', 
																																		 ' rel_fname2', ' rel_fname3', ' zip', ' lookups', ' qa_defined_empty'], 
																																			['did'], isDev);	
																					 
zipb2Summary := keyValidation.validateKeysMacrov2(dsName, 'Zipb2', 'Auto Key', 'Payload Auto Key', buildVersion,  
																																		 parentFile, zipb2AutoKey, 
																																		 ['zip', 'bdid'], 
																																		 [ '(integer4)left.clean_address.zip', 'left.fakeid'], 
																																		 ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'],  
																																		 ['bdid'], isDev);
																					 
autoKeyValidationSummary := addressSummary + addressb2Summary + cityStNameSummary + 
																							cityStNameb2Summary + nameSummary + phone2Summary + ssn2Summary + 
																							stNameSummary + stNameb2Summary + zipSummary + zipb2Summary;

endmacro;