import Prof_License_Mari,Address;

lBaseFileName := Prof_License_Mari.Common_Prof_Lic_Mari.MariDestpath;
// lBaseFileName	:=	'~thor_data400::in::prolic::mari::';

in_file := dataset('~thor_data400::out::prolic::mariflat_base',Prof_License_Mari.layouts_Reference.MARIFLAT_out,thor);


update_file := dataset(lBaseFileName + 'S0644',	Prof_License_Mari.layouts_reference.MARIBASE,thor) 	
						 + dataset(lBaseFileName + 'S0021',	Prof_License_Mari.layouts_reference.MARIBASE,thor)
						 + dataset(lBaseFileName + '20111212::S0900',Prof_License_Mari.layouts_reference.MARIBASE,thor);

// update_file := dataset('~thor_data400::in::prolic::mari::20111212::S0900',Prof_License_Mari.layouts_reference.MARIBASE,thor);
					
// src_test := in_file(std_source_upd in ['S0644','S0021']);
// src_test := in_file(prev_mltreckey != 0);
// src_test := in_file(type_cd = 'GR' and (license_nbr = 'NR' or license_nbr = ''));

ds_source_ma := PROJECT(update_file, TRANSFORM(Prof_License_Mari.layouts_Reference.MARIFLAT_out,
																		  self.TMP_NAME_COMPANY := '';
																			self.TMP_NAME_DBA			:= '';
																			self.PREV_PRIMARY_KEY := 0;
																			self.PREV_MLTRECKEY	  := 0;
																			self.PREV_CMC_SLPK		:= 0;
																			self.PREV_PCMC_SLPK 	:= 0;
																			SELF := LEFT;
																			self := [];
																			));
// test_file := src_test + ds_source_ma;

layout_mari_std := record
	Prof_License_Mari.layouts_Reference.MARIFLAT_out;
	string182	cln_address;
END;

layout_mari_std tProjectAddrClean(Prof_License_Mari.layouts_Reference.MARIFLAT_out L) := TRANSFORM
		CitySTZip := StringLib.StringCleanSpaces(L.Addr_City_1+ L.Addr_State_1 + L.Addr_Zip5_1);
		AddrZip := StringLib.StringCleanSpaces(L.Addr_Addr1_1 + L.Addr_Addr2_1 + L.Addr_Zip5_1);
		SELF.cln_address			:= MAP(trim(L.ADDR_CNTRY_1) != '' or (StringLib.StringFind(L.Addr_City_1,'CANADA',1) > 0 
																and L.Addr_City_1[1..9] not in ['LA CANADA', 'LITTLE CA','NEW CANAD'])
																or L.Addr_State_1[1..2] in ['AB','BC','MB','NF','NT','NS','CN','ON','PE','QC','SK','YT'] => '',
																CitySTZip = '' => '',
																AddrZip = '' and L.Addr_City_1 != '' => '',
																Address.CleanAddress182(TRIM(L.addr_addr1_1+' '+L.addr_addr2_1),TRIM(L.addr_city_1+' '+L.addr_state_1+' '+L.addr_zip5_1))
																		);
		SELF := L;
END;		

ds_source_std	:= PROJECT(ds_source_ma, tProjectAddrClean(LEFT));
		
file_sort     := sort(distribute(ds_source_std, hash(STD_SOURCE_UPD,LICENSE_NBR)),STD_SOURCE_UPD,LICENSE_NBR, NAME_ORG_ORIG, NAME_DBA_ORIG, ADDR_ADDR1_1, ADDR_ADDR2_1, -STAMP_DTE, -LAST_UPD_DTE, -CREATE_DTE,local);

