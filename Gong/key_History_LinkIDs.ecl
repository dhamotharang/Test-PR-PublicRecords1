IMPORT BIPV2, Data_Services, Doxie;


EXPORT Key_History_LinkIds := MODULE


  // DEFINE THE INDEX
	shared superfile_name		:= Data_Services.Data_location.Prefix('Gong_History')
	                           +'thor_data400::key::gong_history_LinkIDs_QA';
	
	// shared Base				:= Gong.File_History_Full_Prepped_for_Keys;
	layout_base := RECORD
  string3 bell_id;
  string11 filedate;
  string1 dual_name_flag;
  string10 sequence_number;
  string1 listing_type_bus;
  string1 listing_type_res;
  string1 listing_type_gov;
  string1 publish_code;
  string1 style_code;
  string1 indent_code;
  string20 book_neighborhood_code;
  string3 prior_area_code;
  string10 phone10;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 v_predir;
  string28 v_prim_name;
  string4 v_suffix;
  string2 v_postdir;
  string25 v_city_name;
  string2 st;
  string5 z5;
  string4 z4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string32 designation;
  string5 name_prefix;
  string20 name_first;
  string20 name_middle;
  string20 name_last;
  string5 name_suffix;
  string120 listed_name;
  string254 caption_text;
  string10 group_id;
  string10 group_seq;
  string1 omit_address;
  string1 omit_phone;
  string1 omit_locality;
  string64 see_also_text;
  unsigned6 did;
  unsigned6 hhid;
  unsigned6 bdid;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string1 current_record_flag;
  string8 deletion_date;
  unsigned2 disc_cnt6;
  unsigned2 disc_cnt12;
  unsigned2 disc_cnt18;
  unsigned8 rawaid;
  string pclean;
  string5 pdid;
  string1 nametype;
  string80 preppedname;
  unsigned8 nid;
  unsigned2 name_ind;
  unsigned8 persistent_record_id;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  unsigned4 global_sid;
  unsigned8 record_sid;
 END;
	shared Base := Dataset('~thor_data400::base::gong_history',layout_base,flat, __compressed__);
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level);
		Gong.mac_check_access(fetched, out, mod_access);   // Jira# CCPA-98, Function created for CCPA suppressions at key fetches.
		return out;																					

	END;
	
	// Depricated version of the above kFetch2
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		JoinLimit = 25000
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, mod_access, Level, ScoreThreshold, JoinLimit);
		return project(f2, recordof(Key));																					

	END;

END;