/* ********************************************************************************************
PRTE2_Header_Ins.fn_generate_relation_base
MUST SWITCH TO THE NEW BOCA BUSINESS CASE BUILD PROCESSES - FOR NOW MUST KEEP THE SAME FILE NAMES
NOTE: We only need file info here for 
a) Spray/DeSpray and the data preparation we used to do during the build before the append.
b) Our Base file and 
c) any research/maintenance
************************************************************************************ */
IMPORT prte_csv;

EXPORT fn_generate_relation_base() := FUNCTION;

	retds1 := files.HDR_BASE_ALPHA_DS;
	retds_Layout := prte_csv.ge_header_base.layout_payload-rtitle;
	// ------------------------------------------------------------------------------------------------------------------
// ***************************************************************************************************	
// FEB 2018 - Gabriel says they re-generate relations with all combined legacy data so this seems to
// 							be obsolete unless at some point, we (a) need specific relations and (b) get them to alter their build
// 							Gabriel says look at this WU W20180213-102027 in prod thor.
	retds2b := PROJECT(retds1,retds_Layout);
//TODO - if Gabriel isn't right we may need to create some new way to generate some relations.
// ***************************************************************************************************	
	
/* ***** old historical fake relations generation ****************************************************
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
*************************************************************************************************** */

	retds3 := SORT(retds2b, did);	// : PERSIST('~prte::persist::custtest::PeopleHeader_LNProperty_Dedup_Sort');
	RETURN dedup(retds3, RECORD, all);
	
END;