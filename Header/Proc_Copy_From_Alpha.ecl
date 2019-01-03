IMPORT STD,header,ut,_control,wk_ut;

EXPORT Proc_Copy_From_Alpha := module

SHARED filedate:=header.version_build;

SHARED linking_keys := dataset ( [ 

                            {'thor_data400::key::insuranceheader_segmentation::<<version>>::did_ind','thor_data400::key::insuranceheader_segmentation::did_ind_qa'},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::address',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::dln',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::dob',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::dobf',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::lfz',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::name',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::ph',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::ssn',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::ssn4',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::zip_pr',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::refs::relative',''},
                            {'thor_data400::key::insuranceheader_xlink::<<version>>::did::sup::rid',''}
                            
                         ] , {string nm,string src_name});
                         
SHARED base_relative := dataset ([

                            {'thor_data400::base::insuranceheader::<<version>>::relatives_v3','thor_data400::base::insurance_header::relative'}
                            
                         ] , {string nm,string src_name});

SHARED additional_keys:= dataset ([

                            {'thor_data400::key::header::<<version>>::relatives_v3','thor_data400::key::relatives_v3_qa'},
                            {'thor_data400::key::insuranceheader::<<version>>::did',''},
                            {'thor_data400::key::insuranceheader::<<version>>::dln',''},
                            {'thor_data400::key::insuranceheader::<<version>>::allpossiblessns','thor_data400::key::insuranceheader::allpossiblessns::qa'}                            
                         ] , {string nm,string src_name});

SHARED allAlphaFils := linking_keys + base_relative + additional_keys;
// ************************************************************************************************************************************

SHARED ver(string nm,string new_ver, string clstr='') := 
    
    regexreplace('<<version>>',if(clstr=''
                                 ,nm
                                 ,regexreplace('thor_data400',nm,clstr)),new_ver);

// ************************************************************************************************************************************
SHARED copy_files(string nm, string src_name, string dest_clstr,string src_alpha, string agmntName=dest_clstr) := function

    src_spr         := if(src_name='',nm,src_name); // if the source file has a different format it's in src_name
    alpha_logical1   := STD.File.SuperFileContents(ut.foreign_aprod+ver(src_spr,'full'))[1].name;
    alpha_logical2   := STD.File.SuperFileContents(ut.foreign_aprod+ver(src_spr,'qa'))[1].name;
    source_filename := case(src_alpha, 'from_alpha1'=>alpha_logical1,
                                       'from_alpha2'=>alpha_logical2,
                                       ver(nm,filedate));
    target_filename := ver(nm,filedate,agmntName); // update the version number
    
    return sequential(output(dataset([{'~'+source_filename,dest_clstr,'~'+target_filename}],{string src,string d_clstr, string trgt}),named('cp_copy'),extend)
                      ,std.file.copy('~'+source_filename,dest_clstr,'~'+target_filename,replicate:=true,compress:=true,allowoverwrite:=true)
                     );

end;
// ************************************************************************************************************************************

SHARED update_supers(string spr0, string newLogical) := function

    spr:='~'+ case( spr0, 'thor_data400::key::header::qa::relatives_v3'=>
                         'thor_data400::key::relatives_v3_qa',
                         'thor_data400::key::insuranceheader_segmentation::qa::did_ind'=>
                         'thor_data400::key::insuranceheader_segmentation::did_ind_qa',
                         'thor400_44::key::insuranceheader_segmentation::qa::did_ind'=>
                         'thor400_44::key::insuranceheader_segmentation::did_ind_qa',
                         'thor400_44::key::insuranceheader_segmentation::built::did_ind'=>
                         'thor400_44::key::insuranceheader_segmentation::did_ind_built',
                         'thor400_36::key::insuranceheader_segmentation::qa::did_ind'=>
                         'thor400_36::key::insuranceheader_segmentation::did_ind_qa'
                  ,spr0);
    return sequential(
        output(dataset([{spr,'~'+newLogical}],{string super, string new_logical}),named('cp_built_update'),extend)
        ,std.file.RemoveOwnedSubFiles(spr,TRUE)
        ,std.file.clearsuperfile     (spr)
        ,if(std.file.SuperFileExists('~'+newLogical)
             ,std.file.addsuperfile       (spr   , '~'+newLogical ,,true)
             ,std.file.addsuperfile       (spr   , '~'+newLogical       ));
    );
end;
// ************************************************************************************************************************************

GetDFUWorkunit(string pWuid, string pesp = wk_ut._constants.LocalEsp) := FUNCTION

              dfuLayout := RECORD
                    STRING TimeStarted          {XPATH('TimeStarted')};
                    STRING TimeStopped          {XPATH('TimeStopped')};
                    STRING SourceLogicalName    {XPATH('SourceLogicalName')};
              END;
              OutRec1 := RECORD
                    DATASET(dfuLayout) Fred{XPATH('/result')};
              END;
              raw := HTTPCALL('http://' + pesp + ':8010/FileSpray/GetDFUWorkunit.xml?wuid=' + pWuid , 'GET', 'text/xml', OutRec1,xpath('GetDFUWorkunitResponse')); 
              return normalize(dataset(raw),left.Fred,transform({ string dfu, dfuLayout},self.dfu:=pWuid, self := right));
        end;

