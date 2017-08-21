IMPORT PRTE2_DEADCO, InfoUSA, PRTE2, ut, PromoteSupers, Address, STD;

//Input
	dMain := PRTE2_DEADCO.Files.DEADCO_In;
	
//Base file - keeps consistent sequence by only sequencing new records
	dMainBase := PRTE2_DEADCO.Files.DEADCO_BaseAID_ext;

//Project to expected base layout which includes clean name/address fields
	Layouts.DEADCO_base_ext ClnNameAddr(Layouts.DEADCO_in L) := TRANSFORM
		//self.BDID									:=	0;
		ClnName										:= Address.CleanPersonFML73(L.CONTACT_NAME);
		self.title								:= ClnName[1..5];
		self.fname								:= ClnName[6..25];
		self.mname								:= ClnName[26..45];
		self.lname								:= ClnName[46..65];
		self.name_suffix					:= ClnName[66..70];
		self.name_cleaning_score	:= ClnName[71..73];
		temp_addr_line1						:= ut.CleanSpacesAndUpper(L.STREET1);
		temp_addr_last_line				:= address.Addr2FromComponents(L.CITY1, L.STATE1, L.ZIP1_5[1..5]);
		tempAddr									:= Address.CleanAddress182(temp_addr_line1, temp_addr_last_line);
		SELF.prim_range						:= tempAddr[1..10];
		SELF.predir								:= tempAddr[11..12];
		SELF.prim_name						:= tempAddr[13..40];
		SELF.addr_suffix					:= tempAddr[41..44];
		SELF.postdir							:= tempAddr[45..46];
		SELF.unit_desig						:= tempAddr[47..56];
		SELF.sec_range						:= tempAddr[57..64];
		SELF.p_city_name					:= tempAddr[65..89];
		SELF.v_city_name					:= tempAddr[90..114];
		SELF.st										:= tempAddr[115..116];
		SELF.zip5									:= tempAddr[117..121];
		SELF.zip4									:= tempAddr[122..125];
		SELF.cart									:= tempAddr[126..129];
		SELF.cr_sort_sz						:= tempAddr[130];
		SELF.lot									:= tempAddr[131..134];
		SELF.lot_order						:= tempAddr[135];
		SELF.dpbc									:= tempAddr[136..137];
		SELF.chk_digit						:= tempAddr[138];
		SELF.rec_type							:= tempAddr[139..140];
		SELF.ace_fips_st					:= tempAddr[141..142];
 		SELF.ace_fips_county			:= tempAddr[143..145];
		SELF.geo_lat							:= tempAddr[146..155];
		SELF.geo_long							:= tempAddr[156..166];
		SELF.msa									:= tempAddr[167..170];
		SELF.geo_blk							:= tempAddr[171..177];
		SELF.geo_match						:= tempAddr[178];
		SELF.err_stat							:= tempAddr[179..182];
		SELF.prep_addr_line1			:= temp_addr_line1;
		SELF.prep_addr_last_line	:= temp_addr_last_line;
		SELF.BDID									:= Prte2.fn_AppendFakeID.bdid((string)L.COMPANY_NAME, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip5, l.cust_name);
		SELF	:= L;
		SELF	:= [];
	END;
	
	pMainClean	:= PROJECT(dMain, ClnNameAddr(LEFT));
	
	/* For future use
 Layouts.DEADCO_base_ext Persist_SRCRecID(pMainClean L, dMainBase R) := transform
    self.source_rec_id := r.source_rec_id;
    self := l;
  end;

  //Join the update file with the base file for source_rec_id persistence 
  ds_with_srcid := join(distribute(pMainClean,hash(FEIN,VENDOR_ID)),
								        distribute(dMainBase,hash(FEIN,VENDOR_ID)),
												left.FEIN = right.FEIN AND
								        left.VENDOR_ID=right.VENDOR_ID AND
												trim(left.COMPANY_NAME) = trim(right.COMPANY_NAME),
								        Persist_SRCRecID(left,right),
								        left outer,
								        local);
*/
	
	//Add source_rec_id
	ut.MAC_Append_Rcid(pMainClean, source_rec_id, full_file_recid);
	
	PromoteSupers.Mac_SF_BuildProcess(full_file_recid, Constants.BASE_PREFIX + 'infousa::deadco', build_base);
	
EXPORT proc_build_base	:= build_base;