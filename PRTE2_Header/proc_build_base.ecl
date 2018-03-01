IMPORT PromoteSupers,ut,PRTE,header,std;

        EXPORT proc_build_base(string filedate) := function
        
        old_file := project(PRTE2_Header.files.file_old_ptre_header_in,{recordof(left)-uid});
        oNMNHR   := project(prte2_header.new_header_records(did<>0)   ,{recordof(left)-uid});
        
        ut.MAC_Sequence_Records(oNMNHR,rid,outfile1); // assign rids every time
        new_file := dedup(sort(outfile1,record),record);

        lTODAY := ((string)Std.Date.Today())[1..6];
        
        {new_file} set_last_date(new_file L):=transform
        
            SELF.dt_last_seen := if (L.dt_last_seen=0,((unsigned3)lTODAY),L.dt_last_seen);
            SELF.dt_vendor_last_reported := if (L.dt_vendor_last_reported=0,((unsigned3)lTODAY),L.dt_vendor_last_reported);
            SELF:=L;
        
        end;
        
        new_base := project(old_file+new_file,set_last_date(LEFT));

        PromoteSupers.Mac_SF_BuildProcess(new_base,'~prte::base::header',build_base,2,,true,pVersion:=filedate);

        return build_base;
END;


