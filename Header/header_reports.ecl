EXPORT Header_reports:=MODULE

    IMPORT header,NID,dx_header,address;
    #OPTION('multiplePersistInstances',FALSE);

    hdr1:=header.File_header_raw_latest.file;
    address.Mac_Is_Business_Parsed(hdr1,isBusiness);
    SHARED b_hdr1:=isBusiness(nametype='B'):persist('thor_data400::temp::header::ingest::business_names',EXPIRE(7),REFRESH(FALSE));
    SHARED top_multi_rec_businesses:=choosen(sort(table(b_hdr1,{did,cnt:=count(group)},did,merge),-cnt),100);

    EXPORT now_is_businessCandidates:= b_hdr1(did in SET(top_multi_rec_businesses[1..5], did));
    EXPORT now_is_businessReport := FUNCTION
        
        
        RETURN SEQUENTIAL( 

            OUTPUT(count(b_hdr1),named('now_know_as_business_count'));
            OUTPUT(count(DEDUP(b_hdr1,did,all)),named('now_know_as_business_did_count'));
            OUTPUT(SORT(TABLE(b_hdr1,{src,cnt:=count(group)},src,few,merge),-cnt),named('now_know_as_business_src_count'));
            OUTPUT(top_multi_rec_businesses,NAMED('now_known_as_business_top_rec_counts'));
            OUTPUT(b_hdr1(did=top_multi_rec_businesses[1].did), NAMED('remove_candidate1'));
            OUTPUT(b_hdr1(did=top_multi_rec_businesses[2].did), NAMED('remove_candidate2'));
            OUTPUT(b_hdr1(did=top_multi_rec_businesses[3].did), NAMED('remove_candidate3'));
            OUTPUT(b_hdr1(did=top_multi_rec_businesses[4].did), NAMED('remove_candidate4'));
            OUTPUT(b_hdr1(did=top_multi_rec_businesses[5].did), NAMED('remove_candidate5'));

        );
    END;

    EXPORT MAIN := SEQUENTIAL(

        now_is_businessReport;
        output(now_is_businessCandidates);
    
    );
END;
