Import $;

infile := $.Header_file;

Export New_Persons := Module 
    Export Layout := Record
    Unsigned6 Lexid := (Unsigned4)infile.did;
    infile.fname;
    infile.mname;
    infile.lname;
    infile.dob;
    infile.ssn;
    infile.prim_range; 
    infile.predir;
    infile.prim_name;
    infile.suffix;
    infile.postdir;
    infile.unit_desig;
    infile.sec_range;
    infile.city_name;
    infile.st;
    infile.zip;
    infile.zip4;
    infile.county;
    infile.cbsa;
    infile.src;
End;

t :=  Table(infile, Layout, Record, src);
dt := Distribute(t, Hash(lexid, fname, mname, lname, dob, ssn, prim_range, predir, prim_name, 
                        suffix, postdir, unit_desig, sec_range, city_name, st, zip, zip4, county, cbsa, src));

sdt := Sort(dt, lexid, fname, mname, lname, dob, ssn, prim_range, predir, prim_name, 
                suffix, postdir, unit_desig, sec_range, city_name, st, zip, zip4, county, cbsa, Local);

Export File := Dedup(sdt, lexid, fname, mname, lname, dob, ssn, prim_range, predir, prim_name, 
                        suffix, postdir, unit_desig, sec_range, city_name, st, zip, zip4, county, cbsa, src)
    :Persist('~Online::MVH::Persist::New_Persons');
End;
