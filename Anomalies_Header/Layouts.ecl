Import Anomalies_Header;


infile := $.Files.Header;
LeftFile := Anomalies_Header.Files.Header; 
RightFile := Anomalies_Header.Files.Watchdog; 

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

   Export MyRecLeft := Record
        LeftFile.did;
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

    Export MyRecright := Record
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

End;

