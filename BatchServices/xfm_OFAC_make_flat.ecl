
IMPORT BatchServices, Doxie, Patriot, ut;

SHARED m_Remarks(Patriot.layout_batch_out l) := 
	MODULE
	
		// If the string in a particular field (s1) does not end in a ';', and the length of that string plus the
		// length of the first word in the next field (s2) is greater than 75, then the two fields most likely contain 
		// continuous text. Just return s1 trimmed with an added space, since s2 is continued directly from s1.
		// If s1 ends in a ';' in any case, return s1 trimmed with an added space as well.
		// But...evaluate first of all whether s2 contains anything at all. If it's null, then return s1 trimmed.
		SHARED fn_concat_remark(STRING75 s1, STRING75 s2) :=
			FUNCTION
				REMARKS_FIELD_LENGTH := 75; 
				
				expr := MAP( TRIM(s2) = ''                                                  => TRIM(s1),
										 TRIM(s1)[LENGTH(TRIM(s1))] != ';' AND 
											 (LENGTH(TRIM(s1)) + LENGTH(ut.StringSplit(s2, ' ')[1])) > REMARKS_FIELD_LENGTH 
																																										=> TRIM(s1) + ' ',
										 TRIM(s1)[LENGTH(TRIM(s1))] = ';'                               => TRIM(s1) + ' ', 
										 /* ELSE ................................................... */    TRIM(s1) + '; '
										);
										
				RETURN expr;
			END;	
			
		// Construct a sensible Remarks text, adding semi-colons appropriately. 
		EXPORT full_remarks :=  fn_concat_remark(l.remarks_1, l.remarks_2)
									 + fn_concat_remark(l.remarks_2, l.remarks_3)
									 + fn_concat_remark(l.remarks_3, l.remarks_4)
									 + fn_concat_remark(l.remarks_4, l.remarks_5)
									 + fn_concat_remark(l.remarks_5, l.remarks_6)
									 + fn_concat_remark(l.remarks_6, l.remarks_7)
									 + fn_concat_remark(l.remarks_7, l.remarks_8)
									 + fn_concat_remark(l.remarks_8, l.remarks_9)
									 + fn_concat_remark(l.remarks_9, l.remarks_10)
									 + fn_concat_remark(l.remarks_10, l.remarks_11)
									 + fn_concat_remark(l.remarks_11, l.remarks_12)
									 + fn_concat_remark(l.remarks_12, l.remarks_13)
									 + fn_concat_remark(l.remarks_13, l.remarks_14)
									 + fn_concat_remark(l.remarks_14, l.remarks_15)
									 + fn_concat_remark(l.remarks_15, l.remarks_16)
									 + fn_concat_remark(l.remarks_16, l.remarks_17)
									 + fn_concat_remark(l.remarks_17, l.remarks_18)
									 + fn_concat_remark(l.remarks_18, l.remarks_19)
									 + fn_concat_remark(l.remarks_19, l.remarks_20)
									 + fn_concat_remark(l.remarks_20, l.remarks_21)
									 + fn_concat_remark(l.remarks_21, l.remarks_22)
									 + fn_concat_remark(l.remarks_22, l.remarks_23)
									 + fn_concat_remark(l.remarks_23, l.remarks_24)
									 + fn_concat_remark(l.remarks_24, l.remarks_25)
									 + fn_concat_remark(l.remarks_25, l.remarks_26)
									 + fn_concat_remark(l.remarks_26, l.remarks_27)
									 + fn_concat_remark(l.remarks_27, l.remarks_28)
									 + fn_concat_remark(l.remarks_28, l.remarks_29)
									 + fn_concat_remark(l.remarks_29, l.remarks_30)
									 + TRIM(l.remarks_30);
				
		SHARED ds_remarks_raw := DATASET( ut.StringSplit(full_remarks,';'), {STRING1000 remark} );
		
		SHARED rec_remark := RECORD
			STRING100  remark_name  := '';
			STRING1000 remark_value := '';
		END;
		
		SHARED rec_remark xfm_split_remark(ds_remarks_raw le) := 
			TRANSFORM
				arTempRemark := ut.StringSplit( le.remark, ':' );
				SELF.remark_name  := StringLib.StringToUpperCase(arTempRemark[1]);
				SELF.remark_value := arTempRemark[2];
			END;
		
		EXPORT ds_remarks := PROJECT(ds_remarks_raw, xfm_split_remark(LEFT));
	
	END;

