IMPORT header, ut, Std, MDR;

Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base_new;

EXPORT MA_Census_As_Header := FUNCTION

  dMA_CensusAsSource := header.Files_SeqdSrc().UM;

  dFiltered := dMA_CensusAsSource(lname <> '', LENGTH(TRIM(fname)) > 1, ~(REGEXFIND('[0-9]',fname)), ~(REGEXFIND('[0-9]',lname)), ~(REGEXFIND(', ',mname)));
										
  header.Layout_New_Records header_trans(dFiltered l, INTEGER c) := TRANSFORM
    SELF.did                      := 0;
    SELF.rid                      := 0;
    SELF.vendor_id                := TRIM(l.vendor_id);
    SELF.rec_type                 := '2'; 
    SELF.pflag1                   := '';
    SELF.pflag2                   := '';
    SELF.pflag3                   := '';
    SELF.src                      := MDR.Sourcetools.src_MA_Census;
    SELF.ssn                      := '';
    //check for bogus or underage dob
    dob                           := IF(l.dob > (ut.date_math((STRING8)Std.Date.Today(), -((18 * 365.00) + 2.00))), 0, (INTEGER)l.dob);
    SELF.dob                      := IF(dob IN [19000101,19010101], 0, dob);
    SELF.tnt                      := '';
    SELF.dt_first_seen            := (INTEGER)l.lastdatevote[1..6];
    SELF.dt_last_seen             := (INTEGER)l.lastdatevote[1..6];
    SELF.dt_vendor_last_reported  := (INTEGER)(l.date_last_seen[1..6]);
    SELF.dt_vendor_first_reported := (INTEGER)(l.date_first_seen[1..6]);
    SELF.dt_nonglb_last_seen      := 0;
    SELF.prim_range               := CHOOSE(c,l.prim_range, l.mail_prim_range);
    SELF.predir                   := CHOOSE(c,l.predir,     l.mail_predir);
    SELF.prim_name                := CHOOSE(c,l.prim_name,  l.mail_prim_name);
    SELF.suffix                   := CHOOSE(c,l.addr_suffix,l.mail_addr_suffix);
    SELF.postdir                  := CHOOSE(c,l.postdir,    l.mail_postdir);
    SELF.unit_desig               := CHOOSE(c,l.unit_desig, l.mail_unit_desig);
    SELF.sec_range                := CHOOSE(c,l.sec_range,  l.mail_sec_range);
    SELF.city_name                := CHOOSE(c,l.v_city_name,l.mail_v_city_name);
    SELF.st                       := CHOOSE(c,l.st,         l.mail_st);
    SELF.zip                      := CHOOSE(c,l.zip,        l.mail_zip);
    SELF.zip4                     := CHOOSE(c,l.zip4,       l.mail_zip4);
    SELF.county                   := CHOOSE(c,l.fips_county,l.mail_fips_county);
    SELF.cbsa                     := CHOOSE(c,l.msa + '0',  l.mail_msa + '0');
    SELF.geo_blk                  := CHOOSE(c,l.geo_blk,    l.mail_geo_blk);
    SELF                          := l;
  END;

  ma_census_projected := NORMALIZE(dFiltered,2,header_trans(LEFT, COUNTER));

  dFiltered2 := ma_census_projected(prim_name <> '' AND zip4 <> '');

  RETURN dFiltered2;
	
END;