IMPORT business_header, Census_Data, doxie_cbrs, Doxie_Raw, doxie;

EXPORT GetByBDID(DATASET(Doxie_Raw.Layout_address_input) addr_in,
											   doxie.IDataAccess mod_access) := MODULE

	EXPORT best_group := business_records(addr_in, mod_access);

	addrDidsWithInputs := getDids(addr_in,mod_access.application_type);
		
	EXPORT getPropFids() := FUNCTION
											
		doxie_cbrs.layout_references getBdids(best_group l) := TRANSFORM
				SELF := l;
		END;
		
		bdids := DEDUP(SORT(PROJECT(best_group, getBdids(LEFT)), bdid), bdid);

		busFids := business_property(bdids);
    
		RETURN busFids;
	
	END;
	
	EXPORT GetCountyRecs() := FUNCTION

		doxie_cbrs.layout_references getBdids(best_group l) := TRANSFORM
			SELF := l;
		END;

		bdids := PROJECT(best_group, getBdids(LEFT));

		bus_hdr_base := choosen(business_header.getBaseRecs(bdids),1000);

		// stolen from bus header
		br_msa_county := RECORD
			doxie_cbrs.Layout_BH;
			string60 msaDesc := '';
			string18 county_name := '';
		END;
				
		br_msa_county add_msa_county(bus_hdr_base L, Census_Data.Key_Fips2County R) := TRANSFORM
			SELF.msaDesc := if(L.msa <> '' and L.msa <> '0000', ziplib.MSAToCityState(L.msa), '');
			SELF.county_name := if (L.county <> '', R.county_name, '');
			SELF.phone := if(L.phone > 0, (string)L.phone, '');
			SELF.fein := if(L.fein > 0, (string)L.fein, '');
			SELF.zip := if(L.zip > 0, INTFORMAT(L.zip,5,1), '');
			SELF.zip4 := if(L.zip4 > 0, INTFORMAT(L.zip4,4,1), '');
			SELF.msa := if(L.msa <> '0000', L.msa, '');
			SELF := L;
		END;

		bus_hdr_county := JOIN(bus_hdr_base,Census_Data.Key_Fips2County,
													 KEYED(LEFT.state = RIGHT.state_code and
													 LEFT.county = RIGHT.county_fips),
													 add_msa_county(LEFT,RIGHT), LEFT OUTER, KEEP (1)); 

		RETURN bus_hdr_county;
		
	END;
END;
