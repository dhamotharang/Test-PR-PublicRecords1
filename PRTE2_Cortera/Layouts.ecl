IMPORT PRTE2_Cortera, cortera;

EXPORT Layouts := MODULE
  
  EXPORT Attributes := Cortera.Layout_Attributes;
  
  EXPORT Header_out := RECORD
  Cortera.Layout_Header_out; 
  END;
  
  EXPORT Attributes_Out := RECORD
  Cortera.Layout_Attributes_Out; 
  END;
  
  EXPORT rlayout := RECORD, MAXLENGTH(62766)
	cortera.Layout_Header_Out;
	STRING9 link_fein;	
	STRING8 link_inc_date;	
	STRING9 executive1_link_ssn;	
	STRING8 executive1_link_dob;
	STRING9 executive2_link_ssn;	
	STRING8 executive2_link_dob;	
	STRING9 executive3_link_ssn;	
	STRING8 executive3_link_dob;	
	STRING9 executive4_link_ssn;	
	STRING8 executive4_link_dob;	
	STRING9 executive5_link_ssn;	
	STRING8 executive5_link_dob;	
	STRING9 executive6_link_ssn;	
	STRING8 executive6_link_dob;	
	STRING9 executive7_link_ssn;	
	STRING8 executive7_link_dob;	
	STRING9 executive8_link_ssn;	
	STRING8 executive8_link_dob;	
	STRING9 executive9_link_ssn;	
	STRING8 executive9_link_dob;	
	STRING9 executive10_link_ssn;	
	STRING8 executive10_link_dob;	
	INTEGER order;	
	UNSIGNED8 contact_lexid;
	cortera.layout_attributes;
	STRING10 cust_name;
	STRING10 bug_num;
  END;
  
  EXPORT base := RECORD 
  rlayout - attributes;
  END;

END;