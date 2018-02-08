IMPORT STD,_control,ut,PRTE2_Header,Orbit3,dops,data_services;

EXPORT Proc_copy_From_Alpha_Incrementals := MODULE

// generic function to get the FIRST subfie in the super
SHARED ifname(string sf) := nothor(STD.File.SuperFileContents(sf)[1].name);

// construct key names per cluster and type (kNm)        
SHARED fName(string mid, string kNm) := '~thor_data400::key::insuranceheader_xlink::'+mid+'::did::'+kNm;
SHARED fName4(string mid, string kNm) := '~thor400_44::key::insuranceheader_xlink::'+mid+'::did::'+kNm;
SHARED fName6(string mid, string kNm) := '~thor400_66::key::insuranceheader_xlink::'+mid+'::did::'+kNm;

// Construct the incremental superfile per cluster
SHARED currLgInc(string KNm) := '~'+ifname(fName('inc',kNm));
SHARED currLgInc6(string KNm) := regexreplace('thor_data400',currLgInc(kNm),'thor400_66');


// Get the version date for the incrementals from one of the incremental superfiles in Alpharetta
// Get version of latest incremental keys in Alpharetta
SHARED getFileVersion(string sf,boolean alp=false) := FUNCTION

        sfc := nothor(STD.File.SuperFileContents(sf));
        frName:=sfc[1].name;
        fd1 := if(alp,regexfind('::2[0-9]{7}[a-z]{0,1}ib:',frName,0),regexfind('::2[0-9]{7}[a-z]{0,1}:',frName,0));
        filedate := if(alp,fd1[3..(length(fd1)-3)],fd1[3..(length(fd1)-1)]);
        output(dataset([{frName,filedate}],{string lg_ck, string fldt}),named('checked_file'),extend);
        return filedate;

END;

