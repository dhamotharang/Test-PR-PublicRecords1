import	STD, AID, Address;
EXPORT proc_CleanHistoryAddresses(dataset(layout_historyaid) infile) := FUNCTION
	master2 := DISTRIBUTE(infile);

	raid := RECORD
		layout_historyaid;
		string	line1;
		string	line2;
	END;
	
	master3 := PROJECT(master2, TRANSFORM(raid,
						self.line1 := Std.str.CleanSpaces( 
							left.predir + ' ' +
							left.prim_name + ' ' +
							left.suffix + ' ' +
							left.postdir + ' ' +
							left.unit_desig + ' ' +
							left.sec_range);
						self.line2 := stringlib.stringcleanspaces(
							trim(left.p_city_name, left, right) + if(left.p_city_name <> '' and left.st <> '', ', ', '') + left.st + ' ' + left.z5);
						self := LEFT;
						));

	aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;

	masterAID := master(prim_name <> '' or sec_range <> '');
	masterNoAID := project(master(prim_name = '' and sec_range = ''), transform(layout_historyaid, self := left));
	
		masterNoAID := project(master3(line1='' OR line2=''), transform(Gong_Neustar.layout_historyaid,
				clnaddr 	  := Address.CleanAddress182(left.line1, left.line2);
				string pickone(string raw, string cleaned) := TRIM(IF(cleaned='',ToUpper(raw),cleaned));
				
				self.rawaid := 0;
				self.prim_range := pickone(left.PRIMARY_STREET_NUMBER,clnaddr[1..10]);
				self.predir :=  pickone(left.PRE_DIR,clnaddr[11..12]);
				self.prim_name := pickone(left.PRIMARY_STREET_NAME,clnaddr[13..40]);
				self.suffix := pickone(left.PRIMARY_STREET_SUFFIX,clnaddr[41..44]);
				self.postdir := pickone(left.POST_DIR,clnaddr[45..46]);
				self.unit_desig := pickone(left.SECONDARY_ADDRESS_TYPE,clnaddr[47..56]);
				self.sec_range := pickone(left.SECONDARY_RANGE,clnaddr[57..64]);
				self.p_city_name := pickone(left.city,clnaddr[65..89]);
				self.v_city_name := pickone(left.city,clnaddr[90..114]);
				self.st := pickone(left.state,clnaddr[115..116]);
				self.z5 := pickone(left.ZIP_CODE,clnaddr[117..121]);
				self.z4 := pickone(left.ZIP_PLUS4,clnaddr[122..125]);
				self.cart := clnaddr[126..129];
				self.cr_sort_sz := clnaddr[130];
				self.lot := clnaddr[131..134];
				self.lot_order := clnaddr[135];
				self.dpbc := clnaddr[136..137];
				self.chk_digit := clnaddr[138];
				self.rec_type := clnaddr[139..140];
				self.county_code := clnaddr[141..142] + clnaddr[143..145];
				self.geo_lat := pickone(left.LATITUDE,clnaddr[146..155]);
				self.geo_long := pickone(left.LONGITUDE,clnaddr[156..166]);
				self.msa := clnaddr[167..170];
				self.geo_blk := clnaddr[171..177];
				self.geo_match := pickone(left.LAT_LONG_MATCH_LEVEL,clnaddr[178]);
				self.err_stat := clnaddr[179..182];
				self:=left));	
		
	aid.MacAppendFromRaw_2Line(masterAID, line1, line2, rawaid , master4, laidappendflags);

	master5 := normalize(master4, 1, transform(Gong_Neustar.layout_gongmaster,
				choose_field(string old, string new) := function
					S := left.err_stat[..1] = 'S';
					prim_range := left.PRIMARY_STREET_NUMBER <> '' and left.aidwork_acecache.prim_range = '';
					prim_name := left.PRIMARY_STREET_NAME <> '' and left.aidwork_acecache.prim_name = '';
					sec_range := left.SECONDARY_RANGE <> '' and left.aidwork_acecache.sec_range = '';
					return if(prim_range or s or prim_name or sec_range, old, new);
				end;
				
				upper(string s) := Std.Str.ToUpperCase(s);
				
				self.rawaid := left.aidwork_rawaid;
				self.prim_range := choose_field(upper(left.PRIMARY_STREET_NUMBER), left.aidwork_acecache.prim_range);
				self.predir := choose_field(upper(left.PRE_DIR), left.aidwork_acecache.predir);
				self.prim_name := choose_field(upper(left.PRIMARY_STREET_NAME), left.aidwork_acecache.prim_name);
				self.suffix := choose_field(upper(left.PRIMARY_STREET_SUFFIX), left.aidwork_acecache.addr_suffix);
				self.postdir := choose_field(upper(left.POST_DIR), left.aidwork_acecache.postdir);
				self.unit_desig := choose_field(upper(left.SECONDARY_ADDRESS_TYPE), left.aidwork_acecache.unit_desig);
				self.sec_range := choose_field(upper(left.SECONDARY_RANGE), left.aidwork_acecache.sec_range);
				self.p_city_name := choose_field(upper(left.city), left.aidwork_acecache.p_city_name);
				self.v_city_name := choose_field(upper(left.city), left.aidwork_acecache.v_city_name);
				self.st := choose_field(upper(left.state), left.aidwork_acecache.st);
				self.z5 := choose_field(upper(left.ZIP_CODE), left.aidwork_acecache.zip5);
				self.z4 := choose_field(upper(left.ZIP_PLUS4), left.aidwork_acecache.zip4);
				self.cart := left.aidwork_acecache.cart;
				self.cr_sort_sz := left.aidwork_acecache.cr_sort_sz;
				self.lot := choose_field(left.lot, left.aidwork_acecache.lot);
				self.lot_order := left.aidwork_acecache.lot_order;
				self.dpbc := left.aidwork_acecache.dbpc;
				self.chk_digit := left.aidwork_acecache.chk_digit;
				self.rec_type := left.aidwork_acecache.rec_type;
				self.county_code := left.aidwork_acecache.county;
				self.geo_lat := choose_field(left.LATITUDE, left.aidwork_acecache.geo_lat);
				self.geo_long := choose_field(left.LONGITUDE, left.aidwork_acecache.geo_long);
				self.msa := left.aidwork_acecache.msa;
				self.geo_blk := left.aidwork_acecache.geo_blk;
				self.geo_match := choose_field(left.LAT_LONG_MATCH_LEVEL, left.aidwork_acecache.geo_match);
				self.err_stat := left.aidwork_acecache.err_stat;
				self:=left));

	master6 := 			
		master5 & masterNoAID;		// : PERSIST('~thor::persist::gong::neustar::cleanaddr');
	return master6;
	
END;