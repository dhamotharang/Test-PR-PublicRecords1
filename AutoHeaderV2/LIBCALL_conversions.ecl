IMPORT AutoStandardI, AutoHeaderI, doxie, AutoHeaderV2, lib_stringlib;

// Encapsulates functionality for transforming/cleaning/deriving from/to search library interface
EXPORT LIBCALL_conversions := MODULE


  // Decomposes an input global module to a flat single-row dataset.
  // No cleaning/translations are done except very few (to avoid bloating the search interface).
  // All synonyms should be resolved here as well, if needed; for instance, "mx_..."
  EXPORT GetPreprocessedInputDataset (AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full args) := function
    AutoHeaderV2.layouts.unprocessed_input format () := transform
      Self.seq := 0;
      //DID and RID
      Self.did := args.did;
      Self.rid := args.rid;
      //SSN
      Self.ssn := args.ssn;
      Self.ssntypos := args.ssntypos;
      Self.UseSSNFallBack := args.UseSSNFallBack;
      Self.searchgoodssnonly := args.searchgoodssnonly;
      //NAME
      Self.firstname := args.firstname;
      Self.unparsedfullname := args.unparsedfullname; //mx_nameasis_val.val, mx_asisname_val, mx_lfm
      Self.middlename := args.middlename;
      Self.lastname := args.lastname; //mx_lname_val.val
      Self.checknamevariants := args.checknamevariants;
      Self.phoneticdistancematch := args.phoneticdistancematch;
      Self.relativefirstname1 := args.relativefirstname1;
      Self.relativefirstname2 := args.relativefirstname2;
      Self.otherlastname1 := args.otherlastname1;
      Self.lname4 := args.lname4;
      Self.fname3 := args.fname3;
      Self.allownicknames := args.allownicknames;
      Self.phoneticmatch := args.phoneticmatch;
      Self.BPSLeadingNameMatch := args.BPSLeadingNameMatch;
      Self.AllowLeadingLname := args.AllowLeadingLname;
      Self.distancethreshold := args.distancethreshold;
      //ADDRESS
      Self.addr := args.addr;
      Self.city := args.city;
      Self.statecityzip := args.statecityzip;
      Self.state := args.state;
      Self.zip := args.zip;
      Self.isPRP := args.isPRP;
      Self.primrange := if(args.primrange != '', args.primrange, args.prim_range);
      Self.primname := if(args.primname != '', args.primname, args.prim_name);
      Self.secrange := args.secrange;
      Self.county := args.county;
      Self.otherstate1 := args.otherstate1;
      Self.otherstate2 := args.otherstate2;
      Self.othercity1 := args.othercity1;
      Self.zipradius := args.zipradius;
      Self.mileradius := args.mileradius;
      Self.allowdateseen := args.allowdateseen;
      Self.datefirstseen := args.datefirstseen;
      Self.datelastseen := args.datelastseen;
      Self.FuzzySecRange := args.FuzzySecRange;
      //PHONE
      Self.phone := args.phone;
      //DOB
      Self.dob := args.dob;
      Self.agelow := args.agelow;
      Self.agehigh := args.agehigh;
      Self.AllowFuzzyDOBMatch := args.AllowFuzzyDOBMatch;
      //OPTIONS
      Self.scorethreshold := args.scorethreshold;
      Self.isCRS := args.isCRS;
      Self.useonlybestdid := args.useonlybestdid;
      Self.household := args.household;
      Self.lnbranded := args.lnbranded;
      Self.nonexclusion := args.nonexclusion;
      Self.searchignoresaddressonly := args.searchignoresaddressonly;
			self.seisintadlservice :=  args.seisintadlservice;
      self.DemoCustomerName := AutoStandardI.InterfaceTranslator.demo_customer_name_value.val(project(args,AutoStandardI.InterfaceTranslator.demo_customer_name_value.params));
			
      // few translations to avoid bloating the library interface
      Self.ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(args,AutoStandardI.InterfaceTranslator.application_type_val.params));
      Self._lookup := doxie.lookup_bit(StringLib.StringToUpperCase(if(args.partytype<>'', 'PARTY_'+args.partytype, args.lookuptype))); //using InterfaceTranslator.lookup_value might introduce unwanted lookup_bit originally targeted for autokeys
      Self.StrictMatch := args.StrictMatch or args.OnlyExactMatches;
      // same test as in AutoStandardI/PermissionI_Tools/val/GLB/mac_FilterOutMinors
      Self.include_minors := (args.GLBPurpose = 2) OR args.IncludeMinors;
			
			Self.allow_wildcard := args.allowwildcard; // note: defines only if it is allowed, doesn't force it.
      // see the note in record definition
      Self.KeepOldSsns := ~args.UsingKeepSSNs or args.KeepOldSsns; //one field instead of two
      Self.currentResidentsOnly := args.currentResidentsOnly;
    end;
    return dataset ([format ()]);
  end;



	EXPORT CleanSearchInputDataset (dataset (AutoHeaderV2.layouts.lib_search) ds_in, integer libVersion =AutoHeaderV2.Constants.LibVersion.LEGACY) := function
    first_row := ds_in[1];

    HasWildcard (string str) := (Stringlib.StringFind(str, '*', 1) <> 0) or (Stringlib.StringFind(str, '?', 1) <> 0);

    AutoHeaderV2.layouts.search clean () := transform
      self.seq       := first_row.seq;

      // AutoStandardI.InterfaceTranslator.did_value.val
      Self.did := (unsigned6) if (stringlib.stringfilterout (first_row.did, '0123456789') = '', first_row.did, '');
      Self.rid := (unsigned6) first_row.rid;    //AutoStandardI.InterfaceTranslator.rid_value.val

						boolean isSaltFetch := libVersion = AutoHeaderV2.Constants.LibVersion.SALT;
      // Name
      Self.tname := AutoheaderV2.translate.cname (first_row,isSaltFetch);
      // Address
      addr := AutoheaderV2.translate.caddress (first_row, isSaltFetch);
      Self.taddress := addr;
      // SSN
      Self.tssn := AutoheaderV2.translate.cssn (first_row);
      //Phone
      Self.tphone := AutoheaderV2.translate.cphone (first_row);
      // DOB
      Self.tdob := AutoheaderV2.translate.cdob (first_row);

      // OPTIONS
      // AutoStandardI.InterfaceTranslator.score_threshold_value.val
      Self.options.score_threshold := if (first_row.StrictMatch,
				                                  1, // for some reason, header_records (at least) uses < rather than <=
				                                  first_row.scorethreshold);
      Self.options.saltLeadThreshold := IF(first_row.saltLeadThreshold=0, AutoHeaderV2.Constants.saltLeadThreshold, first_row.saltLeadThreshold);
      Self.options.strict_match := first_row.StrictMatch;
      Self.options.isCRS := first_row.isCRS;
      Self.options.only_best_did := first_row.useonlybestdid;
      Self.options.household := first_row.household;
      Self.options.ln_branded := first_row.lnbranded;
      Self.options.nonexclusion := first_row.nonexclusion;
      Self.options.SearchIgnoresAddressOnly := first_row.searchignoresaddressonly;
      Self.options.include_minors := first_row.include_minors;
      Self.options._lookup := first_row._lookup;
      Self.options.wildcard := //if we decide to expand library interface, then: first_row.allow_wildcard and 
        (addr._wild or HasWildcard (first_row.firstname) or HasWildcard (first_row.lastname));
    end;
    return dataset ([clean()]);
  end;
END;