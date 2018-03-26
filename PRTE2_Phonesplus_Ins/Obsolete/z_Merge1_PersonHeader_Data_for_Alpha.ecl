IMPORT PRTE2_Phonesplus_Ins, PRTE2_Header_Ins, ut;
// stick our person header data into the Boca phones plus file 
//       alpha peopleheader has 48512 records, Boca phones has 38271, we'll end up with 
//			 38271 records that will have DIDs matching the first 38271 records in our Header Base.
// There were 4 fields I'm not sure how where they can come from 
// SO NOTE - I just KEPT the Boca PRTE data values for these!!!
// ?? name_score, did_score, ace_fips_st, ace_fips_county ??

STRING fileVersion := ut.GetDate+'';
appendIf(STRING s1, STRING s2) := TRIM(IF(s1='', s2, TRIM(s1)+' '+TRIM(s2) ));
appendIf3(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2),s3);
appendIf4(STRING s1, STRING s2, STRING s3, STRING s4) := appendIf(appendIf3(s1,s2,s3),s4);
appendIf5(STRING s1, STRING s2, STRING s3, STRING s4, STRING s5) := appendIf(appendIf4(s1,s2,s3,s4),s5);

// ------------------ Initial layouts with counters added --------------------
DSH1Layout := RECORD
	INTEGER6 Counter := 0;
	PRTE2_Header_Ins.Layouts.newBaseLayout;
END;	
DSPLayout := PRTE2_Phonesplus_Ins.Layouts.Alpha_CSV_Layout;
DSP1Layout := RECORD
	INTEGER6 Counter := 0;
	DSPLayout;
END;

// ---------------------------------------------------------------------------
DS_HDR := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
DSP := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS;

DSH1Layout XForm1(DS_HDR L,CNT) := TRANSFORM
	SELF.Counter := CNT;
	SELF := L;
END;
DSH1 := PROJECT(DS_HDR,XForm1(LEFT,COUNTER));

DSP1Layout XFormP1(DSP L,CNT) := TRANSFORM
	SELF.Counter := CNT;
	SELF := L;
END;

DSP1 := PROJECT(DSP,XFormP1(LEFT,COUNTER));

// --- Now we have two files each have counters on them - randomly join data from each ---
// ----- Now using the Counter (random), join and fill in the fields we need --------------
DSPNew := JOIN(DSP1,DSH1,
					left.Counter = right.Counter
					,TRANSFORM({DSP}
											,self.l_did:=right.did
											,self.datefirstseen:=right.dt_first_seen
											,self.datelastseen:=right.dt_last_seen
											,self.title:=right.title
											,self.fname:=right.fname
											,self.mname:=right.mname
											,self.lname:=right.lname
											,self.origname := appendIf3(right.fname,right.mname,right.lname)
											,self.name_suffix:=right.name_suffix
											,self.prim_range:=right.prim_range
											,self.predir:=right.predir
											,self.prim_name:=right.prim_name
											,self.addr_suffix:=right.addr_suffix
											,self.postdir:=right.postdir
											,self.unit_desig:=right.unit_desig
											,self.sec_range:=right.sec_range
											,self.address1 := appendIf5(right.prim_range,right.predir,right.prim_name,right.suffix,right.postdir)
											,self.address2 := appendIf(right.unit_desig,right.sec_range)
											,self.p_city_name:=right.p_city_name
											,self.v_city_name:=right.v_city_name
											,self.state:=right.st
											,self.zip5:=right.zip
											,self.zip4:=right.zip4
											,self.origcity:=right.v_city_name
											,self.origstate:=right.st
											,self.origzip:=right.zip
											,self.cart:=right.cart
											,self.cr_sort_sz:=right.cr_sort_sz
											,self.lot:=right.lot
											,self.lot_order:=right.lot_order
											,self.dpbc:=right.dbpc
											,self.chk_digit:=right.chk_digit
											,self.rec_type:=right.rec_type
											,self.geo_lat:=right.geo_lat
											,self.geo_long:=right.geo_long
											,self.msa:=right.msa
											,self.geo_blk:=right.geo_blk
											,self.geo_match:=right.geo_match
											,self.err_stat:=right.err_stat
											,self.gender:= ut.GenderTools.gender(right.fname,right.mname)
											,self.homephone:=right.phone
											,self.cellphone:=''		// we should add some phone numbers later
											,self.did:=left.l_did
											,self:=left)
										// ?? name_score, did_score, ace_fips_st, ace_fips_county ??
					,LEFT OUTER  
					);

OUTPUT(DSPNew,,'~prte::bruce::tmp2',overwrite);

// Can save to temp file above or do a generational replace of the QA files

// RoxieKeyBuild.Mac_SF_BuildProcess_V2(DSPNew,
																		 // PRTE2_Phonesplus_Ins.Files.BASE_PREFIX_NAME, 
																		 // PRTE2_Phonesplus_Ins.Files.BASE_NAME,
																		 // fileVersion, buildBase, 3,
																		 // false,true);

// SEQUENTIAL(buildBase);