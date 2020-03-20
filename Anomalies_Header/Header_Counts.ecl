/* 
please start working on a module with exports. 
Each export should populate one of these tables, and additional exports to provide drill down on the top values in these summary tables. 
Please ignor 1.c (business names). The deliverable here is a code module that we will add to the header folder which we can call to generate these tables and drill down
*/ 

Import Anomalies_Header;
Import STD;
Import AID;

Layout_Header := Anomalies_Header.Layouts.Layout_Header;

// Slimmed files from the original header file
input := Anomalies_Header.Files.Header; 

// dedup here

t := Table(input, Layout_Header, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src);

dt := Distribute(t, Hash(did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src));

sdt := Sort(dt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src, Local);

infile := Dedup(sdt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src);

Export Header_Counts := Module 

// 1. NAMES

// A. Most common names accross all records

// Most common first names
t_fname := Record
    fname := infile.fname;
    Integer RecordCnt := Count(Group);
End;
c_fname := Table(infile, t_fname, fname);
Export Sorted_c_fname := Sort(c_fname, -RecordCnt);

// Most common last names
t_lname := Record
    lname := infile.lname;
    Integer RecordCnt := Count(Group);
End;
c_lname := Table(infile, t_lname, lname);
Export Sorted_c_lanme := Sort(c_lname, -RecordCnt);

// B. Most common names across diffeent lexids 

// Most common first names accross lexids 
t_fname2 := Record
    infile.fname;
    infile.did;
End;

c_fname2 := Table(infile, t_fname2, did, fname);
dc_fname2 := Distribute(c_fname2, Hash(did, fname));
sdc_fname2 := Sort(dc_fname2, did, fname, Local);
dsdc_fname2 := Dedup(sdc_fname2, did, fname, Local);

Filteredfname := dsdc_fname2( NOT fname = '' );

crosstab_fname := Record
    Filteredfname.fname;
    Recordcnt := Count(Group);
End;

Out_Crosstab_fname := Table(Filteredfname, crosstab_fname, fname);
Export S_Crosstab_fname := Sort(Out_Crosstab_fname, -RecordCnt);


// Most common last names accross lexids
t_lname2 := Record
    infile.lname;
    infile.did;
End;

c_lname2 := Table(infile, t_lname2, did, lname);
dc_lname2 := Distribute(c_lname2, Hash(did, lname));
sdc_lname2 := Sort(dc_lname2, did, lname, Local);
dsdc_lname2 := Dedup(sdc_lname2, did, lname, Local);

Filteredlname := dsdc_lname2( NOT lname = '');

crosstab_lname := Record
    Filteredlname.lname;
    RecordCnt := Count(Group);
End;

Out_Crosstab_lname := Table(filteredlname, crosstab_lname, lname);
Export S_Crosstab_lname := Sort(Out_Crosstab_lname, -RecordCnt);

// 2. SSN
// A. Most common SSN accross ALL records( non blank);

Filteredssn := infile( NOT ssn = ''); // non blank

t_ssn := Record
    SSN := Filteredssn.ssn;
    integer RecordCnt := Count(Group);
End;
c_ssn := Table(Filteredssn, t_ssn, ssn);
Export Sorted_c_ssn := Sort(c_ssn, -RecordCnt);

// SSN accross lexid
Filteredssn := infile( NOT ssn = ''); // non blank

t_ssn2 := Record
    Filteredssn.did;
    Filteredssn.ssn;
End;

c_ssn2 := Table(Filteredssn, t_ssn2, did, ssn);
dc_ssn2 := Distribute(c_ssn2, Hash(did, ssn));
sdc_ssn2 := Sort(dc_ssn2, did, ssn, Local);
dsdc_ssn2 := Dedup(sdc_ssn2, did, ssn, Local);

crosstab_ssn := Record
    dsdc_ssn2.did;
    dsdc_ssn2.ssn;
    RecordCnt := Count(Group);
END;

Out_Crosstab_ssn := Table(dsdc_ssn2, crosstab_ssn, did, ssn);
Export S_Crosstab_ssn := Sort(Out_Crosstab_ssn, -RecordCnt);



// 3. Address
//    A. Addresses with the highest count of different lexids

// Get the multiples of addresses per lexids


Rec_Address := Record
    infile.did;
    infile.prim_range;
    infile.prim_name;
    infile.unit_desig;
    infile.sec_range;
    infile.st;
    infile.zip;
End;

Addy_Rec := Table(infile, Rec_Address);
sdc_Addy_Rec := Sort(Addy_Rec, did, prim_range, prim_name, unit_desig, 
                               sec_range, st, zip , Local);                                        
Export dsdc_Addy_Rec := Dedup(sdc_Addy_Rec, did, prim_range, prim_name, unit_desig, 
                               sec_range, st, zip , Local);

C_Rec_Address := Record
    dsdc_Addy_Rec.did;
    dsdc_Addy_Rec.prim_range;
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
Filtereddob := infile( NOT dob = 0);

Sequencedob := Record
    Filtereddob.dob;
    RecordCnt := Count(Group);
End;

t_Crosstab_Dob := Table(Filtereddob, Sequencedob, dob);
Export st_Crosstab_Dob := Sort(t_Crosstab_Dob, -RecordCnt);






// B. Full Dob with the highest counts of different Lexids ( no 00/Blank)

// dob is integer4
// MMDDYYYY Dobs without trailing zeroes
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(YY + MM + DD);
End;

// Filters to eliminate all 0s
FilteredDobs := infile( Not dob = 0);

Rec := Record
    Filtereddobs.did;
    Filtereddobs.dob;
    Filtereddobs.src;
End;

Rec SlimRec( Filtereddobs Le ) := Transform
  Self.dob := LoseTrailingZeroes(Le.dob);
  Self := Le;
End;

Export RecSlim := Project(FilteredDobs, SlimRec(Left));

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
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]= '00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(MM + DD);
End;

FilteredDobs := infile( Not dob = 0);

Rec := Record
    Filtereddobs.did;
    Filtereddobs.dob;
    Filtereddobs.src;
End;

// MMDD dobs
Rec SlimRec1( Filtereddobs Le ) := Transform
    Self.dob := LoseTrailingZeroesMD(Le.dob);
    Self := Le;
End;

Export RecSlimMMDD := Project(FilteredDobs, SlimRec1(Left));

NonblankDobMMDD := Record
    RecSlimMMDD.dob;
End;

c_dobMMDD := Table(RecSlimMMDD, NonblankdobMMDD, dob);
dc_dobMMDD := Distribute(c_dobMMDD, Hash(dob));
sdc_dobMMDD := Sort(dc_dobMMDD, dob, Local);
Export dsdc_dobMMDD := Dedup(sdc_dobMMDD, dob, Local);

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
Shared BlankDobsOnly := infile( dob =  0 );

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

LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(YY + MM );
End;

FilteredDobs := infile( Not dob = 0);

Rec_x := Record
    Filtereddobs.did;
    Filtereddobs.dob;
    Filtereddobs.src;
End;

Rec_x SlimRec( Filtereddobs Le ) := Transform
  Self.dob := LoseTrailingZeroes(le.dob);
  Self := Le;
End;

Export RecSlim_x := Project(FilteredDobs, SlimRec(Left));





// E. Dob normal distribution score ( measure of normality accross all non-zero per lexid Dob)

/* Requirements:
U = Population Mean
Ox = Standard Deviation
Pie = 3.14159...
e = 2.71828... Expectation Value
*/ 
End; // Do not delete 