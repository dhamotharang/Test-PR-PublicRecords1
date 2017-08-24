IMPORT tris_lnssi_ingest,SALT36,PromoteSupers,std;

EXPORT proc_build_base(string filedate) := function

        MyDelta := DATASET([],tris_lnssi_ingest.Layout_basefile);
        ingestMod := tris_lnssi_ingest.Ingest(false,MyDelta);

        PromoteSupers.Mac_SF_BuildProcess(ingestMod.AllRecords_NoTag
                                          ,tris_lnssi_build.constants.base_filename
                                          ,build_it
                                          ,2,,true,filedate);

        return sequential(
                     std.file.createsuperfile('~thor_data400::base::tris::lnssi',,true)
                    ,std.file.createsuperfile('~thor_data400::base::tris::lnssi_father',,true)
                    ,std.file.createsuperfile('~thor_data400::base::tris::lnssi_delete',,true)
                    ,ingestMod.DoStats
                    ,build_it
                   );
end;