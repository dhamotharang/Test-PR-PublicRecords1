Import ut, std;
Export Map_BadAddresses_Raw := Module

Export Str(String s) :=  Trim(StringLib.StringCleanSpaces(Stringlib.StringtoUpperCase(s)), Left, Right);

// For date types: mm/dd/yyyy : 2/4/2014 or 12/31/2001
Export DateFormat(String dt) := Function
trim_dt := IF(STD.Str.Find(TRIM(dt, left, right), ' ', 1) > 0, dt[1..STD.Str.Find(TRIM(dt, left, right), ' ', 1)-1], dt);
pos1 :=  If(STD.Str.Find(trim_dt, '/', 1) > 0,  STD.Str.Find(trim_dt, '/', 1), 0);
pos2 :=  If(STD.Str.Find(trim_dt, '/', 2) > 0,  STD.Str.Find(trim_dt, '/', 2), 0);
mm := if((integer)trim_dt[1.. pos1-1] < 10 and length(trim_dt[1.. pos1-1])<2, '0'+trim_dt[1.. pos1-1], trim_dt[1.. pos1-1]);
dd := if((integer)trim_dt[pos1+1 .. pos2-1] < 10 and length(trim_dt[pos1+1 .. pos2-1])<2, '0'+trim_dt[pos1+1.. pos2-1], trim_dt[pos1+1.. pos2-1]);
yyyy := trim_dt[pos2+1..];
// Check for date format YYYY-MM-DD HH:MM:SS.SSS
fDate := If(STD.Str.Find(trim_dt, '-', 1) > 0, STD.Str.Filterout(trim_dt, '-'),yyyy+mm+dd);
Return fDate;
End;

Export File_In := Dataset('~thor400_92::in::BadAddresses', BadAddresses.Layouts.Lay_In, CSV(Heading(1), Separator(['\t', ','])));

// Adding Unique Number to Each Record
// SeqNum_in := Project(File_In, Layouts.Lay_Seq_In);
SeqNum_in := Project(File_In(trim(Address) <> ' '  and ~REGEXFIND('affected|completion',address,NOCASE)),TRANSFORM(Layouts.Lay_Seq_In, self := left, self := []));

                                                                              

ut.MAC_Sequence_Records(SeqNum_in, Seq_Num, File_Seq_in);
 
 // Adding a Unique Sequence Number and removing 'NULL'  Values 
Layouts.Lay_Seq_In xForm(File_Seq_in L) := Transform
dtAdded := If(Str(L.Added_Date) = 'NULL', '', DateFormat(L.Added_Date));
Self.Seq_Num := (integer)(thorlib.wuid()[2..9]+ intformat(L.Seq_Num,10,1));
Self.Source := 'DCF';
Self.SourceId := 1;
Self.Address := Str(L.Address);
// Self.City := Str(L.City);
Self.State := 'FL';
Self.Added_Date := dtAdded;
Self := L;
Self := [];
End;

Export File_SeqNum_in := Project(File_Seq_in, xForm(Left));

End;