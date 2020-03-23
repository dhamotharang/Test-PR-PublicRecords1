Import Anomalies_Header;
Import Data_Services;
Import dx_Header;
Import History_Analysis;
Import Watchdog;


   

Export Files := Module

    Export Header := Dataset(data_services.foreign_prod + 'thor_data400::base::header_raw::latest_built', dx_header.layout_header, Thor): Independent;
    //Export Header := Choosen(hdr, 100000); // Temporary 

    // distrubuted and deduped file
    t := Table(Header, Anomalies_Header.Layouts.layout_header, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src);

    dt := Distribute(t, Hash(did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src));

    sdt := Sort(dt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src, Local);

    
    Export input_file := Dedup(sdt, did, fname, lname,
                  dob, ssn, prim_range, predir, prim_name, 
                  suffix, postdir, unit_desig, sec_range, 
                  city_name, st, zip, zip4, county, cbsa, src);


    Export Watchdog := Dataset(Data_Services.foreign_prod + 'thor_data400::BASE::Watchdog_Best', Watchdog.Layout_Best, Thor): Independent;
    //Export Watchdog := Choosen(Wd, 100000); // Temporary 
    

End;

