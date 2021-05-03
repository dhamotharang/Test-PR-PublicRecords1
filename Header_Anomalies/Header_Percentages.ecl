
Import STD, AID;


infile := Header_Anomalies.Header_Watchdog_Match.ds_rollflagged_rec;


Export Header_Percentages := Module 

// infiles filtererd with all of the values that are true or false in flagged watchdog_match_report
Shared nonblank_fname := infile( fname_match = 'T' or fname_match = 'F' ); 

Shared nonblank_lname := infile( lname_match = 'T' or lname_match = 'F' );

Shared nonblank_dob := infile( dob_match = 'T' or  dob_match = 'F' );

Shared nonblank_ssn := infile( ssn_match = 'T' or ssn_match = 'F' );

Shared nonblank_address := infile( address_match = 'T' or address_match = 'F' );

Shared nonblank_addressall := infile( address_match_all = 'T' or address_match_all = 'F' );


// ================================= Counted Totals Per File and Per Field =================================

// count how many true and how many records per source 
// counted totals per source
total_layout := Record
    infile.source_name; 
    total_count_persource := Count(Group);
End;

t_counted_total := Table(infile, total_layout, source_name );
Shared counted_total := Sort(t_counted_total, -total_count_persource );

// counted totals ( only true and false first names )
fname_total_layout := Record 
    nonblank_fname.source_name;
    nonblank_totalcnt := Count(Group);
End;

tf_counted_total := Table(nonblank_fname, fname_total_layout, source_name );
Shared cnt_treufalse_fname := Sort(tf_counted_total, -nonblank_totalcnt);

// counted totals ( only true and false last names )
lname_total_layout := Record
    nonblank_lname.source_name;
    nonblank_totalcnt := Count(Group);
End;

tf_counted_total := Table(nonblank_lname, lname_total_layout, source_name );
Shared cnt_truefalse_lname := Sort(tf_counted_total, -nonblank_totalcnt );

// counted totals ( only true and false dobs )
dob_total_layout := Record
    nonblank_dob.source_name;
    nonblank_totalcnt := Count(Group);
End;

tf_counted_total := Table(nonblank_dob, dob_total_layout, source_name );
Shared cnt_truefalse_dob := Sort(tf_counted_total, -nonblank_totalcnt );

// counted totals ( only true and false ssns )
ssn_total_layout := Record
    nonblank_ssn.source_name;
    nonblank_totalcnt := Count(Group);
End;

tf_counted_total := Table(nonblank_ssn, ssn_total_layout, source_name );
Shared cnt_truefalse_ssn := Sort(tf_counted_total, -nonblank_totalcnt );

// counted totals ( only true and false address match )
address_total_layout := Record
    nonblank_address.source_name;
    nonblank_totalcnt := Count(Group);
End;

tf_counted_total := Table(nonblank_address, address_total_layout, source_name );
Shared cnt_truefalse_address := Sort(tf_counted_total, -nonblank_totalcnt );

// counted totals ( only treu and false full address match )
addressall_total_layout := Record
    nonblank_addressall.source_name;
    nonblank_totalcnt := Count(Group);
End;

tf_counted_total := Table(nonblank_addressall, addressall_total_layout, source_name );
Shared cnt_truefalse_addressall := Sort(tf_counted_total, -nonblank_totalcnt );



// Join both total counts tables
Shared total_rec_layout := Record
    String2    source_name;
    Integer    nonblank_totalcnt;
    Integer    total_count;
End;


fnamePercentage := Join(
     cnt_treufalse_fname, counted_total,
    Left.source_name = Right.source_name,
    Transform(
        total_rec_layout,
        Self.source_name := Right.source_name;
        Self.nonblank_totalcnt := Left.nonblank_totalcnt;
        Self.total_count  := Right.total_count_persource;
    )
);

Shared total_fname_join := Sort(fnamePercentage, -total_count );

lnamePercentages := Join(
    cnt_truefalse_lname, counted_total,
    Left.source_name = Right.source_name,
    Transform(
        total_rec_layout,
        Self.source_name := Right.source_name;
        Self.nonblank_totalcnt := Left.nonblank_totalcnt;
        Self.total_count := Right.total_count_persource;
    )
);

Shared total_lname_join := Sort(lnamePercentages, -total_count );

dobPercentages := Join(
    cnt_truefalse_dob, counted_total,
    Left.source_name = Right.source_name,
    Transform(
        total_rec_layout,
        Self.source_name := Right.source_name;
        Self.nonblank_totalcnt := Left.nonblank_totalcnt;
        Self.total_count := Right.total_count_persource;
    )
);

Shared total_dob_join := Sort(dobPercentages, -total_count );

