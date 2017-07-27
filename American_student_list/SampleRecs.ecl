//New BaseFile
new_basefile:= American_student_list.File_american_student_DID_v2(DID > 0);

//Previous BaseFile
previous_basefile:= dataset('~thor_data400::base::american_student_list_father',American_Student_List.layout_american_student_base_v2,thor)(DID >0);

newrecords_layout := RECORD
American_Student_List.layout_american_student_base_v2;
END;

//Join on BDID's
newrecords_layout newrecords_output(new_basefile l, previous_basefile r) := TRANSFORM
SELF := l;
END;

//New Records Found in New Basefile Only
newrecords := join(new_basefile, previous_basefile,
						left.did = right.did
						,newrecords_output(LEFT,RIGHT)
						,LEFT ONLY
						);
						
export SampleRecs := output(choosen(newrecords, 1000), named('SampleRecords'));