Import GlobalWatchLists, Patriot, aid, PRTE2_Common;

EXPORT Layouts := module


Export Layout_Baddids_with_name := RECORD
  unsigned6 did;
  unsigned4 other_count;
  unsigned4 first_seen;
  unsigned2 rel_count;
  string20 fname;
  string20 mname;
  string20 lname;
  unsigned8 dummy;
 END;


Export Layout_Score :=Record
  string20 fname;
  string20 lname;
  string20 mname;
  unsigned2 score;
End;

Export layout_pat_keybuild := record
	patriot.Layout_Patriot_addressid;
	unsigned8 __fpos {virtual(fileposition)};
end;

Export Layout_patriot:=Patriot.Layout_patriot;

Export Layout_Base_Patriot:= Record
  Layout_Patriot;
	string10 cust_name;
  string10 bug_num;
	string9 link_ssn;
  string9 link_fein;
  string8 link_inc_date;
	STRING8 link_dob;
  unsigned6 bdid;
	End;
	
export Layout_Patriot_addressid := record
	Layout_Base_Patriot;
	string10	aid_prim_range;
	string2		aid_predir;
	string28	aid_prim_name;
	string4		aid_addr_suffix;
	string2		aid_postdir;
	string10	aid_unit_desig;
	string8		aid_sec_range;
	string25	aid_p_city_name;
	string25	aid_v_city_name;
	string2		aid_st;
	string5		aid_zip;
	string4		aid_zip4;
	string4		aid_cart;
	string1		aid_cr_sort_sz;
	string4		aid_lot;
	string1		aid_lot_order;
	string2		aid_dpbc;
	string1		aid_chk_digit;
	string2		aid_record_type;
	string2		aid_fips_st;
	string3		aid_county;
	string10	aid_geo_lat;
	string11	aid_geo_long;
	string4		aid_msa;
	string7		aid_geo_blk;
	string1		aid_geo_match;
	string4		aid_err_stat;
	aid.common.xaid append_rawaid;
end;

export KeyType_BadDids := Patriot.KeyType_BadDids;

Export Layout_Patriot2 :=  record
	Patriot.Layout_Patriot;  
	unsigned8	__fpos {virtual(fileposition)};
End;
	
Export Layout_Did := record
	Patriot.Layout_Patriot;
 unsigned8	__fpos {virtual(fileposition)};
 End;

Export Layout_bdid := Record
	unsigned6 bdid;
  Patriot.Layout_Patriot;
	unsigned8	__fpos {virtual(fileposition)};
	End;
	
Export LayoutTokens:=GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutTokens;

Export LayoutName := GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutName;

Export LayoutNameIndex:=GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutNameIndex;

Export LayoutCountryName:= GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountryName;

Export LayoutCountry:=GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountry;

Export LayoutAddress:=GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddress;

Export LayoutAdditionalInfo:=GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAdditionalInfo;

Export LayoutEntity:=GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutEntity;

Export LayoutcountryIndex:=GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountryIndex;

Export Layout_GlobalWatchLists :=GlobalWatchLIsts.Layout_GlobalWatchLists;

Export Country_Layout := RECORD
	STRING100 country;
	STRING60 source;
	STRING20 pty_key;
END;

export GWL_base_Layout_IN := RECORD 
	Layout_GlobalWatchLists and not [global_sid, record_sid];
	string10 cust_name;
  string10 bug_num;
	string8 link_dob;
  string9 link_ssn;
	string9 link_fein;
  string8 link_inc_date;
end;	

Export GWL_base_Layout_Ext := RECORD 
       Layout_GlobalWatchLists;
		   string10 cust_name;
       string10 bug_num;
			 string8 link_dob;
			 string9 link_ssn;
       string9 link_fein;
       string8 link_inc_date;
			 unsigned6 bdid;
			 
End;

			 
EXPORT Seq_Layout := RECORD
  unsigned4 seq;
  unsigned4 source;
  string20 pty_key;
  string100 first_name;
  string150 last_name;
  string350 cname;
  unsigned4 max_seq;
 END;
 
 Export IDLayout :=RECORD,maxlength(8192)
 string20 entityid; 
 unicode50 idnumber; 
 unsigned1 idtype; 
 string6 listid; 
 unsigned1 recordid; 
 string10 dateissued; 
 string10 dateexpires; 
 unicode50 label; 
 unicode50 issuedby; 
 unicode1024 comments;
 End;
 
Export Layout_GWL := record
		GWL_Base_Layout_ext;
		aid.common.xaid append_rawaid;
	end;

	Export addressidLayout := record
		GWL_Base_Layout_ext;
		string120 append_prep_address1;
		string60  append_prep_addresslast;
		aid.common.xaid append_rawaid;
	end;

export delta_rid := PRTE2_Common.Layouts.DELTA_RID;
 
END;
