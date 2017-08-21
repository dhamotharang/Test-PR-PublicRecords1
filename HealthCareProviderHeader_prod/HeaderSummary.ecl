IMPORT Health_Provider_full_v3;

EXPORT HeaderSummary(string iterationId = 'it_curr_rpt') := MODULE
    EXPORT myLayout := Layouts.HealthCareProvider_Header;

    EXPORT STRING myFilePrefix       := '~bbounds::health_provider_full_v3::';
    EXPORT STRING input_file         := '~bbounds::health_provider_full_v3::' + iterationId;
    
    EXPORT STRING output_file        := myFilePrefix + iterationId + '_final_hdr_info';
    EXPORT STRING output_file_idx    := myFilePrefix + iterationId + '_final_hdr_info_idx';
    EXPORT STRING output_file_vidx   := myFilePrefix + iterationId + '_final_hdr_info_vidx';

    EXPORT STRING index_hdrfile_data := myFilePrefix + iterationId + '_hdr_index_data';
    EXPORT STRING index_hdrfile_idx  := myFilePrefix + iterationId + '_hdr_index_idx';
    
    EXPORT STRING idx_csz_file := myFilePrefix + iterationId + '_idx_city_state_zip';

    currentHdrRs1 := DATASET(
      input_file,
      {
          myLayout;
      },
      THOR);
    currentHdrRs2 := DISTRIBUTE(currentHdrRs1, HASH32(hcid));
    currentHdrRs3 := currentHdrRs2(true);
    EXPORT currentHdrRs  := currentHdrRs3;

    //
    // SRC Info
    //
    EXPORT srcInfo_layout := RECORD
        currentHdrRs.src;
        currentHdrRs.vendor_id;
        unsigned cnt := 0;
    END;

    srcInfoRs1 := currentHdrRs;
    srcInfoRs2 := TABLE(srcInfoRs1,
      {
          hcid,
          src,
          vendor_id,
          unsigned cnt := COUNT(GROUP)
      }, hcid, src, vendor_id);
    srcInfoRs3 := DISTRIBUTE(srcInfoRs2, HASH32(hcid));
    srcInfoRs4 := SORT(srcInfoRs3, hcid, -cnt, src, vendor_id, LOCAL);
    
    EXPORT srcInfoRs  := srcInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT srcInfoRs_out := OUTPUT(srcInfoRs, NAMED('srcInfoRs'));


    //
    // SRCTYPE Info
    //
    EXPORT srctypeInfo_layout := RECORD
        currentHdrRs.src;
        unsigned cnt := 0;
    END;

    srctypeInfoRs1 := srcInfoRs;
    srctypeInfoRs2 := TABLE(srctypeInfoRs1,
      {
          hcid,
          src,
          unsigned cnt := COUNT(GROUP)
      }, hcid, src);
    srctypeInfoRs3 := DISTRIBUTE(srctypeInfoRs2, HASH32(hcid));
    srctypeInfoRs4 := SORT(srctypeInfoRs3, hcid, -cnt, src, LOCAL);
    EXPORT srctypeInfoRs  := srctypeInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT srctypeInfoRs_out := OUTPUT(srctypeInfoRs, NAMED('srctypeInfoRs'));


    //
    // NAME Info
    //
    EXPORT nameInfo_layout := RECORD
        currentHdrRs.title;
        currentHdrRs.fname;
        currentHdrRs.mname;
        currentHdrRs.lname;
        currentHdrRs.sname;
        currentHdrRs.cname;
        unsigned cnt := 0;
    END;

    nameInfoRs1 := currentHdrRs;
    nameInfoRs2 := TABLE(nameInfoRs1,
      {
          hcid,
          title,
          fname,
          mname,
          lname,
          sname,
          cname,
          unsigned cnt := COUNT(GROUP)
      }, hcid, title, fname, mname, lname, sname, cname);
    nameInfoRs3 := DISTRIBUTE(nameInfoRs2, HASH32(hcid));
    nameInfoRs4 := SORT(nameInfoRs3, hcid, -cnt, title, fname, mname, lname, sname, cname, LOCAL);
    EXPORT nameInfoRs  := nameInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT nameInfoRs_out := OUTPUT(nameInfoRs, NAMED('nameInfoRs'));

    //
    // ADDR Info
    //
    EXPORT addrInfo_layout := RECORD
        currentHdrRs.prim_range;
        currentHdrRs.predir;
        currentHdrRs.prim_name;
        currentHdrRs.addr_suffix;
        currentHdrRs.postdir;
        currentHdrRs.unit_desig;
        currentHdrRs.sec_range;
        currentHdrRs.p_city_name;
        currentHdrRs.v_city_name;
        currentHdrRs.st;
        currentHdrRs.zip;
        currentHdrRs.zip4;
        currentHdrRs.geo_lat;
        currentHdrRs.geo_long;
        currentHdrRs.err_stat;
        unsigned cnt := 0;
    END;
    
    addrInfoRs1 := currentHdrRs;
    addrInfoRs2 := TABLE(addrInfoRs1,
      {
          hcid,
          prim_range,  predir,     prim_name,    addr_suffix,  postdir,
          unit_desig,  sec_range,  p_city_name,  v_city_name,  st,
          zip,         zip4,       geo_lat,      geo_long,     err_stat,
          unsigned cnt := COUNT(GROUP)
      },
      hcid,
      prim_range,  predir,     prim_name,    addr_suffix,  postdir,
      unit_desig,  sec_range,  p_city_name,  v_city_name,  st,
      zip,         zip4,       geo_lat,      geo_long,     err_stat);
    addrInfoRs3 := DISTRIBUTE(addrInfoRs2, HASH32(hcid));
    addrInfoRs4 := SORT(addrInfoRs3,
      hcid, -cnt,
      prim_range,  predir,     prim_name,    addr_suffix,  postdir,
      unit_desig,  sec_range,  p_city_name,  v_city_name,  st,
      zip,         zip4,       geo_lat,      geo_long,     err_stat,
      LOCAL);
    EXPORT addrInfoRs  := addrInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT addrInfoRs_out := OUTPUT(addrInfoRs, NAMED('addrInfoRs'));

    //
    // DEA Info
    //
    EXPORT deaInfo_layout := RECORD
        currentHdrRs.dea_number;
        unsigned cnt := 0;
    END;
    deaInfoRs1 := currentHdrRs(dea_number != '');
    deaInfoRs2 := TABLE(deaInfoRs1,
      {
          hcid,
          dea_number,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, dea_number);
    deaInfoRs3 := DISTRIBUTE(deaInfoRs2, HASH32(hcid));
    deaInfoRs4 := SORT(deaInfoRs3,
      hcid, -cnt, dea_number,
      LOCAL);
    EXPORT deaInfoRs  := deaInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT deaInfoRs_out := OUTPUT(deaInfoRs, NAMED('deaInfoRs'));


    //
    // NPI Info
    //
    EXPORT npiInfo_layout := RECORD
        currentHdrRs.npi_number;
        unsigned cnt := 0;
    END;
    npiInfoRs1 := currentHdrRs(npi_number != '');
    npiInfoRs2 := TABLE(npiInfoRs1,
      {
          hcid,
          npi_number,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, npi_number);
    npiInfoRs3 := DISTRIBUTE(npiInfoRs2, HASH32(hcid));
    npiInfoRs4 := SORT(npiInfoRs3,
      hcid, -cnt, npi_number,
      LOCAL);
    EXPORT npiInfoRs  := npiInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT npiInfoRs_out := OUTPUT(npiInfoRs, NAMED('npiInfoRs'));


    //
    // LIC Info
    //
    EXPORT licInfo_layout := RECORD
        currentHdrRs.lic_state;
        currentHdrRs.lic_nbr;
        unsigned cnt := 0;
    END;
    licInfoRs1 := currentHdrRs(lic_nbr != '');
    licInfoRs2 := TABLE(licInfoRs1,
      {
          hcid,
          lic_state,
          lic_nbr,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, lic_state, lic_nbr);
    licInfoRs3 := DISTRIBUTE(licInfoRs2, HASH32(hcid));
    licInfoRs4 := SORT(licInfoRs3,
      hcid, -cnt, lic_state, lic_nbr,
      LOCAL);
    EXPORT licInfoRs  := licInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT licInfoRs_out := OUTPUT(licInfoRs, NAMED('licInfoRs'));


    //
    // UPIN Info
    //
    EXPORT upinInfo_layout := RECORD
        currentHdrRs.upin;
        unsigned cnt := 0;
    END;
    upinInfoRs1 := currentHdrRs(upin != '');
    upinInfoRs2 := TABLE(upinInfoRs1,
      {
          hcid,
          upin,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, upin);
    upinInfoRs3 := DISTRIBUTE(upinInfoRs2, HASH32(hcid));
    upinInfoRs4 := SORT(upinInfoRs3,
      hcid, -cnt, upin,
      LOCAL);
    EXPORT upinInfoRs  := upinInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT upinInfoRs_out := OUTPUT(upinInfoRs, NAMED('upinInfoRs'));


    //
    // TAXID Info
    //
    EXPORT taxidInfo_layout := RECORD
        currentHdrRs.tax_id;
        unsigned cnt := 0;
    END;
    taxidInfoRs1 := currentHdrRs(tax_id != 0);
    taxidInfoRs2 := TABLE(taxidInfoRs1,
      {
          hcid,
          tax_id,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, tax_id);
    taxidInfoRs3 := DISTRIBUTE(taxidInfoRs2, HASH32(hcid));
    taxidInfoRs4 := SORT(taxidInfoRs3,
      hcid, -cnt, tax_id,
      LOCAL);
    EXPORT taxidInfoRs  := taxidInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT taxidInfoRs_out := OUTPUT(taxidInfoRs, NAMED('taxidInfoRs'));


    //
    // DOB Info
    //
    EXPORT dobInfo_layout := RECORD
        currentHdrRs.dob;
        unsigned cnt := 0;
    END;
    dobInfoRs1 := currentHdrRs(dob != 0);
    dobInfoRs2 := TABLE(dobInfoRs1,
      {
          hcid,
          dob,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, dob);
    dobInfoRs3 := DISTRIBUTE(dobInfoRs2, HASH32(hcid));
    dobInfoRs4 := SORT(dobInfoRs3,
      hcid, -cnt, dob,
      LOCAL);
    EXPORT dobInfoRs  := dobInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT dobInfoRs_out := OUTPUT(dobInfoRs, NAMED('dobInfoRs'));


    //
    // gender Info
    //
    EXPORT genderInfo_layout := RECORD
        currentHdrRs.gender;
        unsigned cnt := 0;
    END;
    genderInfoRs1 := currentHdrRs(gender != '');
    genderInfoRs2 := TABLE(genderInfoRs1,
      {
          hcid,
          gender,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, gender);
    genderInfoRs3 := DISTRIBUTE(genderInfoRs2, HASH32(hcid));
    genderInfoRs4 := SORT(genderInfoRs3,
      hcid, -cnt, gender,
      LOCAL);
    EXPORT genderInfoRs  := genderInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT genderInfoRs_out := OUTPUT(genderInfoRs, NAMED('genderInfoRs'));


    //
    // derived_gender Info
    //
    EXPORT dgenderInfo_layout := RECORD
        currentHdrRs.derived_gender;
        unsigned cnt := 0;
    END;
    dgenderInfoRs1 := currentHdrRs(derived_gender != '');
    dgenderInfoRs2 := TABLE(dgenderInfoRs1,
      {
          hcid,
          derived_gender,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, derived_gender);
    dgenderInfoRs3 := DISTRIBUTE(dgenderInfoRs2, HASH32(hcid));
    dgenderInfoRs4 := SORT(dgenderInfoRs3,
      hcid, -cnt, derived_gender,
      LOCAL);
    EXPORT dgenderInfoRs  := dgenderInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT dgenderInfoRs_out := OUTPUT(dgenderInfoRs, NAMED('dgenderInfoRs'));


    //
    // DID Info
    //
    EXPORT didInfo_layout := RECORD
        currentHdrRs.did;
        unsigned cnt := 0;
    END;
    didInfoRs1 := currentHdrRs(did != 0);
    didInfoRs2 := TABLE(didInfoRs1,
      {
          hcid,
          did,
          unsigned cnt := COUNT(GROUP)
      },
      hcid, did);
    didInfoRs3 := DISTRIBUTE(didInfoRs2, HASH32(hcid));
    didInfoRs4 := SORT(didInfoRs3,
      hcid, -cnt, did,
      LOCAL);
    EXPORT didInfoRs  := didInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
    EXPORT didInfoRs_out := OUTPUT(didInfoRs, NAMED('didInfoRs'));


    //
    // Paste if all of the above datasets together into the following structure.
    // One row per HCID.
    //
    SHARED SRCINFO_MAX     := 10;
    SHARED NAMEINFO_MAX    := 30;
    SHARED ADDRINFO_MAX    := 75;
    SHARED DEAINFO_MAX     := 10;
    SHARED NPIINFO_MAX     := 10;
    SHARED LICINFO_MAX     := 20;
    SHARED UPININFO_MAX    := 10;
    SHARED TAXIDINFO_MAX   := 15;
    SHARED SRCTYPEINFO_MAX := 10;
    SHARED DOBINFO_MAX     := 20;
    SHARED GENDERINFO_MAX  := 5;
    SHARED DGENDERINFO_MAX := 5;
    SHARED DIDINFO_MAX     := 5;

    EXPORT finalHdrInfo_layout := RECORD
        currentHdrRs.hcid;
        unsigned hdr_cnt := 0;
    
        unsigned srctype_cnt := 0;
        DATASET(srctypeInfo_layout) srctype_info{MAXCOUNT(SRCTYPEINFO_MAX)};
    
        unsigned src_cnt := 0;
        DATASET(srcInfo_layout) src_info{MAXCOUNT(SRCINFO_MAX)};
    
        unsigned npi_cnt := 0;
        DATASET(npiInfo_layout) npi_info{MAXCOUNT(NPIINFO_MAX)};
    
        unsigned dea_cnt := 0;
        DATASET(deaInfo_layout) dea_info{MAXCOUNT(DEAINFO_MAX)};
    
        unsigned lic_cnt := 0;
        DATASET(licInfo_layout) lic_info{MAXCOUNT(LICINFO_MAX)};
    
        unsigned did_cnt := 0;
        DATASET(didInfo_layout) did_info{MAXCOUNT(DIDINFO_MAX)};
    
        unsigned upin_cnt := 0;
        DATASET(upinInfo_layout) upin_info{MAXCOUNT(UPININFO_MAX)};
    
        unsigned taxid_cnt := 0;
        DATASET(taxidInfo_layout) taxid_info{MAXCOUNT(TAXIDINFO_MAX)};
    
        unsigned dob_cnt := 0;
        DATASET(dobInfo_layout) dob_info{MAXCOUNT(DOBINFO_MAX)};
    
        unsigned gender_cnt := 0;
        DATASET(genderInfo_layout) gender_info{MAXCOUNT(GENDERINFO_MAX)};
    
        unsigned dgender_cnt := 0;
        DATASET(dgenderInfo_layout) dgender_info{MAXCOUNT(DGENDERINFO_MAX)};
    
        unsigned name_cnt := 0;
        DATASET(nameInfo_layout) name_info{MAXCOUNT(NAMEINFO_MAX)};
    
        unsigned addr_cnt := 0;
        DATASET(addrInfo_layout) addr_info{MAXCOUNT(ADDRINFO_MAX)};
    END;

    //
    // Create the initial lhs dataset for DENORMALIZE
    //
    finalHdrInfoRs1 := TABLE(currentHdrRs,
      {
          hcid,
          unsigned hdr_cnt := COUNT(GROUP)
      }, hcid);
    finalHdrInfoRs2 := PROJECT(finalHdrInfoRs1,
      TRANSFORM(finalHdrInfo_layout,
        SELF := LEFT,
        SELF := []));
    finalHdrInfoRs3 := DISTRIBUTE(finalHdrInfoRs2, HASH32(hcid));


    finalHdrInfoRs4 := DENORMALIZE(finalHdrInfoRs3, srcInfoRs,    // SRC Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.src_cnt := COUNTER,
          SELF.src_info := IF(
            COUNTER > SRCINFO_MAX,
            LEFT.src_info,
            LEFT.src_info + DATASET([{RIGHT.src, RIGHT.vendor_id, RIGHT.cnt}], RECORDOF(LEFT.src_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs5 := DENORMALIZE(finalHdrInfoRs4, nameInfoRs,    // NAME Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.name_cnt := COUNTER,
          SELF.name_info := IF(
            COUNTER > NAMEINFO_MAX,
            LEFT.name_info,
            LEFT.name_info + DATASET([{RIGHT.title, RIGHT.fname, RIGHT.mname, RIGHT.lname, RIGHT.sname, RIGHT.cname, RIGHT.cnt}], RECORDOF(LEFT.name_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs6 := DENORMALIZE(finalHdrInfoRs5, addrInfoRs,    // ADDR Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.addr_cnt := COUNTER,
          SELF.addr_info := IF(
            COUNTER > ADDRINFO_MAX,
            LEFT.addr_info,
            LEFT.addr_info + DATASET(
              [{
                RIGHT.prim_range, RIGHT.predir,     RIGHT.prim_name, RIGHT.addr_suffix,
                RIGHT.postdir,    RIGHT.unit_desig, RIGHT.sec_range, RIGHT.p_city_name, RIGHT.v_city_name,
                RIGHT.st,         RIGHT.zip,        RIGHT.zip4,      RIGHT.geo_lat,     RIGHT.geo_long,
                RIGHT.err_stat,
                RIGHT.cnt}], RECORDOF(LEFT.addr_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs7 := DENORMALIZE(finalHdrInfoRs6, deaInfoRs,    // DEA Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.dea_cnt := COUNTER,
          SELF.dea_info := IF(
            COUNTER > DEAINFO_MAX,
            LEFT.dea_info,
            LEFT.dea_info + DATASET(
              [{RIGHT.dea_number, RIGHT.cnt}], RECORDOF(LEFT.dea_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs8 := DENORMALIZE(finalHdrInfoRs7, npiInfoRs,    // NPI Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.npi_cnt := COUNTER,
          SELF.npi_info := IF(
            COUNTER > NPIINFO_MAX,
            LEFT.npi_info,
            LEFT.npi_info + DATASET(
              [{RIGHT.npi_number, RIGHT.cnt}], RECORDOF(LEFT.npi_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs9 := DENORMALIZE(finalHdrInfoRs8, licInfoRs,    // LIC Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.lic_cnt := COUNTER,
          SELF.lic_info := IF(
            COUNTER > LICINFO_MAX,
            LEFT.lic_info,
            LEFT.lic_info + DATASET(
              [{RIGHT.lic_state, RIGHT.lic_nbr, RIGHT.cnt}], RECORDOF(LEFT.lic_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs10 := DENORMALIZE(finalHdrInfoRs9, upinInfoRs,    // UPIN Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.upin_cnt := COUNTER,
          SELF.upin_info := IF(
            COUNTER > UPININFO_MAX,
            LEFT.upin_info,
            LEFT.upin_info + DATASET(
              [{RIGHT.upin, RIGHT.cnt}], RECORDOF(LEFT.upin_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs11 := DENORMALIZE(finalHdrInfoRs10, taxidInfoRs,    // TAXID Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.taxid_cnt := COUNTER,
          SELF.taxid_info := IF(
            COUNTER > TAXIDINFO_MAX,
            LEFT.taxid_info,
            LEFT.taxid_info + DATASET(
              [{RIGHT.tax_id, RIGHT.cnt}], RECORDOF(LEFT.taxid_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs12 := DENORMALIZE(finalHdrInfoRs11, srctypeInfoRs,    // SRCTYPE Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.srctype_cnt := COUNTER,
          SELF.srctype_info := IF(
            COUNTER > SRCTYPEINFO_MAX,
            LEFT.srctype_info,
            LEFT.srctype_info + DATASET(
              [{RIGHT.src, RIGHT.cnt}], RECORDOF(LEFT.srctype_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs13 := DENORMALIZE(finalHdrInfoRs12, dobInfoRs,    // DOB Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.dob_cnt := COUNTER,
          SELF.dob_info := IF(
            COUNTER > DOBINFO_MAX,
            LEFT.dob_info,
            LEFT.dob_info + DATASET(
              [{RIGHT.dob, RIGHT.cnt}], RECORDOF(LEFT.dob_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs14 := DENORMALIZE(finalHdrInfoRs13, genderInfoRs,    // Gender Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.gender_cnt := COUNTER,
          SELF.gender_info := IF(
            COUNTER > GENDERINFO_MAX,
            LEFT.gender_info,
            LEFT.gender_info + DATASET(
          [{RIGHT.gender, RIGHT.cnt}], RECORDOF(LEFT.gender_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs15 := DENORMALIZE(finalHdrInfoRs14, dgenderInfoRs,    // Dgender Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.dgender_cnt := COUNTER,
          SELF.dgender_info := IF(
            COUNTER > DGENDERINFO_MAX,
            LEFT.dgender_info,
            LEFT.dgender_info + DATASET(
          [{RIGHT.derived_gender, RIGHT.cnt}], RECORDOF(LEFT.dgender_info))),
          SELF := LEFT),
        LOCAL);
    finalHdrInfoRs16 := DENORMALIZE(finalHdrInfoRs15, didInfoRs,    // DID Info
        LEFT.hcid = RIGHT.hcid,
        TRANSFORM(RECORDOF(LEFT),
          SELF.did_cnt := COUNTER,
          SELF.did_info := IF(
            COUNTER > DIDINFO_MAX,
            LEFT.did_info,
            LEFT.did_info + DATASET(
          [{RIGHT.did, RIGHT.cnt}], RECORDOF(LEFT.did_info))),
          SELF := LEFT),
        LOCAL);

    EXPORT finalHdrInfoRs  := finalHdrInfoRs16;

    EXPORT finalHdrInfoRs_out := OUTPUT(finalHdrInfoRs, NAMED('finalHdrInfoRs'));
    EXPORT finalHdrInfoRs_count := OUTPUT(COUNT(finalHdrInfoRs), NAMED('finalHdrInfoCount'));

    EXPORT allData_out := PARALLEL(finalHdrInfoRs_out, finalHdrInfoRs_count);
    
    //
    // Display distributions for the various components of the above.
    //
    hdrCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          hdr_cnt;
          unsigned cnt := COUNT(GROUP);
      }, hdr_cnt,
      LOCAL);
    hdrCntDistRs1a := TABLE(hdrCntDistRs1,
      {
          hdr_cnt;
          unsigned cnt := SUM(GROUP, cnt);
      }, hdr_cnt);
    hdrCntDistRs2 := SORT(hdrCntDistRs1a, hdr_cnt);
    hdrCntDistRs  := hdrCntDistRs2;
    OUTPUT(hdrCntDistRs, NAMED('hdrCntDistRs'));

    srctypeCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          srctype_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, srctype_cnt,
      LOCAL);
    srctypeCntDistRs1a := TABLE(srctypeCntDistRs1,
      {
          srctype_cnt;
          unsigned cnt := SUM(GROUP, cnt);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, srctype_cnt);
    srctypeCntDistRs2 := SORT(srctypeCntDistRs1a, srctype_cnt);
    srctypeCntDistRs  := srctypeCntDistRs2;
    OUTPUT(srctypeCntDistRs, NAMED('srctypeCntDistRs'));

    srcCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          src_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, src_cnt);
    srcCntDistRs2 := SORT(srcCntDistRs1, src_cnt);
    srcCntDistRs  := srcCntDistRs2;
    OUTPUT(srcCntDistRs, NAMED('srcCntDistRs'));


    npiCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          npi_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, npi_cnt);
    npiCntDistRs2 := SORT(npiCntDistRs1, npi_cnt);
    npiCntDistRs  := npiCntDistRs2;
    OUTPUT(npiCntDistRs, NAMED('npiCntDistRs'));


    deaCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          dea_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, dea_cnt);
    deaCntDistRs2 := SORT(deaCntDistRs1, dea_cnt);
    deaCntDistRs  := deaCntDistRs2;
    OUTPUT(deaCntDistRs, NAMED('deaCntDistRs'));


    licCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          lic_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, lic_cnt);
    licCntDistRs2 := SORT(licCntDistRs1, lic_cnt);
    licCntDistRs  := licCntDistRs2;
    OUTPUT(licCntDistRs, NAMED('licCntDistRs'));


    didCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          did_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, did_cnt);
    didCntDistRs2 := SORT(didCntDistRs1, did_cnt);
    didCntDistRs  := didCntDistRs2;
    OUTPUT(didCntDistRs, NAMED('didCntDistRs'));


    upinCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          upin_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, upin_cnt);
    upinCntDistRs2 := SORT(upinCntDistRs1, upin_cnt);
    upinCntDistRs  := upinCntDistRs2;
    OUTPUT(upinCntDistRs, NAMED('upinCntDistRs'));


    taxidCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          taxid_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, taxid_cnt);
    taxidCntDistRs2 := SORT(taxidCntDistRs1, taxid_cnt);
    taxidCntDistRs  := taxidCntDistRs2;
    OUTPUT(taxidCntDistRs, NAMED('taxidCntDistRs'));


    dobCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          dob_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, dob_cnt);
    dobCntDistRs2 := SORT(dobCntDistRs1, dob_cnt);
    dobCntDistRs  := dobCntDistRs2;
    OUTPUT(dobCntDistRs, NAMED('dobCntDistRs'));


    genderCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          gender_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, gender_cnt);
    genderCntDistRs2 := SORT(genderCntDistRs1, gender_cnt);
    genderCntDistRs  := genderCntDistRs2;
    OUTPUT(genderCntDistRs, NAMED('genderCntDistRs'));


    dgenderCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          dgender_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, dgender_cnt);
    dgenderCntDistRs2 := SORT(dgenderCntDistRs1, dgender_cnt);
    dgenderCntDistRs  := dgenderCntDistRs2;
    OUTPUT(dgenderCntDistRs, NAMED('dgenderCntDistRs'));


    nameCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          name_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, name_cnt);
    nameCntDistRs2 := SORT(nameCntDistRs1, name_cnt);
    nameCntDistRs  := nameCntDistRs2;
    OUTPUT(nameCntDistRs, NAMED('nameCntDistRs'));


    addrCntDistRs1 := TABLE(finalHdrInfoRs,
      {
          addr_cnt;
          unsigned cnt := COUNT(GROUP);
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
      }, addr_cnt);
    addrCntDistRs2 := SORT(addrCntDistRs1, addr_cnt);
    addrCntDistRs  := addrCntDistRs2;
    OUTPUT(addrCntDistRs, NAMED('addrCntDistRs'));


    //
    // Spot Check Records that have more than the usual numbers of the various ID values.
    //
    spotChkByNpiDeaLicTaxRs1 := finalHdrInfoRs;
    spotChkByNpiDeaLicTaxRs2 := spotChkByNpiDeaLicTaxRs1(npi_cnt >= 2, dea_cnt >= 2, lic_cnt >= 5, taxid_cnt >= 5);
    spotChkByNpiDeaLicTaxRs3 := ENTH(spotChkByNpiDeaLicTaxRs2, 100);
    spotChkByNpiDeaLicTaxRs  := spotChkByNpiDeaLicTaxRs3;
    EXPORT spotChkByNpiDeaLicTaxRs_out := OUTPUT(spotChkByNpiDeaLicTaxRs, NAMED('spotChkByNpiDeaLicTaxRs'));


    spotChkByNpiRs1 := finalHdrInfoRs;
    spotChkByNpiRs2 := spotChkByNpiRs1(npi_cnt >= 3);
    spotChkByNpiRs3 := ENTH(spotChkByNpiRs2, 100);
    spotChkByNpiRs  := spotChkByNpiRs3;
    EXPORT spotChkByNpiRs_out := OUTPUT(spotChkByNpiRs, NAMED('spotChkByNpiRs'));


    spotChkByDeaRs1 := finalHdrInfoRs;
    spotChkByDeaRs2 := spotChkByDeaRs1(dea_cnt >= 3);
    spotChkByDeaRs3 := ENTH(spotChkByDeaRs2, 100);
    spotChkByDeaRs  := spotChkByDeaRs3;
    EXPORT spotChkByDeaRs_out := OUTPUT(spotChkByDeaRs, NAMED('spotChkByDeaRs'));


    spotChkByLicRs1 := finalHdrInfoRs;
    spotChkByLicRs2 := spotChkByLicRs1(lic_cnt >= 10);
    spotChkByLicRs3 := ENTH(spotChkByLicRs2, 100);
    spotChkByLicRs  := spotChkByLicRs3;
    EXPORT spotChkByLicRs_out := OUTPUT(spotChkByLicRs, NAMED('spotChkByLicRs'));


    spotChkByDidRs1 := finalHdrInfoRs;
    spotChkByDidRs2 := spotChkByDidRs1(did_cnt >= 2);
    spotChkByDidRs3 := ENTH(spotChkByDidRs2, 100);
    spotChkByDidRs  := spotChkByDidRs3;
    EXPORT spotChkByDidRs_out := OUTPUT(spotChkByDidRs, NAMED('spotChkByDidRs'));


    spotChkByTaxidRs1 := finalHdrInfoRs;
    spotChkByTaxidRs2 := spotChkByTaxidRs1(taxid_cnt >= 8);
    spotChkByTaxidRs3 := ENTH(spotChkByTaxidRs2, 100);
    spotChkByTaxidRs  := spotChkByTaxidRs3;
    EXPORT spotChkByTaxidRs_out := OUTPUT(spotChkByTaxidRs, NAMED('spotChkByTaxidRs'));


    spotChkByDobRs1 := finalHdrInfoRs;
    spotChkByDobRs2 := spotChkByDobRs1(dob_cnt >= 3);
    spotChkByDobRs3 := ENTH(spotChkByDobRs2, 100);
    spotChkByDobRs  := spotChkByDobRs3;
    EXPORT spotChkByDobRs_out := OUTPUT(spotChkByDobRs, NAMED('spotChkByDobRs'));


    spotChkByGenderRs1 := finalHdrInfoRs;
    spotChkByGenderRs2 := spotChkByGenderRs1(gender_cnt >= 2);
    spotChkByGenderRs3 := ENTH(spotChkByGenderRs2, 100);
    spotChkByGenderRs  := spotChkByGenderRs3;
    EXPORT spotChkByGenderRs_out := OUTPUT(spotChkByGenderRs, NAMED('spotChkByGenderRs'));


    spotChkByDgenderRs1 := finalHdrInfoRs;
    spotChkByDgenderRs2 := spotChkByDgenderRs1(dgender_cnt >= 2);
    spotChkByDgenderRs3 := ENTH(spotChkByDgenderRs2, 100);
    spotChkByDgenderRs  := spotChkByDgenderRs3;
    EXPORT spotChkByDgenderRs_out := OUTPUT(spotChkByDgenderRs, NAMED('spotChkByDgenderRs'));

    EXPORT allSpotChk_out := PARALLEL(
        spotChkByNpiDeaLicTaxRs_out,
        spotChkByNpiRs_out,
        spotChkByDeaRs_out,
        spotChkByLicRs_out,
        spotChkByDidRs_out,
        spotChkByTaxidRs_out,
        spotChkByDobRs_out,
        spotChkByGenderRs_out,
        spotChkByDgenderRs_out);
        
    //
    // Build a data file and index for interactive access.
    //
    SHARED finalHdrInfo_out := OUTPUT(finalHdrInfoRs, ,output_file, THOR, OVERWRITE);

    EXPORT finalHdrInfoIdx1 := DATASET(output_file,
      {
          RECORDOF(finalHdrInfoRs),
          UNSIGNED8 fpos{virtual(fileposition)}
      }, THOR);
    finalHdrInfoIdx2 := INDEX(finalHdrInfoIdx1, {hcid}, {fpos}, output_file_idx);
    EXPORT finalHdrInfoIdx  := finalHdrInfoIdx2;

    finalHdrInfo_idx := BUILDINDEX(finalHdrInfoIdx, OVERWRITE);

    finalHdrInfoVidx1 := finalHdrInfoIdx1;
    finalHdrInfoVidx2 := NORMALIZE(finalHdrInfoVidx1, LEFT.src_info,
      TRANSFORM(
        {
            TYPEOF(LEFT.src_info.vendor_id) vendor_id,
            TYPEOF(LEFT.src_info.src)       src,
            TYPEOF(LEFT.fpos)               fpos,
            TYPEOF(LEFT.Hcid)               hcid
        },
        SELF.vendor_id := LEFT.src_info[COUNTER].vendor_id,
        SELF.src       := LEFT.src_info[COUNTER].src,
        SELF.fpos      := LEFT.fpos,
        SELF.hcid      := LEFT.hcid),
      LOCAL);
    finalHdrInfoVidx3 := INDEX(finalHdrInfoVidx2, {vendor_id}, {src, hcid}, output_file_vidx);
    finalHdrInfoVidx  := finalHdrInfoVidx3;

    finalHdrInfo_vidx := BUILDINDEX(finalHdrInfoVidx, OVERWRITE);    

    EXPORT finalHdrInfo_all := SEQUENTIAL(finalHdrInfo_out, finalHdrInfo_idx, finalHdrInfo_vidx);

    //finalHdrInfo_all;

    //
    // Build index for the Input File
    //
    indexHdrfileDataRs1 := currentHdrRs;
    EXPORT indexHdrfileDataRs  := indexHdrfileDataRs1;

    EXPORT indexHdrfileData_out := OUTPUT(indexHdrfileDataRs, ,
      index_hdrfile_data,
      OVERWRITE,
      THOR);
  
    indexHdrfileIdx1 := currentHdrRs;
    EXPORT indexHdrfileIdx2 := DATASET(index_hdrfile_data,
      {
          myLayout,
          UNSIGNED8 fpos{virtual(fileposition)}
      }, THOR);
    indexHdrfileIdx3 := INDEX(indexHdrfileIdx2, {hcid}, {fpos}, index_hdrfile_idx);
    EXPORT inputHdrfileIdx  := indexHdrfileIdx3;

    EXPORT inputHdrfileIdx_idx := BUILDINDEX(inputHdrfileIdx, OVERWRITE);

    EXPORT inputHdrfile_all := SEQUENTIAL(indexHdrfileData_out, inputHdrfileIdx_idx);
    
    //
    // Build idx_city_state_zip
    //
    idx_cszRs1 := addrInfoRs((v_city_name != '' or p_city_name != '') AND st != '' AND zip != '' AND err_stat[1] = 'S');
    idx_cszRs2 := NORMALIZE(idx_cszRs1, 2,
      TRANSFORM(
        {
            TYPEOF(LEFT.v_city_name) city;
            LEFT.st;
            LEFT.zip;
        },
        SELF.city := IF(COUNTER = 1,
                        IF(LEFT.v_city_name <> '', LEFT.v_city_name, SKIP),
                        IF(LEFT.p_city_name <> '', LEFT.p_city_name, SKIP));
        SELF.st   := LEFT.st;
        SELF.zip  := LEFT.zip),
      LOCAL);
    idx_cszRs3 := SORT(idx_cszRs2, city, st, zip, LOCAL);
    idx_cszRs4 := DEDUP(idx_cszRs3, city, st, zip, LOCAL);
    idx_cszRs5 := SORT(idx_cszRs4, city, st, zip);
    idx_cszRs6 := DEDUP(idx_cszRs5, city, st, zip);
    EXPORT idx_cszRs  := idx_cszRs6;
    
    EXPORT idx_csz := INDEX(idx_cszRs, {city, st}, {zip}, idx_csz_file);
    EXPORT idx_csz_build := BUILDINDEX(idx_csz, OVERWRITE);

    EXPORT all := PARALLEL(
      allData_out,
      allSpotChk_out,
      finalHdrInfo_all,
      inputHdrfile_all,
      idx_csz_build);
END;