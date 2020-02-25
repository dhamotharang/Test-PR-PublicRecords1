IMPORT $, STD.DataPatterns;
IMPORT STD, AID;

// ================================== Statistics ==========================================

// Slimed files from the original header file
infile0 := $.UID_New_Persons.File; // Already deduped 
infile2 := $.New_Persons.File; // Already deduped
infile3 := $.File_Person_Header.File;
infile4 := $.Address_Module.File; 

// Runs each slimmed file and applies code from STD library
// The code provides summary of data
ProfileResults := DataPatterns.Profile(infile3);
//OUTPUT(profileResults, ALL, NAMED('ProfileResults'));


//========================================== Prepping Data =================================

//1. High counts of names, or name parts combinations. Overall depuded by name and lexid
Mytable0 := Record
    fname := infile2.fname;
    Integer RecordCnt := Count(group);
END;

Tabout0 := Table(infile2, MyTable0, fname);
// EXPORT SortedTout0 := SORT(Tabout0, -RecordCnt); line 146

MyTable1 := Record 
    lname := infile2.lname;
    Integer  RecordCnt := Count(Group);
End;

TabOut1 := Table(infile2, MyTable1, lname);
//EXPORT SortedTout1 := SORT(TabOut1, -RecordCnt);  Exported inside module line 147

//2. High counts of SSN with multiple Lexids

// A. Get the field population percentage oer source 
Rec := Record
    infile0.src;
    Integer SourceCnt := Count(Group);
    Integer Perc := Round((Count(Group, infile0.ssn <> '') / Count(Group)) * 100, 2);
End;

TOut := Table(infile0, Rec, src);
//SortedT0 := SORT(TOut, -Perc);  exported inside module

// B. Eliminate duplicates by rolling the recs 
MyRec1 := Record
    infile0.lexid;
    infile0.ssn;
End;

SSNTable := Table(infile0, MyRec1);
SortedSSNTable := Sort(SSNTable, lexid);

MyRec1 Xform(MyRec1 Le, MyRec1 Ri) := Transform
    Self := Le;
    Self := Ri;
End;

XtabOut := Rollup(SortedSSNTable, 
                 Left.ssn = Right.ssn,
                 Xform(Left,Right));

// Filters blank ssns
NoBlankSSNRec := XtabOut( NOT ssn = '');
// C. Elminate records with blank ssn and test
Myboolean := Exists(noblankssnrec(ssn = '')); // Test                

// Address Recordset
MyRec2 := Record
    infile4.lexid;
    infile4.prim_range;
    infile4.predir;
    infile4.prim_name;
    infile4.suffix;
    infile4.postdir;
    infile4.unit_desig;
    infile4.sec_range;
    infile4.city_name;
    infile4.st;
    infile4.zip
End;

AddyTable := Table(infile4, MyRec2);
SortedAddyTable := Sort(AddyTable, lexid);

// D. Denormalize to create comprehensice output where one can see multiple ssn per lexid
SequenceSSN0 := Record 
    noblankSSNRec.lexid;
End;
ds1 := Table(noblankssnrec, sequencessn0, lexid);

SequenceSSN1 := Record
    noblankssnrec.lexid;
    noblankssnrec.ssn;
End;
ds2 := Table(noblankssnrec, sequencessn1, ssn, lexid);

SequenceAddy := Record
    SortedAddyTable.lexid;
    SortedAddyTable.prim_range;
    SortedAddyTable.predir;
    SortedAddyTable.prim_name;
    SortedAddyTable.suffix;
    SortedAddyTable.postdir;
    SortedAddyTable.unit_desig;
    SortedAddyTable.sec_range;
    SortedAddyTable.city_name;
    SortedAddyTable.st;
    SortedAddyTable.zip;
End;
ds3 := Table(SortedAddyTable, SequenceAddy, Record);

filtereddob := infile2( NOT dob = 0);

// Deduped for cardniality 
t_dob := Table(filtereddob, {lexid, dob});
dt_dob := Distribute(t_dob, HASH32(lexid, dob));
sdt_dob := Sort(dt_dob, lexid, dob, Local);
dsdt_dob := Dedup(sdt_dob, lexid, dob, Local);

