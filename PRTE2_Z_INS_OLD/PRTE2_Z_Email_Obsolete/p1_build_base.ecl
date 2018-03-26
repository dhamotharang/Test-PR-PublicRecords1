// phase1 should ALWAYS wipe out original file, also no autokey builds, just a simple build on the sprayed file.

EXPORT p1_build_base(STRING8 version) := MODULE
			IMPORT PRTE2, ut, address, DID_Add, header_slimsort, AID;
			
			infile := _files.Phase1_Sprayed_File;
			output_layout := _layouts.Phase1_Output_Layout;
			
			layout_name_clean := RECORD
				RECORDOF(infile);
				UNSIGNED6 DID;
				UNSIGNED8 did_score;
				STRING5 clean_title;
				STRING20 clean_fname;
				STRING20 clean_mname;
				STRING20 clean_lname;
				STRING5 clean_name_suffix;
				STRING3 clean_name_score;
				STRING addr1;
				STRING addr2;
				UNSIGNED8 RawAID:=0;
				STRING8 date_vendor_first_reported;
				STRING8 date_vendor_last_reported ;
				STRING8 date_first_seen;
				STRING8 date_last_seen;
			END;

			layout_name_clean tCleanName(infile L):=TRANSFORM
				string fullNameString 	:= TRIM(TRIM(L.fname)+' '+TRIM(L.lname));
				clean_name              := if(length(fullNameString)=0,'',address.CleanPersonFML73(fullNameString));
				SELF.DID                := (INTEGER)L.LexId;	// For CT we are loading DID
				SELF.DID_Score          := 90;								// ?????????????????????
				SELF.clean_title        := clean_name[ 1.. 5];
				SELF.clean_fname        := clean_name[ 6..25];
				SELF.clean_mname        := clean_name[26..45];
				SELF.clean_lname        := clean_name[46..65];
				SELF.clean_name_suffix  := clean_name[66..70];
				SELF.clean_name_score   := clean_name[71..73];
				SELF.addr1:=StringLib.StringCleanSpaces(TRIM(stringlib.stringtouppercase(REGEXREPLACE('[+]',L.address,' ')),LEFT,RIGHT));
				SELF.addr2:=StringLib.StringCleanSpaces(Address.Addr2FromComponents(stringlib.stringtouppercase(L.city),stringlib.stringtouppercase(L.state),stringlib.stringtouppercase(L.zip[..5])));
				SELF.date_vendor_first_reported := version;
				SELF.date_vendor_last_reported  := version;
				SELF.date_first_seen            := PRTE2.fn_format_date(L.date_time);
				SELF.date_last_seen             := SELF.date_first_seen;
				SELF:=L;
			END;
			
			cleaned_name:=PROJECT( infile, tCleanName(LEFT));
			
			no_address:=PROJECT( cleaned_name(address=''), TRANSFORM( output_layout, SELF:=LEFT; SELF:=[];));
			has_address:=cleaned_name( address!='' );

			// Call the AID macro to get the cleaned address information
			UNSIGNED4 lFlags:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
			
			AID.MacAppendFromRaw_2Line(has_address,addr1, addr2, RawAID, cleaned_name_aid, lFlags);
			
			// Get standardized Name and Address fields
			output_layout tAddressClean(cleaned_name_aid L):=TRANSFORM
				SELF.clean_prim_range           := L.aidwork_acecache.prim_range;
				SELF.clean_predir               := L.aidwork_acecache.predir;
				SELF.clean_prim_name            := L.aidwork_acecache.prim_name;
				SELF.clean_addr_suffix          := L.aidwork_acecache.addr_suffix;
				SELF.clean_postdir              := L.aidwork_acecache.postdir;
				SELF.clean_unit_desig           := L.aidwork_acecache.unit_desig;
				SELF.clean_sec_range            := L.aidwork_acecache.sec_range;
				SELF.clean_p_city_name          := L.aidwork_acecache.p_city_name;
				SELF.clean_v_city_name          := L.aidwork_acecache.v_city_name;
				SELF.clean_st                   := L.aidwork_acecache.st;
				SELF.clean_zip                  := L.aidwork_acecache.zip5;
				SELF.clean_zip4                 := L.aidwork_acecache.zip4;
				SELF.clean_cart                 := L.aidwork_acecache.cart;
				SELF.clean_cr_sort_sz           := L.aidwork_acecache.cr_sort_sz;
				SELF.clean_lot                  := L.aidwork_acecache.lot;
				SELF.clean_lot_order            := L.aidwork_acecache.lot_order;
				SELF.clean_dbpc                 := L.aidwork_acecache.dbpc;
				SELF.clean_chk_digit            := L.aidwork_acecache.chk_digit;
				SELF.clean_rec_type             := L.aidwork_acecache.rec_type;
				SELF.clean_county               := L.aidwork_acecache.county;
				SELF.clean_geo_lat              := L.aidwork_acecache.geo_lat;
				SELF.clean_geo_long             := L.aidwork_acecache.geo_long;
				SELF.clean_msa                  := L.aidwork_acecache.msa;
				SELF.clean_geo_blk              := L.aidwork_acecache.geo_blk;
				SELF.clean_geo_match            := L.aidwork_acecache.geo_match;
				SELF.clean_err_stat             := L.aidwork_acecache.err_stat;
				SELF.aid                        := L.aidwork_rawaid;
				SELF                            := L;
				SELF                            := [];
			END;
			
			cleaned_name_address := PROJECT( cleaned_name_aid, tAddressClean(LEFT));
			all_name_address := cleaned_name_address + no_address;
			//Note sure how aid works but I'm getting a bunch of junk records with no data, filter those out.
			only_with_email_address := all_name_address(email!='');

			newbasefile := DISTRIBUTE(only_with_email_address,HASH32(email));

			EXPORT p1_final_base_out := OUTPUT(newbasefile,, _constants.phase1PersistFileString);

END;

