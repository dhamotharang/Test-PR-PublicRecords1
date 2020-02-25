/* 
please start working on a module with exports. 
Each export should populate one of these tables, and additional exports to provide drill down on the top values in these summary tables. 
Please ignor 1.c (business names). The deliverable here is a code module that we will add to the header folder which we can call to generate these tables and drill down
*/ 

Import $, STD;
Import AID;

// Slimmed files from the original header file
infile0 := $.UID_New_Persons.File; // Already deduped 
infile2 := $.New_Persons.File; // Already deduped
infile3 := $.File_Person_Header.File;
infile4 := $.Address_Module.File; 

Export Analytics_Report := Module 

// 1. NAMES

// A. Most common names accross all records

// Most common first names
t_fname := Record
    fname := infile2.fname;
    Integer RecordCnt := Count(Group);
End;
c_fname := Table(infile2, t_fname, fname);
Export Sorted_c_fname := Sort(c_fname, -RecordCnt);

// Most common middle names 
t_mname := Record
    mname := infile2.mname;
    Integer RecordCnt := Count(Group);
End;
c_mname := Table(infile2, t_mname, mname);
Export Sorted_c_mname := Sort(c_mname, -RecordCnt);

// Most common last names
t_lname := Record
    lname := infile2.lname;
    Integer RecordCnt := Count(Group);
End;
c_lname := Table(infile2, t_lname, lname);
Export Sorted_c_lanme := Sort(c_lname, -RecordCnt);

// join all NAMES results on one report

// B. Most common names across diffeent lexids 

// Most common first names accross lexids 
t_fname2 := Record
    infile2.fname;
    infile2.lexid;
End;

c_fname2 := Table(infile2, t_fname2, lexid, fname);
dc_fname2 := Distribute(c_fname2, Hash(lexid, fname));
sdc_fname2 := Sort(dc_fname2, lexid, fname, Local);
dsdc_fname2 := Dedup(sdc_fname2, lexid, fname, Local);

Filteredfname := dsdc_fname2( NOT fname = '' );

crosstab_fname := Record
    Filteredfname.fname;
    Recordcnt := Count(Group);
End;

Out_Crosstab_fname := Table(Filteredfname, crosstab_fname, fname);
Export S_Crosstab_fname := Sort(Out_Crosstab_fname, -RecordCnt);

// Most common middle names accross lexid
t_mname2 := Record
    infile2.mname;
    infile2.lexid;
End;

c_mname2 := Table(infile2, t_mname2, lexid, mname);
dc_mname2 := Distribute(c_mname2, Hash(Lexid, mname));
sdc_mname2 := Sort(dc_mname2, lexid, mname, Local);
dsdc_mname2 := Dedup(sdc_mname2, lexid, mname, Local);

Filteredmname := dsdc_mname2( NOT mname = '');

crosstab_mname := Record
    filteredmname.mname;
    RecordCnt := Count(Group);
END;

Out_Crosstab_mname := Table(filteredmname, crosstab_mname, mname);
Export S_Crosstab_mname := Sort(Out_Crosstab_mname, -RecordCnt);

// Most common last names accross lexids
t_lname2 := Record
    infile2.lname;
    infile2.lexid;
End;

c_lname2 := Table(infile2, t_lname2, lexid, lname);
dc_lname2 := Distribute(c_lname2, Hash(Lexid, lname));
sdc_lname2 := Sort(dc_lname2, lexid, lname, Local);
dsdc_lname2 := Dedup(sdc_lname2, lexid, lname, Local);

Filteredlname := dsdc_lname2( NOT lname = '');

crosstab_lname := Record
    Filteredlname.lname;
    RecordCnt := Count(Group);
End;

Out_Crosstab_lname := Table(filteredlname, crosstab_lname, lname);
Export S_Crosstab_lname := Sort(Out_Crosstab_lname, -RecordCnt);

// 2. SSN
// A. Most common SSN accross ALL records( non blank);

Filteredssn := infile0( NOT ssn = ''); // non blank

t_ssn := Record
    SSN := Filteredssn.ssn;
    integer RecordCnt := Count(Group);
End;
c_ssn := Table(Filteredssn, t_ssn, ssn);
Export Sorted_c_ssn := Sort(c_ssn, -RecordCnt);

// SSN accross lexid
Filteredssn := infile0( NOT ssn = ''); // non blank

t_ssn2 := Record
    Filteredssn.lexid;
    Filteredssn.ssn;
End;

c_ssn2 := Table(Filteredssn, t_ssn2, lexid, ssn);
dc_ssn2 := Distribute(c_ssn2, Hash(lexid, ssn));
sdc_ssn2 := Sort(dc_ssn2, lexid, ssn, Local);
dsdc_ssn2 := Dedup(sdc_ssn2, lexid, ssn, Local);

crosstab_ssn := Record
    dsdc_ssn2.lexid;
    dsdc_ssn2.ssn;
    RecordCnt := Count(Group);
END;

Out_Crosstab_ssn := Table(dsdc_ssn2, crosstab_ssn, lexid, ssn);
Export S_Crosstab_ssn := Sort(Out_Crosstab_ssn, -RecordCnt);

// 3. Address
//    A. Addresses with the highest count of different lexids

// Get the multiples of addresses per lexids

infile := $.Address_Module.File;

Rec_Address := Record
    infile.Lexid;
    infile.prim_range;
    infile.prim_name;
    infile.unit_desig;
    infile.sec_range;
    infile.st;
    infile.zip;
End;

