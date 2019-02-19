IMPORT STD,_control,ut,PRTE2_Header,Orbit3,dops,data_services,InsuranceHeader;

// use test_copy=TRUE to take no action, and just run the report on what action would take place.
EXPORT Proc_copy_From_Alpha_Incrementals(boolean test_copy=false) := MODULE

// These may change if the build process changes
shared lastUpdatedLabQA_SF:='~thor400_36::key::insuranceheader_xlink::qa::header';
shared lastUpdatesFCRAqa_SF:='~thor_data400::key::fcra::header::address_rank_qa';
shared lastUpdatesWklyQA_SF:='~thor_data400::key::header::qa::addr_unique_expanded';

// Gets the version from the latest QA file on Thor
export lastestIkbVersionOnThor  := nothor(regexfind('[0-9]{8}', std.file.superfilecontents(lastUpdatedLabQA_SF)[1].name, 0)) : independent;
export lastestFCRAversionOnThor := nothor(regexfind('[0-9]{8}', std.file.superfilecontents(lastUpdatesFCRAqa_SF)[1].name, 0)) : independent;
export lastestWklyversionOnThor := nothor(regexfind('[0-9]{8}', std.file.superfilecontents(lastUpdatesWklyQA_SF)[1].name, 0)) : independent;


// generic function to get the FIRST subfie in the super
SHARED ifname(string sf) := nothor(STD.File.SuperFileContents(sf)[1].name);

// construct key names per cluster and type (kNm)        
SHARED fName(string mid, string kNm) := '~thor_data400::key::insuranceheader_xlink::'+mid+kNm;
SHARED fName4(string mid, string kNm) := '~thor400_44::key::insuranceheader_xlink::'+mid+kNm;
SHARED fName8(string mid, string kNm) := '~thor400_36::key::insuranceheader_xlink::'+mid+kNm;

// Construct the incremental superfile per cluster
SHARED currLgInc(string KNm) := '~'+ifname(fName('inc',kNm));
SHARED currLgInc8(string KNm) := regexreplace('thor_data400',currLgInc(kNm),'thor400_36');

// Get the version date for the incrementals from one of the incremental superfiles in Alpharetta
// Get version of latest incremental keys in Alpharetta
SHARED getFileVersion(string sf,boolean alp=false) := FUNCTION

    sfc := nothor(STD.File.SuperFileContents(sf));
    frName:=sfc[1].name;
    fd1 := if(alp,regexfind('::2[0-9]{7}[a-z]{0,1}ib:',frName,0),regexfind('::2[0-9]{7}[a-z]{0,1}:',frName,0));
    filedt := if(alp,fd1[3..(length(fd1)-3)],fd1[3..(length(fd1)-1)]);
    output(dataset([{frName,filedt}],{string lg_ck, string fldt}),named('checked_file'),extend);
    
    return filedt;
        // return '20181005';

END;

