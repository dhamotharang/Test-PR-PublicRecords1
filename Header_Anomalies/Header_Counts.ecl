

Import STD, AID;



layout_header := Header_Anomalies.Layouts.Layout_Header;
// Slimmed files from the original header file
infile := Header_Anomalies.Files.Header; 



// dedup here
t := Table(infile, layouts.layout_header, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src );

dt := Distribute(t, hash(did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src ));

sdt := Sort(dt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src, Local );

header := Dedup(sdt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src );



Export Header_Counts := Module 

// 1. NAMES
// A. Most common names accross all records

// Filter out blanks in fnames and lnames, shared for reusability
Shared fname_filter := header( Not fname = '');
Shared lname_filter := header( Not lname = '');


// Most common first names
layout_fname := Record
    fname_filter.fname;
    fname_count := Count(Group);
End;
table_fname := Table(fname_filter, layout_fname, fname );
Export fnames_across_file := Sort(table_fname, -fname_count );



// Most common last names
layout_lname := Record
    lname_filter.lname;
    lname_count := Count(Group);
End;
table_lname := Table(lname_filter, layout_lname, lname );
Export lanmes_across_file := Sort(table_lname, -lname_count );



// B. Most common names across diffeent lexids 

// Most common first names accross lexids 
layout_fnamelexid := Record
    fname_filter.did;
    fname_filter.fname;
End;

c_fname2 := Table(fname_filter, layout_fnamelexid, did, fname );
dc_fname2 := Distribute(c_fname2, Hash(did, fname ));
sdc_fname2 := Sort(dc_fname2, did, fname, Local );
dsdc_fname2 := Dedup(sdc_fname2, did, fname, Local );

crosstab_fname := Record
    dsdc_fname2.fname;
    fnamecnt_across_lexid := Count(Group);
End;

out_crosstab_fname := Table(dsdc_fname2, crosstab_fname, fname );
Export fnames_across_lexid := Sort(out_crosstab_fname, -fnamecnt_across_lexid );



// Most common last names accross lexids
layout_lnamelexid := Record
    lname_filter.lname;
    lname_filter.did;
End;

c_lname2 := Table(lname_filter, layout_lnamelexid, did, lname );
dc_lname2 := Distribute(c_lname2, Hash(did, lname ));
sdc_lname2 := Sort(dc_lname2, did, lname, Local );
dsdc_lname2 := Dedup(sdc_lname2, did, lname, Local );

crosstab_lname := Record
    dsdc_lname2.lname;
    lnamecnt_across_lexid := Count(Group);
End;

out_crosstab_lname := Table(dsdc_lname2, crosstab_lname, lname );
Export lnames_across_lexid := Sort(out_crosstab_lname, -lnamecnt_across_lexid );



// 2. SSN
// A. Most common SSN accross ALL records( non blank); 
filteredssn := header( Not ssn = '' ); // non blank

t_ssn := Record
    filteredssn.ssn;
    ssn_count := Count(Group);
End;

c_ssn := Table(filteredssn, t_ssn, ssn);
Export ssn_across_file := Sort(c_ssn, -ssn_count );


// SSN with top count of Different lexids (no blank SSN nor blank lexids)
filteredssn1 := header( Not ssn = '' and Not did = 0 and Not did  < 100 ); // non blank ssn nor did, not less than 100 dids

t_ssn2 := Record
    filteredssn1.did;
    filteredssn1.ssn;
End;

c_ssn2 := Table(filteredssn1, t_ssn2, did, ssn );
dc_ssn2 := Distribute(c_ssn2, Hash(did, ssn ));
sdc_ssn2 := Sort(dc_ssn2, did, ssn, Local );
Shared dsdc_ssn2 := Dedup(sdc_ssn2, did, ssn, Local );

// Layouts for parent and child record 
layout_lexidperssn := Record
 dsdc_ssn2.ssn;
 dsdc_ssn2.did;
End;

Shared parent_recordssn := Project(dsdc_ssn2, layout_lexidperssn );

t1_ssn := Table(parent_recordssn, {ssn, did}, ssn, did );

