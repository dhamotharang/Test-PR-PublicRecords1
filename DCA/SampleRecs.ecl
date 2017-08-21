oldbase := dataset('~thor_data400::base::dca_father', DCA.Layout_DCA_Base, thor)(bdid > 0);
newbase := DCA.File_DCA_Base(bdid > 0);

newrecords_layout := record
DCA.Layout_DCA_Base;
end;

//Join on BDID's
newrecords_layout newrecords_output(newbase l, oldbase r) := TRANSFORM
SELF := l;
END;

//New Records Found in New Basefile Only
newrecords := join(newbase, oldbase,
						left.bdid = right.bdid
						,newrecords_output(LEFT,RIGHT)
						,LEFT ONLY
						);
						
export SampleRecs := output(choosen(sort(newrecords, -bdid),1000));