Addy_Rec := Table(infile, Rec_Address);
sdc_Addy_Rec := Sort(Addy_Rec, Record, Local);                                        
Export dsdc_Addy_Rec := Dedup(sdc_Addy_Rec, Record, Local);

C_Rec_Address := Record
    dsdc_Addy_Rec.Lexid;
    dsdc_Addy_Rec.prim_name;
    dsdc_Addy_Rec.unit_desig;
    dsdc_Addy_Rec.sec_range;
    dsdc_Addy_Rec.st;
    dsdc_Addy_Rec.zip;
    RecordCnt := Count(Group);
End;

c_Addy_Rec := Table(dsdc_Addy_Rec, C_Rec_Address);
Export st_Addy_Rec := Sort(c_Addy_Rec, -RecordCnt);

// Write code that would elimate blank addresses
// a blank address is defined as an address that is missing all fields

// Count the multipes of lexids



// Date of Birth
//  A. Most common DOB accross all records
Filtereddob := infile2( NOT dob = 0);

Sequencedob := Record
    Filtereddob.dob;
    RecordCnt := Count(Group);
End;

t_Crosstab_Dob := Table(Filtereddob, Sequencedob, dob);
Export st_Crosstab_Dob := Sort(t_Crosstab_Dob, -RecordCnt);

// B. Full Dob with the highest counts of different Lexids ( no 00/Blank)

// dob is integer4
// MMDDYY Dobs without trailing zeroes
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(YY + MM + DD);
End;

FilteredDobs := $.New_Persons.File( Not dob = 0);

Rec := Record
    Lexid := Filtereddobs.lexid;
    Dob := Filtereddobs.dob;
    Src := Filtereddobs.src;
End;

Rec SlimRec( Filtereddobs Le ) := Transform
  Self.dob := LoseTrailingZeroes(le.dob);
  Self := Le;
End;

Shared RecSlim := Project(FilteredDobs, SlimRec(Left));

NonBlankDob := Record
  RecSlim.dob;
End;

c_dob := Table(RecSlim, Nonblankdob, dob);
dc_dob := Distribute(c_dob, Hash(dob));
sdc_dob := Sort(dc_dob, dob, Local);
Shared dsdc_dob := Dedup(sdc_dob, dob, Local);

crosstab_dob := Record
  RecSlim.dob;
  RecordCnt := Count(Group);
End;

Out_Crosstab_dob := Table(RecSlim, crosstab_dob, dob);
Export S_Crosstab_dob := Sort(Out_Crosstab_dob, -RecordCnt);


// C. Partial Dob (MMDD : month and day) with the highest count of different lexids (no 00 / blank)

// mm/dd dob without trailing zeroes
LoseTrailingZeroesMD(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(MM + DD);
End;

FilteredDobs := $.New_Persons.File( Not dob = 0);

Rec := Record
    Lexid := Filtereddobs.lexid;
    Dob := Filtereddobs.dob;
    Src := Filtereddobs.src;
End;

// MMDD dobs
Rec SlimRec1( Filtereddobs Le ) := Transform
    Self.dob := LoseTrailingZeroesMD(Le.dob);
    Self := Le;
End;

Shared RecSlimMMDD := Project(FilteredDobs, SlimRec1(Left));

NonblankDobMMDD := Record
    RecSlimMMDD.dob;
End;

c_dobMMDD := Table(RecSlimMMDD, NonblankdobMMDD, dob);
dc_dobMMDD := Distribute(c_dobMMDD, Hash(dob));
sdc_dobMMDD := Sort(dc_dobMMDD, dob, Local);
Shared dsdc_dobMMDD := Dedup(sdc_dobMMDD, dob, Local);

crosstab_dobMMDD := Record
  RecSlimMMDD.dob;
  RecordCnt := Count(Group);
End;

Out_Crosstab_dobMMDD := Table(RecSlimMMDD, crosstab_dobMMDD, dob);
Export S_Crosstab_dobMMDD := Sort(Out_Crosstab_dobMMDD, -RecordCnt);

//Converting dates (optional)
//converted_date := Std.Date.ConvertDateFormat(Result, '%Y%m%d', '%m/%d/%y'); // need to convert to this format
//Output(converted_date, Named('Date_Results_Converted'));

// D. Sources with the highest count of blank and partially blank dob

// Count of blank yyyymmdd
Shared BlankDobsOnly := infile2( dob =  0 );

Export CountedBlankDobs := Count(BlankdobsOnly); // 33714


// Count of blank mmdd (non-blank yyyy)
Rec_BlankYYYYMMDD := Record
    BlankDobsOnly.dob;
    BlankDobsOnly.src;
    RecordCnt := Count(Group);
End;

Sample_RecSlim := Table(BlankDobsOnly, Rec_BlankYYYYMMDD, dob, src, Merge);
Export S_Sample_RecSlim := Sort(Sample_Recslim, -RecordCnt);

// Count blank DD ( non-blank YYYYMM )
Rec_BlankMMDD := Record
    RecSlimMMDD.dob;
    RecSlimMMDD.src;
    RecordCnt := Count(Group);
End;

Sample_RecSLim1 := Table(RecSlimMMDD, Rec_BlankMMDD, dob, src);
Export S_Sample_RecSlim1 := Sort(Sample_RecSlim1, -RecordCnt);

// Count of blank dd (non-blank yyyymm)


// E. Dob normal distribution score ( measure of normality accross all non-zero per lexid Dob)

/* Requirements:
U = Population Mean
Ox = Standard Deviation
Pie = 3.14159...
e = 2.71828... Expectation Value
*/ 




End; // Do not delete 