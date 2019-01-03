IMPORT Orbit3,_control, header;

EXPORT orbit_update_entries(string filedate, string createORupdate) := function

    tokenval := orbit3.GetToken();
    rec_rep := {STRING  Name, STRING  Status, STRING  Message};
    
    update_entry(string buildname, string Buildvs, string Envmt) := FUNCTION
             
            submit_change1 := Orbit3.UpdateBuildInstance(buildname, Buildvs, tokenval, 'BUILD_AVAILABLE_FOR_USE',
                                                                    Orbit3.Constants(Envmt).platform_upd).retcode ;
            
            return if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
                        project(submit_change1, transform(rec_rep,SELF.Name:=buildname,SELF:=LEFT))
                        );
    END;
    update_bentry(string buildname, string Buildvs, string Envmt) := FUNCTION
            
            status := Orbit3.Constants(Envmt).platform_upd(PlatformName='Boolean Roxie Production');
            submit_change1 := Orbit3.UpdateBuildInstance(buildname, Buildvs, tokenval, 'BUILD_AVAILABLE_FOR_USE',
                                                                    status).retcode ;
            
            return if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
                        project(submit_change1, transform(rec_rep,SELF.Name:=buildname,SELF:=LEFT))
                        );
    END;
    create_entry(string buildname, string Buildvs) := FUNCTION
    
            submit_change1 := Orbit3.CreateBuild        (buildname, Buildvs, tokenval).retcode;
            submit_change2 := Orbit3.UpdateBuildInstance(buildname, Buildvs, tokenval).retcode;
            return if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
                       project(submit_change1, transform(rec_rep,SELF.Name:=buildname,SELF:=LEFT))+
                       project(submit_change2, transform(rec_rep,SELF.Name:=buildname,SELF:=LEFT))
                      );
    end;
    is_hash_month := filedate[5..6] in ['03','06','09','12'];
    
    RETURN if (createORupdate='create',
                        create_entry('Show Sources'          ,filedate)+
                        create_entry('FCRA_Header'           ,filedate)+
                        create_entry('Header'                ,filedate)+
                        create_entry('RelativesV3'           ,filedate)+
                        create_entry('PersonXLAB'            ,filedate)+
                        create_entry('personAncillarykeys'   ,filedate)+
                        create_entry('Slimsorts'             ,filedate)+
                        create_entry('PowerSearchBoolean'    ,filedate)+
                        create_entry('Remote Linking'        ,filedate)+
                        create_entry('Header_IKB'            ,filedate)+
                        if(is_hash_month,   create_entry('Header Hashes'         ,filedate))
                        ,
               // createORupdate = 'update',
                        update_entry('Show Sources'          ,filedate,'N')+
                        update_entry('FCRA_Header'           ,filedate,'F')+
                        update_entry('Header'                ,filedate,'N')+
                        update_entry('RelativesV3'           ,filedate,'N')+
                        update_entry('PersonXLAB'            ,filedate,'N')+
                        update_entry('personAncillarykeys'   ,filedate,'N')+
                        update_entry('Slimsorts'             ,filedate,'N')+
                        update_bentry('PowerSearchBoolean'   ,filedate,'N|B')+
                        update_bentry('Remote Linking'       ,filedate,'N')+
                        update_bentry('Header_IKB'           ,filedate,'N')
               );
    
 
end;

filedate := '20180926'; // RUN ON HTHOR
// filedate := header.version_build;
// orbit_update_entries(filedate,'create');
orbit_update_entries(filedate,'update');

// W:\Projects\Header\15-05a_BuildAssistScripts\personheader_create_orbit_entries.ecl
/*
Previous runs
-------------
version
create entries
update for QA

20181023 W20181029-111111

20180926 W20181001-073122
20180522 W20180621-161729
20180423

http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180425-095340#/stub/Summary

20180320
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180419-152657#/stub/Summary
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