EXPORT  filedate := getFileVersion(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::inc_boca::did::refs::relative',true):INDEPENDENT ;

SHARED fc(string f1, string f2):= sequential(
    output(dataset([{f1,'thor400_44',f2}],{string src,string clsr, string trg}),named('copy_report'),extend),
    if(~test_copy,if(~std.file.FileExists(f2),STD.File.Copy('~'+f1,'thor400_44',f2,,,,,true,true,,true))));

SHARED fc8(string f1, string f2):= sequential(
    output(dataset([{f1,'thor400_36',f2}],{string src,string clsr, string trg}),named('copy_report'),extend),
    if(~test_copy,if(~std.file.FileExists(f2),STD.File.Copy('~'+f1,'thor400_36',f2,,,,,true,true,,true))));

EXPORT copy_addr_uniq_keys_from_alpha(string filedt) := function
  
  aDali := _control.IPAddress.aprod_thor_dali;
  lc := '~foreign::' + aDali + '::';
  get_alogical(string sf):=nothor(fileservices.GetSuperFileSubName(lc+sf,1));
    
  AddrSFKeyName(boolean fcra)  := '~thor_data400::key::' + if(fcra, 'fcra::', '') + 'header::qa::addr_unique_expanded';
  AddrDSFKeyName(boolean fcra) := '~thor_data400::key::' + if(fcra, 'fcra::', '') + 'header::delete::addr_unique_expanded';
  AddrLFKeyName(boolean fcra)  := '~thor_data400::key::' + if(fcra, 'fcra::', '') + 'header::' + filedt + '::addr_unique_expanded';

  copyKeys := sequential(
     fc(get_alogical('thor_data400::key::insuranceheader_incremental::fcra::qa::addr_unique_expanded'), AddrLFKeyName(true))
    ,fc(get_alogical('thor_data400::key::insuranceheader_incremental::qa::addr_unique_expanded'), AddrLFKeyName(false))
    );
    
  moveKeys := sequential(    
        STD.File.StartSuperFileTransaction( )
       ,nothor(STD.file.PromoteSuperFileList([AddrSFKeyName(true), AddrDSFKeyName(true)], AddrLFKeyName(true))) //Fcra
       ,nothor(STD.file.PromoteSuperFileList([AddrSFKeyName(false), AddrDSFKeyName(false)], AddrLFKeyName(false))) //NFcra
       ,STD.File.FinishSuperFileTransaction( )
       );
  
  seq := sequential(copyKeys, moveKeys);
  return seq;  
END;    
                
EXPORT copy_from_alpha(string filedt) := function
    
    // create a new blank file for the insuranceheader_segmentation key 
    ecl1:=  PRTE2_Header.fn_bld_blank_index(
        '','InsuranceHeader_PostProcess.segmentation_keys.key_did_ind ',
        'thor_data400::key::insuranceheader_segmentation::did_ind',           
        '::did_ind','~thor_data400::key::insuranceheader_segmentation::',filedt,'01')
        + '\r\n'+'bld01;';

    // aDali := '10.194.126.207';//_control.IPAddress.adataland_dali;
    aDali := _control.IPAddress.aprod_thor_dali;

    lc := '~foreign::' + aDali + '::';
    get_alogical(string sf):=nothor(fileservices.GetSuperFileSubName(lc+sf,1));
    
    // incremental key prefix
    aPref := 'thor_data400::key::insuranceheader_xlink::inc_boca::';

    // Copy foreign keys to local thor
    copy_incremental_keys := sequential(

     _Control.fSubmitNewWorkunit(ecl1,'thor400_44') // creates blank segmentation did_ind key
    
    ,fc(get_alogical(aPref+'did::refs::address') ,fName(filedt, '::did::refs::address'))
    ,fc(get_alogical(aPref+'did::refs::dln')     ,fName(filedt, '::did::refs::dln'))
    ,fc(get_alogical(aPref+'did::refs::dob')     ,fName(filedt, '::did::refs::dob'))
    ,fc(get_alogical(aPref+'did::refs::dobf')    ,fName(filedt, '::did::refs::dobf')) //new key
    ,fc(get_alogical(aPref+'did::refs::lfz')     ,fName(filedt, '::did::refs::lfz'))
    ,fc(get_alogical(aPref+'did::refs::name')    ,fName(filedt, '::did::refs::name'))
    ,fc(get_alogical(aPref+'did::refs::ph')      ,fName(filedt, '::did::refs::ph'))
    ,fc(get_alogical(aPref+'did::refs::relative'),fName(filedt, '::did::refs::relative'))
    ,fc(get_alogical(aPref+'did::refs::ssn')     ,fName(filedt, '::did::refs::ssn'))
    ,fc(get_alogical(aPref+'did::refs::ssn4')    ,fName(filedt, '::did::refs::ssn4'))
    ,fc(get_alogical(aPref+'did::refs::zip_pr')  ,fName(filedt, '::did::refs::zip_pr'))
    ,fc(get_alogical(aPref+'did::sup::rid')      ,fName(filedt, '::did::sup::rid'))
    ,fc(get_alogical(aPref+'header')             ,fName(filedt, '::idl'))
       
    //copy to cluster - thor400_36
    ,fc8(fName(filedt, '::did::refs::address') ,fName8(filedt, '::did::refs::address'))
    ,fc8(fName(filedt, '::did::refs::dln')     ,fName8(filedt, '::did::refs::dln'))
    ,fc8(fName(filedt, '::did::refs::dob')     ,fName8(filedt, '::did::refs::dob'))
    ,fc8(fName(filedt, '::did::refs::dobf')    ,fName8(filedt, '::did::refs::dobf')) //new key
    ,fc8(fName(filedt, '::did::refs::lfz')     ,fName8(filedt, '::did::refs::lfz'))
    ,fc8(fName(filedt, '::did::refs::name')    ,fName8(filedt, '::did::refs::name'))
    ,fc8(fName(filedt, '::did::refs::ph')      ,fName8(filedt, '::did::refs::ph'))
    ,fc8(fName(filedt, '::did::refs::relative'),fName8(filedt, '::did::refs::relative'))
    ,fc8(fName(filedt, '::did::refs::ssn')     ,fName8(filedt, '::did::refs::ssn'))
    ,fc8(fName(filedt, '::did::refs::ssn4')    ,fName8(filedt, '::did::refs::ssn4'))
    ,fc8(fName(filedt, '::did::refs::zip_pr')  ,fName8(filedt, '::did::refs::zip_pr'))
    ,fc8(fName(filedt, '::did::sup::rid')      ,fName8(filedt, '::did::sup::rid'))
    ,fc8(fName(filedt, '::idl')                ,fName8(filedt, '::idl'))
    );

    return copy_incremental_keys;
END;

SHARED updateSupers(string kNm,boolean skipIncSFupdate=false,string kNml=kNm, string filedt):= sequential(
           
    output(dataset([{'remove',fName('qa' ,kNm),currLgInc(kNm)}],{string20 action, string f1, string f2}),named('action_report'),extend);
    output(dataset([{'remove',fName4('qa' ,kNm),currLgInc(kNm)}],{string20 action, string f1, string f2}),named('action_report'),extend);
    output(dataset([{'remove',fName8('qa' ,kNm),currLgInc8(kNm)}],{string20 action, string f1, string f2}),named('action_report'),extend);

    output(dataset([{'remove',fName('inc',kNm),''}],{string20 action, string f1, string f2}),named('action_report'),extend);
    output(dataset([{'add   ',fName('inc',kNm),fName(filedt,kNml)}],{string20 action, string f1, string f2}),named('action_report'),extend);
    output(dataset([{'add   ',fName('inc',kNm),fName8(filedt,kNml)}],{string20 action, string f1, string f2}),named('action_report'),extend);

    output(dataset([{'add   ',fName( 'qa' ,kNm),fName(filedt,kNml)}],{string20 action, string f1, string f2}),named('action_report'),extend);
    output(dataset([{'add   ',fName4('qa' ,kNm),fName(filedt,kNml)}],{string20 action, string f1, string f2}),named('action_report'),extend);
    output(dataset([{'add   ',fName8('qa' ,kNm),fName8(filedt,kNml)}],{string20 action, string f1, string f2}),named('action_report'),extend);
                  
    if(~test_copy, sequential(
       std.file.startsuperfiletransaction(),
                          
       // remove the previous incrementals from the monthly regular lab key qa superfiles
       nothor(if(count(std.file.LogicalFileSuperOwners(currLgInc(kNm))('~'+name=fName('qa' ,kNm)))>0,
          std.file.RemoveSuperFile          (fName('qa' ,kNm),currLgInc(kNm))          )),

       nothor(if(count(std.file.LogicalFileSuperOwners(currLgInc(kNm))('~'+name=fName4('qa' ,kNm)))>0,
          std.file.RemoveSuperFile          (fName4('qa' ,kNm),currLgInc(kNm))          )),
     
       nothor(if(count(std.file.LogicalFileSuperOwners(currLgInc8(kNm))('~'+name=fName8('qa' ,kNm)))>0,
          std.file.RemoveSuperFile          (fName8('qa' ,kNm),currLgInc8(kNm))          )),
                  
       // We add both to make sure the monthly
       // std.file.RemoveOwnedSubFiles      (fName('inc',kNm)),
       nothor(if(~skipIncSFupdate,std.file.RemoveOwnedSubFiles      (fName('inc',kNm),true))),
       nothor(if(~skipIncSFupdate,std.file.clearsuperfile           (fName('inc',kNm)))),
       nothor(if(~skipIncSFupdate,std.file.addsuperfile             (fName('inc',kNm),fName(filedt,kNml)))),
       nothor(if(~skipIncSFupdate,std.file.addsuperfile             (fName('inc',kNm),fName8(filedt,kNml)))),
               
       // Add the new incrementals to the monthly regular lab keys qa superfiles
       nothor(std.file.AddSuperFile             (fName ('qa',kNm),fName (filedt,kNml))),
       nothor(std.file.AddSuperFile             (fName4('qa',kNm),fName (filedt,kNml))),
       nothor(std.file.AddSuperFile             (fName8('qa',kNm),fName8(filedt,kNml))),
       std.file.finishsuperfiletransaction()
    ))
  );

// Remove incrementals from 'qa', update 'inc' superfiles and add new incrementals to the 'qa' superfiles
EXPORT update_inc_superfiles(boolean skipIncSFupdate=false, string filedt) := function

    return sequential(
     updateSupers('::did::refs::address',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::dln',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::dob',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::dobf',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::lfz',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::name',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::ph',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::relative',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::ssn',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::ssn4',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::refs::zip_pr',skipIncSFupdate, ,filedt)
    ,updateSupers('::did::sup::rid',skipIncSFupdate, ,filedt)
    ,updateSupers('::did'          ,skipIncSFupdate, ,filedt)    
    );
END;

EXPORT update_inc_idl(boolean skipIncSFupdate=false, string filedt) := updateSupers('::header',skipIncSFupdate,'::idl', filedt);

SHARED elist:= Header.email_list.BocaDevelopers;

// KEEP LINE BELOW UNTL you can make sure the named variables udops call is working properly
// udops := Roxiekeybuild.updateversion('PersonLabKeys'        ,'20170901',elist,,'N',,,,,,'DR'); // header // PersonXLAB

SHARED udops(string3 skipPackage='000') := sequential(
    if(skipPackage[1]='0',
    dops.updateversion(
                         l_datasetname:='PersonLabKeys' // Name of the package to update
                        ,l_uversion   :=lastestIkbVersionOnThor     // Version to update to
                        ,l_email_t    :=elist           // Who to email
                        ,l_inenvment  :='N'             // nFCRA
                        ,l_updateflag :='DR'            // Delta Replace (must sepcify, because default is FULL)
                        )),                
    if(skipPackage[2]='0',
    dops.updateversion(
                         l_datasetname:='FCRA_PersonHeaderKeys' // Name of the package to update
                        ,l_uversion   :=lastestFCRAversionOnThor                // Version to update to
                        ,l_email_t    :=elist                   // Who to email
                        ,l_inenvment  :='F'                     // FCRA
                      )),
    if(skipPackage[3]='0',
    dops.updateversion(
                         l_datasetname:='PersonHeaderWeeklyKeys'
                        ,l_uversion   :=lastestWklyversionOnThor        // Version to update to
                        ,l_email_t    :=elist           // Who to email
                        ,l_inenvment  :='N'             // nFCRA
                       ))
);

SHARED tokenval := orbit3.GetToken();
SHARED rec_rep := {STRING  Name, STRING  Status, STRING  Message};
    
SHARED  update_entry(string buildname, string Buildvs, string Envmt) := FUNCTION
             
    submit_change1 := Orbit3.UpdateBuildInstance(buildname, Buildvs, tokenval, 'BUILD_AVAILABLE_FOR_USE',
                                                            Orbit3.Constants(Envmt).platform_upd).retcode ;
    
    return if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
                project(submit_change1, transform(rec_rep,SELF.Name:=buildname,SELF:=LEFT))
                );
