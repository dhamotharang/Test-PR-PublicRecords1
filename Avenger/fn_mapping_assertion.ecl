import address,avenger;
//mapping assertion to common
export fn_mapping_assertion(dataset(avenger.layout_in.assertion) pInFile) := function

need_clean_addr := pinfile(person_address_street1 <> '' or person_address_street2 <> '' or bill_to_address_street1 <> '');
no_need_clean_addr := pinfile(~(person_address_street1 <> '' or person_address_street2 <> '' or bill_to_address_street1 <> ''));

 avenger.layout_in.assertion_clean_rec tmap_assertion1(pInFile le) := transform

input_addr_line1 := trim(le.person_address_street1, left, right) + ' ' + trim(le.person_address_street2, left,right);
input_addr_line2 :=  le.person_address_city +  if(le.person_address_city <> '',', ',' ') + le.person_address_state+ ' '+ le.person_address_zip;
//Billto_addr_line1 := trim(le.bill_to_address_street1, left, right) + ' ' + trim(le.bill_to_address_street2, left,right);
Billto_addr_line1 := trim(le.bill_to_address_street1, left, right);

Billto_addr_line2 :=  le.bill_to_address_city +  if(le.bill_to_address_city <> '',', ',' ') + le.bill_to_address_state+ ' '+ le.bill_to_address_zip;

input_clean_addr := Address.cleanaddress182(input_addr_line1, input_addr_line2);
billto_clean_addr := Address.cleanaddress182(billto_addr_line1, billto_addr_line2);

	 self.input_clean.prim_range  	:= input_clean_addr[1..10];
	 self.input_clean.predir	 			:= input_clean_addr[11..12];
	 self.input_clean.prim_name		:= input_clean_addr[13..40];
	 self.input_clean.addr_suffix 	:= input_clean_addr[41..44];
	 self.input_clean.postdir 			:= input_clean_addr[45..46];
	 self.input_clean.unit_desig		:= input_clean_addr[47..56];
	 self.input_clean.sec_range		:= input_clean_addr[57..64];
	 self.input_clean.p_city_name	:= input_clean_addr[65..89];
	 self.input_clean.v_city_name 	:= input_clean_addr[90..114];
	 self.input_clean.st						:= input_clean_addr[115..116];
	 self.input_clean.zip						:= input_clean_addr[117..121];
	 self.input_clean.zip4					:= input_clean_addr[122..125];
	 self.billto_clean.prim_range  	:= billto_clean_addr[1..10];
	 self.billto_clean.predir	 			:= billto_clean_addr[11..12];
	 self.billto_clean.prim_name		:= billto_clean_addr[13..40];
	 self.billto_clean.addr_suffix 	:= billto_clean_addr[41..44];
	 self.billto_clean.postdir 			:= billto_clean_addr[45..46];
	 self.billto_clean.unit_desig		:= billto_clean_addr[47..56];
	 self.billto_clean.sec_range		:= billto_clean_addr[57..64];
	 self.billto_clean.p_city_name	:= billto_clean_addr[65..89];
	 self.billto_clean.v_city_name 	:= billto_clean_addr[90..114];
	 self.billto_clean.st						:= billto_clean_addr[115..116];
	 self.billto_clean.zip						:= billto_clean_addr[117..121];
	 self.billto_clean.zip4					:= billto_clean_addr[122..125];
	 
