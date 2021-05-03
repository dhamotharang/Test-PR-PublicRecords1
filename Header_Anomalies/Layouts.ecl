// This module stores the core layouts

header := Header_Anomalies.Files.Header; 
watchdog := Header_Anomalies.Files.Watchdog; 

Export Layouts := Module
   
    Export Layout_Header := Record
        header.did;
        header.fname;
        header.lname;
        header.dob;
        header.ssn;
        header.prim_range; 
        header.predir;
        header.prim_name;
        header.suffix;
        header.postdir;
        header.unit_desig;
        header.sec_range;
        header.city_name;
        header.st;
        header.zip;
        header.zip4;
        header.county;
        header.cbsa;
        header.src;
    End;

   Export MyRecLeft := Record
        header.did;
        header.fname;
        header.lname;
        header.dob;
        header.ssn;
        header.prim_range;
        header.predir;
        header.prim_name;
        header.suffix;
        header.postdir;
        header.unit_desig;
        header.sec_range;
        header.city_name;
        header.st;
        header.zip;
        header.zip4;
        header.src;
    End;

    Export MyRecright := Record
        watchdog.did;
        watchdog.fname;
        watchdog.lname;
        watchdog.dob;
        watchdog.ssn;
        watchdog.prim_range;
        watchdog.predir;
        watchdog.prim_name;
        watchdog.suffix;
        watchdog.postdir;
        watchdog.unit_desig;
        watchdog.sec_range;
        watchdog.city_name;
        watchdog.st;
        watchdog.zip;
        watchdog.zip4;
    End;

End;

