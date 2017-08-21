//New BaseFile
new_basefile:= votersv2.File_Voters_Base(did != 0);

//Previous BaseFile
previous_basefile:= dataset('~thor_data400::base::Voters_Reg_father', 
														votersv2.Layouts_Voters.Layout_Voters_Base_new, thor)(did != 0);

newrecords_layout := RECORD
votersv2.Layouts_Voters.Layout_Voters_Base_new;
END;

//Join on DID's
newrecords_layout newrecords_output(new_basefile l, previous_basefile r) := TRANSFORM
SELF := l;
END;

//New Records Found in New Basefile Only
newrecords := join(new_basefile, previous_basefile
						,left.did=right.did
						,newrecords_output(LEFT,RIGHT)
						,LEFT ONLY
						);
						
//output(choosen(newrecords, 1000), named('SampleRecords'));
export SampleRecs := output(choosen(newrecords, 1000));