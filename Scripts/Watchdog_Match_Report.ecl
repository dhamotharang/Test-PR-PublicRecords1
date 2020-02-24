IMPORT $, Watchdog;


LeftFile := $.New_Persons.File; // lexid
RightFile := Choosen(Watchdog.File_Best, 10000); // did
//
Export Watchdog_Match_Report := Module

MyRecLeft := Record
    LeftFile.lexid;
    LeftFile.fname;
    LeftFile.lname;
    LeftFile.dob;
    LeftFile.ssn;
    LeftFile.prim_range;
    LeftFile.predir;
    LeftFile.prim_name;
    LeftFile.suffix;
    LeftFile.postdir;
    LeftFile.unit_desig;
    LeftFile.sec_range;
    LeftFile.city_name;
    LeftFile.st;
    LeftFile.zip;
    LeftFile.zip4;
    LeftFile.src;
End;

MyRecright := Record
    RightFile.did;
    RightFile.fname;
    RightFile.lname;
    RightFile.dob;
    RightFile.ssn;
    RightFile.prim_range;
    RightFile.predir;
    RightFile.prim_name;
    RightFile.suffix;
    RightFile.postdir;
    RightFile.unit_desig;
    RightFile.sec_range;
    RightFile.city_name;
    RightFile.st;
    RightFile.zip;
    RightFile.zip4;
End;

LeftRec := Project(Leftfile, MyRecLeft);
RightRec := Project(RightFile, MyRecRight);


MyOutRec := Record
    Unsigned6 lexid;
    String15  fname_match;
    String15  lname_match;
    String15  dob_match;
    String15  ssn_match;
    String15  address_match;
    String15  address_match_All;
    String2   source_name;
END;

MyOutRec MatchThem( LeftRec Le, RightRec Ri ) := Transform
    Self.Lexid       := Le.lexid;

    Self.fname_match := Map(Le.fname = '' => 'B',
                            Le.fname = Ri.fname => 'T', 'F');

    Self.lname_match := Map(Le.lname = '' => 'B',
                            Le.lname = Ri.lname => 'T', 'F');

    Self.dob_match   := Map(Le.dob = 0  => 'B',
                            Le.dob = Ri.dob => 'T', 'F');

    Self.ssn_match   := Map(Le.ssn = '' => 'B',
                            Le.ssn = Ri.ssn => 'T', 'F'); 

    // compare address values collectively twice once with all fields 
    // Matching of most improtant fields 
    Self.address_match      := Map(Le.prim_range = '' AND Le.unit_desig = '' AND 
                                   Le.st = ''         AND Le.zip = ''  => 'B', // Break 
                                   Le.prim_range = Ri.prim_range AND 
                                   Le.unit_desig = Ri.unit_desig AND 
                                   Le.st = Ri.st                 AND Le.zip = Ri.zip => 'T', 'F');

    // match address values of all fields 
    Self.address_match_All  := Map(Le.prim_range = '' AND Le.predir = ''     AND 
                               Le.prim_name = ''      AND Le.suffix = ''     AND 
                               Le.postdir = ''        AND Le.unit_desig = '' AND 
                               Le.sec_range = ''      AND Le.city_name = ''  AND 
                               Le.st = ''             AND Le.zip = ''        AND Le.zip4 = '' => 'B', // Break 
                               Le.prim_range = Ri.prim_range   AND 
                               Le.predir = Ri.predir           AND 
                               Le.prim_name = Ri.prim_name     AND 
                               Le.suffix = Ri.suffix           AND 
                               Le.postdir = Ri.postdir         AND  
                               Le.unit_desig = Ri.unit_desig   AND
                               Le.sec_range = Ri.sec_range     AND 
                               Le.city_name = Ri.city_name     AND 
                               Le.st = Ri.st                   AND 
                               Le.zip = Ri.zip                 AND Le.zip4 = Ri.zip4 => 'T', 'F');

    Self.source_name  := Le.src;
End;

J_Watchdog_Match := Join(LeftRec, RightRec, Left.lexid = Right.did, MatchThem(Left, Right));
S_Watchdog_Match := Sort(J_Watchdog_Match, Record, Local);

//exports comparingson of header file agaisnt watchdog
Export Watchdog_Match := Dedup(S_Watchdog_Match, Record, Local);


// rollup by lexid

FlaggedRec := Record
    Watchdog_match.Lexid;
    Watchdog_Match.fname_match;
    Watchdog_Match.lname_match;
    Watchdog_Match.dob_match;
    Watchdog_Match.ssn_match;
    Watchdog_Match.address_match;
    Watchdog_Match.address_match_All;
    Watchdog_Match.source_name;
End;

t_flagged_rec := Table(Watchdog_Match, FLaggedRec);
st_flagged_rec := Sort(t_flagged_rec, lexid);

OutFlaggedRec := Record
    String15 fname;
End;

FlaggedRec FormFlagged( st_flagged_rec Le, st_flagged_rec Ri ) := Transform
    Self := Le;
    Self := Ri;
End;

Export ds_rollflagged_rec := Rollup(st_flagged_rec, 
                            Left.Lexid = Right.Lexid,
                            FormFlagged(Left, Right));

//count how many true and how many records per source 

// counted fname_match t/f/b records per source
r_fname_counted := Record
    ds_rollflagged_rec.fname_match;
    ds_rollflagged_rec.source_name; 
    RecordCnt := Count(Group);
End;

t_fname_counted := Table(Watchdog_Match, r_fname_counted, fname_match, source_name);
Export st_counted_fname := Sort(t_fname_counted, -RecordCnt);

// counted lname_match t/f/b records per source
r_lname_counted := Record
    Watchdog_Match.lname_match;
    Watchdog_Match.source_name;
    RecordCnt := Count(Group);
End;

t_fname_counted := Table(Watchdog_Match, r_lname_counted, lname_match, source_name);
Export st_counted_lname := Sort(t_fname_counted, -RecordCnt); 

// counted dob_match t/f/b records per source
r_dob_counted := Record
    Watchdog_Match.dob_match;
    Watchdog_Match.source_name;
    RecordCnt := Count(Group);
End;

t_dob_counted := Table(Watchdog_Match, r_dob_counted, dob_match, source_name);
Export st_counted_dob := Sort(t_dob_counted, -RecordCnt);

// counted ssn_match t/f/b records per source
r_ssn_counted := Record
    Watchdog_Match.ssn_match;
    Watchdog_Match.source_name;
    RecordCnt := Count(Group);
End;

t_ssn_counted := Table(Watchdog_Match, r_ssn_counted, ssn_match, source_name);
Export st_counted_ssn := Sort(t_ssn_counted, -RecordCnt);

r_address_match_counted := Record
    Watchdog_Match.address_match;
    Watchdog_Match.source_name;
    RecordCnt := Count(Group);
End;

t_address_match_counted := Table(Watchdog_Match, r_address_match_counted, address_match, source_name);
Export st_counted_address_match := Sort(t_address_match_counted, -RecordCnt);

r_address_collectivematch_counted := Record
    Watchdog_Match.address_match_All;
    Watchdog_Match.source_name;
    RecordCnt := Count(Group);
End;

t_address_collectivematch_counted := Table(Watchdog_Match, r_address_collectivematch_counted, address_match_all, source_name);
Export st_counted_collectivematch_all := Sort(t_address_collectivematch_counted, -RecordCnt);
//then get a percentage of the amount true 
//Rollup by lexid & src, keep true recs, if not f, and if blank then b
End;