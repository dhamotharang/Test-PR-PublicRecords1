//	Summary:			Layouts for the PRTE DEA process based originally from the DEA module

IMPORT BIPV2,dea;
EXPORT layouts := MODULE
  Export working_layout := record
	  integer fpos;
		unsigned6 my_did;  							
		unsigned6 bd;   							
		string50  cust_name;
		string10	bug_num;
		string8   link_dob;
		string9		link_ssn;
		string9		link_fein;
		STRING8 	link_inc_date;
	end;
	EXPORT layout_DEA_In 			:= dea.Layout_DEA_OUT_baseV2 or working_layout;
	EXPORT layout_DEA_Out_Base 		:= dea.Layout_DEA_OUT_base;
	
	EXPORT layout_DEA_Out_Base_2 		:= dea.Layout_DEA_OUT_base-[xadl2_weight,xadl2_score,xadl2_distance,xadl2_keys_used, xadl2_keys_desc, xadl2_matches,xadl2_matches_desc];

	EXPORT layout_DEA_Out 			:= dea.layout_DEA_Out;
	EXPORT layout_DEA_Out_BaseV2 	:= dea.Layout_DEA_OUT_baseV2 or working_layout;
 
	//EXPORT Layout					:= dea.Layout;
	EXPORT full_layout := RECORD
		dea.Layout_DEA_In_Modified;
		STRING18 county_name := '';
		STRING12 did;
		STRING3  score;
		STRING9  best_ssn;
		STRING12 bdid;
	END;
	EXPORT slim_layout := record
        String9	Dea_Registration_Number;
		unsigned8    lnpid;
	END;
	
END;