//second parameter should be true if incomming dataset has county,cbsa and geo_blk fields, false if not
export Mac_Get_AID_Addr(origDatasetIn , phasAddFields='false' ,pDatasetOut) :=	macro
		#uniquename(dataFromAIDMacro)
		#uniquename(recDatasetOut)
		#uniquename(tsetaddress)
		#uniquename(lfileinplus)
		#uniquename(tmrgaddr)
		#uniquename(pfilein)
		#uniquename(errorcode)
		#uniquename(lFlags)
		
	%lfileinplus% := RECORD
		origDatasetIn;
		string160 addr_line1;
		string100 addr_line2;
		unsigned8 RawAID := 0;
	end;

	%lfileinplus% %tmrgaddr% (origDatasetIn le) := TRANSFORM
		self.addr_line1 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(le.prim_range		)
																					,stringlib.stringtouppercase(le.predir				)
																					,stringlib.stringtouppercase(le.prim_name		)
																					,stringlib.stringtouppercase(le.addr_suffix	)
																					,stringlib.stringtouppercase(le.postdir			)
																					,stringlib.stringtouppercase(le.unit_desig		)
																					,stringlib.stringtouppercase(le.sec_range		)																		
																				);
		self.addr_line2 :=   Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(if(le.v_city_name <> '', le.v_city_name,  le.p_city_name))	
																						,stringlib.stringtouppercase(le.state						)	
																						,stringlib.stringtouppercase(le.zip5 				)
																				);
		self := le;
	END;

	%pfilein% := project(origDatasetIn,%tmrgaddr%(left));

	unsigned4	%lFlags% := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
	
	AID.MacAppendFromRaw_2Line(%pfilein%,addr_line1,addr_line2,RawAID,%dataFromAIDMacro%, %lFlags%);

	origDatasetIn %tsetaddress%(%dataFromAIDMacro% le) := TRANSFORM
		boolean err_flg		:=	if(le.aidwork_acecache.err_stat = '' or le.aidwork_acecache.err_stat[1] = 'E',true,false);

	//score the address on a field by field comparetion on error from cleaner
	//if clean result provides an improvement increment score
	//if clean result removes from existing record decrement score
	//cleaner always removes zip 4 on error, so it was removed from the comparision
		fx_choose_address := FUNCTION
			integer1 score :=  0;

			score1 := if(le.prim_range=le.aidwork_acecache.prim_range,score,if(le.aidwork_acecache.prim_range<>'',score+1,score-1));
			score2 := if(le.predir=le.aidwork_acecache.predir,score,if(le.aidwork_acecache.predir<>'',score+1,score-1));
			score3 := if(le.prim_name=le.aidwork_acecache.prim_name,score,if(le.aidwork_acecache.prim_name<>'',score+1,score-1));
			score4 := if(le.addr_suffix=le.aidwork_acecache.addr_suffix,score,if(le.aidwork_acecache.addr_suffix<>'',score+1,score-1));
			score5 := if(le.postdir=le.aidwork_acecache.postdir,score,if(le.aidwork_acecache.postdir<>'',score+1,score-1));
			score6 := if(le.unit_desig=le.aidwork_acecache.unit_desig,score,if(le.aidwork_acecache.unit_desig<>'',score+1,score-1));
			score7 := if(le.sec_range=le.aidwork_acecache.sec_range,score,if(le.aidwork_acecache.sec_range<>'',score+1,score-1));
			score8 := if(le.p_city_name=le.aidwork_acecache.p_city_name,score,if(le.aidwork_acecache.p_city_name<>'',score+1,score-1));
			score9 := if(le.state=le.aidwork_acecache.st,score,if(le.aidwork_acecache.st<>'',score+1,score-1));
			score10 := if(le.zip5=le.aidwork_acecache.zip5,score,if(le.aidwork_acecache.zip5<>'',score+1,score-1));
			score11 := if(le.zip4=le.aidwork_acecache.zip4,score,if(le.aidwork_acecache.zip4<>'',score+1,score-1));

			total_score := score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11;
			return if(total_score>0,true,false);
		end;
		boolean choose_address := fx_choose_address;

		self.prim_range 	:= 	if(err_flg,le.aidwork_acecache.prim_range,if(choose_address,le.aidwork_acecache.prim_range,le.prim_range));
		self.predir			:= 	if(err_flg,le.aidwork_acecache.predir,if(choose_address,le.aidwork_acecache.predir,le.predir));
		self.prim_name		:= 	if(err_flg,le.aidwork_acecache.prim_name,if(choose_address,le.aidwork_acecache.prim_name,le.prim_name));
		self.addr_suffix			:= 	if(err_flg,le.aidwork_acecache.addr_suffix,if(choose_address,le.aidwork_acecache.addr_suffix,le.addr_suffix));
		self.postdir		:= 	if(err_flg,le.aidwork_acecache.postdir,if(choose_address,le.aidwork_acecache.postdir,le.postdir));
		self.unit_desig		:= 	if(err_flg,le.aidwork_acecache.unit_desig,if(choose_address,le.aidwork_acecache.unit_desig,le.unit_desig));
		self.sec_range		:= 	if(err_flg,le.aidwork_acecache.sec_range,if(choose_address,le.aidwork_acecache.sec_range,le.sec_range));
		self.p_city_name		:= 	if(err_flg,le.aidwork_acecache.p_city_name,if(choose_address,le.aidwork_acecache.p_city_name,le.p_city_name));
		self.v_city_name		:= 	if(err_flg,le.aidwork_acecache.v_city_name,if(choose_address,le.aidwork_acecache.v_city_name,le.v_city_name));
		self.state				:= 	if(err_flg,le.aidwork_acecache.st,if(choose_address,le.aidwork_acecache.st,le.state));
		self.zip5			:= 	if(err_flg,le.aidwork_acecache.zip5,if(choose_address,le.aidwork_acecache.zip5,le.zip5));
		self.zip4			:= 	if(err_flg,le.aidwork_acecache.zip4,if(choose_address,le.aidwork_acecache.zip4,le.zip4));
		#if(phasAddFields)
		self.cart := if(err_flg,le.aidwork_acecache.cart,if(choose_address,le.aidwork_acecache.cart,le.cart));
		self.cr_sort_sz := if(err_flg,le.aidwork_acecache.cr_sort_sz,if(choose_address,le.aidwork_acecache.cr_sort_sz,le.cr_sort_sz));
		self.lot := if(err_flg,le.aidwork_acecache.lot,if(choose_address,le.aidwork_acecache.lot,le.lot));
		self.lot_order := if(err_flg,le.aidwork_acecache.lot_order,if(choose_address,le.aidwork_acecache.lot_order,le.lot_order));
		self.dpbc := if(err_flg,le.aidwork_acecache.dbpc,if(choose_address,le.aidwork_acecache.dbpc,le.dpbc));
		self.chk_digit := if(err_flg,le.aidwork_acecache.chk_digit,if(choose_address,le.aidwork_acecache.chk_digit,le.chk_digit));
		self.rec_type := if(err_flg,le.aidwork_acecache.rec_type,if(choose_address,le.aidwork_acecache.rec_type,le.rec_type));
		self.ace_fips_st := if(err_flg,le.aidwork_acecache.county[..2],if(choose_address,le.aidwork_acecache.county[..2],le.ace_fips_st));
		self.ace_fips_county := if(err_flg,le.aidwork_acecache.county[3..],if(choose_address,le.aidwork_acecache.county[3..],le.ace_fips_county));
		self.geo_lat := if(err_flg,le.aidwork_acecache.geo_lat,if(choose_address,le.aidwork_acecache.geo_lat,le.geo_lat));
		self.geo_long := if(err_flg,le.aidwork_acecache.geo_long,if(choose_address,le.aidwork_acecache.geo_long,le.geo_long));
		self.msa := if(err_flg,le.aidwork_acecache.msa,if(choose_address,le.aidwork_acecache.msa,le.msa));
		self.geo_blk := if(err_flg,le.aidwork_acecache.geo_blk,if(choose_address,le.aidwork_acecache.geo_blk,le.geo_blk));
		self.geo_match := if(err_flg,le.aidwork_acecache.geo_match,if(choose_address,le.aidwork_acecache.geo_match,le.geo_match));
		self.err_stat:= if(err_flg,le.aidwork_acecache.err_stat,if(choose_address,le.aidwork_acecache.err_stat,le.err_stat));
	  #end
		self := le;
	end;

	pDatasetOut := project(%dataFromAIDMacro%, %tsetaddress%(left));

endmacro;