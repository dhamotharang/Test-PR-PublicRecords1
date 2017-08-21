IMPORT HealthCareProviderHeader;
IMPORT SALT26a5 as SALT;

buildFtIndex(myFtPlusRs, myName, myCols, myIdxName, myBldName) := MACRO    
    EXPORT myIdxName := INDEX(myFtPlusRs, { #EXPAND(myCols) }, {fpos}, persistPath + #TEXT(myIdxName));
    EXPORT myBldName := BUILDINDEX(myIdxName, OVERWRITE);
ENDMACRO;

buildlnpidToForeign(myResult, myFtRs, myCols, myColsLeft, myColsJoin) := MACRO
    #uniquename(lnpidToForeignRs1);
    #uniquename(lnpidToForeignRs2);  
    #uniquename(lnpidToForeignRs3);  
    #uniquename(lnpidToForeignRs4);  
    #uniquename(lnpidToForeignRs5);  
    %lnpidToForeignRs1% := TABLE(DISTRIBUTE(myFtRs, HASH32(lnpid)),
      {
          lnpid,
          #EXPAND(myCols),
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt)
      }, lnpid, #EXPAND(myCols),
      LOCAL);

    %lnpidToForeignRs2% := DISTRIBUTE(%lnpidToForeignRs1%, HASH32(#EXPAND(myCols)));   // lhs
    %lnpidToForeignRs3% := TABLE(%lnpidToForeignRs2%,
      {
          #EXPAND(myCols),
          unsigned lnpid_cnt := COUNT(GROUP),
          unsigned hdr_cnt := SUM(GROUP, hdr_cnt)
      }, #EXPAND(myCols),
      LOCAL);    // rhs
  

    %lnpidToForeignRs4% := JOIN(%lnpidToForeignRs2%, %lnpidToForeignRs3%,
      #EXPAND(myColsJoin),
      TRANSFORM(
        {
            LEFT.lnpid,
            #EXPAND(myColsLeft),
            LEFT.hdr_cnt,
            unsigned foreign_lnpid_cnt,
            unsigned foreign_hdr_cnt
        },
        SELF.foreign_lnpid_cnt := RIGHT.lnpid_cnt - 1,
        SELF.foreign_hdr_cnt  := RIGHT.hdr_cnt - LEFT.hdr_cnt,
        SELF := LEFT),
        INNER,
        LOCAL);
    %lnpidToForeignRs5% := SORT(%lnpidToForeignRs4%, lnpid, #EXPAND(myCols));
    EXPORT myResult  := %lnpidToForeignRs5%;

    #uniquename(sample_all);
    #set(sample_all, #TEXT(myResult));
    #append(sample_all, '_sample_all');
    EXPORT %sample_all% := OUTPUT(ENTH(myResult, outlimit), NAMED(#TEXT(myResult)));

    #uniquename(mycount);
    #set(mycount, #TEXT(myResult));
    #append(mycount, '_count');
    EXPORT %mycount%      := OUTPUT(COUNT(myResult(foreign_lnpid_cnt > 0)), NAMED(#TEXT(myResult) + 'Count'));

    #uniquename(mysample);
    #set(mysample, #TEXT(myResult));
    #append(mysample, '_sample');
    EXPORT %mysample%     := OUTPUT(ENTH(myResult(foreign_lnpid_cnt > 0), outlimit), NAMED(#TEXT(myResult) + 'Sample'));

    #uniquename(lnpidDistRs1);
    #uniquename(lnpidDistRs);
    %lnpidDistRs1% := TABLE(myResult,
      {
          #EXPAND(myCols),
          unsigned lnpid_cnt := COUNT(GROUP)
      }, #EXPAND(myCols));
    %lnpidDistRs% := TABLE(%lnpidDistRs1%,
      {
          lnpid_cnt,
          entity_cnt := COUNT(GROUP)
      }, lnpid_cnt);
  
    #uniquename(lnpid_dist);
    #set(lnpid_dist, #TEXT(myResult));
    #append(lnpid_dist, '_lnpid_dist');
    EXPORT %lnpid_dist% := OUTPUT(CHOOSEN(%lnpidDistRs%, outlimit), NAMED(#TEXT(myResult) + 'lnpidDist'));

    #uniquename(out);
    #set(out, #TEXT(myResult));
    #append(out, '_out');
    EXPORT %out% := PARALLEL(%mycount%, %mysample%, %lnpid_dist%);
ENDMACRO;

EXPORT Reporting := MODULE
    EXPORT string persistPath := HeaderSummary().myFilePrefix;
    EXPORT in_dataset         := HeaderSummary().currentHdrRs;
    EXPORT outlimit           := 100;
    
    //
    // Capture analysis
    //
    //EXPORT in_HealthProvider := in_dataset;

    //
    // Create a "fact table" for the capture analysis
    //
    ftRs1 := DISTRIBUTE(in_dataset, HASH32(lnpid));
    ftRs2 := TABLE(ftRs1,
      {
          lnpid,
          did,
          src,
          vendor_id,
          npi_number,
          dea_number,
          lic_state,
          lic_nbr,
          phone,
          tax_id,
          upin,
          unsigned hdr_cnt := COUNT(GROUP);
      },
      lnpid, did, src, vendor_id, npi_number, dea_number, lic_state, lic_nbr, phone, tax_id, upin,
      LOCAL);
      
    EXPORT ftRs  := ftRs2 : PERSIST(persistPath + 'fact_table_ids1');

    EXPORT ftRs_count  := OUTPUT(COUNT(ftRs), NAMED('factTableRsCount'));
    EXPORT ftRs_sample := OUTPUT(ENTH(ftRs, outlimit), NAMED('factTableRsSample'));
    
    EXPORT ftPlusRs := DATASET(persistPath + 'fact_table_ids1',
      {
          RECORDOF(ftRs),
          UNSIGNED8 fpos{virtual(fileposition)}
      }, THOR);
      
    buildFtIndex(ftPlusRs,
      lnpid,   'lnpid',               idx_ft_lnpid,   idx_ft_lnpid_build);  
    buildFtIndex(ftPlusRs,
      src,    'src, vendor_id',     idx_ft_src,    idx_ft_src_build);
    buildFtIndex(ftPlusRs(npi_number <> ''),
      npi,    'npi_number',         idx_ft_npi,    idx_ft_npi_build);
    buildFtIndex(ftPlusRs(dea_number <> ''),
      dea,    'dea_number',         idx_ft_dea,    idx_ft_dea_build);
    buildFtIndex(ftPlusRs(lic_state <> '' AND lic_nbr <> ''),
      lic,    'lic_state, lic_nbr', idx_ft_lic,    idx_ft_lic_build);
    buildFtIndex(ftPlusRs(phone <> ''),
      phone,  'phone',              idx_ft_phone,  idx_ft_phone_build);
    buildFtIndex(ftPlusRs(tax_id <> 0),
      tax_id, 'tax_id',             idx_ft_tax_id, idx_ft_tax_id_build);
    buildFtIndex(ftPlusRs(upin <> ''),
      upin,   'upin',               idx_ft_upin,   idx_ft_upin_build);
    buildFtIndex(ftPlusRs(did <> 0),
      did,    'did',                idx_ft_did,    idx_ft_did_build);
    
    EXPORT buildFtIdx_all := PARALLEL(
      idx_ft_lnpid_build,
      idx_ft_src_build,
      idx_ft_npi_build,
      idx_ft_dea_build,
      idx_ft_lic_build,
      idx_ft_phone_build,
      idx_ft_tax_id_build,
      idx_ft_upin_build,
      idx_ft_did_build);
    

    buildLnpidToForeign(lnpidToForeignSrcRs, ftRs(true),
      'src, vendor_id', 'LEFT.src, LEFT.vendor_id', 'LEFT.src = RIGHT.src AND LEFT.vendor_id = RIGHT.vendor_id');
    buildlnpidToForeign(lnpidToForeignNpiRs, ftRs(npi_number != ''),
      'npi_number', 'LEFT.npi_number', 'LEFT.npi_number = RIGHT.npi_number');
    buildlnpidToForeign(lnpidToForeignDeaRs, ftRs(dea_number != ''),
      'dea_number', 'LEFT.dea_number', 'LEFT.dea_number = RIGHT.dea_number');
    buildlnpidToForeign(lnpidToForeignLicRs, ftRs(lic_state != '' AND lic_nbr != ''),
      'lic_state, lic_nbr', 'LEFT.lic_state, LEFT.lic_nbr', 'LEFT.lic_state = RIGHT.lic_state AND LEFT.lic_nbr = RIGHT.lic_nbr');
    buildlnpidToForeign(lnpidToForeignPhoneRs, ftRs(phone != ''),
      'phone', 'LEFT.phone', 'LEFT.phone = RIGHT.phone');
    buildlnpidToForeign(lnpidToForeignTaxidRs, ftRs(tax_id != 0),
      'tax_id', 'LEFT.tax_id', 'LEFT.tax_id = RIGHT.tax_id');
    buildlnpidToForeign(lnpidToForeignUpinRs, ftRs(upin != ''),
      'upin', 'LEFT.upin', 'LEFT.upin = RIGHT.upin');
    buildlnpidToForeign(lnpidToForeignDidRs, ftRs(did != 0),
      'did', 'LEFT.did', 'LEFT.did = RIGHT.did');

    EXPORT lnpidToForeign_out := PARALLEL(
        lnpidToForeignSrcRs_out,
        lnpidToForeignNpiRs_out,
        lnpidToForeignDeaRs_out,
        lnpidToForeignLicRs_out,
        lnpidToForeignPhoneRs_out,
        lnpidToForeignTaxidRs_out,
        lnpidToForeignUpinRs_out,
        lnpidToForeignDidRs_out);
    
    //
    // LatLongFname Index Creation
    //
    EXPORT ll_divisions := 5;
    EXPORT string latlongLnameIdx_idxfile := persistPath + 'idx_latlong_fname_lnpid';
    
    EXPORT latlongLnameIdx_layout := RECORD
        in_dataset.lnpid;
        in_dataset.lname;
        SALT.Str20Type lat_long;
    END;
    
    latlongLnameIdx1 := in_dataset((REAL)geo_lat != 0 AND (REAL)geo_long != 0);
    latlongLnameIdx2 := latlongLnameIdx1;  //CHOOSEN(latlongLnameIdx1, 500);

    latlongLnameIdx3 := PROJECT(latlongLnameIdx2, TRANSFORM(
      latlongLnameIdx_layout,
      SELF.lat_long := SALT.Fn_Create_LL(LEFT.geo_lat, LEFT.geo_long, ll_divisions);
      SELF := LEFT), LOCAL);
    latlongLnameIdx4 := SORT(latlongLnameIdx3(TRIM(lat_long) != ''), RECORD);
    latlongLnameIdx5 := DEDUP(latlongLnameIdx4, RECORD);
    latlongLnameIdx6 := INDEX(latlongLnameIdx5,
      {lat_long, lname},
      {lnpid},
      latlongLnameIdx_idxfile);
      
    EXPORT latlongLnameIdx       := latlongLnameIdx6;
    EXPORT latlongLnameIdx_build := BUILDINDEX(latlongLnameIdx, OVERWRITE);
END;