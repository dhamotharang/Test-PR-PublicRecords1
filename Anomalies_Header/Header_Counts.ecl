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

t := Table(input, Layouts.Layout_Header, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src);

dt := Distribute(t, hash(did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src));

sdt := Sort(dt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src, Local);

header := Dedup(sdt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src);


Export Header_Counts := Module 
// 1. NAMES
// A. Most common names accross all records

// Most common first names
t_fname := Record
    fname := header.fname;
    Integer RecordCnt := Count(Group);
End;
c_fname := Table(header, t_fname, fname);
Export fnames_across_file := Sort(c_fname, -RecordCnt);


// Most common last names
t_lname := Record
    lname := header.lname;
    Integer RecordCnt := Count(Group);
End;
c_lname := Table(header, t_lname, lname);
Export lanmes_across_file := Sort(c_lname, -RecordCnt);


// B. Most common names across diffeent lexids 
// Most common first names accross lexids 
t_fname2 := Record
    header.did;
    header.fname;
End;

c_fname2 := Table(header, t_fname2, did, fname);
dc_fname2 := Distribute(c_fname2, Hash(did, fname));
sdc_fname2 := Sort(dc_fname2, did, fname, Local);
dsdc_fname2 := Dedup(sdc_fname2, did, fname, Local);

crosstab_fname := Record
    dsdc_fname2.fname;
    recordcnt := Count(Group);
End;

out_crosstab_fname := Table(dsdc_fname2, crosstab_fname, fname);
Export fnames_across_lexid := Sort(out_crosstab_fname, -RecordCnt);


// Most common last names accross lexids
t_lname2 := Record
    header.lname;
    header.did;
End;

c_lname2 := Table(header, t_lname2, did, lname);
dc_lname2 := Distribute(c_lname2, Hash(did, lname));
sdc_lname2 := Sort(dc_lname2, did, lname, Local);
dsdc_lname2 := Dedup(sdc_lname2, did, lname, Local);

crosstab_lname := Record
    dsdc_lname2.lname;
    recordcnt := Count(Group);
End;

out_crosstab_lname := Table(dsdc_lname2, crosstab_lname, lname);
Export lnames_across_lexid := Sort(out_crosstab_lname, -RecordCnt);


// 2. SSN
// A. Most common SSN accross ALL records( non blank); 

filteredssn := header( NOT ssn = ''); // non blank

t_ssn := Record
    ssn := Filteredssn.ssn;
    integer recordcnt := Count(Group);
End;
c_ssn := Table(Filteredssn, t_ssn, ssn);
Export ssn_across_file := Sort(c_ssn, -RecordCnt);


// SSN with top count of Different lexids (no blank SSN nor blank lexids)
filteredssn := header( NOT ssn = '' AND Not did = 0); // non blank ssn nor did

t_ssn2 := Record
    filteredssn.did;
    filteredssn.ssn;
End;

c_ssn2 := Table(filteredssn, t_ssn2, did, ssn );
dc_ssn2 := Distribute(c_ssn2, Hash(did, ssn ));
sdc_ssn2 := Sort(dc_ssn2, did, ssn, Local );
Shared dsdc_ssn2 := Dedup(sdc_ssn2, did, ssn, Local );

// Layouts for parent and child record 
Shared lexidperssn := Record
 qstring ssn;
 integer did;
End;

Shared parentRecordssn := Project(dsdc_ssn2, lexidperssn);

t1_ssn := Table(parentRecordssn, {ssn, did}, ssn, did);

t2_ssn := Table(t1_ssn, {ssn, lexidcnt := count(group)}, ssn);

Export lexids_per_ssn := Sort(t2_ssn, -lexidcnt);


// 3. Address
//    A. Addresses with the highest count of (Different) LexIds 

// Get the multiples of addresses per lexids
Rec_Address := Record
    header.did;
    header.prim_range;
    header.prim_name;
    header.unit_desig;
    header.sec_range;
    header.st;
    header.zip;
End;

addressRec := Table(header, Rec_Address, did, prim_range, prim_name, unit_desig, 
                               sec_range, st, zip);
sdc_addressRec := Sort(addressRec, did, prim_range, prim_name, unit_desig, 
                               sec_range, st, zip , Local);                                        
Shared dsdc_addressRec := Dedup(sdc_addressRec, did, prim_range, prim_name, unit_desig, 
                               sec_range, st, zip , Local);

Shared lexidperaddress := Record
  string  prim_range;
  string  unit_desig;
  string  sec_range;
  string  st;
  string  zip;
  integer did;
End;

Shared parentRecordAddress := Project(dsdc_addressRec, lexidperaddress);

t1_address := Table(parentRecordAddress, {prim_range, unit_desig, sec_range, st, zip, did},
                                         prim_range, unit_desig, sec_range, st, zip, did);

t2_address := Table(t1_address, {prim_range, unit_desig, sec_range, st, zip, lexidcnt := count(group)}, 
                                prim_range, unit_desig, sec_range, st, zip);

Export lexids_per_address := Sort(t2_address, -lexidcnt);