Sequencedob := Record
    dsdt_dob.lexid;
    dsdt_dob.dob;
End;

ds4 := Table(dsdt_dob, Sequencedob, Record);

Sequencedob1 := Record
    ds4.dob;
End;

ds5 := Table(ds4, sequencedob1, Record);

// ================================================ MODULE BEGINS ==========================================================

Export Stats := Module 

// EXPORTS
//EXPORT CleanedAddress := project( dohappendaid, taceAddress(left));
Export SortedTout0 := Sort(Tabout0, -RecordCnt);
Export SortedTout1 := Sort(TabOut1, -RecordCnt);
Export SortedT0 := Sort(TOut, -Perc);

// Layout for multiple ssn in lexid
Export Layout_lexidSSN := Record
    SequenceSSN0;
    Unsigned4 ChildSSNLexid;
    Dataset(SequenceSSN1) SSNRecs;
End;

// Denormed to show multiple ssn per lexid
Layout_LexidSSN ParentRec( SequenceSSN0 Le ) := Transform
    Self.ChildSSNLexid := 0;
    Self.SSNRecs := [];
    Self := Le;
End;
ParentOnly := Project( ds1, ParentRec(Left));
Layout_LexidSSN ChildRec(Layout_LexidSSN Le, SequenceSSN1 Ri, Integer RecordCnt) := Transform
    Self.ChildSSNLexid := RecordCnt;
    Self.SSNRecs :=  Le.SSNRecs + Ri;
    Self := Le;
End;
FILE := Denormalize(ParentOnly, ds2, Left.lexid = Right.lexid, ChildRec(Left, Right, Counter));
Export SSNPerLexid := Sort(File, -ChildSSNLexid);

// Counted child recods 
CountedSSNPerLexid := Record
    SSNPerLexid.ChildSSNLexid;
    Integer Cnt := Count(Group);
End;

Export CountedFile := Table(SSNPerLexid, CountedSSNPerLexid, ChildSSNLExid, -ChildSSNLexid);

// Layout for multiple lexid per ssn
Export Layout_SSNLexid := Record
    SequenceSSN1;
    Unsigned4 ChildLexidCnt;
    Dataset(SequenceSSN0) LexidRecs;
End;

// Denormed to show multiple lexid per ssn
Layout_SSNLexid ParentRecLexid( SequenceSSN1 Le ) := Transform
    Self.ChildLexidCnt := 0;
    Self.LexidRecs := [];
    Self := Le;
End;
ParentOnly1 := Project( ds2, ParentRecLexid(Left));
Layout_SSNLexid ChildRecLexid(Layout_SSNLexid Le, SequenceSSN0 Ri, Integer RecordCnt) := Transform
    Self.ChildLexidCnt := RecordCnt;
    Self.LexidRecs := Le.LexidRecs + Ri;
    Self := Le;
End;
File1 := Denormalize(ParentOnly1, ds1, Left.lexid = Right.lexid, ChildRecLexid(Left, Right, Counter));
Export LexidPerSSN := Sort(File1, -Childlexidcnt);

// Counted child Records
CountedLexidPerSSN := Record
    LexidPerSSN.ChildLexidCnt;
    Integer Cnt := Count(Group);
End;

Export CountedFile1 := Table(LexidPerSSN, CountedLexidPerSSN, -ChildLexidCnt);

//3. High counts of lexid sharing same addresses 
Export Layout_AddyLexid := Record
    SequenceAddy;
    Unsigned4 ChildAddyCnt1;
    Dataset(SequenceSSN0) AddyRecs1;
End;

Layout_AddyLexid ParentAddyRecs( SequenceAddy Le ) := Transform
    Self.ChildAddyCnt1 := 0;
    Self.AddyRecs1 := [];
    Self := Le;
End;
ParentOnly5 := Project( ds3, ParentAddyRecs(Left));
Layout_AddyLexid ChildAddyRec(Layout_AddyLexid Le, SequenceSSN0 Ri, Integer RecordCnt) := Transform
    Self.ChildAddyCnt1 := RecordCnt;
    Self.AddyRecs1 := Le.AddyRecs1 + Ri;
    Self := Le;
