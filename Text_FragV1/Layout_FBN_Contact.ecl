IMPORT FBNV2,BIPV2;
EXPORT Layout_FBN_Contact := RECORD
	FBNV2.Layout_Common.Contact.Tmsid;
	FBNV2.Layout_Common.Contact.Rmsid;
	FBNV2.Layout_Common.Contact.dt_first_seen;    
	FBNV2.Layout_Common.Contact.dt_last_seen;     
	FBNV2.Layout_Common.Contact.dt_vendor_first_reported;
	FBNV2.Layout_Common.Contact.dt_vendor_last_reported;
	FBNV2.Layout_Common.Contact.CONTACT_NAME;
	FBNV2.Layout_Common.Contact.CONTACT_PHONE;
	FBNV2.Layout_Common.Contact.CONTACT_ADDR;
	FBNV2.Layout_Common.Contact.CONTACT_CITY;
	FBNV2.Layout_Common.Contact.CONTACT_STATE;
	FBNV2.Layout_Common.Contact.CONTACT_ZIP;
	FBNV2.Layout_Common.Contact.CONTACT_COUNTRY;
	FBNV2.Layout_Common.Contact.SEQ_NO;
	FBNV2.Layout_Common.Contact.title;
	FBNV2.Layout_Common.Contact.fname;
	FBNV2.Layout_Common.Contact.mname;
	FBNV2.Layout_Common.Contact.lname;
	FBNV2.Layout_Common.Contact.name_suffix;
	FBNV2.Layout_Common.Contact.prim_range;
	FBNV2.Layout_Common.Contact.predir;
	FBNV2.Layout_Common.Contact.prim_name;
	FBNV2.Layout_Common.Contact.addr_suffix;
	FBNV2.Layout_Common.Contact.postdir;
	FBNV2.Layout_Common.Contact.unit_desig;
	FBNV2.Layout_Common.Contact.sec_range;
	FBNV2.Layout_Common.Contact.v_city_name;
	FBNV2.Layout_Common.Contact.st;
	FBNV2.Layout_Common.Contact.zip5;
	FBNV2.Layout_Common.Contact.zip4;
	FBNV2.Layout_Common.Contact.did;
	FBNV2.Layout_Common.Contact.bdid;
	UNSIGNED6 sid := 0;
	UNSIGNED6 rid := 0;
	STRING2   source;
	BIPV2.IDlayouts.l_xlink_ids;
END;