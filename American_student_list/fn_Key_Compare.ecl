Import Data_Services, American_student_list,file_compare,std;

EXPORT fn_Key_Compare(STRING Version) := function 

 OldKey := INDEX(American_student_list.key_DID,data_services.foreign_prod + 'thor_data400::key::american_student::father::did2');
										
 NewKey := INDEX(American_student_list.key_DID,data_services.foreign_prod + 'thor_data400::key::american_student::qa::did2');

 PulledOldKey:=Pull(OldKey);
 PulledNewKey:=Pull(NewKey);
ImportantRecord:=record
string	COLLEGE_NAME;
string	COLLEGE_MAJOR;
string	FIRST_NAME;
string	LAST_NAME;
string	ADDRESS_1;
string	ADDRESS_2;
string	CITY;
string	STATE;
string	Z5;
string	TELEPHONE;
end;

IgnoreRecord:=record
string	process_date;
string	date_last_seen;
string	date_vendor_last_reported;
String	HISTORICAL_FLAG;
end;

// n_File_Compare(datasetName,fileType,Version,OldFile,NewFile,ImportantFields='',IgnoreFields='', DistributeFields = '',useImportant=false,useIgnore=false,useDistribute=false) := functionmacro
return file_compare.Fn_File_Compare(PulledOldKey,PulledNewKey,ImportantRecord,IgnoreRecord,ImportantRecord,true,true,true,true,'American_Student_List','Non_FCRA_Key', Version);

end;