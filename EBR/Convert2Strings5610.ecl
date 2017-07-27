//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert2Strings() function
// -- Pass it the segment code(ex, '0010') and the output file
// -- it will convert the binary fields to strings
//////////////////////////////////////////////////////////////////////////////////////////////
import ut, Business_Header, Business_Header_SS, did_add, address;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Input Files
//////////////////////////////////////////////////////////////////////////////////////////////
File_Base := ebr.File_5610_Demographic_Data_Base;

Layout_New_Base := 
record
	ebr.Layout_Base_ASCII;
	string12	did		:= '';
	string3	did_score	:= '';
	string9	ssn		:= '';
	string8	process_date;
	string10	FILE_NUMBER;
	string4	SEGMENT_CODE;
	string5	SEQUENCE_NUMBER;
	string2	FISCAL_YR_END_MM;
	string1	PROFIT_RANGE_CODE;
	string25	PROFIT_RANGE_DESC;
	string7	PROFIT_RANGE_ACTUAL;
	string1	NET_WORTH_CODE;
	string25	NET_WORTH_DESC;
	string7	NET_WORTH_ACTUAL;
	string4	IN_BLDNG_SINCE_YY;
	string1	OWN_OR_RENT_CODE;
	string7	BLDNG_SQUARE_FEET;
	string7	ACTIVE_CUST_COUNT;
	string1	OWNERSHIP_CODE;
	string20	OWNERSHIP_DESC;
	string31	CORP_NAME;
	string20	CORP_CITY;
	string2	CORP_STATE_CODE;
	string20	CORP_STATE_DESC;
	string10	CORP_PHONE;
	string10	OFFICER_TITLE;
	string10	OFFICER_FIRST_NAME;
	string1	OFFICER_M_I;
	string20	OFFICER_LAST_NAME;
	address.Layout_Clean_Name clean_officer_name;
	string1 lf;
end;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert binary fields to strings
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_New_Base t2strings(Layout_5610_Demographic_Data_Base l) := 
transform
	self.bdid 				:= if (l.bdid = 0,'',intformat(l.bdid, 12, 1));
	self.date_first_seen		:= l.date_first_seen;
	self.date_last_seen 		:= l.date_last_seen;
	self.process_date_first_seen	:= intformat(l.process_date_first_seen,8,1);
	self.process_date_last_seen 	:= intformat(l.process_date_last_seen,8,1);
	self.record_type			:= l.record_type;
	self.did					:= intformat(l.did,12,1);
	self.did_score				:= intformat(l.did_score,3,1);
	self.ssn					:= intformat(l.ssn,9,1);
	self.lf					:= '\n';
	self 					:= l;
end;

export Convert2Strings5610 := project(File_Base, t2strings(left));