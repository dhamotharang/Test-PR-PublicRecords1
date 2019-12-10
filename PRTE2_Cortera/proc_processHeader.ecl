IMPORT ut, std, Cortera;
EXPORT proc_processHeader(dataset(Cortera.Layout_Header) hdr, STRING8 version) := FUNCTION



    ds1 := PROJECT(hdr, TRANSFORM(Cortera.Layout_Header_Out,
                                   SELF.processdate := STD.Date.Today( );
                                   SELF.version := version;
                                   SELF.current := true;
                                   SELF.dt_first_seen := (unsigned4)left.LOC_DATE_LAST_SEEN;
                                   SELF.dt_last_seen := (unsigned4)left.LOC_DATE_LAST_SEEN;
                                   SELF.dt_vendor_first_reported := (unsigned4)version;
                                   SELF.dt_vendor_last_reported := (unsigned4)version;
                                   SELF.persistent_record_id := (left.link_id << 32) + SELF.dt_vendor_first_reported;
                                   SELF.clean_phone := ut.CleanPhone(left.PHONE);
                                   SELF.clean_fax := ut.CleanPhone(left.FAX);
                                   SELF := left;
                                   SELF := [];
                                 )
                  );

    ds := Cortera.FixFirstSeen(ds1);

    us := ds(country='US');

    clean := Cortera.proc_cleanAddresses(us);

    linked := Cortera.proc_linkBiz(clean);

    restored := linked + ds(country<>'US');    // get all records

    dated := Cortera.proc_merge_hdr(restored, PRTE2_Cortera.Files.Hdr_Out, version);  // set dt_first_seen

    RETURN dated;
END;