fixDate := avenger.fncleanfunctions.tDateAdded(le.TRANSACTIONSTARTTIME);
fixTime := avenger.fncleanfunctions.tTimeAdded(fixDate);
self.Asser_Tran_ID	:=	le.TRANSACTIONID	;
self.Asser_Tran_Date	:=	fixTime	;
self.Asser_Account_Name	:=	le.ACCOUNTNAME	;
self.Asser_Customer_ID	:=	le.customer_id	;
self.Assert_Username	:=	le.username	;
self.Asser_Special_Feature_Code	:=	le.SPECIAL_FEATURE_CODE	;
self.Asser_IP_Address	:=	le.ip_address	;
self.Asser_Reference_ID	:=	le.reference_id	;
//self.Asser_Complex_Detail	:=	le.complex_detail	;
self.Asser_Input_Name_First	:=	le.person_name_first	;
self.Asser_Input_Name_Last	:=	le.person_name_last	;
self.Asser_Input_SSN	:=	le.person_ssn	;
self.Asser_Input_Phone	:=	avenger.fncleanfunctions.clean_phone(le.person_home_phone)	;
self.Asser_Input_Street_1	:=	le.person_address_street1	;
self.Asser_Input_Street_2	:=	le.person_address_street2	;
self.Asser_Input_City	:=	le.person_address_city	;
self.Asser_Input_State	:=	le.person_address_state	;
self.Asser_Input_Zip	:=	le.person_address_zip	;
self.Asser_Input_DOB	:=	avenger.fncleanfunctions.clean_asser_dob(le.person_birthdate);
self.Asser_Input_Email	:=	le.person_email	;
self.Asser_BillTo_Name_First	:=	le.bill_to_name_first	;
self.Asser_BillTo_Name_Last	:=	le.bill_to_name_last	;
self.Asser_BillTo_Street	:=	le.bill_to_address_street1	;
self.Asser_BillTo_City	:=	le.bill_to_address_city	;
self.Asser_BillTo_State	:=	le.bill_to_address_state	;
self.Asser_BillTo_Zip	:=	le.bill_to_address_zip	;
self.Asser_BillTo_Phone	:=	avenger.fncleanfunctions.clean_phone(le.bill_to_home_phone)	;
self.Asser_BillTo_Email	:=	le.bill_to_email	;
self := [];

end;


avenger.layout_in.assertion_clean_rec tmap_assertion2(pInFile le) := transform

fixDate := avenger.fncleanfunctions.tDateAdded(le.TRANSACTIONSTARTTIME);
fixTime := avenger.fncleanfunctions.tTimeAdded(fixDate);
self.Asser_Tran_ID	:=	le.TRANSACTIONID	;
self.Asser_Tran_Date	:=	fixTime;
self.Asser_Account_Name	:=	le.ACCOUNTNAME	;
self.Asser_Customer_ID	:=	le.customer_id	;
self.Assert_Username	:=	le.username	;
self.Asser_Special_Feature_Code	:=	le.SPECIAL_FEATURE_CODE	;
self.Asser_IP_Address	:=	le.ip_address	;
self.Asser_Reference_ID	:=	le.reference_id	;
//self.Asser_Complex_Detail	:=	le.complex_detail	;
self.Asser_Input_Name_First	:=	le.person_name_first	;
self.Asser_Input_Name_Last	:=	le.person_name_last	;
self.Asser_Input_SSN	:=	le.person_ssn	;
self.Asser_Input_Phone	:=	avenger.fncleanfunctions.clean_phone(le.person_home_phone)	;
self.Asser_Input_Street_1	:=	le.person_address_street1	;
self.Asser_Input_Street_2	:=	le.person_address_street2	;
self.Asser_Input_City	:=	le.person_address_city	;
self.Asser_Input_State	:=	le.person_address_state	;
self.Asser_Input_Zip	:=	le.person_address_zip	;
self.Asser_Input_DOB	:=	avenger.fncleanfunctions.clean_asser_dob(le.person_birthdate);
self.Asser_Input_Email	:=	le.person_email	;
self.Asser_BillTo_Name_First	:=	le.bill_to_name_first	;
self.Asser_BillTo_Name_Last	:=	le.bill_to_name_last	;
self.Asser_BillTo_Street	:=	le.bill_to_address_street1	;
self.Asser_BillTo_City	:=	le.bill_to_address_city	;
self.Asser_BillTo_State	:=	le.bill_to_address_state	;
self.Asser_BillTo_Zip	:=	le.bill_to_address_zip	;
self.Asser_BillTo_Phone	:=	avenger.fncleanfunctions.clean_phone(le.bill_to_home_phone)	;
self.Asser_BillTo_Email	:=	le.bill_to_email	;
self := [];

end;

clean_address := project(need_clean_addr, tmap_assertion1(left)) + project(no_need_clean_addr,
tmap_assertion2(left));

common_verid_assertion := dedup(clean_address,all);

return common_verid_assertion;

end;
