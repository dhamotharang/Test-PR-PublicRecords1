IMPORT $, iesp, dx_official_records, STD;

EXPORT Functions := MODULE

  EXPORT params := INTERFACE
  END;

  EXPORT fnSearchVal(DATASET(dx_Official_Records.layouts.document) in_recs) := FUNCTION

  // Used to replace spaces in date strings with zeroes so cast to integer works Ok,
  // since some dates only contain a yyyy or a yyyymm.
  fixed_date(STRING8 dtin) := STD.Str.FindReplace(dtin, ' ', '0');

  //******** Party file Transform
  iesp.officialrecord.t_OfficialRecParty party_file_xform(RECORDOF(dx_official_records.Key_Party_ORID) l) := TRANSFORM
    // Only possible master_party_type_cd values are 1, 5 or 9 which are set in
    // official_records.Out_Roxie_Party.
    // "9" is the default set when the entity_type_desc is not one of the known values.
    // So if the value is not 1 or 5, the entity_type_desc is output in case it
    // contains any descriptive text, even though it wasn't known in
    // official_records.Out_Roxie_Party.
    SELF.PartyType := MAP(l.master_party_type_cd = '1' => 'Grantor',
                          l.master_party_type_cd = '5' => 'Grantee',
                          l.entity_type_desc),
    SELF.Name := l.entity_nm
  END;

  // **************** MAIN TRANSFORM ****************
  $.Layouts.t_OfficialRecRecordWithPenalty xform(dx_Official_Records.layouts.document l) := TRANSFORM
    SELF.OfficialRecordId := l.official_record_key;
    SELF.DocumentType := l.doc_type_desc;
    SELF.State := l.state_origin;
    SELF.County := l.county_name;
    SELF.FilingDate := iesp.ECL2ESP.toDate ((INTEGER4) fixed_date(l.doc_filed_dt));
    // For Parties data, use a project to do a keyed look up against the Key Party file
    // using the orid and also matching on the document-type.
    // Then use a "choosen" to limit the total party records returned to 500.
    // (see OFFRECS_MAX_COUNT_PARTIES in iesp.Constants.)
    // Then sort the returned parties first in descending order by PartyType
    // (i.e. Grantor then Grantee); then secondly in alpha name order.
    SELF.Parties := SORT( 
        CHOOSEN(PROJECT(dx_official_records.Key_Party_ORID(
                        KEYED(l.official_record_key = official_record_key) AND
                          l.doc_type_desc = doc_type_desc),
                        party_file_xform(LEFT)),
                        iesp.Constants.OFFRECS_MAX_COUNT_PARTIES),
      -PartyType, Name);
   END;


    // NOTE: Passed in in_recs contains 1 record for each orid to be returned.
    recs_fmtd := PROJECT(in_recs, xform(LEFT));
    
    //Uncomment lines below as needed to assist in debugging
    //output(in_recs,named('func_in_recs'));
    //output(recs_fmtd,named('func_recs_fmtd'));
    
    RETURN(recs_fmtd);
    
  END;
    
END;
