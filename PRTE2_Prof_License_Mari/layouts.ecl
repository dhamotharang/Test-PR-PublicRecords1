﻿import Prof_License_Mari,PRTE2;

export layouts := MODULE
	
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
	// Export Search2:=RECORD
	// search;
	// PRTE2.Layouts.DEFLT_CPA;
	// end;
	

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
	
	export SlimRec := record,maxlength(8000)
			Prof_License_Mari.Layouts.SlimRec;
	END; 
	
	export layout_disciplinary	:= RECORD, MAXLENGTH(8000)
  disp_action - [cust_name,bug_num];
	end;

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

Export auto_payload := RECORD
 unsigned6 fakeid;
 SlimRec;
 END;

END;
