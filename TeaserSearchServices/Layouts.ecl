import iesp, doxie, standard,TeaserSearchServices;

export Layouts := MODULE

	export records := iesp.thinrolluppersonsearch.t_ThinRpsSearchRecord;
	
	export records_plus := RECORD(records)
		doxie.Layout_HeaderFileSearch.penalt;
		integer4 totalRecords;
		
		// additional address parts for appending phone indicator
		string10    prim_range := '';
		string28    prim_name := '';
		string8     sec_range := '';
	end;
  // used in reversePhoneTeaser
	export ReversePhoneteaserIntermediateLayout := RECORD	
		iesp.share.t_address;
		UNSIGNED6 did;
		BOOLEAN current_flag;
	END;	
				 
  EXPORT ReverseAddress := MODULE
	
		EXPORT  rec_header := RECORD
			INTEGER penalt;
			RECORDOF (doxie.key_header) AND NOT [persistent_record_id];
		END;
	
		// rollup presentation  
		EXPORT rec_name := RECORD(standard.name)
			STRING8 dob;
			UNSIGNED6 did;
		END;
		EXPORT rec_addr := RECORD
			standard.addr;
			rec_header.city_name;
			// keep date last seen for sorting 
			rec_header.dt_last_seen;
		END;  
		
		EXPORT recRolled := RECORD
			UNSIGNED6 did;
			UNSIGNED8 rawaid;
			INTEGER penalt;
			rec_header.dt_last_seen;
			UNSIGNED6 hhid;
			DATASET (rec_name) names {MAXCOUNT (TeaserSearchServices.Constants.AddressTeaser.MaxNames)};
    DATASET (rec_addr) addresses {MAXCOUNT (TeaserSearchServices.Constants.AddressTeaser.MaxAddresses)};      
  END;
	
	  EXPORT PersonPlus := RECORD
			iesp.share.t_name Name;
			INTEGER Age;	
			STRING14 MaskedPhone;
			DATASET(iesp.share.t_Name) Relatives {MAXCOUNT(iesp.Constants.ThinReverseAddress.MaxRelatives)};
		end;
	
		EXPORT PersonResidenceRawAid := RECORD
			unsigned8 rawaid;
			boolean cur;
			iesp.thinreverseaddressteaser.t_ThinReverseAddressTeaserPersonResidence;
		end;
	END;
	
end;