SHARED filedate := getFileVersion(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::inc_boca::did::refs::relative',true):INDEPENDENT ;
SHARED lFileDate := getFileVersion(data_services.foreign_prod +'thor_data400::key::insuranceheader_xlink::inc::did::refs::address'):INDEPENDENT ;

// check if version file is ok
version_date_ok := filedate<>'';
    
// check if we have a local copy already
local_address_file_exists :=
    std.file.fileexists('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::address');
    if(version_date_ok,output(local_address_file_exists,named('local_inc_already_exists')));
    
EXPORT ok_to_copy := version_date_ok and (~local_address_file_exists);

EXPORT copy_from_alpha := function
    
    // create a new blank file for the insuranceheader_segmentation key 
    ecl1:=  PRTE2_Header.fn_bld_blank_index(
        '','InsuranceHeader_PostProcess.segmentation_keys.key_did_ind ',
        'thor_data400::key::insuranceheader_segmentation::did_ind',           
        '::did_ind','~thor_data400::key::insuranceheader_segmentation::',filedate,'01')
        + '\r\n'+'bld01;';

    // aDali := _control.IPAddress.adataland_dali;
    aDali := _control.IPAddress.aprod_thor_dali;

    lc := '~foreign::' + aDali + '::';
    get_alogical(string sf):=fileservices.GetSuperFileSubName(lc+sf,1);
    
    // copy files to the respective cluster
    fc(string f1, string f2):= if(~std.file.FileExists(f2),STD.File.Copy('~'+f1,'thor400_44',f2,,,,,true,true,,true));
    fc6(string f1, string f2):= if(~std.file.FileExists(f2),STD.File.Copy('~'+f1,'thor400_66',f2,,,,,true,true,,true));
    // fc(string f1, string f2):= STD.File.Copy('~'+f1,'thor400_sta01',f2,aDali,,,,true,,true);

    // incremental key prefix
    aPref := 'thor_data400::key::insuranceheader_xlink::inc_boca::did::';

    // Copy foreign keys to local thor
    copy_incremental_keys := sequential(

     _Control.fSubmitNewWorkunit(ecl1,std.system.job.target()) // creates blank segmentation did_ind key
    
    ,fc(get_alogical(aPref+'refs::address') ,fName(filedate, 'refs::address'))
    ,fc(get_alogical(aPref+'refs::dln')     ,fName(filedate, 'refs::dln'))
    ,fc(get_alogical(aPref+'refs::dob')     ,fName(filedate, 'refs::dob'))
    ,fc(get_alogical(aPref+'refs::lfz')     ,fName(filedate, 'refs::lfz'))
    ,fc(get_alogical(aPref+'refs::name')    ,fName(filedate, 'refs::name'))
    ,fc(get_alogical(aPref+'refs::ph')      ,fName(filedate, 'refs::ph'))
    ,fc(get_alogical(aPref+'refs::relative'),fName(filedate, 'refs::relative'))
    ,fc(get_alogical(aPref+'refs::ssn')     ,fName(filedate, 'refs::ssn'))
    ,fc(get_alogical(aPref+'refs::ssn4')    ,fName(filedate, 'refs::ssn4'))
    ,fc(get_alogical(aPref+'refs::zip_pr')  ,fName(filedate, 'refs::zip_pr'))
    ,fc(get_alogical(aPref+'sup::rid')     ,fName(filedate, 'sup::rid'))
    
    //copy to other clusters
    ,fc6(fName(filedate, 'refs::address') ,fName6(filedate, 'refs::address'))
    ,fc6(fName(filedate, 'refs::dln')     ,fName6(filedate, 'refs::dln'))
    ,fc6(fName(filedate, 'refs::dob')     ,fName6(filedate, 'refs::dob'))
    ,fc6(fName(filedate, 'refs::lfz')     ,fName6(filedate, 'refs::lfz'))
    ,fc6(fName(filedate, 'refs::name')    ,fName6(filedate, 'refs::name'))
    ,fc6(fName(filedate, 'refs::ph')      ,fName6(filedate, 'refs::ph'))
    ,fc6(fName(filedate, 'refs::relative'),fName6(filedate, 'refs::relative'))
    ,fc6(fName(filedate, 'refs::ssn')     ,fName6(filedate, 'refs::ssn'))
    ,fc6(fName(filedate, 'refs::ssn4')    ,fName6(filedate, 'refs::ssn4'))
    ,fc6(fName(filedate, 'refs::zip_pr')  ,fName6(filedate, 'refs::zip_pr'))
    ,fc6(fName(filedate, 'sup::rid')       ,fName6(filedate, 'sup::rid '))
    
    );

return copy_incremental_keys;

END;

SHARED updateSupers(string kNm,boolean skipIncSFupdate=false):= sequential(

           std.file.startsuperfiletransaction(),
                      
           // remove the previous incrementals from the monthly regular lab key qa superfiles
           if(count(std.file.LogicalFileSuperOwners(currLgInc(kNm))('~'+name=fName('qa' ,kNm)))>0,
              std.file.RemoveSuperFile          (fName('qa' ,kNm),currLgInc(kNm))          ),

           if(count(std.file.LogicalFileSuperOwners(currLgInc(kNm))('~'+name=fName4('qa' ,kNm)))>0,
              std.file.RemoveSuperFile          (fName4('qa' ,kNm),currLgInc(kNm))          ),

           if(count(std.file.LogicalFileSuperOwners(currLgInc6(kNm))('~'+name=fName6('qa' ,kNm)))>0,
              std.file.RemoveSuperFile          (fName6('qa' ,kNm),currLgInc6(kNm))          ),

           // We add both to make sure the monthly
           // std.file.RemoveOwnedSubFiles      (fName('inc',kNm)),
           if(~skipIncSFupdate,std.file.RemoveOwnedSubFiles      (fName('inc',kNm),true)),
           if(~skipIncSFupdate,std.file.clearsuperfile           (fName('inc',kNm))),
           if(~skipIncSFupdate,std.file.addsuperfile             (fName('inc',kNm),fName(fileDate,kNm))),
           if(~skipIncSFupdate,std.file.addsuperfile             (fName('inc',kNm),fName6(fileDate,kNm))),
           
           // Add the new incrementals to the monthly regular lab keys qa superfiles
           std.file.AddSuperFile             (fName('qa' ,kNm),fName(filedate,kNm)),
           std.file.AddSuperFile             (fName4('qa',kNm),fName(filedate,kNm)),
           std.file.AddSuperFile             (fName6('qa',kNm),fName6(filedate,kNm)),
           std.file.finishsuperfiletransaction()
          );

// Remove incrementals from 'qa', update 'inc' superfiles and add new incrementals to the 'qa' superfiles
EXPORT update_inc_superfiles(boolean skipIncSFupdate=false) := function

    return sequential(

     updateSupers('refs::address',skipIncSFupdate)
    ,updateSupers('refs::dln',skipIncSFupdate)
    ,updateSupers('refs::dob',skipIncSFupdate)
    ,updateSupers('refs::lfz',skipIncSFupdate)
    ,updateSupers('refs::name',skipIncSFupdate)
    ,updateSupers('refs::ph',skipIncSFupdate)
    ,updateSupers('refs::relative',skipIncSFupdate)
    ,updateSupers('refs::ssn',skipIncSFupdate)
    ,updateSupers('refs::ssn4',skipIncSFupdate)
    ,updateSupers('refs::zip_pr',skipIncSFupdate)
    ,updateSupers('sup::rid',skipIncSFupdate)
    
    );
end;

elist:= _control.MyInfo.EmailAddressNotify
        ;

// KEEP LINE BELOW UNTL you can make sure the named variables udops call is working properly
// udops := Roxiekeybuild.updateversion('PersonLabKeys'        ,'20170901',elist,,'N',,,,,,'DR'); // header // PersonXLAB

SHARED udops := dops.updateversion(

                                     l_datasetname:='PersonLabKeys' // Name of the package to update
                                    ,l_uversion   :=filedate        // Version to update to
                                    ,l_email_t    :=elist           // Who to email
                                    ,l_inenvment  :='N'             // nFCRA
                                    ,l_updateflag :='DR'            // Delta Replace
                                    );


SHARED orbit_update_entries(string createORupdate) := function

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
    
    RETURN if (createORupdate='create',
                        output(create_entry('PersonXLAB_Inc'            ,filedate)),
              /* createORupdate='update', */
                        output(update_entry('PersonXLAB_Inc'            ,filedate,'N'))
               );
 
end;
// run on hthor
EXPORT Refresh_copy :=  if(
                        // true,
                        not ok_to_copy,output('No copy. see outputs'),
                        sequential(
            copy_from_alpha,
            update_inc_superfiles(),
            udops,
            orbit_update_entries('create'),
            orbit_update_entries('update'),
            _control.fSubmitNewWorkunit('Header.Proc_Copy_Keys_To_Dataland.Incrementals','hthor_sta','Dataland')

));
END;