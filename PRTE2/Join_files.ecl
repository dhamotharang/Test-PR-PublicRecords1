//* attribute Join_files 
IMPORT PRTE2,AutoKeyB2,ut, roxiekeybuild;
EXPORT   Join_Files   (STRING filedate)               := MODULE
//* JOIN all of the current tables into an expanded payload file:
EXPORT Expanded_Foreclosures_Payload := PRTE2.Get_payload.foreclosures;
OUTPUT (Expanded_Foreclosures_Payload,,'~prte::ct::foreclosure::join::retds',OVERWRITE);	
EXPORT New_Expanded_Foreclosures_Payload := PRTE2.Get_payload.NEW_Foreclosures(filedate);
OUTPUT (New_Expanded_Foreclosures_Payload,,'~prte::ct::foreclosure::new::retds',OVERWRITE);	
EXPORT Fall := Expanded_Foreclosures_Payload +
       New_Expanded_Foreclosures_Payload;
Fall_expanded := DEDUP(project(Fall,Transform(PRTE2.layouts.Autokey_layout,
        self := left, self := [])),record,All);
EXPORT  All_Foreclosures_Expanded := Fall_expanded : PERSIST  ('~prte::persist::custtest::file_foreclosure_All::' + filedate);

//* dedup the old    do not dedup the new:	
F1:= dedup(project(Expanded_Foreclosures_Payload,Transform(PRTE2.layouts.Autokey_layout,
	 self := Left,self := [])),record,all);

F2 := project(New_Expanded_Foreclosures_Payload,PRTE2.layouts.Autokey_layout);
EXPORT file_in_expanded := F1	+ F2;


export File_Foreclosure_Autokey_CT := file_in_expanded : PERSIST('~prte::persist::custtest::file_foreclosure_Autokey::' + filedate);		

F3 := dedup(Expanded_Foreclosures_Payload,record,all);
F4 := dedup(New_Expanded_foreclosures_Payload,record,all);
file_out_expanded := F3 + F4;														
Export File_Foreclosures_Joined_CT := file_out_expanded : PERSIST('~prte::persist::custtest::file_foreclosures_Joined::' + filedate);
END;