layout_mari_std  rollupXform(layout_mari_std l, layout_mari_std r) := transform
		self.Create_dte := if(l.create_dte > r.create_dte, r.create_dte, l.create_dte);
		self.Last_Upd_dte  := if(l.last_upd_dte  > r.last_upd_dte, r.last_upd_dte, l.last_upd_dte);
		self.Stamp_dte    := if(l.stamp_dte > r.stamp_dte, l.stamp_dte, r.stamp_dte);
		self.addr_addr1_1				:= if(l.stamp_dte > r.stamp_dte and l.addr_addr1_1 != '', l.addr_addr1_1, r.addr_addr1_1);
		self.addr_addr2_1				:= if(l.stamp_dte > r.stamp_dte and l.addr_addr2_1 != '', l.addr_addr2_1, r.addr_addr2_1);
		self.addr_city_1				:= if(l.stamp_dte > r.stamp_dte and l.addr_city_1 != '', l.addr_city_1, r.addr_city_1);
		self.addr_state_1				:= if(l.stamp_dte > r.stamp_dte and l.addr_state_1 != '', l.addr_state_1, r.addr_state_1);
		self.addr_zip5_1				:= if(l.stamp_dte > r.stamp_dte and l.addr_zip5_1 != '', l.addr_zip5_1, r.addr_zip5_1);
		self.addr_zip4_1				:= if(l.stamp_dte > r.stamp_dte and l.addr_zip4_1 != '', l.addr_zip4_1, r.addr_zip4_1);
		self.addr_cnty_1				:= if(l.stamp_dte > r.stamp_dte and l.addr_cnty_1 != '', l.addr_cnty_1, r.addr_cnty_1);
		self.addr_addr1_2				:= if(l.stamp_dte > r.stamp_dte and l.addr_addr1_2 != '', l.addr_addr1_2, r.addr_addr1_2);
		self.addr_addr2_2				:= if(l.stamp_dte > r.stamp_dte and l.addr_addr2_2 != '', l.addr_addr2_2, r.addr_addr2_2);
		self.addr_city_2				:= if(l.stamp_dte > r.stamp_dte and l.addr_city_2 != '', l.addr_city_2, r.addr_city_2);
		self.addr_state_2				:= if(l.stamp_dte > r.stamp_dte and l.addr_state_2 != '', l.addr_state_2, r.addr_state_2);
		self.addr_zip5_2				:= if(l.stamp_dte > r.stamp_dte and l.addr_zip5_2 != '', l.addr_zip5_2, r.addr_zip5_2);
		self.addr_zip4_2				:= if(l.stamp_dte > r.stamp_dte and l.addr_zip4_2 != '', l.addr_zip4_2, r.addr_zip4_2);
		self.addr_cnty_2				:= if(l.stamp_dte > r.stamp_dte and l.addr_cnty_2 != '', l.addr_cnty_2, r.addr_cnty_2);
		self.affil_type_cd			:= if(l.stamp_dte > r.stamp_dte, l.affil_type_cd, r.affil_type_cd);
		self.prev_primary_key		:= if(l.last_upd_dte  > r.last_upd_dte, r.prev_primary_key, l.prev_primary_key);
		self.prev_mltreckey			:= if(l.last_upd_dte  > r.last_upd_dte,	r.prev_mltreckey, l.prev_mltreckey);
		self.prev_cmc_slpk			:= if(l.last_upd_dte  > r.last_upd_dte,	r.prev_cmc_slpk, l.prev_cmc_slpk);
		self.prev_pcmc_slpk			:= if(l.last_upd_dte  > r.last_upd_dte,	r.prev_pcmc_slpk, l.prev_pcmc_slpk);
		// self.date_First_Reported := if(l.date_First_Reported > r.date_First_Reported, r.date_First_Reported, l.date_First_Reported);
		// self.date_Last_Reported  := if(l.date_Last_Reported  < r.date_Last_Reported,  r.date_Last_Reported, l.date_Last_Reported);
		self := l;
end;


file_rollup := ROLLUP(file_sort,
												trim(LEFT.std_source_upd)= trim(RIGHT.std_source_upd)
													and trim(LEFT.std_license_type)= trim(RIGHT.std_license_type)
													and trim(LEFT.license_nbr)= trim(RIGHT.license_nbr)
													and trim(LEFT.name_org_orig)=trim(RIGHT.name_org_orig)
													and trim(LEFT.name_dba_orig)=trim(RIGHT.name_dba_orig)
													and trim(LEFT.name_dba)=trim(RIGHT.name_dba)
													// and StringLib.StringFilterOut(left.addr_addr1_1[1..7],' ') = StringLib.StringFilterOut(right.addr_addr1_1[1..7],' '),
													and trim(LEFT.cln_address[1..46],left,right)=trim(RIGHT.cln_address[1..46],left,right)
													and trim(LEFT.cln_address[90..121],left,right)=trim(RIGHT.cln_address[90..121],left,right),
														rollupXFORM(LEFT, RIGHT));
						
file_base := project(file_rollup, TRANSFORM(Prof_License_Mari.layouts_Reference.MARIFLAT_out,
																							SELF := LEFT;
																							// self := [];
																							));

