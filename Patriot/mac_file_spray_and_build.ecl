
import Patriot_preprocess;
//export mac_file_spray_and_build(sourceIP,sourcefile,recordsize,filedate,basefilename,outname,group_name='\'thor200_144\'') := macro 
export mac_file_spray_and_build(recordsize,filedate,basefilename,outname,group_name='\'thor200_144\'') := macro 

#uniquename(spray_first)
#uniquename(mv_in_super)
#uniquename(build_fse)
#uniquename(mv_in_super_fse)
#uniquename(run_addressid)
#uniquename(build_super)
#uniquename(foo)
boolean %foo% := true;

//%spray_first% := FileServices.SprayFixed(sourceIP,sourcefile, recordsize, group_name,'~thor_data400::in::' + basefilename + '_' + filedate ,-1,,,true,true);

%spray_first%   := Patriot_preprocess._Mapping_Clean_names(filedate);

%mv_in_super% := sequential(
				 FileServices.StartSuperFileTransaction(),
			     FileServices.AddSuperFile('~thor_data400::in::' + basefilename + '_raw_delete', 
                                           '~thor_data400::in::' + basefilename + '_raw',, true),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename + '_raw'),
				 FileServices.AddSuperFile('~thor_data400::in::' + basefilename + '_raw', 
                                           '~thor_data400::in::' + basefilename + '_'+filedate),
				 FileServices.FinishSuperFileTransaction(),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename + '_raw_delete',true));

%build_fse% := Patriot.Proc_Build_BW_Base(fileDate);

%mv_in_super_fse% := sequential(
				 FileServices.StartSuperFileTransaction(),
			     FileServices.AddSuperFile('~thor_data400::in::' + basefilename + '_fse_raw_delete', 
                                           '~thor_data400::in::' + basefilename + '_fse_raw',, true),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename + '_fse_raw'),
				 FileServices.AddSuperFile('~thor_data400::in::' + basefilename + '_fse_raw', 
                                           '~thor_data400::in::' + basefilename + '_fse_raw_'+filedate),
				 FileServices.FinishSuperFileTransaction(),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename + '_fse_raw_delete',true));

%run_addressid% := Patriot.proc_buildaddressid(filedate);

%build_super% := sequential(
                 FileServices.StartSuperFileTransaction(),
			  FileServices.AddSuperFile('~thor_data400::in::' + basefilename + '_delete', 
                                           '~thor_data400::in::' + basefilename + '_father',, true),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename + '_father'),
                 FileServices.AddSuperFile('~thor_data400::in::' + basefilename + '_father', 
                                           '~thor_data400::in::' + basefilename,, true),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename),
                 FileServices.AddSuperFile('~thor_data400::in::' + basefilename, 
                                           '~thor_data400::in::' + basefilename + '_' + filedate +'_addressid'), 
			  FileServices.FinishSuperFileTransaction(),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename + '_delete',true));

outname := sequential(%spray_first%,%mv_in_super%,%build_fse%,%mv_in_super_fse%,%run_addressid%,%build_super%);

endmacro;