Get_DFUInfo(string filename, string pesp = wk_ut._constants.LocalEsp,string dfu_overwrite='') := FUNCTION
        dfu := if(dfu_overwrite<>'', dfu_overwrite,wk_ut.get_DFUInfo(filename).DFUInfo[1].wuid);
        return project(GetDFUWorkunit(dfu,pesp),TRANSFORM(
                                                {string TargetLogicalName, recordof(LEFT), real4 duration_hours},
                                                SELF.TargetLogicalName:=trim(filename),
                                                
                                                date_diff := ut.DaysApart(regexreplace('-',left.timeStopped,''),
                                                                          regexreplace('-',left.timeStarted,'')  )*24;
                                                             
                                                time_diff := (   ((real8)(left.timeStopped[12..13])+
                                                                  (real8)(left.timeStopped[15..16])/60+
                                                                  (real8)(left.timeStopped[18..19])/60/60)
                                                                 -
                                                                 ((real8)(left.timeStarted[12..13])+
                                                                  (real8)(left.timeStarted[15..16])/60+
                                                                  (real8)(left.timeStarted[18..19])/60/60)
                                                             );
                                                self.dfu := trim(LEFT.dfu);
                                                self.TimeStarted:=trim(LEFT.TimeStarted);
                                                self.TimeStopped:=trim(LEFT.TimeStopped);
                                                self.duration_hours:=date_diff+time_diff;
                                                self:=LEFT));
end;
generateDFUinfo(string filedate):=
sequential(
output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_segmentation::'+filedate+'::did_ind'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::address'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::dln'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::dob'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::lfz'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::name'),named('file_copy_log'),extend)
,output(Get_DFUInfo(  '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::ph'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::ssn'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::ssn4'),named('file_copy_log'),extend)
,output(Get_DFUInfo(  '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::zip_pr'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::relative'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::sup::rid'),named('file_copy_log'),extend)

,output(Get_DFUInfo(   '~thor_data400::key::header::'+filedate+'::relatives_v3'),named('file_copy_log'),extend)
,output(Get_DFUInfo( '~thor_data400::base::insurance_header::'+filedate+'::relative',,'D20170901-061429'),named('file_copy_log'),extend)

,output(Get_DFUInfo('~thor_data400::key::insuranceheader::'+filedate+'::did'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader::'+filedate+'::dln'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader::'+filedate+'::allpossiblessns'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::header::'+filedate+'::addr_unique_expanded'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::fcra::header::'+filedate+'::addr_unique_expanded'),named('file_copy_log'),extend)
);



EXPORT Copy := sequential(
         nothor(apply(linking_keys+base_relative ,copy_files    (nm,src_name,'thor400_44','from_alpha1','thor_data400')))
        ,nothor(apply(linking_keys               ,copy_files    (nm,src_name,'thor400_36','local'      ,'thor400_36'  )))
        ,nothor(apply(linking_keys+base_relative ,update_supers (ver(nm,'built', 'thor400_44')         ,ver(nm,filedate))))
        ,generateDFUinfo(filedate)
);
// ************************************************************************************************************************************

EXPORT copyOthers := sequential(
        nothor(apply(additional_keys    ,copy_files     (nm,src_name,'thor400_44','from_alpha2','thor_data400')  ))
       ,nothor(apply(additional_keys    ,update_supers  (ver(nm,'built', 'thor_data400')   , ver(nm,filedate))    ))
);
// ************************************************************************************************************************************
ld :='thor_data400::key::insuranceheader_xlink::<<version>>::did';
reltv_n_othr:=base_relative + additional_keys;
EXPORT MoveToQA :=sequential(

     nothor(apply(linking_keys, update_supers(  ver(nm,'father','thor400_44'  ), ver(nm,'qa'    ,'thor400_44'  )) ))
    ,nothor(apply(linking_keys, update_supers(  ver(nm,'qa'    ,'thor400_44'), ver(nm,filedate,'thor_data400')) ))
    ,nothor(apply(linking_keys, update_supers(  ver(nm,'qa'    ,'thor400_36'  ), ver(nm,filedate,'thor400_36'  )) ))
    ,nothor(apply(linking_keys, update_supers(  ver(nm,'qa'    ,'thor_data400'  ), ver(nm,filedate,'thor_data400')) ))
    ,nothor(apply(reltv_n_othr, update_supers(  ver(nm,'qa'    ,'thor_data400'), ver(nm,filedate,'thor_data400')) ))
    // This keey is built in Doxie.Proc_Header_Keys (not copied like the rest)
    ,                           update_supers(  ver(ld,'qa'    ,'thor_data400'), ver(ld,filedate,'thor_data400'))
    ,                           update_supers(  ver(ld,'qa'    ,'thor400_44'  ), ver(ld,filedate,'thor_data400'))
    ,                           update_supers(  ver(ld,'qa'    ,'thor400_36'  ), ver(ld,filedate,'thor_data400'))
    ,nothor(Header.Proc_Copy_From_Alpha_Incrementals().update_inc_superfiles(true)) // Restore the incremental keys into the qa superfiles
    ,_control.fSubmitNewWorkunit('Header.Proc_Copy_Keys_To_Dataland.Full','hthor_sta_eclcc','Dataland') // Copy and update new full keys in dataland
);
// ************************************************************************************************************************************

END;