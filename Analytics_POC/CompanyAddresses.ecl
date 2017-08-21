import dnb,standard,address,TopBusiness_External;

export CompanyAddresses := module


shared fsAccounts := FS_Accounts.ds_accts;

export layout_std_addr := record
	
	recordof(fsAccounts);
	unsigned6 bid;
	unsigned1 bid_score;
	string business_name;
	string business_phone;
	standard.Addr;
	string cleanaddr;
	string appended_taxid;
	string source;

end;

// SNAC Data.....

export spray_snac :=
	fileservices.sprayVariable( Constants.landing_ip, // dev
                            //'172.25.246.94', // IQ
                            'w:\\poc\\cred_view_data.tsv',
														8192,
														'\\t',
														, , 'thor20_11',
														'poc::fs_snac_raw'
														,,,,true
													 );
													 

export layout_snac_raw := record
	string SNAC_app_id;
	string SNAC_entity_id;
	string SNAC_std_addr_primary;
	string SNAC_std_addr_secondary;
	string SNAC_std_addr_city;
	string SNAC_std_addr_state;
	string SNAC_std_addr_postal_cd;
	string SNAC_std_addr_zip4;
	string SNAC_std_addr_province;
	string SNAC_std_addr_country;
	string SNAC_acct_num;
	string SNAC_source_system_full;
	string SNAC_name_business;
	string SNAC_dba;
	string SNAC_phone;
end;

export file_snac :=
	dataset('~thor20_11::poc::fs_snac_raw', 
	        layout_snac_raw, 
					csv(heading(1), quote('"'), separator('\t'), terminator(['\r\n', '\n']), maxlength(8192)), 
					opt);



export ds_std_snac := 
	join( file_snac
				,fsAccounts
				//,left.vc_id=left.snac_acct_num 
				,right.CUST_ID = if(left.SNAC_acct_num[1..2]='ST',
				                    StringLib.StringFindReplace(left.SNAC_acct_num,'ST',''),
													  left.snac_acct_num)
				,transform(layout_std_addr,
									 self.business_name := left.SNAC_name_business;
									 self.business_phone := left.SNAC_phone;
									 self.cleanaddr := Address.CleanAddress182(
										stringlib.stringcleanspaces(left.SNAC_std_addr_primary + ' ' + left.SNAC_std_addr_secondary),
										stringlib.stringcleanspaces(if(left.SNAC_std_addr_city + ' ' + left.SNAC_std_addr_state + ' ' + left.SNAC_std_addr_postal_cd <> '', left.SNAC_std_addr_city + ' ' + left.SNAC_std_addr_state + ' ' + left.SNAC_std_addr_postal_cd, 'XXXXX, YY 99999')));
									 self.source := 'snac',
				           self:=right,
					         self:=left;
									 self := [])
				,inner);
// end SNAC data

// Essbase addresses


export spray_essbase :=
	fileservices.sprayVariable( Constants.landing_ip, // dev
                            //'172.25.246.94', // IQ
                            'w:\\poc\\fs_customer_addresses.tsv',
														8192,
														'\\t',
														, , 'thor20_11',
														'poc::fs_essbase_addr'
														,,,,true
													 );

layout_essbase_raw := record
	string cust_cd;
	string cust_sd;
	string cust_str_addr_1;
	string cust_str_addr_2;
	string cust_str_city;
	string cust_str_city_1;
	string cust_str_state;
	string cust_str_zip;
	string cust_str_zip4;
	string cust_main_phone_num;
	string cust_bill_addr_1;
	string cust_bill_addr_2;
	string cust_bill_city;
	string cust_bill_st;
	string cust_bill_zip;
	string cust_bill_zip4;
	integer gl_dt_key;
	integer unit_cnt;
	decimal12_2 sls_amt;
end;


export file_essbase := sort(
	dataset('~thor20_11::poc::fs_essbase_addr', 
	        layout_essbase_raw, 
					csv(heading(1), quote('"'), separator('\t'), terminator(['\r\n', '\n']), maxlength(8192)), 
					opt)
	,cust_cd);



ds_std_esbase_main := 
	join( dedup(file_essbase(cust_str_addr_1!=''),cust_cd)
				,fsAccounts
				//,left.vc_id=left.snac_acct_num 
				,right.CUST_CD = left.cust_cd
				,transform(layout_std_addr,
									 self.business_name := left.cust_sd;
									 self.business_phone := left.cust_main_phone_num;
									 self.cleanaddr := Address.CleanAddress182(
										stringlib.stringcleanspaces(left.cust_str_addr_1 + ' ' + left.cust_str_addr_2),
										stringlib.stringcleanspaces(left.cust_str_city + ' ' + left.cust_str_state + ' ' + left.cust_str_zip));
									 self.source := 'essbase_main',
									 self:=right,
					         self:=left;
									 self := [])
				,inner);