// ========================================== Second Part of Report ======================================================

// Date of Birth
//  A. Most common DOB accross all records
Sequencedob := Record
    header.dob;
    recordcnt := Count(Group);
End;

t_Crosstab_Dob := Table(header, Sequencedob, dob);
Export dob_across_file := Sort(t_crosstab_Dob, -RecordCnt);


// B. Full Dob with the highest counts of (different Lexids) ( no 00/Blank)
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]= '00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(MM + DD + YY );
End;

filteredDob := header( NOT dob = 0);

sequenceDobLexid := Record
    filteredDob.did;
    filteredDob.dob;
End;

sequenceDobLexid SlimRecdob( filteredDob Le ) := TRANSFORM
  Self.dob := LoseTrailingZeroes(Le.dob);
  Self := Le;
END;

t_crosstab_DobLexid := Project(filteredDob, slimrecDob(Left));

// Filter to only output full dobs without blanks 


st_crosstab_DobLexid := Sort(t_crosstab_DobLexid, did, dob);
Shared dst_crosstab_DobLexid := Dedup(st_crosstab_DobLexid, did, dob);

// Filter to capture full dobs only

Shared lexiddob := Record
  integer dob;
  integer did;
End;

Shared parentRecordsDob := Project(dst_crosstab_DobLexid, lexiddob);

t1_dob := Table(parentRecordsDob, {dob, did}, dob, did);

t2_dob := Table(t1_dob, {dob, lexidcnt := Count(Group)}, dob);

Export lexids_per_dob := Sort(t2_dob, -lexidcnt);

// C. Partial Dob (MMDD : month and day) with the highest count of (different lexids) (no 00 / blank)
// still shows zeroes 
// mm/dd dob without trailing zeroes
LoseTrailingZeroesMD(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]= '00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(MM + DD + YY );
End;

filteredDobs := header( Not dob = 0);

// filter to capture partial dobs only

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

RecSlimMMDD := Project(FilteredDobs, SlimRec1(Left));

NonblankDobMMDD := Record
    RecSlimMMDD.dob;
End;

c_dobMMDD := Table(RecSlimMMDD, NonblankdobMMDD, dob);
dc_dobMMDD := Distribute(c_dobMMDD, Hash(dob));
sdc_dobMMDD := Sort(dc_dobMMDD, dob, Local);
Export dsdc_dobMMDD := Dedup(sdc_dobMMDD, dob, Local);

crosstab_dobMMDD := Record
  dsdc_dobMMDD.dob;
  RecordCnt := Count(Group);
End;

Out_Crosstab_dobMMDD := Table(dsdc_dobMMDD, crosstab_dobMMDD, dob);
Export S_Crosstab_MMDD := Sort(Out_Crosstab_dobMMDD, -RecordCnt);





// D. Sources with the highest count of blank and partially blank DOB  

// Count of blank YYYYMMDD 
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(MM + DD + YY );
End;

// Filters to eliminate all 0s
FilteredDobs := header( dob = 0 );

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
  dsdc_dob.dob;
  RecordCnt := Count(Group);
End;

Out_Crosstab_dob := Table(RecSlim, crosstab_dob, dob);
Export s_crosstab_blankdob := Sort(Out_Crosstab_dob, -RecordCnt);

// Count of blank MMDD (non-blank YYYY) 




// Count of blank dd (non-blank yyyymm)
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)( MM + YY );
End;

filteredDobs := header( Not dob = 0 );

rec_dd := Record
    unsigned6 did;
    integer6  dob;
    string2   src;
End;

rec_dd SlimRec( filteredDobs Le ) := Transform
  Self.dob := LoseTrailingZeroes(le.dob);
  Self := Le;
End;

Export recslim_dd := Project(filteredDobs, SlimRec(Left));

blankdd := Record
  recslim_dd.dob;
End;

c_dob := Table(recslim_dd, blankdd, dob);
dc_dob := Distribute(c_dob, Hash(dob));
sdc_dob := Sort(dc_dob, dob, Local);
Shared dsdc_dobdd := Dedup(sdc_dob, dob, Local);

crosstab_dob := Record
  dsdc_dobdd.dob;
  recordCnt := Count(Group);
End;

out_crosstab_dobdd := Table(dsdc_dobdd, crosstab_dob, dob);
Export s_crosstab_dobdd := Sort(out_Crosstab_dobdd, -RecordCnt);


// E. Dob normal distribution score ( measure of normality accross all non-zero per lexid Dob)
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(MM + DD + YY );
End;

filteredDobLexid := header( NOT dob = 0 AND Not did = 0);

normaldist := Record
    Integer6  dob;
    Unsigned6 lexid_count;
End;

normaldist SlimRec( filteredDobLexid Le ) := Transform
    did := Group(filteredDobLexid, did);
    Self.dob := LoseTrailingZeroes(Le.dob);
    Self.lexid_count := Count(did);
End;

Export normal_distribution := Project(filteredDobLexid, SlimRec(Left));


End; // Do not delete 