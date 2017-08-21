import Prof_License_Mari;

export layouts := MODULE
	
	export search := RECORD
			Prof_License_Mari.layouts.final;
			string50  cust_name;
			string10	bug_name;
	END;  		

	export disp_action := RECORD
			Prof_License_Mari.Layouts.Disciplinary_Action;
			string50  cust_name;
			string10	bug_name;
	END;
	
	export indv_detail := RECORD
			Prof_License_Mari.Layouts.Individual_Reg;
			string50  cust_name;
			string10	bug_name;
	END;
	
	export reg_action := RECORD
			Prof_License_Mari.Layouts.Regulatory_Action;
			string50  cust_name;
			string10	bug_name;
	END;
	
	export SlimRec := record,maxlength(8000)
			Prof_License_Mari.Layouts.SlimRec;
	END;      

END;
