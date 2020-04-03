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
    ssn := filteredssn.ssn;
    integer recordcnt := Count(Group);
End;
c_ssn := Table(filteredssn, t_ssn, ssn);
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



// Filters dobs from header to dobs without trailing zeros
// From here we filter to partial dob filtering
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)(YY + MM + DD );
End;

dobFile := Record
  unsigned dob;
  integer  did;
End;

dobFile SlimRec( header Le ) := Transform
  Self.did := Le.did;
  Self.dob := LoseTrailingZeroes(Le.dob);
End;

dob_file := Project(Header, SlimRec(Left));
filteredDob := dob_file( Not dob = 0 AND Not did = 0 );
input_dobs := Sort(filteredDob, did, dob);
Shared dst_crosstab_DobLexid := Dedup(input_dobs, did, dob);

// B. Full Dob with the highest counts of (different Lexids) ( no 00/Blank)
// // Filter to only output full dobs without any blanks 
lexidDob := Record
  unsigned validDob;
  unsigned dob;
  integer  did;
End;

// Validate full dobs 
lexidDob FilterDates( dst_crosstab_DobLexid Le ) := Transform
  Self.validDob :=(unsigned)STD.Date.IsValidDate(Le.dob);
  Self.dob := Le.dob;
  Self.did := Le.did;
End;

// Validated full dobs with 0s and 1s
Shared parentRecordsDob := Project(dst_crosstab_DobLexid, FilterDates(Left));

// Filtering valids dobs only (flagged with 1s)
Shared filterFullDob := parentRecordsDob( validDob = 1 );

t1_dob := Table(filterFullDob, {dob, did}, dob, did);

t2_dob := Table(t1_dob, {dob, lexidcnt := Count(Group)}, dob);

Export lexids_per_fulldob := Sort(t2_dob, -lexidcnt);



// C. Partial Dob (MMDD : month and day) with the highest count of (different lexids) (no 00 / blank)

LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)( MM + DD );
End;

mmdd_dob_only := Record
  unsigned mmdd_dob;
  integer  did;
End;


mmdd_dob_only FilterMMDD( Header Le ) := Transform
  Self.mmdd_dob := LoseTrailingZeroes(Le.dob);
  Self.did := Le.did;
End;

result_mmdd_only := Project(Header, FilterMMDD(Left));

sorted_input := Sort(result_mmdd_only, mmdd_dob, did, local);

dedup_input := Dedup(sorted_input, mmdd_dob, did);

t1_dob_mmdd := Table(dedup_input, {mmdd_dob, did}, mmdd_dob, did);

t2_dob_mmdd := Table(t1_dob_mmdd, {mmdd_dob, lexidcnt := Count(Group)}, mmdd_dob);

Export lexids_per_mmdddob := Sort(t2_dob_mmdd, -lexidcnt);


// D. Sources with the highest count of blank and partially blank DOB  
// Count of blank YYYYMMDD 
Export blankDobs := Header( dob = 0);

NonBlankDob := Record
  blankDobs.dob;
  blankDobs.src;
End;

t_dob := Table(blankDobs, Nonblankdob );

crosstab_dob := Record
  t_dob.src;
  blank_dob_cnt := Count(Group);
End;

Out_Crosstab_dob := Table(t_dob, crosstab_dob, src);
Export blank_dob_persource := Sort(Out_Crosstab_dob, -blank_dob_cnt);

/// Count of blank MMDD (non-blank YYYY) 

LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)( YY );
End;

blankmmdd := Record
  unsigned dob_year;
  integer  did;
  string   src;
End;

blankmmdd FliterDobsYYYY( Header Le ) := Transform
  Self.dob_year := LoseTrailingZeroes(Le.dob);
  Self.did := Le.did;
  Self.src := Le.src;
End;

result_dob_year := Project(Header, FliterDobsYYYY(Left));

nonblank_year := result_dob_year( Not dob_year = 0);

crosstab_dobyear := Record
  nonblank_year.src;
  blank_mmdd_cnt := Count(Group);
End;

Out_Crosstab_dob := Table(nonblank_year, crosstab_dobyear, src);
Export blank_mmdd_persource := Sort(Out_Crosstab_dob, -blank_mmdd_cnt);


// // Count of blank dd (non-blank yyyymm)
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' AND DD='','',dob[5..6]);
  Return (Unsigned8)( YY + MM );
End;

blankdd := Record
  unsigned dob_yyyymm;
  integer  did;
  string   src;
End;

blankdd FilterDobsMMYYYY( Header Le ) := Transform
  Self.dob_yyyymm := LoseTrailingZeroes(Le.dob);
  Self.did := Le.did;
  Self.src := Le.src;
End;

result_dob_mmyyyy := Project(Header, FilterDobsMMYYYY(Left));

nonblank_mmyyyy := result_dob_mmyyyy( Not dob_yyyymm = 0 );

crosstab_mmyyyy := Record
  nonblank_mmyyyy.src;
  blank_dd_cnt := Count(Group);
End;

out_crosstab_dob := Table(nonblank_mmyyyy, crosstab_mmyyyy);
Export blank_dd_persource := Sort(out_crosstab_dob, - blank_dd_cnt);


// // E. Dob normal distribution score ( measure of normality accross all non-zero per lexid Dob)

// filteredFullDobLexid := filterFullDob( NOT dob = 0 AND Not did = 0);

// normaldist := Record
//     Integer   did;
//     string  dob_mmdd;
// End;

// normaldist distSlim( filteredFullDobLexid Le ) := Transform
//   Self.did := Le.did;
//   Self.dob_mmdd := Le.dob[5..8];
// End;

// result_normdist := Project(filteredFullDobLexid, distSlim(Left));

// t1_dob := Table(result_normdist, {dob_mmdd, did}, dob_mmdd, did);

// t2_dob := Table(t1_dob, {dob_mmdd, lexidcnt := Count(Group)}, dob_mmdd);

// Export normal_distribution := Sort(t2_dob, -lexidcnt);

End; // Do not delete 