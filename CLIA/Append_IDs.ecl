IMPORT BIPV2, Business_Header, Business_Header_SS, Business_HeaderV2, DID_Add, ut, Health_Provider_Services;

EXPORT Append_IDs := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBdid
	// -- Attaches BDIDs
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendBdid(DATASET(Layouts.Base) pDataset) := FUNCTION

		BasePlusBDID := RECORD
		  Layouts.Base;
			STRING100 company_name;
			STRING10  prim_range;
			STRING28	prim_name;
			STRING25  p_city_name;
			STRING5		zip5;
			STRING8		sec_range;
			STRING10	phone;
			STRING9		fein;
		END;

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Project record for Bdiding
		// -- In this case, the fields the macro uses are not used here, except state, so no
		//    need to use a slim layout for projection and connect it back to the base later.
		//////////////////////////////////////////////////////////////////////////////////////
		BasePlusBDID tForBdiding(Layouts.Base L) := TRANSFORM
			SELF.company_name	:= L.facility_name;
			SELF.prim_range		:= L.clean_company_address.prim_range;
			SELF.prim_name		:= L.clean_company_address.prim_name;
			SELF.p_city_name	:= L.clean_company_address.p_city_name;
			SELF.zip5					:= L.clean_company_address.zip;
			SELF.sec_range		:= L.clean_company_address.sec_range;
			SELF.phone				:= L.clean_phones.Phone;
			SELF.fein					:= '';
			SELF.bdid					:= 0;
			SELF.bdid_score		:= 0;
			
			SELF := L;
		END;

		dForBdiding := sort(distribute(PROJECT(pDataset, tForBdiding(LEFT)), 
												hash(zip5, prim_range, prim_name, sec_range, phone, company_name, clia_number)),
												zip5, prim_range, prim_name, sec_range, phone, company_name, clia_number, skew(1), local);
												
		BDID_Matchset := ['A', 'P'];

		Business_Header_SS.MAC_Add_BDID_Flex(
			 dForBdiding													// Input Dataset
			,BDID_Matchset                        // BDID Matchset what fields to match on
			,company_name	                        // company_name
			,prim_range		                        // prim_range
			,prim_name		                        // prim_name
			,zip5					                        // zip5
			,sec_range		                        // sec_range
			,state				                        // state
			,phone				                        // phone
			,fein					                        // fein
			,bdid													        // bdid
			,BasePlusBDID           							// Output Layout
			,TRUE                                 // output layout has bdid score field?
			,bdid_score                           // bdid_score
			,dBdidOut                             // Output Dataset
			,																			// score_threshold
			,																			// file version (prod)
			,																			// use other environment?
			,BIPV2.xlink_version_set  						// BIP2 ids
			,																			// URL
			,																			// email
			,p_city_name													// city
		
		);
    RETURN PROJECT(dBdidOut, Layouts.Base);

	END;
	
		 export fAppendLNpid(dataset(layouts.base) pDataset)	:= function
	 		Health_Provider_Services.mac_get_best_lnpid_on_thor (
				pDataset
				,lnpid
				,//FNAME
				,//MNAME
				,//LNAME
				,//name_suffix
				,//GENDER
				,clean_company_address.prim_range
				,clean_company_address.prim_name
				,clean_company_address.sec_range
				,clean_company_address.p_city_name
				,clean_company_address.st
				,clean_company_address.zip
				,//clean_SSN
				,//clean_DOB
				,clean_Phones.phone
				,//LIC_STATE
				,//LIC_Num_in
				,//TAX_ID
				,//DEA_NUM
				,clia_number//group_key
				,//NPI
				,//UPIN
				,DID
				,BDID
				,//SRC
				,//SOURCE_RID
				,result,false,38
			);
			
		RETURN result;
   END;


	EXPORT fAll(DATASET(Layouts.Base) pDataset) := FUNCTION

		dAppendBdid := fAppendBdid(pDataset) : PERSIST(Persistnames.AppendIdsBdid);
		
		sort_Bdid		:= sort(distribute(dAppendBdid, hash(clean_company_address.zip, clean_phones.phone, clia_number)), clean_company_address.zip, clean_phones.phone, clia_number, skew(1), local);
		
		dAppendLNpid	:= fAppendLNpid(sort_Bdid) : PERSIST(Persistnames.AppendIdsLNpid);

		RETURN dAppendLNpid;

	END;

END;
