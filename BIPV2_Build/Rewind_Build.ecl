import tools,wk_ut,std,ut,WsDFU;

EXPORT Rewind_Build(

   string                                     pversion                      // version of the build you are rolling back
  ,string                                     PWuid                         // all files created in this workunit and subsequent workunits in this build will be deleted.
  ,boolean                                    pDeleteFiles        = false   // true = output the files to the workunit + delete them.  false = output the files to the workunit
  ,string                                     pFilter             = ''      // optional regex filter for the files to delete.
  ,dataset(wk_ut.Layouts.wks_slim_filename)   pWorkman_Superfile  = BIPV2_Build.files().workunit_history_.qa
) :=
function
             
  ds_workman                          := pWorkman_Superfile(wuid != '',pWuid = '' or wuid >= pWuid,pversion = '' or version = pversion);
  ds_workman_files_written            := project(ds_workman  ,transform({string esp,dataset(wk_ut.get_WUInfo().WsFileWritten) files} ,self.files := wk_ut.get_FilesWritten(left.wuid,left.esp),self := left));
  ds_workman_files_written_norm       := normalize(ds_workman_files_written ,left.files ,transform({string name,string esp},self.name := '~' + right.name,self := left));
  ds_workman_files_written_norm_filt  := ds_workman_files_written_norm(regexfind('[[:digit:]]{8}',name,nocase),pFilter = '' or regexfind(pFilter,name,nocase));

  // -- for non-local wuids, also put in the local names because it will copy them over.
  ds_workman_extra_fnames             := 
      project(ds_workman ,transform({string name,string esp},self.name := '~' + trim(left.__filename),self := left))
    + project(ds_workman(esp != wk_ut._Constants.LocalEsp) ,transform({string name,string esp},self.name := '~' + trim(left.__filename),self.esp := wk_ut._Constants.LocalEsp))
  ;

  WsTiming := 
  RECORD
    UNSIGNED4 count               ;
    UNSIGNED4 duration            ;
    UNSIGNED4 max                 ;
    STRING    name{MAXLENGTH(64)} ;
  END;

  ds_workman_timings  := project(ds_workman ,transform({string esp,dataset(WsTiming) timings},
    self.timings := wk_ut.get_WUInfo(left.wuid,left.esp).ds_Wstiming,self := left));
  ds_workman_timings_filter := normalize(ds_workman_timings ,left.timings,transform({string esp,WsTiming},self := right,self := left)) (regexfind('copy',name,nocase));
  ds_dfuwuids               := dedup(project(ds_workman_timings_filter  ,transform({string wuid,string esp},self.wuid := regexfind('D[[:digit:]]{8}[-][[:alnum:]-]+',left.name,0),self := left)),all);
  ds_dfu_files              := project(ds_dfuwuids  ,transform({string name,string esp},self.name := '~' + tools.mod_dfuInfo(left.wuid,left.esp).DestLogicalName,self := left));

  ds_concat                 := project(
      ds_workman_files_written_norm_filt 
    + ds_workman_extra_fnames(pFilter = '' or regexfind(pFilter,name,nocase)) 
    + ds_dfu_files
    + dataset([{'~bipv2_build::'+ pversion + '::workunit_history::proc_build_all',wk_ut._Constants.LocalEsp}],{string name,string esp})  // in case the full build finished, this needs to be deleted for the build to run at all
    ,transform({recordof(left),boolean isLocal},self.isLocal := if(left.esp = wk_ut._Constants.LocalEsp,true,false)  ,self := left));

  total_cnt1        := count(ds_concat);
  files2delete      := project(sort(dedup(sort(ds_concat,name,esp),name,esp,all),isLocal,name,esp),transform({unsigned rid,string name,string esp,unsigned total_cnt,boolean isLocal},self.rid := counter,self := left,self.total_cnt := total_cnt1));

  outputdebug := 
  parallel(
     output(ds_workman                         ,named('ds_workman'                         ))
    ,output(ds_workman_files_written           ,named('ds_workman_files_written'           ))   //up to here works
    ,output(ds_workman_files_written_norm      ,named('ds_workman_files_written_norm'      ))   //good
    ,output(ds_workman_files_written_norm_filt ,named('ds_workman_files_written_norm_filt' ))
    ,output(ds_workman_extra_fnames            ,named('ds_workman_extra_fnames'            ))
    ,output(ds_workman_timings                 ,named('ds_workman_timings'                 ))
    ,output(ds_workman_timings_filter          ,named('ds_workman_timings_filter'          )) //good
    ,output(ds_dfuwuids                        ,named('ds_dfuwuids'                        )) //good
    ,output(ds_dfu_files                       ,named('ds_dfu_files'                       ))
    ,output(ds_concat                          ,named('ds_concat'                          ))
    ,output(total_cnt1                         ,named('total_cnt1'                         ))
    ,output(files2delete                       ,named('files2delete'                       ),all)
  );
  
  return sequential(
     apply(global(ds_workman,few) ,sequential(
         STD.System.Log.addWorkunitInformation('Restoring '       + wuid + ' on ' + ut.GetTimeDate())
        ,output(wk_ut.Restore_Workunit(wuid,esp)) 
        ,STD.System.Log.addWorkunitInformation('Done restoring '  + wuid + ' on ' + ut.GetTimeDate())
     ))
    ,outputdebug
    // ,iff(pDeleteFiles  = true ,nothor(apply(files2delete, tools.Delete_File(/*'~' + */name,rid,total_cnt,esp))))//no worky
    // ,iff(pDeleteFiles  = true ,nothor(global(apply(files2delete, tools.Delete_File(/*'~' + */name,rid,total_cnt,esp)))))//no worky
    ,iff(pDeleteFiles  = true ,       apply(global(files2delete(isLocal = false),few), sequential(
       output(WsDFU.DeleteLogicalFile(name,true,,esp),named('Remote_Files_Deleted'),extend)
      ,output(rid,named('Number_Files_Deleted'),overwrite)
      ,STD.System.Log.addWorkunitInformation ('Number of files deleted so far: ' + (string)rid + ' out of a total of ' + total_cnt + ' files.')
    )))
    ,iff(pDeleteFiles  = true ,nothor(apply(global(files2delete(isLocal = true ),few), tools.Delete_File(/*'~' + */name,rid,total_cnt))))
    // ,iff(pDeleteFiles  = true ,nothor(apply(global(files2delete,few), tools.Delete_File(/*'~' + */name,rid,total_cnt,esp))))
  );

end;