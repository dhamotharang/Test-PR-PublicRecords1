import Prof_License_Mari,PRTE2, aid, AID_BUILD;

export layouts := MODULE

  export rFinal := RECORD
    AID_BUILD.layouts.rFinal;
  end;

	export search := RECORD
			Prof_License_Mari.layouts.final;
			string9 link_ssn;
      string8 link_dob;
      string9 link_fein;
      string8 link_inc_date;
      string10 cust_name;
      string10 bug_num;
      string20 req;
		END;  
	
	Export search_ext:=record
   search;
	 unsigned8 rawaid;
	 end;
	 
	export disp_action := RECORD
			Prof_License_Mari.Layouts.Disciplinary_Action;
			string10  cust_name;
			string10	bug_num;
	END;

	export indv_detail := RECORD
			Prof_License_Mari.Layouts.Individual_Reg;
			unsigned8 __internal_fpos__;
			string10  cust_name;
			string10	bug_num;
	END;
	
	export reg_action := RECORD
			Prof_License_Mari.Layouts.Regulatory_Action;
			string10  cust_name;
			string10	bug_num;
	END;
	
export reg_action_2 := RECORD
			Prof_License_Mari.Layouts.Regulatory_Action_Base;
	END;	
	
	export SlimRec := record,maxlength(8000)
			Prof_License_Mari.Layouts.SlimRec;
	END; 
	
	export Slim_rec_ext:=record
	slimrec;
	unsigned8 RawAID;
	end;
	
	export layout_disciplinary	:= RECORD, MAXLENGTH(8000)
 	Prof_License_Mari.Layouts.Disciplinary_Action_Base;
	end;
	
  Export Individ_Reg_Base	:=record
  		Prof_License_Mari.Layouts.Individual_Reg_Base;
	End;
 

Export slim_ssn := record
unsigned6 mari_rid;
string2		tax_type;
string9		ssn_taxid;
unsigned8 MLTRECKEY;
unsigned8 CMC_SLPK;
unsigned8 PCMC_SLPK;
end;

Export tempSlimRec := record
SlimRec;
integer cnt;
end;

Export tempSlimRec_ext := record
tempSlimRec;
  unsigned8 RawAID;
	string25 v_city_name;
	string4		cart;
	string1		cr_sort_sz;
	string4		lot;
	string1		lot_order;
	string2		dbpc;
	string1		chk_digit;
	string2		rec_type;
	string5		county;
	string10	geo_lat;
	string11	geo_long;
	string4		msa;
	string7		geo_blk;
	string1		geo_match;
	string4		err_stat;
end;


Export auto_payload := RECORD
 unsigned6 fakeid;
 SlimRec;
 END;

END;
