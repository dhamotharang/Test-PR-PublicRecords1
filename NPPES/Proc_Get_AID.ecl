import lib_fileservices, _control, lib_stringlib, _Validate, AID, did_add;

trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;  

export Proc_Get_AID(dataset(nppes.Layouts.Base)	pBaseFile) := function

//assign a unique_id for normalize/denormalize
nppes.layouts.keybuildFirst assignID(pBaseFile L,integer cnt) := transform
	self.unique_id := cnt;
	self := L;
	self := [];
	end;
  
temp_base_recs := project(pBaseFile,assignID(left,counter));			

nppes.Layouts.Address_Layout tNormalizeAddress(temp_base_recs L, unsigned cnt) := transform   
   self.unique_id				 := l.unique_id;
   self.address_type			 := cnt;
   self.Append_Prep_Address1	 := choose(cnt,L.Mailing_Prep_Address1,
											   L.Location_Prep_Address1);
   self.Append_Prep_AddressLast  := choose(cnt,L.Mailing_Prep_AddressLast,
											   L.Location_Prep_AddressLast);
   self := [];
   end;
   
   //normalize the records to populate the address information for both addresses
   dAddressPrep	:= normalize(temp_base_recs,2,tNormalizeAddress(left,counter));
   
   // output(dAddressPrep);
   
   HasAddress	:=	trim(dAddressPrep.Append_Prep_Address1,left,right)    != '' and
					trim(dAddressPrep.Append_Prep_AddressLast,left,right) != '';
										
   dWith_address			:= dAddressPrep(HasAddress);
   dWithout_address	        := dAddressPrep(not(HasAddress));
			
		AID.Common.xflags flags	:=	AID.Common.eReturnValues.RawAID  |
										AID.Common.eReturnValues.ACECacheRecords;
		
		AID.MacAppendFromRaw_2Line(dWith_address,Append_Prep_Address1,Append_Prep_AddressLast,Append_RawAID,dAddressCleaned,flags);

		nppes.Layouts.Address_Layout	tAddressAppended(dAddressCleaned pInput)
		 :=
		  transform
				self.Append_RawAID			:=	pInput.AIDWork_RawAID;
				self.Append_AceAID          := pInput.aidwork_acecache.aid;
				self.clean_address.zip		:=	pInput.AIDWork_ACECache.zip5;
				self.clean_address.fips_state       :=  pInput.AIDWork_ACECache.county[1..2];
				self.clean_address.fips_county      :=  pInput.AIDWork_ACECache.county[3..5];
				self.clean_address			:=	pInput.AIDWork_ACECache;
				self						:=	pInput;
			end;
			
       dAddressAppended		:=	project(dAddressCleaned,tAddressAppended(left)); //: persist ('Final_NPI_AID::pvsmith');
	   
	   all_address := dAddressAppended + dWithout_address;
	   		   
	   //denormalize the records 
		nppes.layouts.KeyBuildFirst denormAID(nppes.layouts.KeyBuildFirst l, dAddressAppended r) := transform
				self.RawAID_Mailing  := if(r.address_type = 1, r.Append_RawAID, l.RawAID_Mailing);
				self.RawAID_Location := if(r.address_type = 2, r.Append_RawAID, l.RawAID_Location);
				self.AceAID_Mailing  := if(r.address_type = 1, r.Append_AceAID, l.AceAID_Mailing);
				self.AceAID_Location := if(r.address_type = 2, r.Append_AceAID, l.AceAID_Location);
				self.Clean_mailing_address.prim_range		:= if(r.address_type = 1	,r.Clean_address.prim_range		,l.Clean_mailing_address.prim_range	);
			self.Clean_mailing_address.predir				:= if(r.address_type = 1	,r.Clean_address.predir				,l.Clean_mailing_address.predir	);
			self.Clean_mailing_address.prim_name		:= if(r.address_type = 1	,r.Clean_address.prim_name		,l.Clean_mailing_address.prim_name	);
			self.Clean_mailing_address.addr_suffix	:= if(r.address_type = 1	,r.Clean_address.addr_suffix	,l.Clean_mailing_address.addr_suffix	);
			self.Clean_mailing_address.postdir			:= if(r.address_type = 1	,r.Clean_address.postdir			,l.Clean_mailing_address.postdir	);
			self.Clean_mailing_address.unit_desig		:= if(r.address_type = 1	,r.Clean_address.unit_desig		,l.Clean_mailing_address.unit_desig	);
			self.Clean_mailing_address.sec_range		:= if(r.address_type = 1	,r.Clean_address.sec_range		,l.Clean_mailing_address.sec_range	);
			self.Clean_mailing_address.p_city_name	:= if(r.address_type = 1	,r.Clean_address.p_city_name	,l.Clean_mailing_address.p_city_name	);
			self.Clean_mailing_address.v_city_name	:= if(r.address_type = 1	,r.Clean_address.v_city_name	,l.Clean_mailing_address.v_city_name	);
			self.Clean_mailing_address.st						:= if(r.address_type = 1	,r.Clean_address.st						,l.Clean_mailing_address.st	);
			self.Clean_mailing_address.zip					:= if(r.address_type = 1	,r.Clean_address.zip					,l.Clean_mailing_address.zip	);
			self.Clean_mailing_address.zip4					:= if(r.address_type = 1	,r.Clean_address.zip4					,l.Clean_mailing_address.zip4	);		
			self.Clean_mailing_address.cart					:= if(r.address_type = 1	,r.Clean_address.cart					,l.Clean_mailing_address.cart	);
			self.Clean_mailing_address.cr_sort_sz		:= if(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.Clean_mailing_address.cr_sort_sz	);
			self.Clean_mailing_address.lot					:= if(r.address_type = 1	,r.Clean_address.lot					,l.Clean_mailing_address.lot	);
			self.Clean_mailing_address.lot_order		:= if(r.address_type = 1	,r.Clean_address.lot_order		,l.Clean_mailing_address.lot_order	);
			self.Clean_mailing_address.dbpc					:= if(r.address_type = 1	,r.Clean_address.dbpc					,l.Clean_mailing_address.dbpc	);
			self.Clean_mailing_address.chk_digit		:= if(r.address_type = 1	,r.Clean_address.chk_digit		,l.Clean_mailing_address.chk_digit	);
			self.Clean_mailing_address.rec_type			:= if(r.address_type = 1	,r.Clean_address.rec_type			,l.Clean_mailing_address.rec_type	);
			self.Clean_mailing_address.fips_state		:= if(r.address_type = 1	,r.Clean_address.fips_state	,l.Clean_mailing_address.fips_state	);
			self.Clean_mailing_address.fips_county		:= if(r.address_type = 1	,r.Clean_address.fips_county ,l.Clean_mailing_address.fips_county	);
			self.Clean_mailing_address.geo_lat			:= if(r.address_type = 1	,r.Clean_address.geo_lat			,l.Clean_mailing_address.geo_lat	);
			self.Clean_mailing_address.geo_long			:= if(r.address_type = 1	,r.Clean_address.geo_long			,l.Clean_mailing_address.geo_long	);
			self.Clean_mailing_address.msa					:= if(r.address_type = 1	,r.Clean_address.msa					,l.Clean_mailing_address.msa	);
			self.Clean_mailing_address.geo_blk			:= if(r.address_type = 1	,r.Clean_address.geo_blk			,l.Clean_mailing_address.geo_blk	);
			self.Clean_mailing_address.geo_match		:= if(r.address_type = 1	,r.Clean_address.geo_match		,l.Clean_mailing_address.geo_match	);
			self.Clean_mailing_address.err_stat			:= if(r.address_type = 1	,r.Clean_address.err_stat			,l.Clean_mailing_address.err_stat		);
			
			self.Clean_location_address.prim_range	:= if(r.address_type = 2	,r.Clean_address.prim_range		,l.Clean_location_address.prim_range	);
			self.Clean_location_address.predir			:= if(r.address_type = 2	,r.Clean_address.predir				,l.Clean_location_address.predir	);
			self.Clean_location_address.prim_name		:= if(r.address_type = 2	,r.Clean_address.prim_name		,l.Clean_location_address.prim_name	);
			self.Clean_location_address.addr_suffix	:= if(r.address_type = 2	,r.Clean_address.addr_suffix	,l.Clean_location_address.addr_suffix	);
			self.Clean_location_address.postdir			:= if(r.address_type = 2	,r.Clean_address.postdir			,l.Clean_location_address.postdir	);
			self.Clean_location_address.unit_desig	:= if(r.address_type = 2	,r.Clean_address.unit_desig		,l.Clean_location_address.unit_desig	);
			self.Clean_location_address.sec_range		:= if(r.address_type = 2	,r.Clean_address.sec_range		,l.Clean_location_address.sec_range	);
			self.Clean_location_address.p_city_name	:= if(r.address_type = 2	,r.Clean_address.p_city_name	,l.Clean_location_address.p_city_name	);
			self.Clean_location_address.v_city_name	:= if(r.address_type = 2	,r.Clean_address.v_city_name	,l.Clean_location_address.v_city_name	);
			self.Clean_location_address.st					:= if(r.address_type = 2	,r.Clean_address.st						,l.Clean_location_address.st	);
			self.Clean_location_address.zip					:= if(r.address_type = 2	,r.Clean_address.zip					,l.Clean_location_address.zip	);
			self.Clean_location_address.zip4				:= if(r.address_type = 2	,r.Clean_address.zip4					,l.Clean_location_address.zip4	);		
			self.Clean_location_address.cart				:= if(r.address_type = 2	,r.Clean_address.cart					,l.Clean_location_address.cart	);
			self.Clean_location_address.cr_sort_sz	:= if(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.Clean_location_address.cr_sort_sz	);
			self.Clean_location_address.lot					:= if(r.address_type = 2	,r.Clean_address.lot					,l.Clean_location_address.lot	);
			self.Clean_location_address.lot_order		:= if(r.address_type = 2	,r.Clean_address.lot_order		,l.Clean_location_address.lot_order	);
			self.Clean_location_address.dbpc				:= if(r.address_type = 2	,r.Clean_address.dbpc					,l.Clean_location_address.dbpc	);
			self.Clean_location_address.chk_digit		:= if(r.address_type = 2	,r.Clean_address.chk_digit		,l.Clean_location_address.chk_digit	);
			self.Clean_location_address.rec_type		:= if(r.address_type = 2	,r.Clean_address.rec_type			,l.Clean_location_address.rec_type	);
			self.Clean_location_address.fips_state	:= if(r.address_type = 2	,r.Clean_address.fips_state	,l.Clean_location_address.fips_state	);
			self.Clean_location_address.fips_county	:= if(r.address_type = 2	,r.Clean_address.fips_county ,l.Clean_location_address.fips_county	);
			self.Clean_location_address.geo_lat			:= if(r.address_type = 2	,r.Clean_address.geo_lat			,l.Clean_location_address.geo_lat	);
			self.Clean_location_address.geo_long		:= if(r.address_type = 2	,r.Clean_address.geo_long			,l.Clean_location_address.geo_long	);
			self.Clean_location_address.msa					:= if(r.address_type = 2	,r.Clean_address.msa					,l.Clean_location_address.msa	);
			self.Clean_location_address.geo_blk			:= if(r.address_type = 2	,r.Clean_address.geo_blk			,l.Clean_location_address.geo_blk	);
			self.Clean_location_address.geo_match		:= if(r.address_type = 2	,r.Clean_address.geo_match		,l.Clean_location_address.geo_match	);
			self.Clean_location_address.err_stat		:= if(r.address_type = 2	,r.Clean_address.err_stat			,l.Clean_location_address.err_stat		);			
				self            := l;
				end;
	   
	   denormRecs :=  denormalize(temp_base_recs,all_address,
								  left.unique_id = right.unique_id,
								  denormAID(left,right));
								         
		return denormrecs;
		
		end;
	   