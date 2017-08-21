import AID;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
export Standardize_Addr (
			
			dataset(Layouts.Base.Main) pBaseFile
	
	) :=
	function
	
	tempLayout := record
		string100 									address1;
		string50										address2;
		unsigned8 									raw_aid := 0;
		unsigned8 									ace_aid := 0;
		Layouts.Base.Main;
	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	tempLayout tPreProcess(pBaseFile l) :=
	transform

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 :=	StringLib.StringCleanSpaces(
		              stringlib.stringtouppercase(trim(l.rawaddressfields.AMS_STREET) + ' ' +
		                                          trim(l.rawaddressfields.AMS_UNIT)));

		address2 := StringLib.StringCleanSpaces(
									stringlib.stringtouppercase(trim(l.rawaddressfields.AMS_CITY)
									                            + if(l.rawaddressfields.AMS_STATE != '', ', ', '')
									                            + trim(l.rawaddressfields.AMS_STATE)
									                            + ' '
									                            + trim(l.rawaddressfields.AMS_ZIP5)));                           
			
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////					
		SELF.address1 	:= address1;
		SELF.address2 	:= address2;
		SELF						:= l; 
	end;
		
	dPreAddrRec := project(pBaseFile, tPreProcess(left));

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	// 
	//////////////////////////////////////////////////////////////////////////////////////
	HasAddress :=	trim(dPreAddrRec.address2, left,right) != '';
									
	dWith_address			:= dPreAddrRec(HasAddress);
	dWithout_address	:= dPreAddrRec(not(HasAddress));

	unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, Raw_AID, dwithAID, lFlags);
	
	dBase := project(
		dwithAID
		,transform(
			Layouts.Base.Main
			,
			self.rawaddressfields.ace_aid						:= left.aidwork_acecache.aid					;
			self.rawaddressfields.raw_aid						:= left.aidwork_rawaid								;
			self.Clean_Company_address.fips_state 	:= left.aidwork_acecache.county[1..2]	;
			self.Clean_Company_address.fips_county	:= left.aidwork_acecache.county[3..]	;
			self.Clean_Company_address.zip					:= left.aidwork_acecache.zip5					;
			self.Clean_Company_address							:= left.aidwork_acecache							;
			self																		:= left																;
		)
	)
	+ project(dWithout_address,transform(Layouts.Base.Main, self := left));

	return dBase;
end;