import ut;

export Rollup_Base(dataset(Layouts.KeyBuild) pDataset) := function
		
		filter_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

		//This transform removes special characters from the Business fields.  Some input
		//datasets do not have special characters in the fields.  This is done before the 
		//rollup occurs.
		Layouts.Roll_Up trFileToRollUp(Layouts.KeyBuild l) := transform
			self.Rollup_Business_Name							:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Business_Name,filter_string));
			self.Rollup_Business_Acronym					:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Business_Acronym,filter_string));					
			self.Rollup_Business_Address1					:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Business_Address1,filter_string));	
			self.Rollup_Clean_Business_Address2		:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Clean_Business_Address2,filter_string));	
			self.Rollup_Clean_Business_City				:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Clean_Business_City,filter_string));	
			self.Rollup_Business_Phone_No					:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Business_Phone_No,filter_string));	
			self.Rollup_Business_Clean_Phone_No		:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Business_Clean_Phone_No,filter_string));	
			self.Rollup_Business_Fax_No						:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Business_Fax_No,filter_string));	
			self.Rollup_Business_Clean_Fax_No			:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Business_Clean_Fax_No,filter_string));	
			self.Rollup_ISO_Committee_Reference		:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.ISO_Committee_Reference,filter_string));	
			self.Rollup_ISO_Committee_Title				:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.ISO_Committee_Title,filter_string));	
			self.Rollup_ISO_Committee_Type				:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.ISO_Committee_Type,filter_string));	
			self                									:= l;
		end;

		Layouts.Roll_Up RollupUpdate(Layouts.Roll_Up l, Layouts.Roll_Up r) := transform
			self.Date_FirstSeen	:=	ut.EarliestDate(
																						ut.EarliestDate(l.Date_FirstSeen, r.Date_FirstSeen),
																						ut.EarliestDate(l.Date_LastSeen, r.Date_LastSeen)
																			  		);
			self.Date_LastSeen	:=	max(l.Date_LastSeen,r.Date_LastSeen);
			self.Date_Added			:=	(string)ut.EarliestDate(
																						ut.EarliestDate((unsigned6)l.Date_Added, (unsigned6)r.Date_Added),
																						ut.EarliestDate((unsigned6)l.Date_Updated, (unsigned6)r.Date_Updated)
																			  		);
			self.Date_Updated		:=	(string)max((unsigned6)l.Date_Updated,(unsigned6)r.Date_Updated);
			self                := l;
		end;

		//This transform slims down the dataset from the RollUp structure to the 
		//KeyBuild structure.
		Layouts.KeyBuild trRollUpToKeyBuild(Layouts.Roll_Up l) := transform
			self := l;
		end;
		
		//This project takes the KeyBuild file and creates a new file where
		//the dataset has new "RollUp" fields.  These fields have all the 
		//punctuation removed since some of the files are missing punctuation.
		dProjToRollup		:=	project(pDataset, trFileToRollUp(left));
	
		//This sort will sort on the "RollUp" fields and the other fields where
		//there is not a punctuation issue.
		pDataset_sort	:=	sort(	dProjToRollup,
														except
															 Business_Name
															,Business_Acronym
															,Business_Address1
															,Business_Address2
															,Clean_Business_Address2
															,Business_City
															,Clean_Business_City		
															,Business_Phone_No
															,Business_Clean_Phone_No
															,Business_Fax_No
															,Business_Clean_Fax_No
															,ISO_Committee_Reference
															,ISO_Committee_Title
															,ISO_Committee_Type
															,Date_FirstSeen
															,Date_lastSeen
															,Date_Added
															,Date_Updated
															,Append_MailAddress1
															,Append_MailAddressLast
															,Append_MailRawAID
															,Append_MailAceAID
															,m_prim_range 
															,m_predir
															,m_prim_name	
															,m_addr_suffix 
															,m_postdir
															,m_unit_desig	
															,m_sec_range	
															,m_p_city_name	
															,m_v_city_name 
															,m_st
															,m_zip	
															,m_zip4
															,m_cart	
															,m_cr_sort_sz	
															,m_lot	
															,m_lot_order	
															,m_dbpc
															,m_chk_digit	
															,m_rec_type	
															,m_fips_state	
															,m_fips_county	
															,m_geo_lat
															,m_geo_long	
															,m_msa
															,m_geo_blk
															,m_geo_match
															,m_err_stat																	
													);	

		//This rollup process will rollup on all the "RollUp" fields and the other 
		//fields where punctuation is not an issue.
		pDataset_rollup := rollup( 	pDataset_sort,
																RollupUpdate(left, right),
																record,
																except 
																		Business_Name
																	 ,Business_Acronym
																	 ,Business_Address1	
																	 ,Business_Address2
																	 ,Clean_Business_Address2
																	 ,Business_City
																	 ,Clean_Business_City		
																	 ,Business_Phone_No
																	 ,Business_Clean_Phone_No
																	 ,Business_Fax_No
																	 ,Business_Clean_Fax_No
																	 ,ISO_Committee_Reference
																	 ,ISO_Committee_Title
																	 ,ISO_Committee_Type
																	 ,Date_FirstSeen
																	 ,Date_lastSeen
																	 ,Date_Added
																	 ,Date_Updated
									  							 ,Append_MailAddress1
																	 ,Append_MailAddressLast
																	 ,Append_MailRawAID
																   ,Append_MailAceAID
																	 ,m_prim_range 
																	 ,m_predir
																	 ,m_prim_name	
																	 ,m_addr_suffix 
																	 ,m_postdir	
																	 ,m_unit_desig	
																	 ,m_sec_range	
																	 ,m_p_city_name	
																	 ,m_v_city_name 
																	 ,m_st
																	 ,m_zip	
																	 ,m_zip4
																	 ,m_cart	
																	 ,m_cr_sort_sz	
																	 ,m_lot	
																	 ,m_lot_order	
																	 ,m_dbpc
																	 ,m_chk_digit	
																	 ,m_rec_type	
																	 ,m_fips_state	
																	 ,m_fips_county	
																	 ,m_geo_lat
																	 ,m_geo_long	
																	 ,m_msa
																	 ,m_geo_blk
																	 ,m_geo_match
																	 ,m_err_stat																			 
																);

		//This project slims down the dataset from the RollUp structure to the 
		//KeyBuild structure.
		dRolledUpBase		:=	project(pDataset_rollup, trRollUpToKeyBuild(left));

		return dRolledUpBase;
end;
