import ut, Business_Header, Business_Header_SS, did_add,lib_stringlib,idl_header;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_5610_Demographic_Data_In;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Map the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_5610_Demographic_Data_Base Convert2Base(File_in l, integer cnt) := 
transform
	self.date_first_seen							 	:= '';
	self.date_last_seen 								:= self.date_first_seen;
	self.PROFIT_RANGE_ACTUAL 						:= if( lib_stringlib.StringLib.StringFilter(l.PROFIT_RANGE_ACTUAL,'{') != '',lib_stringlib.StringLib.StringFilterOut(l.PROFIT_RANGE_ACTUAL,'{'),l.PROFIT_RANGE_ACTUAL);
	self.NET_WORTH_ACTUAL    						:= if( lib_stringlib.StringLib.StringFilter(l.NET_WORTH_ACTUAL,'{') != '',lib_stringlib.StringLib.StringFilterOut(l.NET_WORTH_ACTUAL,'{'),l.NET_WORTH_ACTUAL);
	self.OFFICER_TITLE									:= choose(cnt, l.OFFICER_TITLE_1, 		l.OFFICER_TITLE_2, 		l.OFFICER_TITLE_3);
	self.OFFICER_FIRST_NAME							:= choose(cnt, l.OFFICER_FIRST_NAME_1,	l.OFFICER_FIRST_NAME_2, 	l.OFFICER_FIRST_NAME_3);
	self.OFFICER_M_I										:= choose(cnt, l.OFFICER_M_I_1, 		l.OFFICER_M_I_2, 		l.OFFICER_M_I_3);
	self.OFFICER_LAST_NAME							:= choose(cnt, l.OFFICER_LAST_NAME_1, 	l.OFFICER_LAST_NAME_2, 	l.OFFICER_LAST_NAME_3);
	self.clean_officer_name.title 			:= choose(cnt, l.clean_officer_name_1.title, l.clean_officer_name_2.title, l.clean_officer_name_3.title);
	self.clean_officer_name.fname 			:= choose(cnt, l.clean_officer_name_1.fname, l.clean_officer_name_2.fname, l.clean_officer_name_3.fname);
	self.clean_officer_name.mname 			:= choose(cnt, l.clean_officer_name_1.mname, l.clean_officer_name_2.mname, l.clean_officer_name_3.mname);
	self.clean_officer_name.lname 			:= choose(cnt, l.clean_officer_name_1.lname, l.clean_officer_name_2.lname, l.clean_officer_name_3.lname);
	self.clean_officer_name.name_suffix := choose(cnt, l.clean_officer_name_1.name_suffix, l.clean_officer_name_2.name_suffix, l.clean_officer_name_3.name_suffix);
	self.clean_officer_name.name_score  := choose(cnt, l.clean_officer_name_1.name_score, l.clean_officer_name_2.name_score, l.clean_officer_name_3.name_score);
	self.process_date_first_seen				:= (unsigned4)l.process_date;
	self.process_date_last_seen					:= self.process_date_first_seen;
	self.record_type										:= 'C';	
	self 																:= l;
	self																:= [];
end;

File_in2base := normalize(File_in, 3, Convert2Base(left, counter));

ut.mac_flipnames(File_in2base,clean_officer_name.fname,clean_officer_name.mname,clean_officer_name.lname,dFlippedNames);	

export BDID_5610_Demo_Input_Norm :=  dFlippedNames;