IMPORT header,doxie,Infutor,doxie_build,Relationship,NID,PRTE,PRTE_CSV,ut,infutor,watchdog,data_services
;
        
        
EXPORT files := MODULE


EXPORT personrecs := // 10.121.145.93 /data/prct/infiles/dev_16/PRCT_PersonRecs__20170314
dataset(data_services.Data_location.prefix('PRTE')+PRTE2_Header.constants.filename_prct_personrecs
        ,prte2_header.layout_prte_manual_raw.main
        ,CSV(HEADING(1), SEPARATOR([',','\t']), TERMINATOR(['\n','\r\n','\n\r'])   ))(link_dob<>'link_dob');

// EXPORT file_headers_base         := prte2_header.file_header_base;
EXPORT file_header_building      := prte2_header.file_header_base;
EXPORT file_headers              := dedup(sort(PRTE2_Header.file_header_base,did,rid),did,rid);
EXPORT file_old_ptre_header_in   := project(dedup(PRTE.Get_payload.header,record,all),Header.Layout_New_Records);


// output(PRTE.Get_Header_Base.payload,,'~prte::base::header::payload',compressed);
EXPORT file_headers2             := PRTE.Get_Header_Base.payload;
// EXPORT file_headers2             := dataset('~prte::base::header::payload',prte_csv.ge_header_base.layout_payload,flat);;
EXPORT File_FCRA_header_building := PRTE2_Header.file_header_base;

EXPORT File_HHID         := dedup(sort(distribute(project(file_headers,transform({header.File_HHID},
                            SELF.hhid:=LEFT.did,
                            SELF.hhid_relat:=LEFT.did,
                            SELF.addr_id:=x'',
                            SELF:=LEFT,
                            SELF:=[],)),hash32(lname,did)),lname,did,local),lname,did,local);

END;