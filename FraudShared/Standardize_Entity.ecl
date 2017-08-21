import AID , tools; 
EXPORT Standardize_Entity       := 
module

export address(
			
			dataset(Layouts.Base.Main) pBaseFile ) := 
function
	
		HasAddress :=	trim(pBaseFile.address_2, left,right) != '';
									
		dWith_address			:= pBaseFile(HasAddress);
		dWithout_address	:= pBaseFile(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, address_1, address_2, RawAID, dwithAID, lFlags);
		
		dBase := project( dwithAID ,transform( Layouts.Base.Main,
				self.AceAID				                := left.aidwork_acecache.aid					;
				self.RawAID				                := left.aidwork_rawaid								;
				self.clean_address.prim_range			:= left.aidwork_acecache.prim_range		;
				self.clean_address.predir					:= left.aidwork_acecache.predir				;
				self.clean_address.prim_name			:= left.aidwork_acecache.prim_name		;
				self.clean_address.addr_suffix		:= left.aidwork_acecache.addr_suffix	;
				self.clean_address.postdir				:= left.aidwork_acecache.postdir			;
				self.clean_address.unit_desig			:= left.aidwork_acecache.unit_desig		;
				self.clean_address.sec_range			:= left.aidwork_acecache.sec_range		;
				self.clean_address.p_city_name		:= left.aidwork_acecache.p_city_name	;
				self.clean_address.v_city_name		:= left.aidwork_acecache.p_city_name	;
				self.clean_address.st							:= left.aidwork_acecache.st						;
				self.clean_address.zip						:= left.aidwork_acecache.zip5					;
				self.clean_address.zip4						:= left.aidwork_acecache.zip4					;
				self.clean_address.cart						:= left.aidwork_acecache.cart					;
				self.clean_address.cr_sort_sz			:= left.aidwork_acecache.cr_sort_sz		;
				self.clean_address.lot						:= left.aidwork_acecache.lot					;
				self.clean_address.lot_order			:= left.aidwork_acecache.lot_order		;
				self.clean_address.dbpc						:= left.aidwork_acecache.dbpc					;
				self.clean_address.chk_digit			:= left.aidwork_acecache.chk_digit		;
				self.clean_address.rec_type				:= left.aidwork_acecache.rec_type			;
				self.clean_address.fips_state 		:= left.aidwork_acecache.county[1..2]	;
				self.clean_address.fips_county		:= left.aidwork_acecache.county[3..]	;
				self.clean_address.geo_lat				:= left.aidwork_acecache.geo_lat			;
				self.clean_address.geo_long				:= left.aidwork_acecache.geo_long			;
				self.clean_address.msa						:= left.aidwork_acecache.msa					;
				self.clean_address.geo_blk				:= left.aidwork_acecache.geo_blk			;
				self.clean_address.geo_match			:= left.aidwork_acecache.geo_match		;
				self.clean_address.err_stat				:= left.aidwork_acecache.err_stat			;
				self								              := left																;
			) )
		+ project(dWithout_address,transform(Layouts.Base.Main, self := left));

	return dBase;
end;

export Phone(dataset(Layouts.Base.Main) pBaseFile) :=
function

	tools.mac_AppendCleanPhone(pBaseFile	    ,phone_number	,dphone_number	,clean_phones.phone_number	,,true);
	tools.mac_AppendCleanPhone(dphone_number	,cell_phone		,dcell_phone		,clean_phones.cell_phone		,,true);
  tools.mac_AppendCleanPhone(dcell_phone	  ,Work_phone		,dWork_phone		,clean_phones.Work_phone	,,true);

  return dWork_phone;
	
end;
end; 
