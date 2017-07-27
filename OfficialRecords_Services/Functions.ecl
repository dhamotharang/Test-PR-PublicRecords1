import iesp,official_records;

export Functions := module

	export params := interface
	end;

  export fnSearchVal(dataset(recordof(Official_Records.Key_Document_ORID)) in_recs) := function
	
	// Used to replace spaces in date strings with zeroes so cast to integer works Ok,
	// since some dates only contain a yyyy or a yyyymm.
  fixed_date(string8 dtin) := StringLib.StringFindReplace(dtin, ' ', '0');


    //******** Party file Transform
	  iesp.officialrecord.t_OfficialRecParty party_file_xform(
                                         official_records.Key_Party_ORID l) := transform
		  // Only possible master_party_type_cd values are 1, 5 or 9 which are set in 
			// official_records.Out_Roxie_Party.
			// "9" is the default set when the entity_type_desc is not one of the known values.
			// So if the value is not 1 or 5, the entity_type_desc is output in case it 
			// contains any descriptive text, even though it wasn't known in 
			// official_records.Out_Roxie_Party.
		  self.PartyType := map(l.master_party_type_cd = '1' => 'Grantor',
													  l.master_party_type_cd = '5' => 'Grantee',
													  l.entity_type_desc),
		  self.Name      := l.entity_nm
    end;

    // **************** MAIN TRANSFORM ****************
		Layouts.t_OfficialRecRecordWithPenalty 
			                    xform(Official_Records.Key_Document_ORID l) := transform
			self.OfficialRecordId := l.official_record_key,
      self.DocumentType     := l.doc_type_desc,
			self.State            := l.state_origin,
			self.County           := l.county_name,
	    self.FilingDate       := iesp.ECL2ESP.toDate ((integer4) fixed_date(l.doc_filed_dt)),
			// For Parties data, use a project to do a keyed look up against the Key Party file
			// using the orid and also matching on the document-type. 
			// Then use a "choosen" to limit the total party records returned to 500.
			// (see OFFRECS_MAX_COUNT_PARTIES in iesp.Constants.)
      // Then sort the returned parties first in descending order by PartyType 
			// (i.e. Grantor then Grantee); then secondly in alpha name order.
	 	  self.Parties := sort(choosen(project(official_records.Key_Party_ORID(
                                    keyed(l.official_record_key = official_record_key) and
															            l.doc_type_desc = doc_type_desc),
			                     	        party_file_xform(left)),
													         iesp.Constants.OFFRECS_MAX_COUNT_PARTIES),
											     -PartyType,Name)
	 end;


		// NOTE: Passed in in_recs contains 1 record for each orid to be returned.
		recs_fmtd := project(in_recs, xform(LEFT));
		
    //Uncomment lines below as needed to assist in debugging
		//output(in_recs,named('func_in_recs'));
		//output(recs_fmtd,named('func_recs_fmtd'));
		
		return(recs_fmtd);         	
		
	end;
		
end;
