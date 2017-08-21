import business_header,business_header_ss,did_add,mdr,BIPV2,PromoteSupers;

df := govdata.File_OR_Workers_Comp_In;

seqrec := record
	df;
	unsigned4	seq;
end;

seqrec into_seq(df L, integer C) := transform
	self.seq := C;
	self := L;
end;

df2 := project(df,into_seq(LEFT,COUNTER));

myRec := record
  BIPV2.IDlayouts.l_xlink_ids;	
	unsigned6	bdid;
	unsigned1	score;
	string10	phone;
	string10	prim_range;
	string28	prim_name;
	string10	sec_range;
	string5	zip;
	string25 p_city_name;
	string2	st;
	string100	name;
	unsigned4	seq;
end;

myrec into_temp(df2 L, integer C) := transform
	self.ultid      := 0;
  self.orgid      := 0;
  self.seleid     := 0;
  self.proxid     := 0;
  self.powid      := 0;
  self.empid      := 0;
  self.dotid      := 0;
  self.ultscore   := 0;
  self.orgscore   := 0;
  self.selescore  := 0;
  self.proxscore  := 0;
  self.powscore   := 0;
  self.empscore   := 0;
  self.dotscore   := 0;
  self.ultweight  := 0;
  self.orgweight  := 0;
  self.seleweight := 0;
  self.proxweight := 0;
  self.powweight  := 0;
  self.empweight  := 0;
  self.dotweight  := 0;
	self.name := L.employer_legal_name;
	self.phone := L.ppb_phone_number;
	self.prim_range := if (C = 1, L.ppb_prim_range, L.mailing_prim_Range);
	self.prim_name := if (C = 1, L.ppb_prim_name, L.mailing_prim_name);
	self.sec_range := if (C = 1, L.ppb_sec_range, L.mailing_sec_range);
	self.p_city_name := if (C = 1, L.ppb_p_city_name,L.mailing_p_city_name);
	self.zip := If (C = 1, L.ppb_zip5,L.mailing_zip5);
	self.st := If (C = 1, L.ppb_st, L.mailing_st);
	self.seq := L.seq;
	self.bdid := 0;
	self.score := 0;
end;

df3 := normalize(df2,2,into_temp(LEFT,COUNTER));

business_header.MAC_Source_Match(df3,o1,
						false,bdid,
						false,MDR.sourceTools.src_OR_Worker_Comp,
						false,foo,
						Name,
						prim_range,prim_name,sec_range,zip,
						true,Phone,
						false, foo)

// we want these at the top of the sort order.
myrec add_fake_score(o1 L) := transform
	self.score := if (L.bdid != 0,101,L.score);
	self := l;
end;

o2 := project(o1,add_fake_score(LEFT));

myset := ['A','P'];

Business_Header_SS.MAC_Add_BDID_Flex(o2                       // Input Dataset
                                     ,myset                   // BDID Matchset
                                     ,name                    // company_name
                                     ,prim_range              // prim_range
																		 ,prim_name               // prim_name
																		 ,zip                     // zip5
                                     ,sec_range               // sec_range
																		 ,st                      // state
                                     ,phone                   // phone
																		 ,foo                     // fein
                                     ,bdid                    // bdid
																		 ,myrec                   // Output Layout
                                     ,true                    // output layout has bdid score field?
																		 ,score                   // bdid_score
                                     ,o3                      // Output Dataset   
	                                   ,												// default threscold
	                                   ,											  // use prod version of superfiles
                                     ,												// default is to hit prod from dataland, and on prod hit prod.		
	                                   ,BIPV2.xlink_version_set // Create BIP Keys only
	                                   ,           					   	// Url
	                                   ,								        // Email
	                                   ,p_city_name         		// City
	                                   ,              		      // fname
                                     ,              	      	// mname
	                                   ,              	        // lname
  																	 ,                        // contact_ssn
																		 ,                        // source - MDR.sourceTools
																		 ,                        // source_record_id
																		 ,FALSE                   // src_matching_is_priority
                                     );			

outf := dedup(sort(distribute(o3,hash(seq)),seq,-score,bdid,local),seq,local);

govdata.Layout_OR_Workers_Comp_Base into_final(df2 L, outf R) := transform
	self.ultid      := R.ultid;
  self.orgid      := R.orgid;
  self.seleid     := R.seleid;
  self.proxid     := R.proxid;
  self.powid      := R.powid;
  self.empid      := R.empid;
  self.dotid      := R.dotid;
  self.ultscore   := R.ultscore;
  self.orgscore   := R.orgscore;
  self.selescore  := R.selescore;
  self.proxscore  := R.proxscore;
  self.powscore   := R.powscore;
  self.empscore   := R.empscore;
  self.dotscore   := R.dotscore;
  self.ultweight  := R.ultweight;
  self.orgweight  := R.orgweight;
  self.seleweight := R.seleweight;
  self.proxweight := R.proxweight;
  self.powweight  := R.powweight;
  self.empweight  := R.empweight;
  self.dotweight  := R.dotweight;		
	self.bdid := R.bdid;
	self := L;
end;

outfinal := join(distribute(df2,hash(seq)),outf,left.seq = right.seq,
				into_final(LEFT,RIGHT),local,left outer);

PromoteSupers.MAC_SF_BuildProcess(outfinal,'~thor_data400::base::OR_workers_comp',do1,2);

export Make_OR_Workers_Comp_BDID := do1;
			
