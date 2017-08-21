//second parameter should be true if incomming dataset has county,cbsa and geo_blk fields, false if not
export macGetCleanAddr(origDatasetIn, 
											 pprim_range, 
											 ppredir, 
											 pprim_name, 
											 paddr_suffix, 
											 ppostdir, 
											 punit_desig, 
											 psec_range, 
											 pcity, 
											 pstate, 
											 pzip, 
											 pzip4, 
											 pRawAID,
											 //phasAddFields='false',
											 pBestAddr='false',
											 pIsZipString='false',
											 pDatasetOut) :=	macro
		#uniquename(dataFromAIDMacro)
		#uniquename(recDatasetOut)
		#uniquename(tsetaddress)
		#uniquename(lfileinplus)
		#uniquename(tmrgaddr)
		#uniquename(pfilein)
		#uniquename(errorcode)
		#uniquename(lFlags)
		#uniquename(blkAdrrFilter)
		#uniquename(nonBlkAddrOrigDatasetIn)
		#uniquename(blkAddrOrigDatasetIn)
			
		%lfileinplus% := RECORD
			origDatasetIn;
			string160 addr_line1;
			string100 addr_line2;
		end;
		
		%blkAdrrFilter%  := origDatasetIn.prim_range	= '' and 
												origDatasetIn.prim_name		= '' and 
												origDatasetIn.city				= '' and 
												(unsigned3)origDatasetIn.zip 				= 0;
																	
		%nonBlkAddrOrigDatasetIn% := origDatasetIn(~%blkAdrrFilter%);
		%blkAddrOrigDatasetIn%    := origDatasetIn(%blkAdrrFilter%);

		%lfileinplus% %tmrgaddr% (origDatasetIn le) := TRANSFORM
			self.addr_line1 :=	trim(Stringlib.stringcleanspaces(le.pprim_range+' '+
															le.ppredir+' '+
															le.pprim_name+' '+
															le.paddr_suffix+' '+
															le.ppostdir+' '+
															le.punit_desig+' '+
															le.psec_range),left,right);
			self.addr_line2 :=  trim(Stringlib.stringcleanspaces(	trim(le.pcity) + if(le.pcity <> '',',','')
																	+ ' '+ le.pstate
																	+ ' '+ if((unsigned3)le.pzip = 0, '',(string5)intformat((unsigned3)le.pzip,5,1))
																	),left,right);
			self := le;
		END;

		%pfilein% := project(%nonBlkAddrOrigDatasetIn%,%tmrgaddr%(left));

		#if(pBestAddr)
			unsigned4	%lFlags% := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
			AID.MacAppendFromRaw_2Line(%pfilein%,addr_line1,addr_line2,pRawAID,%dataFromAIDMacro%,%lFlags%);
			
			origDatasetIn %tsetaddress%(%dataFromAIDMacro% le) := TRANSFORM
				boolean err_flg		:=	if(le.aidwork_acecache.err_stat[1] = 'S',true,false);

				//score the address on a field by field comparision on error from cleaner
				//if clean result provides an improvement increment score
				//if clean result removes from existing record decrement score
				//cleaner always removes zip 4 on error, so it was removed from the comparision
				fx_choose_address := FUNCTION
					integer1 score :=  0;
					
					score1  := if(le.pprim_range=le.aidwork_acecache.prim_range,score,if(le.aidwork_acecache.prim_range<>'',score+1,score-1));
					score2  := if(le.ppredir=le.aidwork_acecache.predir,score,if(le.aidwork_acecache.predir<>'',score+1,score-1));
					score3  := if(le.pprim_name=le.aidwork_acecache.prim_name,score,if(le.aidwork_acecache.prim_name<>'',score+1,score-1));
					score4  := if(le.paddr_suffix=le.aidwork_acecache.addr_suffix,score,if(le.aidwork_acecache.addr_suffix<>'',score+1,score-1));
					score5  := if(le.ppostdir=le.aidwork_acecache.postdir,score,if(le.aidwork_acecache.postdir<>'',score+1,score-1));
					score6  := if(le.punit_desig=le.aidwork_acecache.unit_desig,score,if(le.aidwork_acecache.unit_desig<>'',score+1,score-1));
					score7  := if(le.psec_range=le.aidwork_acecache.sec_range,score,if(le.aidwork_acecache.sec_range<>'',score+1,score-1));
					score8  := if(le.pcity=le.aidwork_acecache.v_city_name,score,if(le.aidwork_acecache.v_city_name<>'',score+1,score-1));
					score9  := if(le.pstate=le.aidwork_acecache.st,score,if(le.aidwork_acecache.st<>'',score+1,score-1));
					score10 := if((string5)intformat((unsigned3)le.pzip,5,1)=le.aidwork_acecache.zip5,score,if(le.aidwork_acecache.zip5<>'',score+1,score-1));
					score11 := if((string4)intformat((unsigned2)le.pzip4,4,1)=le.aidwork_acecache.zip4,score,if(le.aidwork_acecache.zip4<>'',score+1,score-1));

					total_score := score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11;
					return if(total_score>0,true,false);
				end;
				
				boolean choose_address := fx_choose_address;

				self.pprim_range 	:= 	if(err_flg,le.aidwork_acecache.prim_range,if(choose_address,le.aidwork_acecache.prim_range,le.pprim_range));
				self.ppredir			:= 	if(err_flg,le.aidwork_acecache.predir,if(choose_address,le.aidwork_acecache.predir,le.ppredir));
				self.pprim_name		:= 	if(err_flg,le.aidwork_acecache.prim_name,if(choose_address,le.aidwork_acecache.prim_name,le.pprim_name));
				self.paddr_suffix	:= 	if(err_flg,le.aidwork_acecache.addr_suffix,if(choose_address,le.aidwork_acecache.addr_suffix,le.paddr_suffix));
				self.ppostdir		  := 	if(err_flg,le.aidwork_acecache.postdir,if(choose_address,le.aidwork_acecache.postdir,le.ppostdir));
				self.punit_desig	:= 	if(err_flg,le.aidwork_acecache.unit_desig,if(choose_address,le.aidwork_acecache.unit_desig,le.punit_desig));
				self.psec_range		:= 	if(err_flg,le.aidwork_acecache.sec_range,if(choose_address,le.aidwork_acecache.sec_range,le.psec_range));
				self.pcity     		:= 	if(err_flg,le.aidwork_acecache.v_city_name,if(choose_address,le.aidwork_acecache.v_city_name,le.pcity));
				self.pstate	    	:= 	if(err_flg,le.aidwork_acecache.st,if(choose_address,le.aidwork_acecache.st,le.pstate));
				#if(pIsZipString)
				self.pzip		    	:= 	if(err_flg,le.aidwork_acecache.zip5,if(choose_address,le.aidwork_acecache.zip5,le.pzip));
				self.pzip4			  := 	if(err_flg,le.aidwork_acecache.zip4,if(choose_address,le.aidwork_acecache.zip4,le.pzip4));
				#else
				self.pzip		    	:= 	if(err_flg,(unsigned3)le.aidwork_acecache.zip5,if(choose_address,(unsigned3)le.aidwork_acecache.zip5,le.pzip));
				self.pzip4			  := 	if(err_flg,(unsigned2)le.aidwork_acecache.zip4,if(choose_address,(unsigned2)le.aidwork_acecache.zip4,le.pzip4));
				#end
				//#if(phasAddFields)
				//self.county			  := 	if(err_flg,le.aidwork_acecache.county[3..5],if(choose_address,le.aidwork_acecache.county[3..5],le.county)); 
				//self.geo_blk	  	:= 	if(err_flg,le.aidwork_acecache.geo_blk,if(choose_address,le.aidwork_acecache.geo_blk,le.geo_blk));
				//self.cbsa			    :=  if(err_flg,le.aidwork_acecache.msa+'0',if(choose_address,le.aidwork_acecache.msa+'0',le.cbsa));
				//#end
				self.prawaid			:= 	le.AIDWork_RawAID;
				self				      :=  le;
			end;
			
			pDatasetOut := project(%dataFromAIDMacro%, %tsetaddress%(left)) + %blkAddrOrigDatasetIn%;			
		#else
			unsigned4	%lFlags% := AID.Common.eReturnValues.RawAID;
			AID.MacAppendFromRaw_2Line(%pfilein%,addr_line1,addr_line2,pRawAID,%dataFromAIDMacro%,%lFlags%);
			pDatasetOut := project(%dataFromAIDMacro%, transform(recordof(origDatasetIn), self.prawaid :=	left.AIDWork_RawAID, self := left)) + %blkAddrOrigDatasetIn%;
		#end

endmacro;