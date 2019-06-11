Import FBNV2, NID, address, PRTE2, BIPV2;
EXPORT Layouts := module

Export Business:=FBNV2.Layout_Common.Business;
Export Business_AID:=FBNV2.Layout_Common.Business_AID;
Export Contact:=FBNV2.Layout_Common.Contact;
Export Contact_AID:=FBNV2.Layout_Common.Contact_AID;

Export Contact_base := Record
string38  TMSID;
string35  RMSID;
unsigned4 DT_FIRST_SEEN;
unsigned4 DT_LAST_SEEN;
unsigned4 DT_VENDOR_FIRST_REPORTED;
unsigned4 DT_VENDOR_LAST_REPORTED;
string1   CONTACT_TYPE;
string55  CONTACT_NAME;
string10  CONTACT_STATUS;
string10  CONTACT_PHONE;
string10  CONTACT_NAME_FORMAT;
string40  CONTACT_ADDR;
string28  CONTACT_CITY;
string2   CONTACT_STATE;
unsigned6 CONTACT_ZIP;
string12  CONTACT_COUNTRY;
unsigned4 CONTACT_FEI_NUM;
unsigned4 INC_DATE;
string12  CONTACT_CHARTER_NUM;
unsigned4 DOB;
string9   SSN;                  
unsigned3 SEQ_NO;
unsigned4 WITHDRAWAL_DATE;
string200 cust_name;
string10  bug_num;
string9		link_ssn;
string8		link_dob;
string9 	link_fein;
string8		link_inc_date;
string		link_bus_name;
END;


Export Business_Base := RECORD
string38 TMSID;
string35 RMSID;
unsigned4 DT_FIRST_SEEN;
unsigned4 DT_LAST_SEEN;
unsigned4 DT_VENDOR_FIRST_REPORTED;
unsigned4 DT_VENDOR_LAST_REPORTED;
string3 FILING_JURISDICTION;
string35 FILING_NUMBER;
unsigned4 FILING_DATE;
string FILING_TYPE;
unsigned4 EXPIRATION_DATE;
unsigned4 CANCELLATION_DATE;
string12 ORIG_FILING_NUMBER;
unsigned4 ORIG_FILING_DATE;
string192 BUS_NAME;
string LONG_BUS_NAME;
unsigned4 BUS_COMM_DATE;
string10 BUS_STATUS;
unsigned4 ORIG_FEIN;
unsigned4 INC_DATE;
string10 BUS_PHONE_NUM;
string9 SIC_CODE;
string100 BUS_TYPE_DESC;
string40 BUS_ADDRESS1;
string40 BUS_ADDRESS2;
string28 BUS_CITY;
string12 BUS_COUNTY;
string2 BUS_STATE;
unsigned3 BUS_ZIP;
unsigned2 BUS_ZIP4;
string12 BUS_COUNTRY;
string80 MAIL_STREET;
string28 MAIL_CITY;
string2 MAIL_STATE;
string10 MAIL_ZIP;
unsigned3 SEQ_NO;
string200 cust_name;
string10 bug_num;
string9 	link_fein;
string8		link_inc_date;
string		link_bus_name;
END;


EXPORT Combined_Business_Base_ext := RECORD
		Business_Base;
		string9		link_ssn;
    string8		link_dob;
   	address.Layout_Clean_Name;
		address.Layout_Clean182;
		UNSIGNED8	raw_aid								:=  0;
		UNSIGNED8	ace_aid								:=  0;
		STRING100 prep_addr_line1				:= '';
		STRING50	prep_addr_line_last		:= '';
		UNSIGNED8	source_rec_id 		    :=  0;
		Unsigned6 Bdid;
		BIPV2.IDlayouts.l_xlink_ids ;
    PRTE2.Layouts.DEFLT_CPA;   // CCPA Project
	END;


EXPORT Combined_Business_Base := RECORD
  Combined_Business_Base_ext and not [link_bus_name] - {BIPV2.IDlayouts.l_xlink_ids};
		// Business_Base;
		// address.Layout_Clean_Name;
		// address.Layout_Clean182;
		// UNSIGNED8	raw_aid								:=  0;
		// UNSIGNED8	ace_aid								:=  0;
		// STRING100 prep_addr_line1				:= '';
		// STRING50	prep_addr_line_last		:= '';
		// UNSIGNED8	source_rec_id 		    :=  0;
		// Unsigned6 Bdid;
	END;

EXPORT Combined_Contact_Base_ext := RECORD
		contact_Base;
    address.Layout_Clean_Name;
		address.Layout_Clean182;
		UNSIGNED8	raw_aid								:=  0;
		UNSIGNED8	ace_aid								:=  0;
		STRING100 prep_addr_line1				:= '';
		STRING50	prep_addr_line_last		:= '';
		UNSIGNED8	source_rec_id 		    :=  0;
		Unsigned6 Did;
		Unsigned6 Bdid;
    PRTE2.Layouts.DEFLT_CPA;   // CCPA Project
	END;
  
  
EXPORT Combined_Contact_Base := RECORD
    Combined_Contact_Base_ext and not link_bus_name;
		// contact_Base;
		// address.Layout_Clean_Name;
		// address.Layout_Clean182;
		// UNSIGNED8	raw_aid								:=  0;
		// UNSIGNED8	ace_aid								:=  0;
		// STRING100 prep_addr_line1				:= '';
		// STRING50	prep_addr_line_last		:= '';
		// UNSIGNED8	source_rec_id 		    :=  0;
		// Unsigned6 Did;
		// Unsigned6 Bdid;
	END;
	
Export clean_Layout:=record
FBNV2.Layout_Common.Contact_AID;
unsigned8	nid;
string1	nametype;
string5	cln_title;
string20	cln_fname;
string20	cln_mname;
string20	cln_lname;
string5	cln_suffix;
string5	cln_title2;
string20	cln_fname2;
string20	cln_mname2;
string20	cln_lname2;
string5	cln_suffix2;
unsigned2	name_ind;
end;

End;