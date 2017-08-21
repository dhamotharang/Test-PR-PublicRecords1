EXPORT fn_remove_post_header_joined(dataset(recordof(header.layout_header)) in_hdr):= FUNCTION

        // Blank-out bad UT mnames (DF-16517)
        bad_mname_ut_filename:= '~thor::insuranceheader::boca_header::bogus_utility_mname_recs_refined';
        bad_mname_ut_file := dataset(bad_mname_ut_filename,header.layout_header,thor);
        
        out_hdr := join(distribute(in_hdr           ,hash32(rid)),
                        distribute(bad_mname_ut_file,hash32(rid)),
                        LEFT.rid = RIGHT.rid,
                        TRANSFORM({in_hdr},
                                  SELF.mname  := if(LEFT.rid = RIGHT.rid,'',LEFT.mname),
                                  SELF        := LEFT
                        ),
                        LOCAL,LEFT OUTER
        );
        
        
        return out_hdr;
END;