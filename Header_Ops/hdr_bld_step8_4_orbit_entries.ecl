IMPORT Orbit3,_control, header;

EXPORT fn_orbit_entries(boolean isCreate, string filedate) := function    

    is_hash_month := filedate[5..6] in ['03','06','09','12'];   
    
    skipcreatebuild := if(isCreate, false, true);
    skipupdatebuild := if(isCreate, true, false);
       
    return parallel(
            Orbit3.Proc_Orbit3_CreateBuild('Show Sources', filedate, 'N', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            // - Orbit3.Proc_Orbit3_CreateBuild('FCRA_Header', filedate, 'F', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            Orbit3.Proc_Orbit3_CreateBuild('FCRA_AddressRawAIDKeys', filedate, 'F', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);            
            Orbit3.Proc_Orbit3_CreateBuild('Header', filedate, 'N', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            Orbit3.Proc_Orbit3_CreateBuild('RelativesV3', filedate, 'N',skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            Orbit3.Proc_Orbit3_CreateBuild('PersonXLAB', filedate, 'N', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            Orbit3.Proc_Orbit3_CreateBuild('personAncillarykeys', filedate, 'N', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            Orbit3.Proc_Orbit3_CreateBuild('Slimsorts', filedate, 'N', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            Orbit3.Proc_Orbit3_CreateBuild('PowerSearchBoolean', filedate, 'B', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            Orbit3.Proc_Orbit3_CreateBuild('Remote Linking', filedate, 'N', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            // - Orbit3.Proc_Orbit3_CreateBuild('Header_IKB', filedate, 'N', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers);
            if(is_hash_month, Orbit3.Proc_Orbit3_CreateBuild('Header Hashes', filedate, 'N', skipcreatebuild, skipupdatebuild, true, Header.email_list.BocaDevelopers))
            );
end;

filedate := '20191226'; // RUN ON HTHOR

// fn_orbit_entries(true, filedate);
fn_orbit_entries(false, filedate);


// W:\Projects\Header\15-05a_BuildAssistScripts\personheader_create_orbit_entries.ecl
/*
Previous runs
-------------
version
create entries
update for QA

20191226 W20200128-102242 - create
20191128 W20200103-135944 - create
20191128 W20200103-140359 - update
20190422 W20190424-145840 - create
20190324 W20190424-092000 - update
20181224 W20190109-101007(create)
20181023 W20181029-111111
20180926 W20181001-073122
20180522 W20180621-161729
20180423 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180425-095340#/stub/Summary
20180320 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180419-152657#/stub/Summary
W20180322-100610
// */

// version |create entries  |update for QA   |
// 20180221|W20180314-152102|W20180320-130745|
// 20180130|W20180306-154721|W20180306-155728|
// 20171227|                |W20180206-100031|
// 20171121|W20171211-135958|                |
// 
// +----------------+----------------+----------------+--------+
// |Create entries  | Update in prog | Update on dev  | Version|
// +----------------+----------------+----------------+--------+
// |W20171206-103400|W20171207-093634| 20171025a|
// |W20171129-120539|20171025 |
// +----------------+----------------+----------------+--------+
// |W20170927-135526|20170925|
// +----------------+----------------+----------------+--------+
// |W20170925-103952|20170828|
// +----------------+----------------+----------------+--------+
// |W20170727-131623|W20170808-124636|W20170907-153130|20170725|
// +----------------+----------------+----------------+--------+
// |W20170719-162039|W20170719-162039|20170628|
// +----------------+----------------+----------------+--------+
// |W20170605-160234|W20170605-160234|W20170726-093846|20170522|
// +----------------+----------------+----------------+--------+
// |W20170508-125756|W20170612-143440| N/A            |20170430|
// +----------------+----------------+----------------+--------+
// |W20170322-130855|W20170501-154811|   N/A          |20170321|
// +----------------+----------------+----------------+--------+
// |W20170309-145811| 20170223       |W20170322-130855|20170223|
// +----------------+----------------+----------------+--------+
// |W20170131-145103|W20170222-194953|    N/A         |20170123| <-- Has an error on boolean change
// +----------------+----------------+----------------+--------+
// |W20170106-141659|                                 |20161220|
// +----------------+----------------+----------------+--------+
// |W20161201-142855|      N/A       |     N/A        |20161122|
// +----------------+----------------+----------------+--------+