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
string5		CONTACT_ZIP;
string12  CONTACT_COUNTRY;
unsigned4 CONTACT_FEI_NUM;
string8   INC_DATE;
string12  CONTACT_CHARTER_NUM;
string8		DOB;
string9   SSN;                  
unsigned3 SEQ_NO;
string8		WITHDRAWAL_DATE;
string10 	cust_name;
string10  bug_num;
string9		link_ssn;
string8		link_dob;
string9 	link_fein;
string8		link_inc_date;
string		link_bus_name;
Unsigned6	did;
END;


Export Business_Base := RECORD
string38 	TMSID;
string35 	RMSID;
unsigned4 DT_FIRST_SEEN;
unsigned4 DT_LAST_SEEN;
unsigned4 DT_VENDOR_FIRST_REPORTED;
unsigned4 DT_VENDOR_LAST_REPORTED;
string3 	FILING_JURISDICTION;
string35 	FILING_NUMBER;
string8		FILING_DATE;
string 		FILING_TYPE;
string8 	EXPIRATION_DATE;
string8		CANCELLATION_DATE;
string12 	ORIG_FILING_NUMBER;
string8		ORIG_FILING_DATE;
string192 BUS_NAME;
string 		LONG_BUS_NAME;
string8		BUS_COMM_DATE;
string10 	BUS_STATUS;
string9 	ORIG_FEIN;
string8 	INC_DATE;
string10 	BUS_PHONE_NUM;
string9 	SIC_CODE;
string100 BUS_TYPE_DESC;
string40 	BUS_ADDRESS1;
string40 	BUS_ADDRESS2;
string28 	BUS_CITY;
string12 	BUS_COUNTY;
string2 	BUS_STATE;
string5 	BUS_ZIP;
string4 	BUS_ZIP4;
string12 	BUS_COUNTRY;
string80 	MAIL_STREET;
string28 	MAIL_CITY;
string2 	MAIL_STATE;
string10  MAIL_ZIP;
unsigned3 SEQ_NO;
string10 	cust_name;
string10 	bug_num;
string9 	link_fein;
string8		link_inc_date;
string		link_bus_name;
END;


EXPORT Combined_Business_Base_ext := RECORD
		Business_AID;
		string10 	cust_name;
		string10 	bug_num;
		string9 	link_fein;
		string8		link_inc_date;
		string		link_bus_name;
	END;


EXPORT Combined_Business_Base := RECORD
			Combined_Business_Base_ext and not [link_bus_name] - {BIPV2.IDlayouts.l_xlink_ids};
	END;

EXPORT Combined_Contact_Base_ext := RECORD
		Contact_AID;
		string10 cust_name;
		string10  bug_num;
		string9		link_ssn;
		string8		link_dob;
		string9 	link_fein;
		string8		link_inc_date;
		string		link_bus_name;
	END;
  

EXPORT Combined_Contact_Base := RECORD
    Combined_Contact_Base_ext and not link_bus_name;

	END;

Export clean_Layout:=record
FBNV2.Layout_Common.Contact_AID;
unsigned8	nid;
string1		nametype;
string5		cln_title;
string20	cln_fname;
string20	cln_mname;
string20	cln_lname;
string5		cln_suffix;
string5		cln_title2;
string20	cln_fname2;
string20	cln_mname2;
string20	cln_lname2;
string5		cln_suffix2;
unsigned2	name_ind;
end;

End;