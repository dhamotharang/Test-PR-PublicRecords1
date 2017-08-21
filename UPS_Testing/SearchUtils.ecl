IMPORT AutoStandardI, AutoHeaderI, doxie, doxie_cbrs, Business_Header, UPS_Testing;

// A generic person search and business search

export SearchUtils := MODULE
	// some globals used throughout this module
	shared AIT := AutoStandardI.InterfaceTranslator;
	shared dppaPurpose := 3;
	shared glbPurpose := 1;

	// this is a generic ADL response for either a business (adlType = bdid) or
	// an individual (adlType = did).
	export ResponseADL := RECORD
		UNSIGNED 	adl;
		STRING4 	adlType;
	END;

	// this is a generic response layout suitable for either an individual or a
	// business.
	export ResponseRecord := RECORD(ResponseADL)
		STRING25  fname;
		STRING25  mname;
		STRING25  lname;
		STRING120 company_name;
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  city_name;
		STRING2   state;
		STRING5   zip;
		STRING10  phone;
	END;	

	export BusinessLookup:= MODULE
		export params := INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full, 
															 AutoStandardI.InterfaceTranslator.dppa_purpose.params)
										 END;

		export DATASET(ResponseADL) getBDIDs(params in_mod) := FUNCTION
			bdids := AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(in_mod);

			ResponseADL toResponseADL(bdids L) := TRANSFORM
				SELF.adl := L.bdid;
				SELF.adlType := 'bdid';
			END;
output(bdids, named('raw_bdids'));
			return PROJECT(bdids, toResponseADL(LEFT));
			// return if(exists(bdids), DATASET( [ { bdids[1].bdid, 'bdid' } ], ResponseADL),
															 // DATASET( [], ResponseADL));
		END;
		
		export DATASET(ResponseRecord) getRecords(DATASET(ResponseADL) bdids) := FUNCTION

			doxie.layout_ref_bdid toLookupBDIDFormat(ResponseADL L) := TRANSFORM
				SELF.bdid := L.adl;
				SELF := [];
			END;

			useBDIDs := PROJECT(bdids, toLookupBDIDFormat(LEFT));

			bizLayout := doxie_cbrs.Layout_BH_Best_String;
			dppa_purpose := dppaPurpose;
			dppa_ok := TRUE;
			
			doxie_cbrs.mac_best_records(useBDIDs, bizRecs, bizLayout);

			response := if (EXISTS(useBDIDs), bizRecs, 
																				DATASET( [], bizLayout));

			ResponseRecord toOutputLayout(response L) := TRANSFORM
				SELF.adl := L.bdid;
				SELF.adlType := 'bdid';
				
				SELF.fname := '';
				SELF.mname := '';
				SELF.lname := '';
				SELF.company_name := L.company_name;
				
				SELF.prim_range := L.prim_range;
				SELF.predir := L.predir;
				SELF.prim_name := L.prim_name;
				SELF.suffix := L.addr_suffix;
				SELF.postdir := L.postdir;
				SELF.unit_desig := L.unit_desig;
				SELF.sec_range := L.sec_range;
				SELF.city_name := L.city;
				SELF.state := L.state;
				SELF.zip := L.zip;
				SELF.phone := L.phone;

			END;
			
			return PROJECT(response, toOutputLayout(LEFT));
		END;

	END;

	export PersonLookup := MODULE
		export params := interface(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
		end;

		export DATASET(ResponseADL) getDIDs(params in_mod) := FUNCTION
			dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do_hhid(in_mod);

			ResponseADL toResponseADL(dids L) := TRANSFORM
				SELF.adl := L.did;
				SELF.adlType := 'did';
			END;

			return PROJECT(dids, toResponseADL(LEFT));
			// return if(exists(dids), DATASET( [ { dids[1].did, 'did' } ], ResponseADL),
															// DATASET( [], ResponseADL));
		END;
	END;
END;
