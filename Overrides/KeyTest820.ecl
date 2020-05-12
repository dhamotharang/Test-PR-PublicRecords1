IMPORT  ut, Std,
			address,
			PromoteSupers,
			idl_header,
			Header_Slimsort,
			AID,
 		  DID_Add,
			lib_StringLib,
			Census_Data,
			Watchdog,
			mdr;


STRING last_name:='EVANS';
STRING first_name:='WILLIAM';

STRING z5 := '64131';

STRING DOB_FORMATTED :='';
oldKeyWithZip:=hash64(stringlib.StringToUpperCase(trim(TRIM(last_name,left,right) 
																										   +TRIM(first_name,left,right) 
																											 +IF(DOB_FORMATTED = '',
																											        lib_stringlib.stringlib.stringfilter(TRIM(z5,left,right),'0123456789'),
																															lib_stringlib.stringlib.stringfilter(TRIM(DOB_FORMATTED,left,right),'0123456789')))));
				
OUTPUT(oldKeyWithZip,NAMED('Using_Zip_In_key'));

oldkeyNoZip := hash64(stringlib.StringToUpperCase(trim(trim(last_name,left,right) 
                                                  +trim(first_name,left,right) 
																									+lib_stringlib.stringlib.stringfilter(trim(DOB_FORMATTED,left,right),'0123456789'))));																																				
																		
OUTPUT(oldkeyNoZip,NAMED('No_Zip_In_key'));

//persistance id.
STRING FULL_NAME :='WILLIAM EVANS';

STRING ZIP:='64131';
//STRING ZIP:='64128';
//STRING ZIP:='64131';

//STRING addr1:='8015 CAMPBELL ST';
STRING addr1:='9921 LOCUST ST';
STRING addr2:='APT 3206';
STRING addr:=Std.Str.CleanSpaces(addr1 + ' ' + addr2);

STRING DOB_FORMATTED2 :='';


//STRING LN_COLLEGE_NAME :='UNIVERSITY OF MISSOURI';
STRING LN_COLLEGE_NAME :='UNIVERSITY OF CENTRAL MISSOURI';                   

//STRING COLLEGE_MAJOR :='B';
STRING COLLEGE_MAJOR :='U';
STRING telephone :='';


pidKEY := HASH64(FULL_NAME, ZIP,addr, DOB_FORMATTED2, LN_COLLEGE_NAME, COLLEGE_MAJOR, telephone);
OUTPUT(pidKey,NAMED('pid_results'));

