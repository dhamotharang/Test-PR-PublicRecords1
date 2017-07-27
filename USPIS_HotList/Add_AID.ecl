import Address, Lib_AddrClean, Ut, lib_stringlib, _Control, business_header,_Validate,aid;

export Add_AID :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input) pRawFileInput) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcessIndividuals(Layouts.Input l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	Address.Addr1FromComponents(
								l.ADDRESS	
								,l.SUFFIX		
								,''	 	
								,''	 
								,''	 	
								,''
								,''	 	
								); 
			address2 :=	Address.Addr2FromComponents(
								l.CITY					
								,l.STATE				
								,l.ZIP_CODE	
								);

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			
			findMonth := MAP(regexfind('JAN',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '01',
							regexfind('FEB',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '02',
							regexfind('MAR',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '03',
							regexfind('APR',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '04',
							regexfind('MAY',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '05',
							regexfind('JUN',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '06',
							regexfind('JUL',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '07',
							regexfind('AUG',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '08',
							regexfind('SEP',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '09',
							regexfind('OCT',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '10',
							regexfind('NOV',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '11',
							regexfind('DEC',trim(StringLib.StringToUpperCase(l.date),left,right)[1..3],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)='' => '12',
							regexfind('JAN',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '01',
							regexfind('FEB',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '02',
							regexfind('MAR',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '03',
							regexfind('APR',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '04',
							regexfind('MAY',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '05',
							regexfind('JUN',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '06',
							regexfind('JUL',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '07',
							regexfind('AUG',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '08',
							regexfind('SEP',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '09',
							regexfind('OCT',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '10',
							regexfind('NOV',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '11',
							regexfind('DEC',trim(StringLib.StringToUpperCase(l.date),left,right)[5..7],0)<>'' and regexfind('\\/', trim(l.date,left,right)[4],0)<>'' => '12',
							'');

			findYear := if(regexfind('8|9',trim(l.date,left,right)[5],0)<>'' and length(trim(l.date,left,right))=6,
							'19'+trim(l.date)[length(l.date)-1..length(l.date)],
							if(trim(l.date,left,right)<>'' and length(trim(l.date,left,right))=6,
							'20'+trim(l.date)[length(l.date)-1..length(l.date)],
							if(regexfind('8|9',trim(l.date,left,right)[9],0)<>'' and length(trim(l.date,left,right))=12,
							'19'+trim(l.date)[length(l.date)-1..length(l.date)],
							if(trim(l.date,left,right)<>'' and length(trim(l.date,left,right))=12,
							'20'+trim(l.date)[length(l.date)-1..length(l.date)],
							''))));

			formatDate := if(findYear<>'' and findMonth<>'',
							findYear+findMonth+'01',
							'');
			
			self.dt_first_reported	:= formatDate;
			self.dt_last_reported	:= formatDate;
			self.address1			:= address1;
			self.address2			:= address2;                                        
			self.unique_id			:= cnt;
			self.prim_range 		:= '';
			self.predir 			:= '';
			self.prim_name 			:= '';
			self.addr_suffix 		:= '';
			self.postdir 			:= '';
			self.unit_desig 		:= '';
			self.sec_range 			:= '';
			self.p_city_name 		:= '';
			self.v_city_name 		:= '';
			self.st 				:= '';
			self.zip 				:= '';
			self.zip4 				:= '';
			self.cart 				:= '';
			self.cr_sort_sz 		:= '';
			self.lot 				:= '';
			self.lot_order 			:= '';
			self.dpbc 				:= '';
			self.chk_digit 			:= '';
			self.record_type 		:= '';
			self.county 			:= '';
			self.geo_lat 			:= '';
			self.geo_long 			:= '';
			self.msa 				:= '';
			self.geo_blk 			:= '';
			self.geo_match 			:= '';
			self.err_stat 			:= '';
			self.raw_aid			:= 0;		
			self.ace_aid			:= 0;				
			self					:= l;
		end;
		
		pCombinedRec 	:= project(pRawFileInput(DATE != '',DATE != 'DATE'), tPreProcessIndividuals(left,counter));
		hotlist_dst 	:= distribute(pCombinedRec, hash(dt_first_reported, dt_last_reported, address, suffix, city, state, zip_code, comments));
		hotlist_srt 	:= sort(hotlist_dst, dt_first_reported, dt_last_reported, address, suffix, city, state, zip_code, comments, local);
		dPreProcess 	:= dedup(hotlist_srt, dt_first_reported, dt_last_reported, address, suffix, city, state, zip_code, comments, local);
		
			dPreProcess tr(dPreProcess L, dPreProcess R) := TRANSFORM
				self.dt_last_reported := r.dt_last_reported;
				SELF := L;
			END;

		rollupRptDates	:= ROLLUP(sort(dPreProcess, address1, address2, dt_first_reported), tr(left,right), RECORD, EXCEPT dt_first_reported, dt_last_reported);
		
		return rollupRptDates;

	end;

	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.StandardizeInput) pPrepInput) :=
	function

		HasAddress			:= trim(pPrepInput.address1, left,right) != ''
								and trim(pPrepInput.address2, left,right) != '';
										
		dWith_address		:= pPrepInput(HasAddress);
		dWithout_address	:= pPrepInput(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, Raw_AID, dwithAID, lFlags);
		
		dBase := project(
			dwithAID
			,transform(
				layouts.base
				,self.ace_aid		:= left.aidwork_acecache.aid;
				self.raw_aid		:= left.aidwork_rawaid;
				self.prim_range		:= left.aidwork_acecache.prim_range;
				self.predir 		:= left.aidwork_acecache.predir;
				self.prim_name 		:= left.aidwork_acecache.prim_name;
				self.addr_suffix 	:= left.aidwork_acecache.addr_suffix;
				self.postdir 		:= left.aidwork_acecache.postdir;
				self.unit_desig 	:= left.aidwork_acecache.unit_desig;
				self.sec_range 		:= left.aidwork_acecache.sec_range;
				self.p_city_name 	:= left.aidwork_acecache.p_city_name;
				self.v_city_name 	:= left.aidwork_acecache.v_city_name;
				self.st 			:= left.aidwork_acecache.st;
				self.zip 			:= left.aidwork_acecache.zip5;
				self.zip4 			:= left.aidwork_acecache.zip4;
				self.cart 			:= left.aidwork_acecache.cart;
				self.cr_sort_sz 	:= left.aidwork_acecache.cr_sort_sz;
				self.lot 			:= left.aidwork_acecache.lot;
				self.lot_order 		:= left.aidwork_acecache.lot_order;
				self.dpbc 			:= left.aidwork_acecache.dbpc;
				self.chk_digit 		:= left.aidwork_acecache.chk_digit;
				self.record_type 	:= left.aidwork_acecache.rec_type;
				self.county 		:= left.aidwork_acecache.county;
				self.geo_lat 		:= left.aidwork_acecache.geo_lat;
				self.geo_long 		:= left.aidwork_acecache.geo_long;
				self.msa 			:= left.aidwork_acecache.msa;
				self.geo_blk 		:= left.aidwork_acecache.geo_blk;
				self.geo_match 		:= left.aidwork_acecache.geo_match;
				self.err_stat 		:= left.aidwork_acecache.err_stat;
				self				:= left;
			)
		)
		+ project(dWithout_address,transform(layouts.base, self := left));
														
		return dBase;
		
	end;

	export fAll( dataset(Layouts.Input	)	pRawFileInput
	) :=
	function
	
		dPreprocess			:= fPreProcess(pRawFileInput);
		dStandardizeAddress	:= fStandardizeAddresses(dPreprocess	);
		
		return dStandardizeAddress;
	
	end;


end;
