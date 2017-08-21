//second parameter should be true if incomming dataset has county,cbsa and geo_blk fields, false if not
export macGetCleanAddr(origDatasetIn ,pRawAID ,phasAddFields='false' ,pDatasetOut) :=	macro
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
	end;

	%lfileinplus% %tmrgaddr% (origDatasetIn le) := TRANSFORM
		self.addr_line1 :=	trim(Stringlib.stringcleanspaces(le.prim_range+' '+
														le.predir+' '+
														le.prim_name+' '+
														le.suffix+' '+
														le.postdir+' '+
														le.unit_desig+' '+
														le.sec_range),left,right);
		self.addr_line2 :=  trim(Stringlib.stringcleanspaces(	trim(le.city_name) + if(le.city_name <> '',',','')
																+ ' '+ le.st
																+ ' '+ le.zip
																),left,right
																									);
		self := le;
	END;

	%pfilein% := project(origDatasetIn,%tmrgaddr%(left));

	unsigned4	%lFlags% := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	
	AID.MacAppendFromRaw_2Line(%pfilein%,addr_line1,addr_line2,pRawAID,%dataFromAIDMacro%, %lFlags%);

	origDatasetIn %tsetaddress%(%dataFromAIDMacro% le) := TRANSFORM
		boolean err_flg		:=	if(le.aidwork_acecache.err_stat[1] = 'S',true,false);

	//score the address on a field by field comparetion on error from cleaner
	//if clean result provides an improvement increment score
	//if clean result removes from existing record decrement score
	//cleaner always removes zip 4 on error, so it was removed from the comparision
		fx_choose_address := FUNCTION
			integer1 score :=  0;

			score1 := if(le.prim_range=le.aidwork_acecache.prim_range,score,if(le.aidwork_acecache.prim_range<>'',score+1,score-1));
			score2 := if(le.predir=le.aidwork_acecache.predir,score,if(le.aidwork_acecache.predir<>'',score+1,score-1));
			score3 := if(le.prim_name=le.aidwork_acecache.prim_name,score,if(le.aidwork_acecache.prim_name<>'',score+1,score-1));
			score4 := if(le.suffix=le.aidwork_acecache.addr_suffix,score,if(le.aidwork_acecache.addr_suffix<>'',score+1,score-1));
			score5 := if(le.postdir=le.aidwork_acecache.postdir,score,if(le.aidwork_acecache.postdir<>'',score+1,score-1));
			score6 := if(le.unit_desig=le.aidwork_acecache.unit_desig,score,if(le.aidwork_acecache.unit_desig<>'',score+1,score-1));
			score7 := if(le.sec_range=le.aidwork_acecache.sec_range,score,if(le.aidwork_acecache.sec_range<>'',score+1,score-1));
			score8 := if(le.city_name=le.aidwork_acecache.v_city_name,score,if(le.aidwork_acecache.v_city_name<>'',score+1,score-1));
			score9 := if(le.st=le.aidwork_acecache.st,score,if(le.aidwork_acecache.st<>'',score+1,score-1));
			score10 := if(le.zip=le.aidwork_acecache.zip5,score,if(le.aidwork_acecache.zip5<>'',score+1,score-1));
			score11 := if(le.zip4=le.aidwork_acecache.zip4,score,if(le.aidwork_acecache.zip4<>'',score+1,score-1));

			total_score := score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11;
			return if(total_score>0,true,false);
		end;
		boolean choose_address := fx_choose_address;

		self.prim_range 	:= 	if(err_flg,le.aidwork_acecache.prim_range,if(choose_address,le.aidwork_acecache.prim_range,le.prim_range));
		self.predir			:= 	if(err_flg,le.aidwork_acecache.predir,if(choose_address,le.aidwork_acecache.predir,le.predir));
		self.prim_name		:= 	if(err_flg,le.aidwork_acecache.prim_name,if(choose_address,le.aidwork_acecache.prim_name,le.prim_name));
		self.suffix			:= 	if(err_flg,le.aidwork_acecache.addr_suffix,if(choose_address,le.aidwork_acecache.addr_suffix,le.suffix));
		self.postdir		:= 	if(err_flg,le.aidwork_acecache.postdir,if(choose_address,le.aidwork_acecache.postdir,le.postdir));
		self.unit_desig		:= 	if(err_flg,le.aidwork_acecache.unit_desig,if(choose_address,le.aidwork_acecache.unit_desig,le.unit_desig));
		self.sec_range		:= 	if(err_flg,le.aidwork_acecache.sec_range,if(choose_address,le.aidwork_acecache.sec_range,le.sec_range));
		self.city_name		:= 	if(err_flg,le.aidwork_acecache.v_city_name,if(choose_address,le.aidwork_acecache.v_city_name,le.city_name));
		self.st				:= 	if(err_flg,le.aidwork_acecache.st,if(choose_address,le.aidwork_acecache.st,le.st));
		self.zip			:= 	if(err_flg,le.aidwork_acecache.zip5,if(choose_address,le.aidwork_acecache.zip5,le.zip));
		self.zip4			:= 	if(err_flg,le.aidwork_acecache.zip4,if(choose_address,le.aidwork_acecache.zip4,le.zip4));
		#if(phasAddFields)
		self.county			:= 	if(err_flg,le.aidwork_acecache.county[3..5],if(choose_address,le.aidwork_acecache.county[3..5],le.county)); 
		self.geo_blk		:= 	if(err_flg,le.aidwork_acecache.geo_blk,if(choose_address,le.aidwork_acecache.geo_blk,le.geo_blk));
		self.cbsa			:=  if(err_flg,le.aidwork_acecache.msa+'0',if(choose_address,le.aidwork_acecache.msa+'0',le.cbsa));
		#end
		self.rawaid			:= 	le.AIDWork_RawAID;
		self				:=  le;
	end;

	pDatasetOut := project(%dataFromAIDMacro%, %tsetaddress%(left));

endmacro;