END;

SHARED update_bentry(string buildname, string Buildvs, string Envmt) := FUNCTION
            
    status := Orbit3.Constants(Envmt).platform_upd(PlatformName='Boolean Roxie Production');
    submit_change1 := Orbit3.UpdateBuildInstance(buildname, Buildvs, tokenval, 'BUILD_AVAILABLE_FOR_USE',
                                                            status).retcode ;
    
    return if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
                project(submit_change1, transform(rec_rep,SELF.Name:=buildname,SELF:=LEFT))
                );
END;

SHARED create_entry(string buildname, string Buildvs) := FUNCTION
    
    submit_change1 := Orbit3.CreateBuild        (buildname, Buildvs, tokenval).retcode;
    submit_change2 := Orbit3.UpdateBuildInstance(buildname, Buildvs, tokenval).retcode;
    return if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
               project(submit_change1, transform(rec_rep,SELF.Name:=buildname,SELF:=LEFT))+
               project(submit_change2, transform(rec_rep,SELF.Name:=buildname,SELF:=LEFT))
              );
END;

SHARED orbit_update_entries(string createORupdate, string skipPackage='000') := function

    RETURN if (createORupdate='create',
                sequential(
                        if(skipPackage[1]='0',output(create_entry('PersonXLAB_Inc' ,lastestIkbVersionOnThor))),
                        if(skipPackage[2]='0',output(create_entry('FCRA_Header'    ,lastestFCRAversionOnThor))),
                        if(skipPackage[3]='0',output(create_entry('Header_IKB'     ,lastestWklyversionOnThor)))
                ),
                sequential(
                        if(skipPackage[1]='0',output(update_entry('PersonXLAB_Inc' ,lastestIkbVersionOnThor,'N'))),
                        if(skipPackage[2]='0',output(update_entry('FCRA_Header'    ,lastestFCRAversionOnThor,'F'))),
                        if(skipPackage[3]='0',output(update_entry('Header_IKB'     ,lastestWklyversionOnThor,'N')))
                )
       );

