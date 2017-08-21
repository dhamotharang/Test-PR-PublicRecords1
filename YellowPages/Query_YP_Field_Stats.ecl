import YellowPages;

export Query_YP_Field_Stats(
  string																              pversion
 ,dataset(YellowPages.Layout_YellowPages_Base_V2_BIP) pInputAid	= YellowPages.CleanedInputAID(pversion)

) :=
function

	yp := pInputAid;

	Layout_YP_Slim := record
		string12	Primary_key;
		string8		Pub_date;
		string100	Business_Name;
		string100	orig_Street;
		string28	orig_city;
		string2		orig_state;
		string9		orig_zip;
		string1		addr_suffix_flag;
		string8		sic_code;
		string6		naics_code;
		string10	orig_phone10;
		string4		err_stat;	
	end;

	Layout_YP_Slim InitYP(yp l) := transform
		self := l;
	end;

	yp_init := project(yp, InitYP(left));

	Layout_YP_Stat := record
		yp_init.orig_state;
		integer4 primary_key_cnt 		:= count(group, yp_init.primary_key <> '');
		integer4 business_name_cnt 		:= count(group, yp_init.business_name <> '');
		integer4 orig_street_cnt 		:= count(group, yp_init.orig_street <> '');
		integer4 orig_city_cnt 			:= count(group, yp_init.orig_city <> '');
		integer4 orig_state_cnt 		:= count(group, yp_init.orig_state <> '');
		integer4 orig_zip_cnt 			:= count(group, yp_init.orig_zip <> '');
		integer4 orig_phone10_cnt 		:= count(group, yp_init.orig_phone10 <> '');
		integer4 sic_code_cnt 			:= count(group, yp_init.sic_code <> '');
		integer4 pub_date_cnt 			:= count(group, yp_init.pub_date <> '');
		integer4 naics_code_cnt 		:= count(group, yp_init.naics_code <> '');
		integer4 addr_suffix_flag_cnt	:= count(group, yp_init.addr_suffix_flag <> '');

		// clean address error stats
		integer4 err_stat_S 			:= count(group, yp_init.err_stat[1] = 'S');
		integer4 err_stat_E 			:= count(group, yp_init.err_stat[1] = 'E');
		integer4 err_stat_U 			:= count(group, yp_init.err_stat[1] = 'U');
		integer4 err_stat_other 		:= count(group, yp_init.err_stat[1] not in ['S','E','U']);

		integer4 total					:= count(group);
	END;

	yp_stat := table(yp_init, Layout_YP_Stat, orig_state, few);

	return  output(yp_stat);

end;