ssnPercentages := Join(
    cnt_truefalse_ssn, counted_total,
    Left.source_name = Right.source_name,
    Transform(
        total_rec_layout,
        Self.source_name := Right.source_name;
        Self.nonblank_totalcnt := Left.nonblank_totalcnt;
        Self.total_count := Right.total_count_persource;
    )
);

Shared total_ssn_join := Sort(ssnPercentages, -total_count );

addressPercentages := Join(
    cnt_truefalse_address, counted_total,
    Left.source_name = Right.source_name,
    Transform(
        total_rec_layout,
        Self.source_name := Right.source_name;
        Self.nonblank_totalcnt := Left.nonblank_totalcnt;
        Self.total_count := Right.total_count_persource;
    )
);

Shared total_address_join := Sort(addressPercentages, -total_count );


addressallPercentages := Join(
    cnt_truefalse_addressall, counted_total,
    Left.source_name = Right.source_name,
    Transform(
        total_rec_layout,
        Self.source_name := Right.source_name;
        Self.nonblank_totalcnt := Left.nonblank_totalcnt;
        Self.total_count := Right.total_count_persource;
    )
);

Shared total_addressall_join := Sort(addressallPercentages, -total_count );


// ================================= Joins to percentages based on fields against totals ==============================


// counted fname_match t/f/b records per source
r_fname_counted := Record
    infile.source_name; 
    infile.fname_match;//
    record_count := Count(Group);
End;

t_fname_counted := Table(infile, r_fname_counted, fname_match, source_name );
Shared st_counted_fname := Sort(t_fname_counted, -record_count );


// counted lname_match t/f/b records per source
r_lname_counted := Record
    infile.source_name;
    infile.lname_match;
    record_count := Count(Group);
End;

t_fname_counted := Table(infile, r_lname_counted, lname_match, source_name );
Shared st_counted_lname := Sort(t_fname_counted, -record_count ); 

// counted dob_match t/f/b records per source
r_dob_counted := Record
    infile.source_name;
    infile.dob_match;
    record_count := Count(Group);
End;

t_dob_counted := Table(infile, r_dob_counted, source_name, dob_match );
Shared st_counted_dob := Sort(t_dob_counted, -record_count );

// counted ssn_match t/f/b records per source
r_ssn_counted := Record
    infile.source_name;
    infile.ssn_match;
    record_count := Count(Group);
End;

t_ssn_counted := Table(infile, r_ssn_counted, ssn_match, source_name);
Shared st_counted_ssn := Sort(t_ssn_counted, -record_count );

r_address_match_counted := Record
    infile.address_match;
    infile.source_name;
    record_count := Count(Group);
End;

t_address_match_counted := Table(infile, r_address_match_counted, address_match, source_name );
Shared st_counted_address_match := Sort(t_address_match_counted, -record_count );

r_address_collectivematch_counted := Record
    infile.source_name;
    infile.address_match_All;
    record_count := Count(Group);
End;

t_address_collectivematch_counted := Table(infile, r_address_collectivematch_counted, address_match_all, source_name );
Shared st_counted_collectivematch_all := Sort(t_address_collectivematch_counted, -record_count );
//then get a percentage of the amount true 
//Rollup by lexid & src, keep true recs, if not f, and if blank then b


//Joins


// True first name values only 
fnameTrue :=  st_counted_fname( fname_match = 'T');

fname_Layout := Record
    String2    source_name;
    Integer    unique_fname_cnt;
    Integer    nonblank_totalcnt;
    Integer    total_count;
    Decimal5_2 nonblank_percentage;
    Decimal5_2 total_percentage;
End;

// First name percetanges aginst totals 
fnamePercentage := Join(
     fnameTrue, total_fname_join,
    Left.source_name = Right.source_name,
    Transform(
        fname_layout,
        Self.source_name := Left.source_name;
        Self.unique_fname_cnt := Left.record_count;
        Self.nonblank_totalcnt := Right.nonblank_totalcnt;
        Self.total_count  := Right.total_count;
        Self.nonblank_percentage := (Decimal5_2)( Left.record_count / Right.nonblank_totalcnt * 100 );
        Self.total_percentage  := (Decimal5_2)( Left.record_count / Right.total_count * 100 );
    )
);

Export fname_percentage := Sort(fnamePercentage, -total_percentage);


// True last name values only
lnameTrue := st_counted_lname( lname_match = 'T' );

lnameLayout := Record
   String2    source_name;
   Integer    unique_lname_cnt;
   Integer    nonblank_totalcnt;
   Integer    total_count;
   Decimal5_2 nonblank_percentage;
   Decimal5_2 total_percentage;
End;