END;

// check if we have a local copy already   
EXPORT ok_to_copy(string filedt) := filedt<>'' and (~std.file.fileexists('~thor_data400::key::insuranceheader_xlink::'+filedt+'::did::refs::idl')) and (~std.file.fileexists('~thor400_36::key::insuranceheader_xlink::'+filedt+'::did::refs::idl'));
SHARED ok_to_copy_UniqExKeys(string filedt) := filedt<>'' and (~std.file.fileexists('~thor_data400::key::header::' + filedt + '::addr_unique_expanded'));

// run on hthor
EXPORT Refresh_copy(string filedt) :=  FUNCTION

    noLABcopy := ~test_copy AND ~ok_to_copy(filedt);
    cpLab := if(noLABcopy
             ,output('No LAB copy. see outputs')
             ,copy_from_alpha(filedt)
             );
             
    noUniqExcopy := ~test_copy AND ~ok_to_copy_UniqExKeys(filedt);
    cpUniqEx := if(noUniqExcopy
             ,output('No Address Unique Expanded copy. see outputs')
             ,copy_addr_uniq_keys_from_alpha(filedt)
             );
             
    return sequential(cpLab, cpUniqEx);
END;

copy_to_dataland:= _control.fSubmitNewWorkunit('Header.Proc_Copy_Keys_To_Dataland.Incrementals','hthor_sta','Dataland');

