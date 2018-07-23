import iesp;  
EXPORT ConsumerProfile_layouts := MODULE
	export in_key := RECORD
		string20 dataset_name;
		string30 acctNo;
		string2 Seq;
		string15 fname;
		string20 lname;
		string5  in_zip5;
		string9  in_ssn;
		string10 hphone;
	END;
	
	export report := RECORD
		in_key;
		unsigned6 did;
		iesp.share.t_Name;
		string9 cp_SSN;
		string8 dob;
		iesp.share.t_Address;
		string1 SSNVerificationCode;
		string SSNVerificationDescription;
		string1 AddressVerificationCode;
		string AddressVerificationDescription;
		string1 DOBVerificationCode;
		string DOBVerificationDescription;
		string1 PhoneVerificationCode;
		string PhoneVerificationDescription;
		string1 AddressStability;
		string8 ssnInfo_ssn;
		string5 ssnInfo_valid;
		string32 ssnInfo_issuedLocation;
		string8	ssnInfo_issuedStartDate;
		string8 ssnInfo_issuedEndDate;
		string4 hri;
		string100 hri_desc;
		string4 hri2;
		string100 hri2_desc;
		string4 hri3;
		string100 hri3_desc;
		string4 hri4;
		string100 hri4_desc;
		string4 hri5;
		string100 hri5_desc;
		string consumerstatement;
		string alertcode;
		string alertcode_desc;
		string alertcode2;
		string alertcode2_desc;
		string alertcode3;
		string alertcode3_desc;
		string alertcode4;
		string alertcode4_desc;
		string alertcode5;
		string alertcode5_desc;
	END;
	
	export AddressHistory := RECORD
		in_key;
		iesp.share.t_Address;
		string8 dt_last_seen;
		string8 dt_first_seen;
	END;
	
	export AKAs := RECORD
		in_key;
		iesp.share.t_Name;
	END;
	
END;