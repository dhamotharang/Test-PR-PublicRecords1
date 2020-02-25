Import $;

infile := $.Header_file;

Export UID_New_Persons := Module 
    Export Layout := Record
    Unsigned6 Lexid := (Unsigned4)Infile.did;
    infile.ssn;
    infile.src;
END;
          
t := Table(infile, Layout, did, ssn, src);
dt := Distribute(t, Hash(lexid, ssn, src));
sdt := Sort(dt, lexid, ssn, src, Local);

Export File := Dedup(sdt, lexid, ssn, src)
    :Persist('~Online::MVH::Persist::UID_New');
End;