EXPORT movetoQA(string filedt) := sequential(
    // The following can only copy after the key is built in Boca
    fc8(fName(filedt, '::did'), fName8(filedt, '::did')),
    update_inc_superfiles(,filedt),
    copy_to_dataland
    );
        
EXPORT deploy(string emailList,string rpt_qa_email_list,string skipPackage='000') := sequential(  

   std.system.Email.SendEmail(rpt_qa_email_list+','+emailList,'New boca Header IKB deployment',
     'Hello,\n\nPlease note that the following datasets have been updated for CERT deployment:'
    +'\n\n'
    +if(skipPackage[1]='0','PersonXLAB_Inc\n','')
    +if(skipPackage[2]='0','FCRA_Header\n','')
    +if(skipPackage[3]='0','PersonHeaderWeeklyKeys\n','')
    +if(skipPackage[1]='0','\nPersonXLAB_Inc Deployment version: \n' + lastestIkbVersionOnThor,'')
    +if(skipPackage[2]='0','\nFCRA_Header Deployment version: \n' + lastestFCRAversionOnThor,'')
    +if(skipPackage[3]='0','\nPersonHeaderWeeklyKeys Deployment version: \n' + lastestWklyversionOnThor,'')
    +'\n\n'
    +'Corespondiong Orbit entries have been created and updated.\n'
    +'\n'
    +'If you have any question or concerns please contact:\n'
    +'Debendra.Kumar@lexisnexisrisk.com\n'
    +'gabriel.marcan@lexisnexisrisk.com\n'
    +'\nThank you,'),          
    
    orbit_update_entries('create',skipPackage),
    orbit_update_entries('update',skipPackage),
    udops(skipPackage)
);
END;