End;
File5 := Denormalize(ParentOnly5, ds1, Left.lexid = Right.lexid, ChildAddyRec(Left, Right, Counter));
Export LexPerAddy := Sort(File5, -ChildAddyCnt1);

// Count child recods
CountedLexPerAddy := Record
    LexPerAddy.ChildAddyCnt1;
    Integer Cnt := Count(Group);
End;

Export CountedFile5 := Table(LexPerAddy, CountedLexPerAddy, -ChildAddyCnt1);

// 4. Lexids with high count of different addresses 
// Layout for mutiple address per lexid
Export Layout_LexidAddy := Record
    SequenceSSN0;
    Unsigned4 ChildAddyCnt;
    Dataset(SequenceAddy) AddyRecs;
End;

// Denormed to show multiple address per lexid
Layout_LexidAddy ParentRecAddy( SequenceSSN0 Le ) := Transform
    Self.ChildAddyCnt := 0;
    Self.AddyRecs := [];
    Self := Le;
End;
ParentOnly2 := Project( ds1, ParentRecAddy(Left));
Layout_LexidAddy ChildRecAddy(Layout_LexidAddy Le, SequenceAddy Ri, Integer RecordCnt) := Transform 
    Self.ChildAddyCnt := RecordCnt;
    Self.AddyRecs := Le.AddyRecs + Ri;
    Self := Le;
End;
File2 := Denormalize(ParentOnly2, ds3, Left.lexid = Right.lexid, ChildRecAddy(Left, Right, Counter));
Export AddyPerLexid := Sort(File2, -Childaddycnt);

// Count how many child records
CountedAddyPerLexid := Record
    AddyPerLexid.ChildAddyCnt;
    Integer Cnt := Count(Group);
End;

Export CountFile2 := Table(AddyPerLexid, CountedAddyPerLExid, -ChildAddyCnt);

// 4. High counts of Lexids sharing the same birth day 
Export Layout_dob := Record
    Sequencedob1;
    Unsigned4 ChildLexidCnt;
    Dataset(Sequencedob) DobRecs;
End;

Layout_dob ParentRecDob( Sequencedob1 Le ) := Transform
    Self.ChildLexidCnt := 0;
    Self.DobRecs := [];
    Self := Le;
End;
ParentOnly3 := Project( ds5, ParentRecdob(Left));
Layout_dob ChildRecDob(Layout_dob Le, Sequencedob Ri, Integer RecordCnt) := Transform
    Self.ChildLexidCnt := RecordCnt;
    Self.DobRecs := Le.DobRecs + Ri;
    Self := Le;
End;
File3 := Denormalize(ParentOnly3, ds4, Left.dob = Right.dob, ChildRecDob(Left, Right, Counter));
Export LexidPerDob := Sort(file3, -ChildLexidCnt);

// Count how many child recods
CountedLexidPerDob := Record
    LexidPerdob.ChildLexidCnt;
    Integer Cnt := Count(Group);
End;

Export Countfile3 := Table(LexidPerdob, CountedLexidPerDob, -ChildLexidCnt);

// 5. Lexids with high counts of different dobs
Export Layout_doblexid := Record
     SequenceSSN0;
     Unsigned4 ChildDobCnt;
     Dataset(Sequencedob) DobLexid;
End;

Layout_doblexid ParentRecLexidDob( SequenceSSN0 Le ) := Transform
    Self.ChildDobCnt := 0;
    Self.DobLexid := [];
    Self := Le;
End;
ParentOnly4 := Project( ds1, ParentRecLexidDob(Left));
Layout_doblexid ChildRecdobLexid( Layout_doblexid Le, SequenceDob Ri, Integer RecordCnt) := Transform
    Self.ChildDobCnt := RecordCnt;
    Self.DobLexid := Le.DobLexid + Ri;
    Self := Le;
End;
File4 := Denormalize(ParentOnly4, ds4, Left.Lexid = Right.Lexid, ChildRecDobLexid(Left, Right, Counter));
Export DobLexid := Sort(file4, -ChildDobCnt);

// Count all how many child records
Counteddoblexidchild := Record
    Doblexid.ChildDobCnt;
    Integer cnt := Count(Group);
End;

Export countfile4 := Table(doblexid, Counteddoblexidchild, -ChildDobcnt);
End;