// First name percentages against totals 
lnamePercentage := Join(
     lnameTrue, total_lname_join,
    Left.source_name = Right.source_name,
    Transform(
        lnameLayout,
        Self.source_name := Left.source_name;
        Self.unique_lname_cnt := Left.record_count;
        Self.nonblank_totalcnt := Right.nonblank_totalcnt;
        Self.total_count  := Right.total_count;
        Self.nonblank_percentage := (Decimal5_2)( Left.record_count / Right.nonblank_totalcnt * 100 );
        Self.total_percentage  := (Decimal5_2)( Left.record_count / Right.total_count * 100 );
    )
);

Export lname_percentage := Sort(lnamePercentage, -total_percentage );



dobTrue := st_counted_dob( dob_match = 'T' );

dobLayout := Record
    String2    source_name;
    Integer    unique_dob_cnt;
    Integer    nonblank_totalcnt;
    Integer    total_count;
    Decimal5_2 nonblank_percentage;
    Decimal5_2 total_percentage;
End;

dobPercentage := Join(
     dobTrue, total_dob_join,
    Left.source_name = Right.source_name,
    Transform(
        dobLayout,
        Self.source_name := Left.source_name;
        Self.unique_dob_cnt := Left.record_count;
        Self.nonblank_totalcnt := Right.nonblank_totalcnt;
        Self.total_count  := Right.total_count;
        Self.nonblank_percentage := (Decimal5_2)( Left.record_count / Right.nonblank_totalcnt * 100 );
        Self.total_percentage  := (Decimal5_2)( Left.record_count / Right.total_count * 100 );
    )
);

Export dob_percentage := Sort(dobPercentage, -total_percentage );



ssnTrue := st_counted_ssn( ssn_match = 'T' );

ssnLayout := Record
    String2    source_name;
    Integer    unique_ssn_cnt;
    Integer    nonblank_totalcnt;
    Integer    total_count;
    Decimal5_2 nonblank_percentage;
    Decimal5_2 total_percentage;
End;

ssnPercentage := Join(
     ssnTrue, total_ssn_join,
    Left.source_name = Right.source_name,
    Transform(
        ssnLayout,
        Self.source_name := Left.source_name;
        Self.unique_ssn_cnt := Left.record_count;
        Self.nonblank_totalcnt := Right.nonblank_totalcnt;
        Self.total_count  := Right.total_count;
        Self.nonblank_percentage  := (Decimal5_2)( Left.record_count / Right.nonblank_totalcnt * 100 );
        Self.total_percentage := (Decimal5_2)(Left.record_count / Right.total_count * 100 );
    )
);

Export ssn_percentage := Sort(ssnPercentage, -total_percentage );



addressTrue := st_counted_address_match( address_match = 'T' );

addressLayout := Record
    String2    source_name;
    Integer    unique_address_cnt;
    Integer    nonblank_totalcnt;
    Integer    total_count;
    Decimal5_2 nonblank_percentage;
    Decimal5_2 total_percentage;
End;

addressPercentage := Join(
     addressTrue, total_address_join,
    Left.source_name = Right.source_name,
    Transform(
        addressLayout,
        Self.source_name := Left.source_name;
        Self.unique_address_cnt := Left.record_count;
        Self.nonblank_totalcnt := Right.nonblank_totalcnt;
        Self.total_count  := Right.total_count;
        Self.nonblank_percentage  := (Decimal5_2)( Left.record_count / Right.nonblank_totalcnt * 100 );
        Self.total_percentage := (Decimal5_2)(Left.record_count / Right.total_count * 100 );
    )
);

Export addressMatch_percentage := Sort(addressPercentage, -total_percentage );



addressAllTrue := st_counted_collectivematch_all( address_match_all = 'T' );

addressAllLayout := Record
    String2    source_name;
    Integer    unique_addressall_cnt;
    Integer    nonblank_totalcnt;
    Integer    total_count;
    Decimal5_2 nonblank_percentage;
    Decimal5_2 total_percentage;
End;

addressAllPercentage := Join(
     addressAllTrue, total_addressall_join,
    Left.source_name = Right.source_name,
    Transform(
        addressAllLayout,
        Self.source_name := Left.source_name;
        Self.unique_addressall_cnt := Left.record_count;
        Self.nonblank_totalcnt := Right.nonblank_totalcnt;
        Self.total_count  := Right.total_count;
        Self.nonblank_percentage  := (Decimal5_2)( Left.record_count / Right.nonblank_totalcnt * 100 );
        Self.total_percentage := (Decimal5_2)(Left.record_count / Right.total_count * 100 );
    )
);

Export addressAllMatch_percentage := Sort(addressAllPercentage, -total_percentage );


End;