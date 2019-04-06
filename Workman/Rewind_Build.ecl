/*
  Workman.Rewind_Build()
    rewind a build to an earlier step.  this will use the workman files to examine all workunits in the 
    build(starting from the workunit you pass in), and compile the following files to be deleted:
      1. files written by all of the workunits found.  
      2. any files that were skipped in the build using the tools.macf_WriteFile macro
      3. any files copied using the dfu.
      4. any files you pass in using the pExtraFiles parameter

    It will rename the workman files so that they will be rerun, but keep them around for a breadcrumb trail.

    Also note that it will NOT delete files if the pDeleteFiles parameter is set to false.  it is recommended to run this function
    first with that set to false to get an idea of the files that will be deleted, then tweak the parameters if necessary and
    run it as many times as necessary until you get the files you expect/want in the files2delete output result dataset.
    Once that is achieved, run it again setting the pDeleteFiles to true and it will delete those files.
    This will restore any wuids that it needs to so that it can get the information it needs from the wuids.
    
*/
import tools,Workman,std,ut,WsDFU,FileSpray,WsWorkunits;

EXPORT Rewind_Build(

   string                                       pversion                      // version of the build you are rolling back
  ,string                                       PWuid                         // all files created in this workunit and subsequent workunits in this build will be deleted.
  ,dataset(Workman.Layouts.wks_slim_filename  ) pWorkman_Superfile            // the workman superfile for your build.  it should contain all of the workman build files.
  ,boolean                                      pDeleteFiles        = false   // true = output the files to the workunit + delete them.  false = output the files to the workunit
  ,string                                       pFilter             = ''      // optional regex filter for the files to delete.
  ,dataset({string name,string esp}           ) pExtraFiles         = dataset([],{string name,string esp})
  ,boolean                                      pRestoreWuids       = true
) :=
function
             
  ds_workman                          := pWorkman_Superfile(wuid != '',pWuid = '' or wuid >= pWuid,pversion = '' or version = pversion);
  ds_workman_files_written            := project(ds_workman  ,transform({string esp,dataset(WsWorkunits.layouts.WsFileWritten) files} ,self.files := Workman.get_FilesWritten(left.wuid,left.esp,false),self := left));
  ds_workman_files_written_norm       := normalize(ds_workman_files_written ,left.files ,transform({string name,string esp},self.name := '~' + right.name,self := left));
  ds_workman_files_written_norm_filt  := ds_workman_files_written_norm(regexfind('[[:digit:]]{8}',name,nocase),pFilter = '' or regexfind(pFilter,name,nocase));

  // -- for non-local wuids, also put in the local names because it will copy them over.
  ds_workman_extra_fnames             := 
      project(ds_workman                                   ,transform({string srcname,string dstname,string esp},self.srcname := '~' + trim(left.__filename),self.dstname := if(STD.Str.Find(self.srcname ,left.wuid, 1) = 0,trim(self.srcname) + '.' + trim(left.wuid) ,self.srcname),self      := left                     ))
    + project(ds_workman(esp != Workman._Config.LocalEsp)  ,transform({string srcname,string dstname,string esp},self.srcname := '~' + trim(left.__filename),self.dstname := if(STD.Str.Find(self.srcname ,left.wuid, 1) = 0,trim(self.srcname) + '.' + trim(left.wuid) ,self.srcname),self.esp  := Workman._Config.LocalEsp))
  ;

  ////////////////////////////
  ds_workman_skipped_files            := project(ds_workman  ,transform({dataset({string name}) files,string esp} ,self.files := project(WsWorkunits.get_Results(left.wuid)(filename = '',regexfind('not building',value,nocase)),transform({string name},self.name := regexreplace('not building (.*?) because it already exists',left.value,'$1',nocase))),self := left));
  ds_workman_skipped_files_norm       := normalize(ds_workman_skipped_files ,left.files ,transform({string name,string esp},self.name := right.name,self := left));

  ds_workman_timings  := project(ds_workman ,transform({string esp,dataset(Layouts.WsTiming) timings},
    self.timings := WorkMan.get_WsTiming(left.wuid,left.esp),self := left));
  ds_workman_timings_filter := normalize(ds_workman_timings ,left.timings,transform({string esp,WsTiming},self := right,self := left)) (regexfind('copy',name,nocase));
  ds_dfuwuids               := dedup(project(ds_workman_timings_filter  ,transform({string wuid,string esp},self.wuid := regexfind('D[[:digit:]]{8}[-][[:alnum:]-]+',left.name,0),self := left)),all);
  ds_dfu_files              := project(ds_dfuwuids  ,transform({string name,string esp},self.name := '~' + FileSpray.get_DestLogicalName(left.wuid,left.esp),self := left));

  ds_workman_extra_fnames_filtered := dedup(ds_workman_extra_fnames(pFilter = '' or regexfind(pFilter,srcname,nocase)),srcname,all);

  ds_concat                 := project(
      ds_workman_files_written_norm_filt 
    // + ds_workman_extra_fnames_filtered 
    + ds_dfu_files
    + pExtraFiles
    + ds_workman_skipped_files_norm       
    + project(ds_workman_extra_fnames_filtered  ,transform({string name,string esp},self.name := left.srcname,self.esp := left.esp))
    ,transform({recordof(left),boolean isLocal},self.isLocal := if(left.esp = Workman._Config.LocalEsp,true,false)  ,self := left));

  total_cnt1        := count(ds_concat);
  files2delete      := project(sort(dedup(sort(ds_concat,name,esp),name,esp,all),isLocal,name,esp),transform({unsigned rid,string name,string esp,unsigned total_cnt,boolean isLocal},self.rid := counter,self := left,self.total_cnt := total_cnt1)) : independent;

  outputdebug := 
  parallel(
     iff(pDeleteFiles  = true ,sequential(
         output(0                         ,named('Number_Files_Deleted'),overwrite)
        ,output(WsDFU.DeleteLogicalFile('',true),named('Remote_Files_Deleted'),extend   )
     ))
    ,output(total_cnt1                          ,named('total_cnt'                           ))
    ,output(files2delete                        ,named('files2delete'                        ),all)
    ,output(ds_workman_extra_fnames_filtered    ,named('files2rename'                        ),all)
    ,output(ds_workman_files_written_norm_filt  ,named('ds_workman_files_written_norm_filt'  ))
    ,output(ds_dfu_files                        ,named('ds_dfu_files'                        ))   //good
    ,output(pExtraFiles                         ,named('pExtraFiles'                         ))
    ,output(ds_workman_skipped_files_norm       ,named('ds_workman_skipped_files_norm'       ))

    ,output(ds_workman                         ,named('ds_workman'                         ))
    ,output(ds_workman_files_written           ,named('ds_workman_files_written'           ))   //up to here works
    ,output(ds_workman_files_written_norm      ,named('ds_workman_files_written_norm'      ))   //good
    ,output(ds_workman_extra_fnames            ,named('ds_workman_extra_fnames'            ))
    ,output(ds_workman_timings                 ,named('ds_workman_timings'                 ))
    ,output(ds_workman_timings_filter          ,named('ds_workman_timings_filter'          )) //good
    // ,output(ds_workman_skipped_files_norm      ,named('ds_workman_skipped_files_norm'      ))
    ,output(ds_dfuwuids                        ,named('ds_dfuwuids'                        )) //good
    // ,output(ds_dfu_files                       ,named('ds_dfu_files'                       ))
    ,output(ds_concat                          ,named('ds_concat'                          ))
  );

  rename_workman_files := apply(global(ds_workman_extra_fnames_filtered,few)  ,sequential(Workman.Rename_File(srcname,dstname,true,esp)));
  
  return sequential(iff(pRestoreWuids = true,
     apply(global(ds_workman,few) ,sequential(
         STD.System.Log.addWorkunitInformation('Restoring '       + wuid + ' on ' + Workman.getTimeDate())
        ,output(Workman.Restore_Workunit(wuid,esp),named('restoring_wuids'),extend) 
        ,STD.System.Log.addWorkunitInformation('Done restoring '  + wuid + ' on ' + Workman.getTimeDate())
     )))
    ,outputdebug
    // -- delete remote files first
    ,iff(pDeleteFiles  = true 
      ,iff(exists(files2delete(isLocal = false)) ,apply(global(files2delete(isLocal = false),few)
        ,sequential(
           output(WsDFU.DeleteLogicalFile(name,true,,esp) ,named('Remote_Files_Deleted'),extend)
          ,output(rid                               ,named('Number_Files_Deleted'),overwrite)
          ,STD.System.Log.addWorkunitInformation ('Number of files deleted so far: ' + (string)rid + ' out of a total of ' + total_cnt + ' files.')
        )
      ))
    )
    // -- delete local files next
    ,iff(pDeleteFiles  = true ,nothor(apply(global(files2delete(isLocal = true ),few), tools.Delete_File(/*'~' + */name,rid,total_cnt))))
    // ,iff(pDeleteFiles  = true ,rename_workman_files)
  );

end;