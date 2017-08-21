Export Layouts := Module
Import AID;

Export Layout_OutwardMedia := Record
String   Email;
String   Firstname;
String   Lastname;
String   Address1;
String   Address2;
String   City;
String   State;
String 	Zip;
String 	Phone;
String 	WebUrl;
String 	IPaddress;
String 	Optin;
End;

/* Setting a Unique Sequence Number to the OutwardMedia File*/
Export Layout_OutwardMedia_SeqNum := Record
Unsigned8 Seq_Num:=0;
Layout_OutwardMedia;
End;

/* Extracting Clean Names and Addresses*/
Export Layout_cln_Name_address := Record		
		STRING5 clean_title;
    STRING20 clean_fname;
    STRING20 clean_mname;
    STRING20 clean_lname;
    STRING5 clean_name_suffix;
    STRING3 clean_name_score;
	
    STRING10 clean_prim_range;
    STRING2 clean_predir;
    STRING28 clean_prim_name;
    STRING4 clean_addr_suffix;
    STRING2 clean_postdir;
    STRING10 clean_unit_desig;
    STRING8 clean_sec_range;
    STRING25 clean_p_city_name;
    STRING25 clean_v_city_name;
    STRING2 clean_st;
    STRING5 clean_zip;
    STRING4 clean_zip4;
    STRING4 clean_cart;
    STRING1 clean_cr_sort_sz;
    STRING4 clean_lot;
    STRING1 clean_lot_order;
    STRING2 clean_dbpc;
    STRING1 clean_chk_digit;
    STRING2 clean_rec_type;
    STRING5 clean_county;
    STRING10 clean_geo_lat;
    STRING11 clean_geo_long;
    STRING4 clean_msa;
    STRING7 clean_geo_blk;
    STRING1 clean_geo_match;
    STRING4 clean_err_stat;
    
		// Instance tracking fields
		STRING8 date_first_seen;
		STRING8 date_last_seen;
		STRING8 date_vendor_first_reported;
		STRING8 date_vendor_last_reported;
End;
/* Appending AID to Outward Media File  */
 Export Layout_OutwardMedia_Clean := Record
	AID.Common.xAID AID := 0;
	Layout_OutwardMedia_SeqNum;
	Layout_cln_Name_address;
	End;
	
/* Appending DID to Outward Media File */
Export Layout_OutwardMedia_DID := Record
Layout_OutwardMedia_Clean;
UNSIGNED8 DID :=0;
UNSIGNED8 DID_Score := 0;
End;

/* OLD OUTWARD MEDIA LAYOUT FOR STRATA*/
Export Old_OM_Layout := Record
//AID
AID.Common.xAID AID := 0;
Unsigned8 Seq_Num:=0;
//Old Layout with 10 Fields and Seq_num
String   firstname;
String   lastname;
String   address;
String   city;
String   state;
String   zip;
String   email;
String   optin;
String   weburl;
String   phone;
Layout_cln_Name_address; 
UNSIGNED8 DID :=0;
UNSIGNED8 DID_Score := 0;
End;

End; // Module