ds_std_esbase_billing := 
	join( dedup(file_essbase(cust_bill_addr_1!=''),cust_cd)
				,fsAccounts
				//,left.vc_id=left.snac_acct_num 
				,right.CUST_CD = left.cust_cd
				,transform(layout_std_addr,
									 self.business_name := left.cust_sd;
									 self.business_phone := left.cust_main_phone_num;
									 self.cleanaddr := Address.CleanAddress182(
										stringlib.stringcleanspaces(left.cust_bill_addr_1 + ' ' + left.cust_bill_addr_2),
									  stringlib.stringcleanspaces(left.cust_bill_city + ' ' + left.cust_bill_st + ' ' + left.cust_bill_zip));
									 self.source := 'essbase_billing',
									 self:=right,
					         self:=left;
									 self := [])
				,inner);

export ds_std_essbase := ds_std_esbase_main + ds_std_esbase_billing;

// end Essbase addresses


// dayton addresses



export spray_dayton :=
	fileservices.sprayVariable( Constants.landing_ip, // dev
                            //'172.25.246.94', // IQ
                            'w:\\poc\\dayton_customer_addresses.tsv',
														8192,
														'\\t',
														, , 'thor20_11',
														'poc::fs_dayton_addr'
														,,,,true
													 );

layout_dayton_raw := record
	string SYS_CD;
	string CUST_CD;
	string VC_ID;
	string MIG_GEN03_CD;
	string CUST_ID;
	string sub_acct_name;
	string line1;
	string line2;
	string city_name;
	string state_cd;
	string postal_cd;
	string main_phone;
end;

export file_dayton :=
	dataset('~thor20_11::poc::fs_dayton_addr', 
	        layout_dayton_raw, 
					csv(heading(1), quote('"'), separator('\t'), terminator(['\r\n', '\n']), maxlength(8192)), 
					opt);


export ds_std_dayton := 
	join( file_dayton
				,fsAccounts
				,right.vc_id = left.vc_id
				,transform(layout_std_addr,
									 self.business_name := left.sub_acct_name;
									 self.business_phone := stringlib.stringfindreplace(left.main_phone,'?','');
									 self.cleanaddr := Address.CleanAddress182(
										stringlib.stringcleanspaces(left.line1 + ' ' + left.line2),
									  stringlib.stringcleanspaces(left.city_name + ' ' + left.state_cd + ' ' + left.postal_cd));
									 self.source := 'dayton',
									 self:=right,
					         self:=left;
									 self := [])
				,inner);

// end dayton addresses

all_addr := ds_std_snac + ds_std_dayton + ds_std_essbase;

export 
	pre_bid:= project(all_addr, TRANSFORM(layout_std_addr,
													self.prim_range := address.CleanAddressFieldsFips(left.cleanaddr).prim_range;//[1..10];
													self.predir := address.CleanAddressFieldsFips(left.cleanaddr).predir;
													self.prim_name := address.CleanAddressFieldsFips(left.cleanaddr).prim_name;
													self.addr_suffix := address.CleanAddressFieldsFips(left.cleanaddr).addr_suffix;
													self.postdir := address.CleanAddressFieldsFips(left.cleanaddr).postdir;
													self.unit_desig := address.CleanAddressFieldsFips(left.cleanaddr).unit_desig;
													self.sec_range := address.CleanAddressFieldsFips(left.cleanaddr).sec_range;
													self.v_city_name := stringlib.stringfindreplace(address.CleanAddressFieldsFips(left.cleanaddr).v_city_name, 'XXXXX YY', '');
													self.st := address.CleanAddressFieldsFips(left.cleanaddr).st;
													self.zip5 :=if( left.cleanaddr[117..121] <> '99999',  left.cleanaddr[117..121], '');
													self.zip4 := address.CleanAddressFieldsFips(left.cleanaddr).zip4;
													self.addr_rec_type := address.CleanAddressFieldsFips(left.cleanaddr).rec_type;
													self.fips_state := address.CleanAddressFieldsFips(left.cleanaddr).fips_state;
													self.fips_county := address.CleanAddressFieldsFips(left.cleanaddr).fips_county;
													self.geo_lat := address.CleanAddressFieldsFips(left.cleanaddr).geo_lat;
													self.geo_long := address.CleanAddressFieldsFips(left.cleanaddr).geo_long;
													self.cbsa := '';
													self.geo_blk := address.CleanAddressFieldsFips(left.cleanaddr).geo_blk;
													self.geo_match := address.CleanAddressFieldsFips(left.cleanaddr).geo_match;
													self.err_stat := address.CleanAddressFieldsFips(left.cleanaddr).err_stat;
													self := left));
													
bdid_match_set := ['A','N','N']; 


TopBusiness_External.MAC_External_BID(pre_bid,
                                      BIDFile,
																			bid,
																			bid_score,
																			,,,
																			business_name,
																			zip5,
																			prim_name,
																			prim_range,
																			,business_phone, // phone
																			true );

export proc_AppendBID :=
	output(BIDFile, ,
				 'poc::fs_addr_bdid_all', 
				 csv(heading(single), quote(''), separator('\t'), terminator('\n')),
				 overwrite
				 );

export file_bid :=
	dataset('~thor20_11::poc::fs_addr_bdid_all', 
	        layout_std_addr, csv(heading(1), quote('"'), separator('\t'), terminator(['\r\n', '\n']), maxlength(10240)), opt);


export file_bid_deduped := dedup(sort(file_bid, mig_gen03_cd, -bid_score),mig_gen03_cd);

end;