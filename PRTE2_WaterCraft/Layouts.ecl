/********************************************************************************************************** 
	Name: 			Layouts
	Created On: 06/10/2013
	By: 				ssivasubramanian
	Desc: 			Holds all layouts of different datasets/record sets used within PRTE watercraft build process. 
***********************************************************************************************************/
IMPORT Watercraft, PRTE2_Watercraft, AID_BUILD;

EXPORT Layouts := MODULE

EXPORT AID_LAYOUT := AID_BUILD.layouts.rFinal;
	
EXPORT Incoming_Boca	:= RECORD
		Watercraft.Layout_Scrubs.Main_Base - [global_sid, record_sid];
		Watercraft.Layout_Watercraft_Search_Base - [watercraft_key,	sequence_key,	state_origin, source_code, history_flag, persistent_record_id, global_sid, record_sid];
		Watercraft.Layout_Watercraft_Coastguard_Base - [watercraft_key,	sequence_key,	state_origin, source_code, persistent_record_id, global_sid, record_sid];
		STRING10	bug_num;
		STRING20	cust_name;
		STRING8		link_inc_date;
		STRING9		link_fein;
		STRING8		link_dob;
		STRING9		link_ssn;
	END;	
	
	EXPORT Base_Boca	:= RECORD
		Watercraft.Layout_Scrubs.Main_Base;
		Watercraft.Layout_Watercraft_Search_Base - [watercraft_key,	sequence_key,	state_origin, source_code, history_flag, persistent_record_id];
		Watercraft.Layout_Watercraft_Coastguard_Base - [watercraft_key,	sequence_key,	state_origin, source_code, persistent_record_id];
		STRING10	bug_num;
		STRING20	cust_name;
		STRING8		link_inc_date;
		STRING9		link_fein;
		STRING8		link_dob;
		STRING9		link_ssn;
	END;
	
	/*****************************************************************************
		Using existing base layouts plus custom fields, for easier maintenance and 
		easier to combine both Alpharetta and Boca data
	*****************************************************************************/
	EXPORT Base_new				:= RECORD
		Watercraft.Layout_Watercraft_Main_Base - [persistent_record_id];
		Watercraft.Layout_Watercraft_Search_Base - [source_code, history_flag, persistent_record_id];
		Watercraft.Layout_Watercraft_Coastguard_Base - source_code;
		//Alpharetta base file fields
		STRING2 	source_code_Search; 
		STRING2 	source_code_CG;			
		STRING1 	history_flag_Search;
		//Boca file fields
		STRING10	bug_num;
		STRING20	cust_name;
		STRING8		link_inc_date;
		STRING9		link_fein;
		STRING8		link_dob;
		STRING9		link_ssn;
	END;
	
	/***************************************************************************** 
		The following are the 3 different layouts of the source files for the keys. 
		The files are Main, Search and CoastGuard.
	*****************************************************************************/
	EXPORT Main 		:= RECORD
		Watercraft.Layout_Watercraft_Main_Base;
	END;

	EXPORT Search 	:= RECORD
		Watercraft.Layout_Watercraft_Search_Base;
	END;
	 
	EXPORT Coastguard 	:= RECORD
		Watercraft.Layout_Watercraft_Coastguard_Base;
	END;


	/*****************************************************************************
		Other layouts used for building keys, intermediate files
	*****************************************************************************/
  EXPORT Search_Slim 	:= RECORD
		Watercraft.Layout_Watercraft_Search_Base_slim;
  END;

	EXPORT Exclusions 	:= RECORD
			UNSIGNED8 RawAID;
			STRING100 Reg_Owner_Name_2; 
	END; 

END;