// file_rollout := ROLLUP(file_sort,
												// trim(LEFT.std_source_upd)= trim(RIGHT.std_source_upd)
													// and trim(LEFT.license_nbr)= trim(RIGHT.license_nbr)
													// and trim(LEFT.name_org_orig)=trim(RIGHT.name_org_orig)
													// and trim(LEFT.name_dba_orig)=trim(RIGHT.name_dba_orig)
													// and trim(LEFT.name_dba)=trim(RIGHT.name_dba),
														// rollupXFORM(LEFT, RIGHT));						
						
						
diff_source  := ds_source_std - file_rollup;
						
// export BWR_MariFlat := rollup(file_sort,rollupXform(LEFT,RIGHT),RECORD,
                                // EXCEPT Stamp_dte, Create_dte, Last_Upd_dte
																			// date_First_Reported, date_Last_Reported,
																					// SANC_UNAMB_IND
																					// );						
output(choosen(file_sort,1000));
output(choosen(file_rollup,1000));
// output(count(src_test));

// output(choosen(file_sort(prev_cmc_slpk in 
// [10396579,10005330,3911684,3907536,4279612,3932046,3932227,3934791,3940078,3909078,
// 3907335,3923286,3918624,3907413,3907421,3930749,3916368,3919809,3927611,3939146,
// 3907701,3942734,3944620,3907900,3907954,3908027,3909163,3909284,3909324,3909642,
// 3909676,3910794,3911008,3911042,3911411,4110988,3911701,3913024,3913559,3913658,
// 3913719,3913781,3914202,3914954,3915033,3915230,3916344,3916388,3916807,3917026,
// 3918101,3918174,3919602,3919680,3920235,8469850,3920583,3920777,3920780,3921338,
// 3922663,4111628,3923362,3923897,3924461,4111852,3925190,3925190,3925808,3927549,
// 3927549,3927555,3927802,3929075,3929075,3929895,3930423,3930560,3930826,3931624,
// 4190925,3931889,3931889,3932103,3932345,3932595,3932831,3933962,3934359,3934748,
// 3936110,3936122,3936277,3938419,3940344,3940453,3941636,4112888,3944517,3910936,
// 3923026,3924396,3907429,3928006,3907540,3934386,3907584,3907585,3938716,3907705,
// 3907726,3907948,3908095,3908119,3908146,3908312,3908404]),500));
// output(choosen(file_rollout(prev_cmc_slpk in 
// [10396579,10005330,3911684,3907536,4279612,3932046,3932227,3934791,3940078,3909078,
// 3907335,3923286,3918624,3907413,3907421,3930749,3916368,3919809,3927611,3939146,
// 3907701,3942734,3944620,3907900,3907954,3908027,3909163,3909284,3909324,3909642,
// 3909676,3910794,3911008,3911042,3911411,4110988,3911701,3913024,3913559,3913658,
// 3913719,3913781,3914202,3914954,3915033,3915230,3916344,3916388,3916807,3917026,
// 3918101,3918174,3919602,3919680,3920235,8469850,3920583,3920777,3920780,3921338,
// 3922663,4111628,3923362,3923897,3924461,4111852,3925190,3925190,3925808,3927549,
// 3927549,3927555,3927802,3929075,3929075,3929895,3930423,3930560,3930826,3931624,
// 4190925,3931889,3931889,3932103,3932345,3932595,3932831,3933962,3934359,3934748,
// 3936110,3936122,3936277,3938419,3940344,3940453,3941636,4112888,3944517,3910936,
// 3923026,3924396,3907429,3928006,3907540,3934386,3907584,3907585,3938716,3907705,
// 3907726,3907948,3908095,3908119,3908146,3908312,3908404]),500));

// output(file_sort(prev_cmc_slpk in 
		// [5819482,5819486,5819500,5819501,5819553,
// 5819555,5819562,5819582,5819589,5819615,
// 5819616,5819617,5819620,5819623,5819627,
// 5819633,5819639,5819647,5819652,5819659,
// 5819663,5819666,5819675,5819680,5819683]));

// output(file_rollout(prev_cmc_slpk in 
		// [5819482,5819486,5819500,5819501,5819553,
// 5819555,5819562,5819582,5819589,5819615,
// 5819616,5819617,5819620,5819623,5819627,
// 5819633,5819639,5819647,5819652,5819659,
// 5819663,5819666,5819675,5819680,5819683]));
output(ds_source_std);



// output(ds_source_ma);
// output(src_test);
// output(count(test_file));
// output(count(file_rollout));
// output(count(diff_source));
output(choosen(diff_source,1000));
output(file_base);

// output(count(file_rollout(stamp_dte[1..6] != '201111')));
// output(count(file_rollout(create_dte[1..6] = '201111')));