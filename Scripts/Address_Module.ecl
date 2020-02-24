Import $;

infile := $.Header_file;

Export Address_Module := Module 
    Export Layout := Record
    Unsigned6 Lexid := (Unsigned4)infile.did;
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
End;

t := Table(infile, Layout);
dt := Distribute(t);
sdt := Sort(dt, Record);

Export file := Dedup(sdt, Record)
    :Persist('~Online::MVH::Persist::Address_Module');
End;
