Import $;

infile := $.Files.Header;

Export Layouts := Module

    Export Layout_Header := Record
        infile.did;
        infile.fname;
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

End;

