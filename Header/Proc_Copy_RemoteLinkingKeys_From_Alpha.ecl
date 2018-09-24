// There are 27 remote Linking Keys

EXPORT Proc_Copy_RemoteLinkingKeys_From_Alpha(string filedate) := FUNCTION

  import std,_control;
  step:='Yogurt:'+Header.version_build+' COPY ALPHA Remote Linking Keys...';
  
#WORKUNIT('name', step);
#stored ('emailList', 'debendra.kumar@lexisnexisrisk.com'); 

  cmpltd:=step+' completed';
  failed:=step+' failed';
  
  fc(string f1, string f2):= sequential(
           output(dataset([{f1,'thor400_44',f2}],{string src,string clsr, string trg}),named('copy_report'),extend),
           if(~std.file.FileExists(f2),STD.File.Copy('~'+f1,'thor400_44',f2,,,,,true,true,,true))
           );
  
  aDali := _control.IPAddress.aprod_thor_dali;
  lc    := '~foreign::' + aDali + '::';
  aPref := 'thor_data400::insuranceheader_remotelinking::did::word::';
  sSufx := '::full::current';
  
  get_alogical(string sf):= nothor(fileservices.GetSuperFileSubName(lc+sf,1));

  copyKeys := sequential(
     fc(get_alogical(aPref + 'specificities' + sSufx) , aPref + 'specificities::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'ssn' + sSufx)           , aPref + 'ssn::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'dob_year' + sSufx)      , aPref + 'dob_year::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'dob_month' + sSufx)     , aPref + 'dob_month::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'dob_day' + sSufx)       , aPref + 'dob_day::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'dl_nbr' + sSufx)        , aPref + 'dl_nbr::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'sname' + sSufx)         , aPref + 'sname::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'fname' + sSufx)         , aPref + 'fname::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'mname' + sSufx)         , aPref + 'mname::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'lname' + sSufx)         , aPref + 'lname::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'gender' + sSufx)        , aPref + 'gender::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'derived_gender' + sSufx), aPref + 'derived_gender::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'prim_name' + sSufx)     , aPref + 'prim_name::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'prim_range' + sSufx)    , aPref + 'prim_range::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'sec_range' + sSufx)     , aPref + 'sec_range::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'city' + sSufx)          , aPref + 'city::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'st' + sSufx)            , aPref + 'st::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'zip' + sSufx)           , aPref + 'zip::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'policy_number' + sSufx) , aPref + 'policy_number::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'claim_number' + sSufx)  , aPref + 'claim_number::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'mainname' + sSufx)      , aPref + 'mainname::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'addr1' + sSufx)         , aPref + 'addr1::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'locale' + sSufx)        , aPref + 'locale::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'address' + sSufx)       , aPref + 'address::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'fullname' + sSufx)      , aPref + 'fullname::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'dt_first_seen' + sSufx) , aPref + 'dt_first_seen::' + filedate + '::publish')
    ,fc(get_alogical(aPref + 'dt_last_seen' + sSufx)  , aPref + 'dt_last_seen::' + filedate + '::publish')
    );
  
  QAfiles := STD.File.logicalfilelist('thor_data400::insuranceheader_remotelinking::did::word*::qa::current',FALSE,TRUE);
  moveKeys := sequential(    
        STD.File.StartSuperFileTransaction( )
       ,nothor(apply(QAfiles, STD.File.PromoteSuperFileList(['~' + name, '~' + regexreplace('::qa', name, '::father')], '~' + regexreplace('qa::current', name, filedate))))
       ,STD.File.FinishSuperFileTransaction( )
       );
  
  seq := sequential(
          header.LogBuild.single('Started :'+step),
          copyKeys,
          moveKeys,
          header.LogBuild.single('Completed :'+step)
          );
  return seq;
   
END;