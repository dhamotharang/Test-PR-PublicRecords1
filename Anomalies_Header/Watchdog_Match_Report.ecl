Import Anomalies_Header;

t := Table(Anomalies_Header.Files.Header, Layouts.Layout_Header, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src );

dt := Distribute(t, Skew(0.1,0.15));

sdt := Sort(dt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src, Local );

// Files
LeftFile := Dedup(sdt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src, All );

RightFile_input := Anomalies_Header.Files.Watchdog; 
RightFile_sort := Distribute(RightFile_input, Skew(0.1,0.15));
RightFile := Sort(RightFile_sort, did, Local );

// Layouts
Header_Layout := Anomalies_Header.Layouts.MyRecLeft;
Watchdog_Layout := Anomalies_Header.Layouts.MyRecright;

Export Watchdog_Match_Report := Module


Export LeftRec := Project(Leftfile, Header_Layout);
RightRec := Project(RightFile, Watchdog_Layout);


MyOutRec := Record
    Unsigned6 did;
    String15  fname_match;
    String15  lname_match;
    String15  dob_match;
    String15  ssn_match;
    String15  address_match;
    String15  address_match_All;
    String2   source_name;
END;

MyOutRec MatchThem( LeftRec Le, RightRec Ri ) := Transform
    Self.did       := Le.did;

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

J_Watchdog_Match := Join(LeftRec, RightRec, Left.did = Right.did, MatchThem(Left, Right));
d_Watchdog_Match := Distribute(J_Watchdog_Match, Skew(0.1,0.15));
S_Watchdog_Match := Sort(d_Watchdog_Match, did, fname_match, lname_match, dob_match,
                                           ssn_match, address_match, address_match_all,
                                           source_name, Local ); // take a look

//exports comparingson of header file agaisnt watchdog
Export Watchdog_Match := Dedup(S_Watchdog_Match, did, fname_match, lname_match, dob_match,
                                                ssn_match, address_match, address_match_all, 
                                                source_name, All ); // take a look


// rollup by lexid
FlaggedRec := Record
    Watchdog_match.did;
    Watchdog_Match.fname_match;
    Watchdog_Match.lname_match;
    Watchdog_Match.dob_match;
    Watchdog_Match.ssn_match;
    Watchdog_Match.address_match;
    Watchdog_Match.address_match_All;
    Watchdog_Match.source_name;
End;

t_flagged_rec := Table(Watchdog_Match, FLaggedRec);
st_flagged_rec := Sort(t_flagged_rec, did);

FlaggedRec FormFlagged( st_flagged_rec Le, st_flagged_rec Ri ) := Transform
    Self := Le;
    Self := Ri;
End;

Export ds_rollflagged_rec := Rollup(st_flagged_rec, 
                            Left.did = Right.did,
                            FormFlagged(Left, Right));

End;