t2_ssn := Table(t1_ssn, {ssn, lexidcnt_per_ssn := Count(Group)}, ssn );

Export lexids_per_ssn := Sort(t2_ssn, -lexidcnt_per_ssn );



// 3. Address
//    A. Addresses with the highest count of (Different) LexIds 

// Get the multiples of addresses per lexids
layout_address := Record
    header.did;
    header.prim_range;
    header.prim_name;
    header.sec_range;
    header.st;
    header.zip;
End;

addressRec := Table(header, layout_address, did, prim_range, prim_name, sec_range,
                                st, zip );
sdc_addressRec := Sort(addressRec, did, prim_range, prim_name, sec_range,
                                st, zip , Local );                                        
Shared dsdc_addressRec := Dedup(sdc_addressRec, did, prim_range, prim_name, sec_range,
                                st, zip , Local );



Shared layout_lexidperaddress := Record
  Integer did;
  String  prim_range;
  String  prim_name;
  String  sec_range;
  String  st;
  String  zip;
End;

parentRecordAddress := Project(dsdc_addressRec, layout_lexidperaddress );

filteredAddress := parentRecordAddress( Not prim_range = '' And Not prim_name = ''  And 
                                        Not st = '' And Not zip = '' );

t1_address := Table(filteredAddress, {prim_range, prim_name, sec_range, st, zip, did},
                                         prim_range, prim_name, sec_range, st, zip, did );

t2_address := Table(t1_address, {prim_range, prim_name, sec_range, st, zip, lexidcnt_per_address := Count(Group)}, 
                                prim_range, prim_name, sec_range, st, zip );

Export lexids_per_address := Sort(t2_address, -lexidcnt_per_address );



//  4. Date of Birth
//  A. Most common DOB accross all records
filter_dob := header( Not dob = 0 );

layout_dob := Record
    filter_dob.dob;
    dob_count := Count(Group);
End;

t_crosstab_Dob := Table(filter_dob, layout_dob, dob );
Export dob_across_file := Sort(t_crosstab_dob, -dob_count );

//alidDob :=(Unsigned)STD.Date.IsValidDate(Le.dob)

// Filters dobs from header to dobs without trailing zeros
// From here we filter to partial dob filtering
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' And DD='','',dob[5..6]);
  Return (Unsigned8)(YY + MM + DD );
End;

layout_dob_file := Record
  Integer  did;
  Unsigned dob;
End;

layout_dob_file SlimRec( header Le ) := Transform
  Self.did := Le.did;
  Self.dob := LoseTrailingZeroes(Le.dob);
End;

dob_file := Project(Header, SlimRec(Left));

filtered_dob := dob_file( Not dob = 0 And Not did = 0 );

input_dobs := Sort(filtered_dob, did, dob );

Export input_dob_perlexid := Dedup(input_dobs, did, dob);



// B. Full Dob with the highest counts of (different Lexids) ( no 00/Blank)
// // Filter to only output full dobs without any blanks 
layout_lexiddob := Record
  Unsigned validDob;
  Unsigned dob;
  Integer  did;
End;

// Validate full dobs 
layout_lexiddob FilterDates( input_dob_perlexid  Le ) := Transform
  Self.validDob := (Unsigned)STD.Date.IsValidDate(Le.dob);
  Self.dob := Le.dob;
  Self.did := Le.did;
End;

// Validated full dobs with 0s and 1s
Shared parent_records_dob := Project(input_dob_perlexid, FilterDates(Left));

// Filtering valids dobs only (flagged with 1s)
Shared filter_fulldob := parent_records_dob( validDob = 1 );

t1_dob := Table(filter_fulldob, {dob, did}, dob, did);

t2_dob := Table(t1_dob, {dob, lexidcnt_per_dob := Count(Group)}, dob);

Export lexids_per_fulldob := Sort(t2_dob, -lexidcnt_per_dob);



// C. Partial Dob (MMDD : month and day) with the highest count of (different lexids) (no 00 / blank)
Export input_file := input_dob_perlexid( Not dob = 0 And Not did = 0);

mmdd_dob_only := Record
  Integer    did;
  Unsigned   dob_mmdd;
  Unsigned   dob_yyyy;
  Unsigned   dob;
