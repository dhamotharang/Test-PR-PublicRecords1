import address;

export Layouts := module
	
	export EmailWithUidPatternTagAndCount := RECORD
			unsigned8									Domain_Freq 						:= 1;
			real8		 									Uid_Pattern_Portion 		:= 0;
			real8		 									Blk_Uid_Pattern_Portion := 0;
			boolean 									is_Potential_POE 		:= false;
			string25 									Uid_Pattern_Tag							;
			unsigned8									Uid_Pattern_Freq				 :=1;
			unsigned8 								email_rec_key								;
			string2 									email_src										;
			string100 								append_email_username				;
			string100 								append_domain								;
			string200 								clean_email									;
			string30									orig_first_name							;
			string30									orig_last_name							;
			Address.Layout_Clean_Name Pname												;
			string9 									best_ssn										;
			unsigned4									best_dob										;
			Address.Layout_clean_125 	Person_addr				    			;
			string10 									person_addr_geo_lat					;
			string11 									person_addr_geo_long				;
			unsigned8 								append_rawaid								;
			string8 									date_first_seen							;
			string8 									date_last_seen							;			
	END;
	
	export EmailsWithRegistrantInfo := RECORD
			unsigned6							 		bdid := 0;
			string46	 						 		registrant_name				:='';
			string45	 						 		registrant_address1		:='';
			string45	 								registrant_address2		:='';
			string45	 						 		registrant_address3		:='';
			string45	 						 		registrant_address4		:='';
			string45	 						 		registrant_address5		:='';
			string45	 						 		registrant_address6		:='';
			string45	 						 		registrant_address7		:='';
			string45	 						 		registrant_address8		:='';
			string45	 						 		registrant_address9		:='';
			string45	 						 		registrant_address10	:='';
			string8		 						 		domain_date_last_seen :='';
			EmailWithUidPatternTagAndCount;
	END;
	
	export AllDataForAllBdidsRec := RECORD
			unsigned8 								bh_rec_key 					:= 0;
			unsigned8									bdid			 					:= 0;
			unsigned8 								group_id 	 					:= 0;
			unsigned8 								agrp_bdid								;
			string120  								bh_company_name					;
			unsigned6 								bh_phone								;
			Address.Layout_clean_slim	bh_Company_addr					;
			string10 									bh_Company_addr_geo_lat	;
			string11 									bh_Company_addr_geo_long;
			unsigned8 								bh_rawaid								;
	END;

	
	////////////////////////////////////////////////////////////////////////
	// -- Common Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Common := record 
//			unsigned8									raw_aid							:= 0;
//			unsigned8									ace_aid							:= 0;
			unsigned4 								date_first_seen					;	
			unsigned4 								date_last_seen					;
			string200 								clean_email							;
			string2 									email_src								;
			real8 										distance								;
			Address.Layout_Clean_Name Pname										;
			string9 									best_ssn								;
			unsigned4									best_dob								;
			Address.Layout_clean_125 	Person_addr				    	;
			string10 									person_addr_geo_lat			;
			string11 									person_addr_geo_long		;
			unsigned8 								append_rawaid						;
			
			unsigned8 								bh_rec_key							;
			string120  								bh_company_name					;
			unsigned6 								bh_phone								;
			Address.Layout_clean_slim	bh_Company_addr					;
			string10 									bh_Company_addr_geo_lat	;
			string11 									bh_Company_addr_geo_long;
			unsigned8 								bh_rawaid								;
	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layout
	////////////////////////////////////////////////////////////////////////
	export Base := record 
		unsigned6						Did				:= 0;
		unsigned6						Bdid			:= 0;
		unsigned6 					group_id			;
		unsigned6 					agrp_bdid			;
		Common														;
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layout
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=
	record
		Base;
	end;

end;