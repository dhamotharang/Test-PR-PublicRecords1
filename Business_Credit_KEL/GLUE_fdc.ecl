IMPORT Address, BIPV2, Business_Credit, Business_Credit_KEL, ut;

EXPORT GLUE_fdc := MODULE

		// Note: field names that are shared amongst Business Info and Tradeline are:
		//    o  sbfe_contributor_num
		//    o  contractacc_num
		//    o  accholder_businessname
		//    o  comp_website
		//    o  source

		// Create a single flat file containing both Business Info and Tradeline records--but not
		// in the same record. So, some records will have only Business Info data while other will have 
		// Tradelines data. Not very elegant, but it'll work. And it'll avoid having to create all of the combinations of the businessinfo and matching tradeline records, which we would otherwise have to untangle later anyway.

		// Redistribute keyfiles for local work on Thor.
		SHARED linkids_redist := 
			DISTRIBUTE(Business_Credit.Key_LinkIds().Key, HASH(sbfe_contributor_num, contractacc_num) );
			
		SHARED businessinfo_redist := 
			DISTRIBUTE(Business_Credit.Key_BusinessInformation(), HASH(sbfe_contributor_num, contractacc_num) );

		SHARED tradelines_redist := 
			DISTRIBUTE(Business_Credit.key_tradeline(), HASH(sbfe_contributor_num, contractacc_num) );
				
		// Define the output layout:
		EXPORT layout_combined := RECORD
			STRING1   segment_type; // 'B' = BusinessInformation; 'T' = Tradeline
			STRING30  Sbfe_Contributor_Num;
			STRING50  ContractAcc_Num;
			STRING30  AccHolder_BusinessName;
			STRING250	Comp_Website;
			STRING2   source;
			RECORDOF(businessinfo_redist) AND NOT [Sbfe_Contributor_Num, ContractAcc_Num, AccHolder_BusinessName, Comp_Website, source];
			RECORDOF(tradelines_redist) AND NOT [Sbfe_Contributor_Num, ContractAcc_Num, AccHolder_BusinessName, Comp_Website, source];
		END;
		
		// 1. Get unique instances of sbfe_contributor_num + contractacc_num. This is our seed data.
		// Note that we want only the BusinessInfo and Tradelines records for which there exist
		// a sbfe_contributor_num + contractacc_num tuple in Key_LinkIds().Key, since Key_LinkIds().Key
		// is the mechanism by which we conduct an SBFE search.
    EXPORT SBFE_UIDs := 
			PROJECT(
				DEDUP(
					SORT(
						TABLE(linkids_redist, {sbfe_contributor_num, contractacc_num}), 
						sbfe_contributor_num, contractacc_num, LOCAL
					),
					sbfe_contributor_num, contractacc_num, LOCAL
				), 
				TRANSFORM( layout_combined, 
					SELF.sbfe_contributor_num := LEFT.sbfe_contributor_num, 
					SELF.contractacc_num := LEFT.contractacc_num, 
					SELF := [] 
				)
			);
		
    EXPORT BusinessInfo_as_combined := 
			JOIN(
				SBFE_UIDs, businessinfo_redist, 
				LEFT.sbfe_contributor_num = RIGHT.sbfe_contributor_num AND
				LEFT.contractacc_num = RIGHT.contractacc_num, 
				TRANSFORM( layout_combined, SELF.segment_type := 'B', SELF := RIGHT, SELF := LEFT, SELF := []	),
				LOCAL
			);

		EXPORT Tradeline_as_combined := 
			JOIN(
				SBFE_UIDs, tradelines_redist, 
				LEFT.sbfe_contributor_num = RIGHT.sbfe_contributor_num AND
				LEFT.contractacc_num = RIGHT.contractacc_num, 
				TRANSFORM( layout_combined, SELF.segment_type := 'T', SELF := RIGHT, SELF := LEFT, SELF := []	),
				LOCAL
			);
		
		EXPORT BusinessInfo_Tradeline_unioned := 
			SORT( 
				(BusinessInfo_as_combined + Tradeline_as_combined), 
				sbfe_contributor_num, contractacc_num, -(UNSIGNED)(segment_type = 'B'),
				LOCAL 
			);

		EXPORT File := BusinessInfo_Tradeline_unioned; //  : PERSIST('~kel::persist::fdc::sbfe');
		
		// 4. Define index for full FDC
		EXPORT RoxieIndexName := '~kel::key::fdc::sbfe::recordid';
		EXPORT RoxieIndex := INDEX(File, { sbfe_contributor_num, contractacc_num }, { File }, RoxieIndexName);

END;
