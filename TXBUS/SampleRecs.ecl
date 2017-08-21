//New BaseFile
new_basefile:= TXBUS.File_Txbus_Base(bdid > 0);

//Previous BaseFile
previous_basefile:= dataset('~thor_data400::base::txbus::basefile_father', txbus.Layouts_Txbus.Layout_Base, thor)(bdid > 0);

newrecords_layout := RECORD
txbus.Layouts_Txbus.Layout_Base;
END;

//Join on BDID's
newrecords_layout newrecords_output(new_basefile l, previous_basefile r) := TRANSFORM
SELF := l;
END;

//New Records Found in New Basefile Only
newrecords := join(new_basefile, previous_basefile,
						left.bdid = right.bdid
						,newrecords_output(LEFT,RIGHT)
						,LEFT ONLY
						);
						
export SampleRecs := output(choosen(newrecords, 1000), named('SampleRecords'));