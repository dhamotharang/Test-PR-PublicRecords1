EXPORT Layout_Combined := MODULE
	
	EXPORT Layout_Relationship := RECORD
    UNSIGNED6 DID;
		STRING20  attr_lname;
		STRING10  attr_prim_range;
		STRING28  attr_prim_name;
		STRING8   attr_sec_range;
		STRING25  attr_city;
		STRING2   attr_st;  
		UNSIGNED4 attr_dt_first_seen;
		UNSIGNED4 attr_dt_last_seen;
		string2   rectype;    
		IFBLOCK(self.rectype = constants.lien)
		  STRING50 ln_tmsid;
		  STRING50 ln_rmsid;
		  STRING1  ln_name_type;
	  END;
		IFBLOCK(self.rectype = constants.bankruptcy)
		  STRING25 bk_tmsid;
		  STRING1  bk_name_type;
		END;
		IFBLOCK(self.rectype = constants.vehicle)
		  STRING30 vh_Vehicle_Key;
		  STRING15 vh_Iteration_Key;
		  STRING15 vh_Sequence_Key;	
		END;
		IFBLOCK(self.rectype = constants.foreclosure)
		  STRING70 fo_foreclosure_id;
			STRING1  fo_name_type;
		END;
		IFBLOCK(self.rectype = constants.property)
      STRING12 pr_ln_fares_id;
		  STRING2  pr_source_code;
		END;
		IFBLOCK(self.rectype = constants.utility)
		  STRING15 ut_ID;
		END;
		IFBLOCK(self.rectype = constants.experian)
		  UNSIGNED xp_seq_rec_id;	
		END;
		IFBLOCK(self.rectype = constants.businessassociates)
		 unsigned6 ba_bdid;	
		END;
		IFBLOCK(self.rectype = constants.transunion)
		  STRING18 tu_vendor_id;	
		END;
		IFBLOCK(self.rectype = constants.enclarity)
		  STRING38 en_billing_group_key;	
			STRING20 en_addr_key;
		END;
		IFBLOCK(self.rectype = constants.watercraft)
		  STRING30 wc_watercraft_key;
			STRING30 wc_sequence_key;
			STRING2  wc_state_origin;
			STRING2  wc_source_code;
		END;
		IFBLOCK(self.rectype = constants.aircraft)
		  STRING8  ac_n_number;
			STRING15 ac_cert_issue_date;
		END;
		//IFBLOCK(self.rectype = constants.ChargebackDefender)
		//	string	Transaction_ID;
	  //  string	Sequence_Number;
		//END;
		IFBLOCK(self.rectype = constants.marriagedivorce)
		  unsigned6 md_record_id;
		END;
		IFBLOCK(self.rectype = constants.ucc)
		  string31 uc_tmsid;
			string23 uc_rmsid;
		END;
  END;
	
END;