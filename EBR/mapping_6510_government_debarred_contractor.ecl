import EBR,ut,lib_stringlib,doxie,address,lib_fileservices;

export mapping_6510_government_debarred_contractor(string filedate) := function

File_6510_government_debarred_contractor := EBR.File_Sprayed_Input(segment_code = '6510');

Layout_6510_debarred_contractor_payment_tmp :=	record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string6		DATE_FILED_YYMMDD;
	string6		DATE_REPORTED_YYMMDD;
	string2		ACTION_CODE;
	string10	ACTION_DESC;
	string40	CO_BUS_NAME;
	string30	CO_BUS_ADDRESS;
	string13	CO_BUS_CITY;
	string2		CO_BUS_STATE_CODE;
	string20	CO_BUS_STATE_DESC;
	string5		CO_BUS_ZIP;
	string15	EXTENT_OF_ACTION;
	string5		AGENCY_CODE;
	string40	AGENCY_DESC;
	string1		DISPUTE_IND;
	string2		DISPUTE_CODE;
end;

rec := record
	string503 allcat;
end;

rec ebr_6510(File_6510_government_debarred_contractor le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_6510_prj := project(File_6510_government_debarred_contractor,ebr_6510(LEFT));

Layout_6510_debarred_contractor_payment_tmp ebr_6510_trans(ebr_6510_prj le) := transform
	self.FILE_NUMBER					:= le.allcat[1..10];   
	self.SEGMENT_CODE					:= le.allcat[11..14];   
	self.SEQUENCE_NUMBER			:= le.allcat[15..19];   
	self.DATE_FILED_YYMMDD		:= le.allcat[26..31];   
	self.DATE_REPORTED_YYMMDD	:= le.allcat[32..37];   
	self.ACTION_CODE					:= le.allcat[38..39];   
	self.ACTION_DESC					:= le.allcat[40..49];   
	self.CO_BUS_NAME					:= le.allcat[50..89];   
	self.CO_BUS_ADDRESS				:= le.allcat[90..119];   
	self.CO_BUS_CITY					:= le.allcat[120..132];   
	self.CO_BUS_STATE_CODE		:= le.allcat[133..134];   
	self.CO_BUS_STATE_DESC		:= le.allcat[135..154];   
	self.CO_BUS_ZIP						:= le.allcat[155..159];   
	self.EXTENT_OF_ACTION			:= le.allcat[160..174];   
	self.AGENCY_CODE					:= le.allcat[175..179];   
	self.AGENCY_DESC					:= le.allcat[180..219];   
	self.DISPUTE_IND					:= le.allcat[220];   
	self.DISPUTE_CODE					:= le.allcat[221..222];   
end;

File_6510_layout := project(ebr_6510_prj,ebr_6510_trans(LEFT));

Layout_6510_government_deb_contr :=	record
	string8		process_date;
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string6		orig_DATE_FILED_YYMMDD;
	string6		orig_DATE_REPORTED_YYMMDD;
	string2		ACTION_CODE;
	string10	ACTION_DESC;
	string40	CO_BUS_NAME;
	string30	CO_BUS_ADDRESS;
	string13	CO_BUS_CITY;
	string2		CO_BUS_STATE_CODE;
	string20	CO_BUS_STATE_DESC;
	string5		CO_BUS_ZIP;
	string15	EXTENT_OF_ACTION;
	string5		AGENCY_CODE;
	string40	AGENCY_DESC;
	string1		DISPUTE_IND;
	string2		DISPUTE_CODE;
	string8		date_filed;
	string8		date_reported;
	string73	clean_business_name;
end;

Layout_6510_government_deb_contr ebr_6510_tmp(File_6510_layout l) := transform
	self.orig_DATE_FILED_YYMMDD			:= l.DATE_FILED_YYMMDD;
	self.orig_DATE_REPORTED_YYMMDD	:= l.DATE_REPORTED_YYMMDD;
	self.date_filed									:= if( l.DATE_FILED_YYMMDD[1..2] > '50','19'+l.DATE_FILED_YYMMDD[1..2]+l.DATE_FILED_YYMMDD[3..4]+l.DATE_FILED_YYMMDD[5..6],'20'+l.DATE_FILED_YYMMDD[1..2]+l.DATE_FILED_YYMMDD[3..4]+l.DATE_FILED_YYMMDD[5..6]);
	self.date_reported							:= if( l.DATE_REPORTED_YYMMDD[1..2] > '50','19'+l.DATE_REPORTED_YYMMDD[1..2]+l.DATE_REPORTED_YYMMDD[3..4]+l.DATE_REPORTED_YYMMDD[5..6],'20'+l.DATE_REPORTED_YYMMDD[1..2]+l.DATE_REPORTED_YYMMDD[3..4]+l.DATE_REPORTED_YYMMDD[5..6]);
	self.clean_business_name 				:= if(ut.IsCompany(lib_stringlib.StringLib.StringtoUpperCase(l.CO_BUS_NAME)) = false and Address.CleanPersonLFM73(l.CO_BUS_NAME)[71..73] > '75',Address.CleanPersonLFM73(l.CO_BUS_NAME),'');
	self.process_date 							:= filedate;
	self 														:= l;
end;

ebr_6510_debr_contractor := project(File_6510_layout,ebr_6510_tmp(LEFT));

EBR.Layout_6510_government_debarred_contractor_In_AID ebr_6510_government_debarred_contractor_tr(ebr_6510_debr_contractor le) := transform
	self.clean_business_name.title				:=	le.clean_business_name[1..5];
	self.clean_business_name.fname				:=	le.clean_business_name[6..25];
	self.clean_business_name.mname				:=	le.clean_business_name[26..45];
	self.clean_business_name.lname				:=	le.clean_business_name[46..65];
	self.clean_business_name.name_suffix	:=	le.clean_business_name[66..70];
	self.clean_business_name.name_score		:=	le.clean_business_name[71..73];
	self.process_date											:=	le.process_date;   
	self.FILE_NUMBER											:=	le.FILE_NUMBER;   
	self.SEGMENT_CODE											:=	le.SEGMENT_CODE;   
	self.SEQUENCE_NUMBER									:=	le.SEQUENCE_NUMBER;   
	self.orig_DATE_FILED_YYMMDD						:=	le.orig_DATE_FILED_YYMMDD;   
	self.orig_DATE_REPORTED_YYMMDD				:=	le.orig_DATE_REPORTED_YYMMDD;   
	self.ACTION_CODE											:=	le.ACTION_CODE;   
	self.ACTION_DESC											:=	le.ACTION_DESC;   
	self.CO_BUS_NAME											:=	le.CO_BUS_NAME;   
	self.CO_BUS_ADDRESS										:=	le.CO_BUS_ADDRESS;   
	self.CO_BUS_CITY											:=	le.CO_BUS_CITY;   
	self.CO_BUS_STATE_CODE								:=	le.CO_BUS_STATE_CODE;   
	self.CO_BUS_STATE_DESC								:=	le.CO_BUS_STATE_DESC;   
	self.CO_BUS_ZIP												:=	le.CO_BUS_ZIP;   
	self.EXTENT_OF_ACTION									:=	le.EXTENT_OF_ACTION;   
	self.AGENCY_CODE											:=	le.AGENCY_CODE;   
	self.AGENCY_DESC											:=	le.AGENCY_DESC;   
	self.DISPUTE_IND											:=	le.DISPUTE_IND;   
	self.DISPUTE_CODE											:=	le.DISPUTE_CODE;   
	self.date_filed												:=	le.date_filed;   
	self.date_reported										:=	le.date_reported;
	self.Append_RawAID										:=	0;
	self.Append_ACEAID										:=	0;	
	self.prep_addr_line1									:=	trim(le.CO_BUS_ADDRESS,left,right);
	self.prep_addr_last_line							:=	if (trim(le.CO_BUS_CITY,left,right) != '',
																									StringLib.StringCleanSpaces(trim(le.CO_BUS_CITY,left,right) + ', ' +
																																							trim(le.CO_BUS_STATE_CODE,left,right) + ' ' + 
																																							trim(le.CO_BUS_ZIP,left,right)[1..5]), 
																									StringLib.StringCleanSpaces(trim(le.CO_BUS_STATE_CODE,left,right) + ' ' + 
																																							trim(le.CO_BUS_ZIP,left,right)[1..5])
																								);	
end;

Filenm_6510_government_debarred_contractor:= project(ebr_6510_debr_contractor,ebr_6510_government_debarred_contractor_tr(LEFT));

FileName_6510_tr := '~thor_data400::in::ebr_6510_government_debarred_contractor_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_6510_' + trim(decode_segments('6510'))),
												output(Filenm_6510_government_debarred_contractor,,FileName_6510_tr,overwrite,__compressed__)
												);

add_files := fileservices.AddSuperFile('~thor_data400::in::EBR_6510_' + trim(decode_segments('6510')),FileName_6510_tr);

return sequential(Out_File,add_files);
end;