End;


mmdd_dob_only FilterMMDD( input_file Le ) := Transform
  Self.did := Le.did;
  Self.dob_yyyy := (Unsigned)Le.dob[1..4]; 
  Self.dob_mmdd := (Unsigned)Le.dob[5..8]; 
  Self.dob := Le.dob;
End;

result_input := Project(input_file, FilterMMDD(Left));

result_mmdd_only := result_input( Not dob_mmdd = 0 and dob_mmdd = (Unsigned)dob_mmdd[5..8] );

result_mmdd := Table(result_mmdd_only, {did, dob}, did, dob);

t_result_mmdd := Table(result_mmdd, {dob, lexidcnt_per_dob := Count(Group)}, dob );

Export lexids_per_mmdddob := Sort(t_result_mmdd, -lexidcnt_per_dob );



// D. Sources with the highest count of blank and partially blank DOB  

// Count of blank YYYYMMDD 
blankDobs := Header( dob = 0);

NonBlankDob := Record
  blankDobs.src;
  blank_dob_count := Count(Group);
End;

t_dob := Table(blankDobs, Nonblankdob, src );
Export blank_dob_persource := Sort(t_dob, -blank_dob_count);



/// Count of blank MMDD (non-blank YYYY) 
LoseTrailingZeroes(Unsigned4 indob) := Function
  String8 dob := (String8)indob;
  String4 YY  := dob[1..4];
  String2 DD  := if(dob[7..8]='00','',dob[7..8]);
  String2 MM  := if(dob[5..6]='00' And DD='','',dob[5..6]);
  Return (Unsigned8)( YY );
End;

blankmmdd := Record
  Unsigned dob_year;
  Integer  did;
  String   src;
End;

blankmmdd FliterDobsYYYY( header Le ) := Transform
  Self.dob_year := LoseTrailingZeroes(Le.dob);
  Self.did := Le.did;
  Self.src := Le.src;
End;

result_dob_year := Project(header, FliterDobsYYYY(Left));

Export nonblank_year := result_dob_year( Not dob_year = 0);

crosstab_dobyear := Record
  nonblank_year.src;
  blank_mmdd_count := Count(Group);
End;

out_crosstab_dob := Table(nonblank_year, crosstab_dobyear, src );
Export blank_mmdd_persource := Sort(Out_Crosstab_dob, -blank_mmdd_count );



// // Count of blank dd (non-blank yyyymm)
blankdd := Record
  Unsigned dob_yyyymm;
  Integer  did;
  String   src;
End;

blankdd FilterDobsMMYYYY( header Le ) := Transform
  Self.dob_yyyymm := (Unsigned)Le.dob[1..6];
  Self.did := Le.did;
  Self.src := Le.src;
End;

result_dob_mmyyyy := Project(header, FilterDobsMMYYYY(Left));

Export nonblank_mmyyyy := result_dob_mmyyyy( Not dob_yyyymm = 0 );

crosstab_mmyyyy := Record
  nonblank_mmyyyy.src;
  blank_dd_count := Count(Group);
End;

out_crosstab_dob := Table(nonblank_mmyyyy, crosstab_mmyyyy, src );
Export blank_dd_persource := Sort(out_crosstab_dob, -blank_dd_count );



// E. Dob normal distribution score ( measure of normality accross all non-zero per lexid Dob)
filteredFullDobLexid := filter_fulldob( Not dob = 0 And Not did = 0);

normaldist := Record
    Integer   did;
    String    dob_mmdd;
End;

normaldist distSlim( filteredFullDobLexid Le ) := Transform
  Self.did := Le.did;
  dob := formating_tools.date_format(Le.dob);
  Self.dob_mmdd := dob[5..9];
End;

result_normdist := Project(filteredFullDobLexid, distSlim(Left));

t1_dob := Table(result_normdist, {dob_mmdd, did}, dob_mmdd, did);

t2_dob := Table(t1_dob, {dob_mmdd, lexid_count := Count(Group)}, dob_mmdd );

Export normal_distribution := Sort(t2_dob, dob_mmdd );

End; 
