IMPORT dx_Header,PromoteSupers;
EXPORT Explicit_record_removal := MODULE

    SHARED filename:='~thor_data400::base::header::explicit_records_removed';

    EXPORT code_removal_reason:=ENUM(

        cleaned_as_person_now_as_business=1

    );

    SHARED remover_layout:=RECORD
        dx_Header.layout_header;
        code_removal_reason reason_code;
        unsigned4 removal_date;
    END;
    
    // we will match on: did, rid and src
    EXPORT file_rec_remover:=DATASET(filename,remover_layout,thor,opt);

    EXPORT Add_records(DATASET(dx_header.layout_header) inHdr, code_removal_reason reason_code, unsigned4 removal_date) := FUNCTION

            new_file:=file_rec_remover + PROJECT(inHdr,TRANSFORM(remover_layout,
                                                                SELF.reason_code:=reason_code;
                                                                SELF.removal_date:=removal_date;
                                                                SELF:=LEFT));

            PromoteSupers.Mac_SF_BuildProcess(dedup(new_file,record,all),filename,updateFile,,,TRUE);
            RETURN updateFile;

    END;
END;