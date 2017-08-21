EXPORT mac_SimpleRandomSample(InFile,UID_Field,SampleSize,Result) := MACRO
//build a table of the UIDs
#UNIQUENAME(Layout_Plus_RecID)
%Layout_Plus_RecID% := RECORD
UNSIGNED8 RecID := 0;
InFile.UID_Field;
END;
#UNIQUENAME(InTbl)
%InTbl% := TABLE(InFile,%Layout_Plus_RecID%);
//then assign unique record IDs to the table entries
#UNIQUENAME(IDRecs)
%Layout_Plus_RecID% %IDRecs%(%Layout_Plus_RecID% L, INTEGER C) :=
TRANSFORM
SELF.RecID := C;
SELF := L;
END;
#UNIQUENAME(UID_Recs)
%UID_Recs% := PROJECT(%InTbl%,%IDRecs%(LEFT,COUNTER));
//discover the number of records
#UNIQUENAME(WholeSet)
%WholeSet% := COUNT(InFile) : GLOBAL;
//then generate the unique record IDs to include in the sample
#UNIQUENAME(BlankSet)
%BlankSet% := DATASET([{0}],{UNSIGNED8 seq});
#UNIQUENAME(SelectEm)
TYPEOF(%BlankSet%) %SelectEm%(%BlankSet% L, INTEGER c) := TRANSFORM
SELF.seq := ROUNDUP(%WholeSet% * (((RANDOM()%100000)+1)/100000));
END;
#UNIQUENAME(selected)
%selected% := NORMALIZE( %BlankSet%, SampleSize,
%SelectEm%(LEFT, COUNTER));
//then filter the original dataset by the selected UIDs
#UNIQUENAME(SetSelectedRecs)
%SetSelectedRecs% := SET(%UID_Recs%(RecID IN SET(%selected%,seq)),
UID_Field);
result := infile(UID_Field IN %SetSelectedRecs% );
ENDMACRO;