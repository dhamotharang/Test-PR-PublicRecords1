
IMPORT Address, dx_header, Risk_Indicators, RiskWise, data_services;

EXPORT getAssociatedAddresses(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) VOOShell = DATASET([],VerificationOfOccupancy.Layouts.Layout_VOOShell), BOOLEAN isFCRA = FALSE) := FUNCTION 
		
	addr_history_data := 
		JOIN(
			VOOShell, dx_header.key_addr_hist(IF(isFCRA, data_services.data_env.iFCRA, 0)),
			KEYED(LEFT.did = RIGHT.s_did), 
			TRANSFORM( VerificationOfOccupancy.Layouts.Layout_address, 
				SELF.s_did                   := RIGHT.s_did,
				SELF.address_prim_range      := RIGHT.prim_range,
				SELF.address_predir          := RIGHT.predir,
				SELF.address_prim_name       := RIGHT.prim_name,
				SELF.address_suffix          := RIGHT.suffix,
				SELF.address_postdir         := RIGHT.postdir,
				SELF.address_unit_desig      := RIGHT.unit_desig,
				SELF.address_sec_range       := RIGHT.sec_range,
				SELF.address_city            := '', // calculate below
				SELF.address_state           := '', // calculate below
				SELF.address_zip             := RIGHT.zip,
				SELF.address_date_first_seen := RIGHT.date_first_seen,
				SELF.address_date_last_seen  := RIGHT.date_last_seen,
				SELF.address_history_seq     := RIGHT.address_history_seq,
				SELF.source_count            := RIGHT.source_count,
				SELF.insurance_source_count  := RIGHT.insurance_source_count, 
				SELF.addressstatus           := RIGHT.addressstatus,
				SELF.addresstype             := RIGHT.addresstype,
				SELF.bureau_source_count     := RIGHT.bureau_source_count,
				SELF.property_source_count   := RIGHT.property_source_count,
				SELF.utility_source_count    := RIGHT.utility_source_count,
				SELF.vehicle_source_count    := RIGHT.vehicle_source_count,
				SELF.dl_source_count         := RIGHT.dl_source_count,
				SELF.voter_source_count      := RIGHT.voter_source_count,
				SELF := LEFT,
				SELF := []
			),
			ATMOST(riskwise.max_atmost)
		);

	// Add City, State.
	VerificationOfOccupancy.Layouts.Layout_address xfm_add_city_state(VerificationOfOccupancy.Layouts.Layout_address le) :=
		TRANSFORM
			addr_line1 := Address.Addr1FromComponents(le.address_prim_range, le.address_predir, le.address_prim_name, le.address_suffix, le.address_postdir, le.address_unit_desig, le.address_sec_range);
			addr_clean := Address.GetCleanAddress(addr_line1, le.address_zip, address.Components.Country.US).results;
			SELF.address_city  := addr_clean.p_city; 
			SELF.address_state := addr_clean.state;
			SELF := le;
			SELF := [];
		END;
	
	results := PROJECT( addr_history_data, xfm_add_city_state(LEFT) );
	
	RETURN results;
END;

