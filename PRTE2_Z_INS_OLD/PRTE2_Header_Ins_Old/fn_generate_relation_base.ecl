IMPORT prte_csv;

EXPORT fn_generate_relation_base() := FUNCTION;

	retds1 := files.HDR_BASE_ALPHA_DS;
	retds_Layout := prte_csv.ge_header_base.layout_payload-rtitle;
	// ------------------------------------------------------------------------------------------------------------------

	// ------------------------------------------------------------------------------------------------------------------
	// NOTE: Danny designed this to make everyone related to everyone.
	// However, it looks like he actually made relationships only if streetNums are equal.
	//TODO - will this cause any issues with alpharetta test cases?
	// For alpharetta here, I'm thinking about adding street name and/or zip - RESEARCH WHAT TO DO
	// Long term I think we might need to bring in related people from spreadsheet for alpha data.
	// ------------------------------------------------------------------------------------------------------------------
	retds2 := join(retds1,retds1
				,left.prim_range = right.prim_range
				// AND left.prim_name = right.prim_name
				// AND left.zip+left.zip4 = right.zip+right.zip4
				AND left.did <> right.did
				,TRANSFORM({retds1}
					,self.person1:=left.did
					,self.person2:=right.did
					,self:=left)
				,left outer
				);
	retds2b := PROJECT(retds2,retds_Layout);
	// ------------------------------------------------------------------------------------------------------------------	
	retds3 := SORT(retds2b, did);	// : PERSIST('~prte::persist::custtest::PeopleHeader_LNProperty_Dedup_Sort');
	RETURN dedup(retds3, RECORD, all);
	
END;