SHARED m_Addresses(Patriot.layout_batch_out l) := 
	MODULE
		// To get something up and running, we need to make a hasty, unfounded assumption. Namely,
		// that there will be only one address associated with each record, and that it will occupy
		// fields addr_1, or addr_1 and addr_2, or addr_1 and addr_2 and addr_3. That is, addr_4 thru 
		// addr_10 will be empty.
		SHARED address := TRIM(TRIM(TRIM(l.addr_1) + ' ' + TRIM(l.addr_2)) + ' ' + TRIM(l.addr_3));
		
		// Determine whether an address is likely in the U.S. based on whether it has an abbreviated state.
		// To do this, split the address value into parts using a space as the delimiter, and enumerate them. 
		// Then, identify which address-part is the state. The address-part that follows the state must be the
		// zip code, and the one preceding it must be the city. Everything up to the city must therefore be
		// the street address. Lots of assumptions, I know. It'll have to work, though.
		SHARED SET OF STRING set_address_parts := ut.StringSplit(address, ' ');
		SHARED ds_address_parts                := DATASET(set_address_parts, {STRING100 address_part});
		
		SHARED rec_addr_parts := RECORD
			INTEGER cntr := 0;
			STRING100 address_part := '';
		END;
		
		SHARED rec_addr_parts xfm_add_seq(ds_address_parts l, INTEGER C) :=
			TRANSFORM
				SELF.cntr := C;
				SELF.address_part := l.address_part;
			END;
		
		SHARED ds_address_numbered_parts := PROJECT(ds_address_parts, xfm_add_seq(LEFT, COUNTER));		
		SHARED ds_found_state            := ds_address_numbered_parts(address_part IN ut.Set_State_Abbrev);
		
		SHARED city_pos  := IF( EXISTS(ds_found_state), ds_address_numbered_parts[ds_found_state[1].cntr - 1].cntr, 0 );
		SHARED state_pos := IF( EXISTS(ds_found_state), ds_address_numbered_parts[ds_found_state[1].cntr].cntr, 0 );
		SHARED zip_pos   := IF( EXISTS(ds_found_state), ds_address_numbered_parts[ds_found_state[1].cntr + 1].cntr, 0 );
																	
		SHARED Is_US_Address := EXISTS(ds_found_state) AND ut.isNumeric(ds_address_numbered_parts[zip_pos].address_part[1..5]);
		
		EXPORT foreign_address := IF( NOT Is_US_Address, address, '');
		EXPORT us_address      := IF( Is_US_Address, address, '');		
		EXPORT city            := IF( Is_US_Address, TRIM(ds_address_numbered_parts[city_pos].address_part), '');
		EXPORT state           := IF( Is_US_Address, TRIM(ds_address_numbered_parts[state_pos].address_part), '');
		EXPORT zip             := IF( Is_US_Address, TRIM(ds_address_numbered_parts[zip_pos].address_part), '');

		SHARED end_street_addr_pos := StringLib.StringFind(address, city, 1) - 1;
		
		EXPORT addr            := IF( Is_US_Address, address[1..end_street_addr_pos], '' );
		
	END;
	
EXPORT BatchServices.layout_OFAC_Batch_out xfm_OFAC_make_flat(Patriot.layout_batch_out l) := 
	TRANSFORM
	
		r := m_Remarks(l);
		a := m_Addresses(l);
	
		SELF.acctno              := l.acctno;
		SELF.Name                := IF( l.name_unparsed != '', l.name_unparsed, TRIM(l.name_last) + ', ' + TRIM(l.name_first) + ' ' + TRIM(l.name_middle) );
		SELF.Alt_Names           := (string)l.orig_pty_name;
		SELF.Address             := a.us_address;
		SELF.USA_StreetAddress   := a.addr;
		SELF.USA_City            := a.city;
		SELF.USA_State           := a.state;
		SELF.USA_Zip             := a.zip;
		SELF.ForeignAddress      := a.foreign_address;
		SELF.IncarceratedAddress := '';
		SELF.Type_of_Denial      := r.ds_remarks(REGEXFIND('DENIAL', remark_name ))[1].remark_value;
		SELF.Program             := r.ds_remarks(REGEXFIND('PROGRAM', remark_name ))[1].remark_value; // See GlobalWatchLists.program_lookup
		SELF.SDN_Type            := ''; // Don't know.... (e.g. 'Individual', 'Vessel')
		SELF.Title               := r.ds_remarks(REGEXFIND('TITLE', remark_name ))[1].remark_value;
		SELF.Remarks             := r.full_remarks;
		SELF.Effective_Date      := r.ds_remarks(REGEXFIND('(EFFECTIVE DATE|DATE ADDED)', remark_name ))[1].remark_value; 
		SELF.Expiration_Date     := r.ds_remarks(REGEXFIND('EXPIRATION DATE', remark_name ))[1].remark_value;
		SELF.Vessel_Owner        := ''; // Haven't a clue what this could be called either....
	END;
