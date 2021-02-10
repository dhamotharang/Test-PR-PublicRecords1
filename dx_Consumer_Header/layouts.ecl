EXPORT layouts := MODULE

permRec := RECORD
	unsigned8 permissions;
END;
	
fnameRec := RECORD
	string20 fname;
	string2 fname_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

mnameRec := RECORD
	string20 mname;
	string2 mname_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

lnameRec := RECORD
	string20 lname;
	string2 lname_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

snameRec := RECORD
	string5 sname;
	string2 sname_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

phoneRec := RECORD
	string10 phone;
	string2 phone_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

genderRec := RECORD
	string1 gender;
	string2 gender_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

ssnRec := RECORD
	string9 ssn;
	string2 ssn_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

dobRec := RECORD
	unsigned4 dob;
	string2 dob_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

dlRec := RECORD
	string2 dl_state;
	string25 dl_nbr;
	string2 dl_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

addrRec := RECORD
	STRING10	PRIM_RANGE;
	STRING2		PREDIR;
	STRING28	PRIM_NAME;
	STRING4		ADDR_SUFFIX;
	STRING2		POSTDIR;
	STRING10	UNIT_DESIG;
	STRING8		SEC_RANGE;
	STRING25	CITY;
	STRING2		ST;
	STRING5		ZIP;
	STRING4		ZIP4;
	UNSIGNED6 LOCID;
	string2 addr_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

emailRec := RECORD
	string60 email;
	string2 email_ind;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	DATASET(permRec) permissions_ds;
END;

EXPORT i_did := RECORD
	unsigned8 did;
	string9 ind;
	DATASET(phoneRec) phones_ranked;
	DATASET(fnameRec) fnames_ranked;
	DATASET(mnameRec) mnames_ranked;
	DATASET(lnameRec) lnames_ranked;
	DATASET(snameRec) snames_ranked;
	DATASET(genderRec) genders_ranked;
	DATASET(ssnRec) ssns_ranked;
	DATASET(dobRec) dobs_ranked;
	DATASET(dlRec) dls_ranked;
	DATASET(addrRec) addrs_ranked;
	DATASET(emailRec) emails_ranked;
END;

END;