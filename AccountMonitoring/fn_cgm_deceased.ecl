IMPORT BatchServices, Header, NID;

EXPORT DATASET(layouts.history) fn_cgm_deceased(
    DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
    DATASET(AccountMonitoring.layouts.documents.deceased.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.deceased.base),
    AccountMonitoring.i_Job_Config job_config
  ) :=
  FUNCTION

    // Assign base file(s). See block comment far below for layout definition.
    Header.Layout_Did_Death_MasterV3 base_file := product_files.deceased.base_file;

    fnmac_cgm_deceased(in_portfolio_fnmac, base_file_fnmac) := FUNCTIONMACRO
      // Temporary Join Layout
      temp_layout := record
        in_documents.pid;
        in_documents.rid;
        in_documents.hid;
        in_documents.state_death_id;
        typeof(in_portfolio_fnmac.did) save_did;
        typeof(in_portfolio_fnmac.bdid) save_bdid;
      end;

      // Pivot on SSN
      temp_port_dist_1 := distribute(in_portfolio_fnmac(ssn != ''),hash64(ssn));
      temp_base_dist_1 := distribute(base_file_fnmac(ssn != ''),hash64(ssn));
      temp_join_1 := join(temp_port_dist_1,temp_base_dist_1,
        left.ssn = right.ssn,
        transform(temp_layout,
          self.pid := left.pid,
          self.rid := left.rid,
          self.hid := 0,
          self.save_did := left.did,
          self.save_bdid := left.bdid,
          self := right),
        local);

      // Pivot on Zip
      temp_port_dist_3 := distribute(in_portfolio_fnmac(z5 != '' and name_last != ''),hash64(z5,metaphonelib.DMetaPhone1(name_last)[1..4],NID.PreferredFirstNew(name_first)));

      temp_base_dist_3a := distribute(base_file_fnmac(zip_lastres != '' and lname != ''),hash64(zip_lastres,metaphonelib.DMetaPhone1(lname)[1..4],NID.PreferredFirstNew(fname)));
      temp_join_3a := join(temp_port_dist_3,temp_base_dist_3a,
        left.z5 = right.zip_lastres and
        metaphonelib.DMetaPhone1(left.name_last)[1..4] = metaphonelib.DMetaPhone1(right.lname)[1..4] and
        NID.PreferredFirstNew(left.name_first) = NID.PreferredFirstNew(right.fname),
        transform(temp_layout,
          self.pid := left.pid,
          self.rid := left.rid,
          self.hid := 0,
          self.save_did := left.did,
          self.save_bdid := left.bdid,
          self := right),
        local);

      temp_base_dist_3b := distribute(base_file_fnmac(zip_lastpayment != '' and lname != ''),hash64(zip_lastpayment,metaphonelib.DMetaPhone1(lname)[1..4],NID.PreferredFirstNew(fname)));
      temp_join_3b := join(temp_port_dist_3,temp_base_dist_3b,
        left.z5 = right.zip_lastpayment and
        metaphonelib.DMetaPhone1(left.name_last)[1..4] = metaphonelib.DMetaPhone1(right.lname)[1..4] and
        NID.PreferredFirstNew(left.name_first) = NID.PreferredFirstNew(right.fname),
        transform(temp_layout,
          self.pid := left.pid,
          self.rid := left.rid,
          self.hid := 0,
          self.save_did := left.did,
          self.save_bdid := left.bdid,
          self := right),
        local);

      // Pivot on DID
      temp_port_dist_4 := distribute(in_portfolio_fnmac((unsigned)did != 0),hash64((unsigned)did));
      temp_base_dist_4 := distribute(base_file_fnmac((unsigned)did != 0),hash64((unsigned)did));
      temp_join_4 := join(temp_port_dist_4,temp_base_dist_4,
        (unsigned)left.did = (unsigned)right.did,
        transform(temp_layout,
          self.pid := left.pid,
          self.rid := left.rid,
          self.hid := 0,
          self.save_did := left.did,
          self.save_bdid := left.bdid,
          self := right),
        local);

      temp_project_documents := project(in_documents,transform(temp_layout,
        self.save_did := 0,
        self.save_bdid := 0,
        self := left));

      // Combine the possibilities from the various pivots (joins)
      temp_all_joins := temp_join_1
                      + temp_join_3a
                      + temp_join_3b
                      + temp_join_4
                      + temp_project_documents
                        ;

      // Dedup by pid/rid & key field (did, tmsid, etc.) so not to double-count
      temp_all_deduped := dedup(sort(distribute(temp_all_joins,hash64(pid,rid,hid)),
                                     pid,rid,hid,state_death_id,local),
                                pid,rid,hid,state_death_id,local);

      // Go get the data to check out.

      temp_data_layout := record
        temp_layout;
        base_file_fnmac.did;
        base_file_fnmac.ssn;
        base_file_fnmac.state;
        base_file_fnmac.zip_lastres;
        base_file_fnmac.lname;
        base_file_fnmac.name_suffix;
        base_file_fnmac.fname;
        base_file_fnmac.mname;
        base_file_fnmac.dod8;
      end;

      temp_get_main := join(distribute(temp_all_deduped,hash64(state_death_id)),
                            distribute(base_file_fnmac,hash64(state_death_id)),
        left.state_death_id = right.state_death_id,
        transform(temp_data_layout,
          self.pid         := left.pid,
          self.rid         := left.rid,
          self.hid         := left.hid,
          self.save_did    := left.save_did,
          self.save_bdid   := left.save_bdid,
          self.did         := right.did,
          self.ssn         := right.ssn,
          self.state       := right.state,
          self.state_death_id := right.state_death_id,
          self.zip_lastres := right.zip_lastres,
          self.lname       := right.lname,
          self.name_suffix := right.name_suffix,
          self.fname       := right.fname,
          self.mname       := right.mname,
          self.dod8        := right.dod8,
          self := []),
        left outer,
        local);

      // Now create a hash value from only the fields we're interested in
      // (these are the non *id fields in the temp_layout).
      temp_unrolled_hashes := project(temp_get_main,
        transform(layouts.history,
          self.pid          := left.pid,
          self.rid          := left.rid,
          self.hid          := left.hid,
          self.did          := left.save_did,
          self.bdid         := left.save_bdid,
          self.product_mask := AccountMonitoring.Constants.pm_deceased,
          self.timestamp    := '',
          self.hash_value   := hash64(
            left.did,
            left.ssn,
            left.state,
            left.state_death_id,
            left.zip_lastres,
            left.lname,
            left.name_suffix,
            left.fname,
            left.mname,
            left.dod8),
          self := left
          ));

      return temp_unrolled_hashes;
    ENDMACRO;

    temp_unrolled_hashes_all := fnmac_cgm_deceased(in_portfolio, base_file);

    // Roll up the hashes for all records for a particular pid/rid; and return.
    temp_rolled_hashes := rollup(sort(distribute(temp_unrolled_hashes_all,hash64(pid,rid,hid)),pid,rid,hid,record,local),
      transform(layouts.history,
        self.hash_value := left.hash_value + right.hash_value,
        self := left),
      pid,rid,local);

    // Debugging:
    // output(in_portfolio, named('in_portfolio'));
    // output(temp_join_1, named('temp_join_1'));
    // output(temp_join_2, named('temp_join_2'));
    // output(temp_join_3, named('temp_join_3'));
    // output(temp_join_4, named('temp_join_4'));
    // output(temp_join_5, named('temp_join_5'));
    // output(temp_join_6, named('temp_join_6'));
    // output(temp_all_joins, named('temp_all_joins'));
    // output(temp_all_deduped, named('temp_all_deduped'));
    // output(temp_get_main, named('temp_get_main'));
    // output(temp_unrolled_hashes, named('temp_unrolled_hashes'));
    // output(temp_rolled_hashes, named('temp_rolled_hashes'));

    // ***********************************************************************************

    return temp_rolled_hashes;

  END;

/*  header.Layout_Did_Death_MasterV2 := record
      string12  did,
      unsigned1 did_score,
      string8   filedate;
      string1   rec_type;
      string1   rec_type_orig;
      string9   ssn;
      string20  lname;
      string4   name_suffix;
      string15  fname;
      string15  mname;
      string1   VorP_code;
      string8   dod8;
      string8   dob8;
      string2   st_country_code;
      string5   zip_lastres;
      string5   zip_lastpayment;
      string2	  state;
      string3	  fipscounty;
      string2   crlf;
      string16  state_death_id;
    end;
*/