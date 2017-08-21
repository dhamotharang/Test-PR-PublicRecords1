
export fn_GetInputRecLength(string updatetype,string state) := 
	map(
	    updatetype = 'MAR' and state='TX'	=> 0,
			updatetype = 'DIV' and state='TX'	=> 0, 
			updatetype = 'MAR' and state='NC'	=> sizeof(Layout_Marriage_NC_In), 
		  updatetype = 'DIV' and state='NC'	=> sizeof(Layout_Divorce_NC_In), 
			updatetype = 'MAR' and state='KY'	=> sizeof(Layout_Marriage_KY_In), 
			updatetype = 'DIV' and state='KY'	=> sizeof(Layout_Divorce_KY_In), 
			updatetype = 'MAR' and state='CA'	=> sizeof(Layout_Marriage_CA_In), 
			updatetype = 'MAR' and state='MI'	=> 0,
			updatetype = 'MAR' and state='OH'	=> sizeof(Layout_Marriage_OH_In), 
			updatetype = 'DIV' and state='OH'	=> sizeof(Layout_Divorce_OH_In), 
			updatetype = 'MAR' and state='NV'	=> sizeof(Layout_Marriage_NV_In), 
		  updatetype = 'DIV' and state='NV'	=> sizeof(Layout_Divorce_NV_In), 
		0);



