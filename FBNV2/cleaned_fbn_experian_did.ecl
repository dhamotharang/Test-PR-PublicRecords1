
import  DID_Add, Business_Header_SS,Business_Header, ut,Header_Slimsort;

matchSet := ['A','P'];

DID_Add.MAC_Match_Flex             // regular did macro
		(cleaned_fbn_experian_contact, matchSet, '',
		 '', fname, mname, lname, name_suffix,
		 Contact_prim_range, Contact_prim_name, Contact_sec_range, Contact_zip5, Contact_st,Officer_phone ,
		 DID,
		 Layout_fbn_experian.DID_Rec,
		 true, did_score,
		 75,                      //dids with a score below here will be dropped
		 outDID				
		)
		export cleaned_fbn_experian_did  :=outDID :persist(cluster.cluster_out+'persist::FBNV2::CleanedFBN_Experian_did');





