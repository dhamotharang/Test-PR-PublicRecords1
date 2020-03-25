Import Anomalies_Header;
Import STD;
Import AID;


infile := Anomalies_Header.Watchdog_Match_Report.ds_rollflagged_rec;

Export Header_Percentages := Module 


//count how many true and how many records per source 

// counted totals per source
r_counted_total := Record
    infile.source_name; 
    totalcount_persource := Count(Group);
End;

t_counted_total := Table(infile, r_counted_total, source_name);
Export st_counted_total := Sort(t_counted_total, -totalcount_persource);


// counted fname_match t/f/b records per source
r_fname_counted := Record
    infile.fname_match;//
    infile.source_name; 
    RecordCnt := Count(Group);
End;

t_fname_counted := Table(infile, r_fname_counted, fname_match, source_name);
Export st_counted_fname := Sort(t_fname_counted, -RecordCnt);


// counted lname_match t/f/b records per source
r_lname_counted := Record
    infile.lname_match;
    infile.source_name;
    RecordCnt := Count(Group);
End;

t_fname_counted := Table(infile, r_lname_counted, lname_match, source_name);
Export st_counted_lname := Sort(t_fname_counted, -RecordCnt); 

// counted dob_match t/f/b records per source
r_dob_counted := Record
    infile.dob_match;
    infile.source_name;
    RecordCnt := Count(Group);
End;

t_dob_counted := Table(infile, r_dob_counted, dob_match, source_name);
Export st_counted_dob := Sort(t_dob_counted, -RecordCnt);

// counted ssn_match t/f/b records per source
r_ssn_counted := Record
    infile.ssn_match;
    infile.source_name;
    RecordCnt := Count(Group);
End;

t_ssn_counted := Table(infile, r_ssn_counted, ssn_match, source_name);
Export st_counted_ssn := Sort(t_ssn_counted, -RecordCnt);

r_address_match_counted := Record
    infile.address_match;
    infile.source_name;
    RecordCnt := Count(Group);
End;

t_address_match_counted := Table(infile, r_address_match_counted, address_match, source_name);
Export st_counted_address_match := Sort(t_address_match_counted, -RecordCnt);

r_address_collectivematch_counted := Record
    infile.address_match_All;
    infile.source_name;
    RecordCnt := Count(Group);
End;

t_address_collectivematch_counted := Table(infile, r_address_collectivematch_counted, address_match_all, source_name);
Export st_counted_collectivematch_all := Sort(t_address_collectivematch_counted, -RecordCnt);
//then get a percentage of the amount true 
//Rollup by lexid & src, keep true recs, if not f, and if blank then b



// Joins
fnameTrue :=  st_counted_fname( fname_match = 'T');

fnameLayout := Record
    String2    source_name;
    Integer    recordcnt;
    Integer    totalcount;
    Decimal5_2 percentage;
End;

fnamePercentage := Join(
     fnameTrue, st_counted_total,
    Left.source_name = Right.source_name,
    Transform(
        fnameLayout,
        Self.source_name := Left.source_name;
        Self.recordcnt   := Left.recordcnt;
        Self.totalcount  := Right.totalcount_persource;
        Self.percentage  := (Decimal5_2)( Left.recordcnt / Right.totalcount_persource * 100);
    )
);

Export s_fname_percentage := Sort(fnamePercentage, -Percentage);


lnameTrue := st_counted_lname( lname_match = 'T' );

lnameLayout := Record
    String2    source_name;
    Integer    recordcnt;
    Integer    totalcount;
    Decimal5_2 percentage;
End;

lnamePercentage := Join(
     lnameTrue, st_counted_total,
    Left.source_name = Right.source_name,
    Transform(
        lnameLayout,
        Self.source_name := Left.source_name;
        Self.recordcnt   := Left.recordcnt;
        Self.totalcount  := Right.totalcount_persource;
        Self.percentage  := (Decimal5_2)( Left.recordcnt / Right.totalcount_persource * 100);
    )
);

Export s_lname_percentage := Sort(lnamePercentage, -Percentage);


dobTrue := st_counted_dob( dob_match = 'T' );

dobLayout := Record
    String2    source_name;
    Integer    recordcnt;
    Integer    totalcount;
    Decimal5_2 percentage;
End;

dobPercentage := Join(
     dobTrue, st_counted_total,
    Left.source_name = Right.source_name,
    Transform(
        dobLayout,
        Self.source_name := Left.source_name;
        Self.recordcnt   := Left.recordcnt;
        Self.totalcount  := Right.totalcount_persource;
        Self.percentage  := (Decimal5_2)( Left.recordcnt / Right.totalcount_persource * 100);
    )
);

Export s_dob_percentage := Sort(dobPercentage, -Percentage);

ssnTrue := st_counted_ssn( ssn_match = 'T' );

ssnLayout := Record
    String2    source_name;
    Integer    recordcnt;
    Integer    totalcount;
    Decimal5_2 percentage;
End;

ssnPercentage := Join(
     ssnTrue, st_counted_total,
    Left.source_name = Right.source_name,
    Transform(
        ssnLayout,
        Self.source_name := Left.source_name;
        Self.recordcnt   := Left.recordcnt;
        Self.totalcount  := Right.totalcount_persource;
        Self.percentage  := (Decimal5_2)( Left.recordcnt / Right.totalcount_persource * 100);
    )
);

Export s_ssn_percentage := Sort(ssnPercentage, -Percentage);

addressTrue := st_counted_address_match( address_match = 'T' );

addressLayout := Record
    String2    source_name;
    Integer    recordcnt;
    Integer    totalcount;
    Decimal5_2 percentage;
End;

addressPercentage := Join(
     addressTrue, st_counted_total,
    Left.source_name = Right.source_name,
    Transform(
        addressLayout,
        Self.source_name := Left.source_name;
        Self.recordcnt   := Left.recordcnt;
        Self.totalcount  := Right.totalcount_persource;
        Self.percentage  := (Decimal5_2)( Left.recordcnt / Right.totalcount_persource * 100);
    )
);

Export s_addressMatch_percentage := Sort(addressPercentage, -Percentage);

addressAllTrue := st_counted_collectivematch_all( address_match_all = 'T' );

addressAllLayout := Record
    String2    source_name;
    Integer    recordcnt;
    Integer    totalcount;
    Decimal5_2 percentage;
End;

addressAllPercentage := Join(
     addressAllTrue, st_counted_total,
    Left.source_name = Right.source_name,
    Transform(
        addressAllLayout,
        Self.source_name := Left.source_name;
        Self.recordcnt   := Left.recordcnt;
        Self.totalcount  := Right.totalcount_persource;
        Self.percentage  := (Decimal5_2)( Left.recordcnt / Right.totalcount_persource * 100);
    )
);

Export s_addressAllMatch_percentage := Sort(addressAllPercentage, -Percentage);


End;
