//**********************************************************************************************************************
// Purpose :  To synchronise with Miami dade county's database
// Description : 1) The recording extract will no longer contain deleted (D) records. 
//                  You will need to use the CFN Year + CFN Sequence in order to synchronize your database with the Countys database. 
//                  The CFN Year and Sequence is a unique key combination you can use to do a full refresh of the document in your database. 
//*****************************************************************************************************************
import lib_fileservices,lib_stringlib,ut, std;
export Proc_Official_Record_document( string filedate) := function

//distribute the fils
File_Miami_dade_Document_Update := dataset('~thor_200::base::official_records_fl_miami_dade_document',official_records.Layout_In_Miami_dade_Document,thor);
File_Miami_dade_Document_full :=  dataset('~thor_200::base::official_records_fl_miami_dade_document_father',official_records.Layout_In_Document,thor);

//Add cfn_year,cfn_sequence fields as these fields do not exist in base layout
 Layout_cfn := record
official_records.Layout_In_Document;
string4 cfn_year := '';
string10 cfn_sequence := '';
end;

Layout_cfn tr_addfull(File_Miami_dade_Document_full l) := transform
self.cfn_year := l.official_record_key[3..6];
self.cfn_sequence := l.official_record_key[7..16];
self := l;
end;

//Full File extracts cfn_year and cfn_sequence data from official record key

File_add_full := project(File_Miami_dade_Document_full,tr_addfull(LEFT));
 
concat_full := File_add_full(cfn_year <> '' and cfn_sequence <> '' and length(trim(doc_filed_dt)) = 8) ;

Layout_cfn tr_addup(File_Miami_dade_Document_Update l) := transform
self.cfn_year := l.official_record_key[3..6];
self.cfn_sequence := l.official_record_key[7..16];
self := l;
end;

//Input File extracts cfn_year and cfn_sequence data from official record key

File_add_update := project(File_Miami_dade_Document_Update,tr_addup(LEFT));
 

concat_update := File_add_update(cfn_year <> '' and cfn_sequence <> '' and length(trim(doc_filed_dt)) = 8) ;

//Built Hash function on cfn_year and cfn_sequence
dist_Key_File := distribute(concat_update,HASH32(cfn_year,cfn_sequence));

dist_Full_File  := distribute(concat_full,HASH32(cfn_year,cfn_sequence));


//Join to get only updates from full file with non match cfn_year and cfn_sequence

 Layout_cfn join_all(dist_Full_File l,dist_Key_File r) := transform


self := l;

end;

join_get_full := join(dist_Full_File,dist_Key_File,trim(LEFT.cfn_year,left,right)=trim(RIGHT.cfn_year,left,right) and  trim(LEFT.cfn_sequence,left,right)=trim(RIGHT.cfn_sequence,left,right),join_all(LEFT,RIGHT),left only,local);


//concat the data from full file and input file to get final full file

Full_file_base := join_get_full + concat_update;

join_persist := Full_file_base : persist('~thor_200::persist::official_records_fl_miami_dade_document');

//to get the data into final layout

official_records.Layout_In_document tr_final(join_persist le) := transform

self := le;

end;

File_Miami_final := project(join_persist,tr_final(LEFT));


get_final_file := output(File_Miami_final,,'~thor_200::in::official_records_fl_miami_dade_'+filedate+'_document_final',__compressed__,overwrite);
//CHeck the counts and validate

File_Miami_dade_Document_check := dataset('~thor_200::base::official_records_fl_miami_dade_document',official_records.Layout_In_Document,thor);

validate_doc := if(count(File_Miami_dade_Document_check) > count(File_Miami_dade_Document_full),output('COUNTS_LOOK_FINE'), fail('Abort:  COUNT_OF_BASE_LESS_THAN_FATHER'));
//Super File transaction


doc_Father_SFile := lib_fileservices.FileServices.GetSuperFileSubname('~thor_200::base::official_records_fl_miami_dade_document_father',1);


doc_Fthdate := lib_stringlib.StringLib.StringFind(doc_Father_SFile,'201',1);

validate_Fatherfile := if( ut.DaysApart((STRING8)Std.Date.Today(),doc_Father_SFile[doc_Fthdate..doc_Fthdate+8]) > 22, fail('Abort:  DOCUMENT_FATHER_BASE_FILE_IS_NOT_CURRENT'),OUTPUT('DOCUMENT_FATHER_BASE_FILE_IS_CURRENT'));




Final_Miami_document := Sequential(
                        validate_Fatherfile,
                       get_final_file,
											 FileServices.ClearSuperFile('~thor_200::base::official_records_fl_miami_dade_document'),
					  FileServices.StartSuperFileTransaction(),			
                      
					  FileServices.AddSuperFile('~thor_200::base::official_records_fl_miami_dade_document','~thor_200::in::official_records_fl_miami_dade_'+filedate+'_document_final'),
					  FileServices.FinishSuperFileTransaction(),
					 validate_doc,
											  FileServices.ClearSuperFile('~thor_200::base::official_records_fl_miami_dade_document_father'),
					  FileServices.StartSuperFileTransaction(),
					  FileServices.AddSuperFile('~thor_200::base::official_records_fl_miami_dade_document_father','~thor_200::in::official_records_fl_miami_dade_'+filedate+'_document_final'),
					  FileServices.FinishSuperFileTransaction()
                          );

return Final_Miami_document;

end;