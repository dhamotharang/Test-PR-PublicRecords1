// PRTE2_LNProperty.Transform_Data_V2

// Now that we refreshed from production - this is to finalize the layout, as described below.
//   ?? are deeds ready or do they need refreshing?  257 rows only.
//-------------------------------------------------------------------------------------------------------
//TODO - plan is to repair all codes in our spreadsheet, remove all desc's from the spreadsheet
// and then none of these "repair" type steps will be needed 
// This problem comes from the original spreadsheet coming from the gateway folks and it was NOT based from data, 
//    it came from responses.
//-------------------------------------------------------------------------------------------------------
// 12/19/15 - Modified the code for Alpharetta data to not mess up the codes we fixed via V_Refresh
//            probably still needs a little more review and simplification, perhaps more v_refresh filling too
//-------------------------------------------------------------------------------------------------------

IMPORT PRTE2, PRTE2_Common, address, ut, doxie, NID;

EXPORT Transform_Data(STRING pindexversion) := MODULE

		SHARED LNPropertyRec := Layouts.layout_LNP_V2_expanded_payload;
		SHARED spreadsheet_layout := PRTE2_LNProperty.Layouts_V2.LN_spreadsheet;
		
		SHARED string8 today_date := ut.GetDate; 
		// New 11/10/15, moving to phase1 and phase2 sections, second pass to create "O" owner records
		// Currently all of our records are "P" property records
		EXPORT LNPropertyRec  Reformat_PHASE2 (LNPropertyRec L) := TRANSFORM
					// First character indicates type of party ("O" => Buyer/Owner; "B" => Borrower, "S" => Seller); 
					// second character indicates the type of address associated with that party ("O" => Buyer/Owner; "P" => Property).
					SELF.source_code   := 'OO';
					SELF.source_code_1            := 'O';
					SELF.source_code_2            := 'O';
					SELF := L;
		END;
	
		EXPORT LNPropertyRec  Reformat_PHASE1 (spreadsheet_layout L, Integer C) := TRANSFORM
					// ln_fares_id must be unique per record (internal use only)
					// ?? Production usually has a few records per ln_fares_id ??? But it doesn't seem to tie 1/property either. Need to research that.
					// OLD: l.address should have no unit or unit_desig in it because they have a separate column for Apt#
					SELF.did 				:= L.did;
					SELF.s_did 			:= L.did;
					SELF.dph_lname  := metaphonelib.DMetaPhone1(l.lname);
					SELF.pfname     := NID.PreferredFirstVersionedStr(L.fname,2);
					SELF.minit      := L.mname [1..1];
					SELF.fakeid     := (unsigned) 16000000 + C;  			// TODO - confirm with Danny that Linda chose a number that won't clash
					SELF.zero       := (unsigned1)0;

					newUnitString		:= IF(L.Apt='','',L.unitDesc+' '+L.Apt);
					tempAddrString  := l.address+' '+newUnitString;
					clean_address := PRTE2_Common.Clean_Address.FromLine(tempAddrString, l.city,l.st,l.zip);
					SELF.prim_name  :=  clean_address.prim_name;
					SELF.predir     := clean_address.predir;
					SELF.prim_range := clean_address.prim_range;
					SELF.sec_range  := clean_address.sec_range;					
					SELF.unit_desig := clean_address.unit_desig;
					SELF.postdir    := clean_address.postdir;
					SELF.suffix     := clean_address.addr_suffix;
					SELF.st         := clean_address.st;
					self.state      := clean_address.st;
					self.zip        := clean_address.zip; 
					self.zip4       := clean_address.zip4;
					SELF.msa        := clean_address.msa;
					SELF.err_stat   := clean_address.err_stat;
					SELF.cart       := clean_address.cart;
					SELF.cr_sort_sz := clean_address.cr_sort_sz;
					SELF.lot        := clean_address.lot;
					SELF.lot_order  := clean_address.lot_order;
					SELF.dbpc       := clean_address.dbpc;
					SELF.chk_digit  := clean_address.chk_digit;
					SELF.rec_type   := clean_address.rec_type;
					SELF.county     := clean_address.fips_state+clean_address.fips_county;	// ??? This is what it used to do - [141-145]
					self.geo_lat    := clean_address.geo_lat;
					self.geo_long   := clean_address.geo_long;
					SELF.geo_blk    := clean_address.geo_blk;
					SELF.geo_match  := clean_address.geo_match;
					SELF.p_city_name := clean_address.p_city_name;
					SELF.v_city_name := clean_address.v_city_name;
					// shouldn't we use p_city or v_city below instead of the original city?
					SELF.city_code  := doxie.Make_CityCode(L.city);

					// SELF.phone      := L.deed_phone_number;
					self.s4         := (unsigned) l.ssn[6..9];		//????  This looks ODD??  Should there be S4 below and ssn4 here?
					SELF.yob        := (unsigned2) L.DOB [1..4];
					SELF.DOB        := (unsigned4) L.DOB;
					self.s1         :=  l.ssn[1];
					self.s2         :=  l.ssn[2];
					self.s3         :=  l.ssn[3];
					self.s5         :=  l.ssn[5]; 
					self.s6         :=  l.ssn[6];
					self.s7         :=  l.ssn[7];
					self.s8         :=  l.ssn[8];
					self.s9         :=  l.ssn[9];		
 
					SELF.which_orig := 'T';
					// SELF.dt_first_seen            := (unsigned)today_date[1..6];		//TODO - might want to take from BHDR/CSV
					// SELF.dt_last_seen             := (unsigned)today_date[1..6];		//TODO - might want to take from BHDR/CSV
					// SELF.dt_vendor_first_reported := (unsigned)today_date[1..6];		//TODO - might want to take from BHDR/CSV
					// SELF.dt_vendor_last_reported  := (unsigned)today_date[1..6];		//TODO - might want to take from BHDR/CSV
					SELF.process_date             := today_date;

					//--------------------------------------------------------------------------
					SELF.vendor_source_flag       := IF(L.fid_type='A','F','O');
					// Currently we only have two fid_types A or D
					// NOTE: LN_PropertyV2.layout_property_common_model_base says possible vendor_source_flags are:
					// Vendor Codes for Source A are "F" and "S"; and for Source B are "D" and "O". (F=FAR_F,  S=FAR_S,  O=OKCTY,   D=DAYTN)
					// if field: from_file =F that is source A; if =D or M, it is a source B record.
					//--------------------------------------------------------------------------
					
					//--------------------------------------------------------------------------
					SELF.lookups		:= IF(L.fid_type='A', 3, 5);			// ??????????  we were told any non-zero value should work.
					//RE:lookups - BOCA PRCT data:  Assess has 3:	1366276 records;  Deed has 5:	1065466 records Plus Boca has some 0 records
					// SPOTTED THIS IN LN_PropertyV2.file_search_autokey - may want to do someday... for now, just go with Boca 3,5
					// ft		:= L.fid_type;	// ('D' => 'D',	'M' => 'D',	'A' => 'A')  - we have no M types
					// pt		:= L.source_code[1];
					// self.lookups := (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt )));
					// If we have any problems, might need to research 
					// Boca seems to have some zeros for all fid/source_code types - see PRTE2_LNProperty.U_Study_FidType_and_lookups
					// Bottomline: Not doing the production logic right now because we have only two source_codes 
					//      - OO and OP so our numbers would be 19,21 not 3,5 and for now, we'll just imitate Boca PRCT data (except no zeros)
					//--------------------------------------------------------------------------
					
					//--------------------------------------------------------------------------
					// First character indicates type of party ("O" => Buyer/Owner; "B" => Borrower, "S" => Seller); 
					// second character indicates the type of address associated with that party ("O" => Buyer/Owner; "P" => Property).
					SELF.source_code   := 'OP';
					SELF.source_code_1            := 'O';
					SELF.source_code_2            := 'P';
					//--------------------------------------------------------------------------

					SELF.app_tax_id  := L.tax_id_number;
					SELF.app_ssn     := L.ssn;
					SELF.person_name.fname := L.fname;
					SELF.person_name.mname := L.mname;
					SELF.person_name.lname := L.lname;
					self.nameasis  := PRTE2_Common.Functions.appendIf3(L.fname,L.mname,l.lname);

					SELF.person_addr.prim_range   := clean_address.prim_range;
					SELF.person_addr.predir       := clean_address.predir;
					SELF.person_addr.prim_name    := clean_address.prim_name;
					SELF.person_addr.addr_suffix  := clean_address.addr_suffix;
					Self.person_addr.postdir      := clean_address.postdir;
					SELF.person_addr.sec_range  	:= clean_address.sec_range;					
					SELF.person_addr.unit_desig 	:= clean_address.unit_desig;				
					SELF.person_addr.st 					:= clean_address.st;
					SELF.person_addr.zip5 				:= clean_address.zip;
					SELF.person_addr.zip4 				:= clean_address.zip4;
					SELF.person_addr.geo_lat      := clean_address.geo_lat;
					SELF.person_addr.geo_long     := clean_address.geo_long;
					SELF.person_addr.fips_state   := clean_address.fips_state;
					SELF.person_addr.fips_county  := clean_address.fips_county;
					SELF.person_addr.v_city_name  := clean_address.v_city_name;
					SELF.person_addr.err_stat 		:= clean_address.err_stat;	
					SELF.person_addr.geo_blk			:= clean_address.geo_blk;
					SELF.person_addr.geo_match		:= clean_address.geo_match;
					SELF.person_addr.cbsa					:= clean_address.msa;
					
					SELF.proc_date                := (unsigned8) pIndexVersion [1..8];
					SELF.current_record           := 'Y';
					SELF.from_file                := IF (L.fid_type = 'A', 'F', 'D');
					
					//------- note how spreadsheet fips_code might hold deed or assess codes ---
					// SELF.fips_code                := IF(L.Deed_fips_code > '', L.Deed_fips_code, L.assess_fips_code);
					//--------------------------------------------------------------------------

					SELF.county_name              := L.county_name;
					self.p_county_name            := self.county_name;
					self.o_county_name            := self.county_name;
					SELF.assessee_name            := TRIM(L.fname + ' ' + L.lname);
					SELF.tax_account_number       := '9923' + TRIM(L.tax_account_number[1..3]) + L.ssn[7..9];

 
					//---- don't see any fields with 'iris' in the name ??----------------------
					// iris_apn := stringlib.stringfilter(L.deed_iris_apn,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
					deed_apn := stringlib.stringfilter(L.apnt_or_pin_number,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
					assess_apn := stringlib.stringfilter(L.apna_or_pin_number,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
					// self.fares_unformatted_apn    := IF(iris_apn != '',iris_apn, IF(deed_apn != '',deed_apn, assess_apn));
					self.fares_unformatted_apn    := IF(deed_apn != '',deed_apn, assess_apn);
					//--------------------------------------------------------------------------
 
					SELF.name1                    := TRIM(L.fname,right,left) + ', ' + TRIM(L.lname,right,left);
 					
/* TODO ********************************************************************************					
					// STILL NEED THIS UNTIL WE ADD standardized_land_use_code column to our spreadsheet.
					SELF.standardized_land_use_code := MAP
							(L.assess_style_desc = 'SINGLE FAMILY RESIDENTIAL'                => 'SFR',
							 L.assess_style_desc = 'RESIDENTIAL (GENERAL) (SINGLE FAMILY)'    => 'RES',
							 L.assess_style_desc = 'RURAL RESIDENTIAL (AGRICULTURAL)'         => 'RRR',
							 L.assess_style_desc [1..20] = 'PRESUMED RESIDENTIAL'             => 'PRS',
							 '');		
   TODO ********************************************************************************					*/
							 
					//---- note this one field came from two possible sources ------------------
					// SELF.condo_project_or_building_name := IF (L.assess_condo_project_name > '', 
																									// L.assess_condo_project_name,
																									// L.assess_building_name);																				
							 
					//--------------------------------------------------------------------------


// -------------------------------------------------------------------------------------------							 
					SELF := L;
					SELF := [];
			END;    	
END;			