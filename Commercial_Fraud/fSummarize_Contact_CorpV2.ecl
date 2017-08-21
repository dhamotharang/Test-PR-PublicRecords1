import mdr,corp2;

export fSummarize_Contact_CorpV2(

	 dataset(Corp2.Layout_Corporate_Direct_Cont_Base) pCorpCont		= Prep_CorpV2.fCont()
	,dataset(Corp2.Layout_Corporate_Direct_Corp_Base) pCorp				= Prep_CorpV2.fCorp()

) :=
function
/*
	export Contact_Summary :=
	record
		unsigned8	bdid 																					;// bdid
		string		vendor_id 																		;// unique id for dataset(i.e. for corps, corp_key)
		string		source 																				;// source code
		string		contact_type  																;// 'R' = Registered Agent, 'O' = Officer
		unsigned8 Date_Last_Contact_Type_Change    							;// last time this contact's info changed
		unsigned8 Count_Contact_Changes      							;// Count of Changes to this contact title
		unsigned8 Count_bankruptcies    ;// Count of bankruptcies for this contact
		unsigned8 Count_liens_judgments ;// Count of Liens and Judgements for this contact
		unsigned8 Count_ucc_filings			;// Count of UCC filings for this contact							
		unsigned8 count_business_contacts												;// Count number of additional businesses associated with contacts
		unsigned8 count_delinquent_business_contacts						;// Count number of delinquent businesses associated with contacts
		unsigned8 count_derogatory_business_contacts						;// Count number of businesses with derogatory events associated with contacts
	end;
*/

	dcont_slim := project(pCorpCont	,transform(
		layouts.temporary.contactsummary
		,self.unique_id																				:= counter;
		 self.bdid																						:= left.bdid;
		 self.did																							:= left.did;
		 self.vendor_id																				:= left.corp_key;
		 self.source																					:= mdr.sourceTools.fcorpv2(left.corp_key,left.corp_state_origin);
		 self.contact_type																		:= 'O';	//only officers for now
		 self.Count_bankruptcies    													:= 0;
		 self.Count_liens_judgements 													:= 0;
		 self.Count_ucc_filings																:= 0;
		 self.fname 																					:= left.cont_fname;
		 self.mname 																					:= left.cont_mname;
		 self.lname 																					:= left.cont_lname;
		 self.name_hash																				:= hash64(left.cont_fname,left.cont_lname,left.cont_mname);
		 self.contact_title																		:= left.cont_title_desc;
		 self.dt_first_seen	    															:= left.dt_first_seen	;
		 self.dt_last_seen	    															:= left.dt_last_seen	;
		 
		 self.current_contact_change													:= false;
		 self.Date_Last_Contact_Type_Change    								:= 0;	// figure these out later
		 self.Count_Contact_Changes      											:= 0;
		 self.Date_Last_Contact_Filing												:= left.dt_last_seen;
	))(fname != '',lname != '');
	
	dcont_dist	:= distribute(dcont_slim,hash64(vendor_id));
	
	dcont_sort	:= sort	(dcont_dist,source,vendor_id,contact_type, contact_title,-dt_last_seen,name_hash,local);
	dcont_group := group(dcont_sort,source,vendor_id,contact_type, contact_title,local);
	
	dcont_type_changes1 := table(dcont_group				,{source,vendor_id,contact_type, contact_title},source,vendor_id,contact_type, contact_title,name_hash,local);
	dcont_type_changes2 := group(table(dcont_type_changes1,{source,vendor_id,contact_type, contact_title,unsigned8 cnt := count(group)},source,vendor_id,contact_type, contact_title,local));
	
	dcont_iterate := group(iterate(dcont_group
		,transform(
			 recordof(dcont_group)
			,
			  self.Date_Last_Contact_Type_Change := if(	(			counter > 1 
																										and left.name_hash != right.name_hash
																									)
																										and left.Date_Last_Contact_Type_Change = 0
																									,right.dt_last_seen
																									,left.Date_Last_Contact_Type_Change
																							);
			 self := right;
		
		
		)
	));
	
	dcont_get_type_changes := join(
		 distribute(dcont_iterate				,hash64(vendor_id))
		,distribute(dcont_type_changes2 ,hash64(vendor_id))
		,			left.source					= right.source
		 and 	left.vendor_id			= right.vendor_id
		 and	left.contact_type		= right.contact_type
		 and	left.contact_title	= right.contact_title
		,transform(
			recordof(dcont_iterate)
			,self.Count_Contact_Changes := if(right.cnt != 0, right.cnt - 1, 0);
			 self := left;
		)
		,local
	);
	
	dcont_curr_contact_change := project(dcont_get_type_changes,transform(recordof(dcont_iterate)
			 ,self.current_contact_change					:= if(left.Date_Last_Contact_Filing = left.Date_Last_Contact_Type_Change,true,false);
			  self := left;
	));
	
	dcorp_sort_return := sort(dcont_curr_contact_change,vendor_id)
		: persist(persistnames().fSummarizeContactCorpV2);

	return dcorp_sort_return;
	
end;