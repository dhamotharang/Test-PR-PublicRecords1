IMPORT tris_lnssi_ingest,SALT36,PromoteSupers,std;

EXPORT proc_build_base(string filedate) := function

        MyDelta := DATASET([],tris_lnssi_ingest.Layout_basefile);
        ingestMod := tris_lnssi_ingest.Ingest(false,MyDelta);
        
        // take only type 4 and 6 (new and changed) This is a full replacement, so we are not interested in the "old"
        preMap := ingestMod.AllRecords(__tpe in[4,6]);
        
        // Apply mapping corrections
        tris_lnssi_ingest.Layout_basefile tMap(preMap L) := TRANSFORM

             SELF.Contrib_Risk_field := STD.Str.ToUpperCase(L.Contrib_Risk_field);
             SELF.Contrib_Risk_Value := STD.Str.ToUpperCase(L.Contrib_Risk_Value);
             SELF := L
        
        END;
        new_replace:=project(preMap,tMap(LEFT));
        
        PromoteSupers.Mac_SF_BuildProcess( new_replace
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