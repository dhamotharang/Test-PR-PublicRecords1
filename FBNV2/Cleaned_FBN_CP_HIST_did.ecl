import  DID_Add, Business_Header_SS,Business_Header, ut,Header_Slimsort;
DID_Rec := record,maxlength(10000000)
	unsigned6	DID	:= 0;
	unsigned6	did_score:= 0;
	Layout_FBN_CP_HIST.Layout_Slim_Clean_Cont;
end;


DID_Rec DIDs(Layout_FBN_CP_HIST.Layout_Slim_Clean_Cont l) := transform
	self.DID := 0;
	self.did_score:=0;
	self := l;
end;

common_in := project(cleaned_FBN_CP_HIST_Contact, DIDs(left));

matchSet := ['A','P'];

DID_Add.MAC_Match_Flex             // regular did macro
		(common_in, matchSet, '',
		 '', fname, mname, lname, name_suffix,
		 Contact_prim_range, Contact_prim_name, Contact_sec_range, Contact_zip5, Contact_st, Officer_phone,
		 DID,
		 DID_rec,
		 true, did_score,
		 75,                      //dids with a score below here will be dropped
		 postDID				
		)
		export Cleaned_FBN_CP_HIST_did  := postDID :persist(cluster.cluster_out+'persist::FBNV2::CP_HIST_did');
