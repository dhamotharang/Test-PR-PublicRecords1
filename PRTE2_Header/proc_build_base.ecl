IMPORT PromoteSupers,ut,PRTE,header;

        EXPORT proc_build_base(string filedate) := function
        
        old_file := project(PRTE2_Header.files.file_old_ptre_header_in,{recordof(left)-uid});
        oNMNHR   := project(prte2_header.new_header_records(did<>0)   ,{recordof(left)-uid});
        
        ut.MAC_Sequence_Records(oNMNHR,rid,outfile1); // assign rids every time
        new_file := dedup(sort(outfile1,record),record);
        

        PromoteSupers.Mac_SF_BuildProcess(old_file+new_file,'~prte::base::header',build_base,2,,true,pVersion:=filedate);

        return build_base;
END;


