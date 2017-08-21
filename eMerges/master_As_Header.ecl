import header;

export	Master_as_header(dataset(emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout) peMerges = dataset([],emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout), boolean pForHeaderBuild=false,boolean isPRCT=false)
 :=
  function
	deMergesAsSource	:=	if(pForHeaderBuild,header.Files_SeqdSrc().EM,eMerges.Master_as_Source(peMerges,pForHeaderBuild));

	header.Layout_New_Records header_trans(deMergesAsSource L, integer c) := transform
  	SELF.did := If(IsPRCT,(integer)l.DID_out,0);
		//self.did := 0;
		self.rid := 0;
		self.vendor_id := trim(l.source) + trim(l.vendor_id);
		self.rec_type := '2'; 
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';
		self.ssn := '';
		self.dob := if((integer)l.dob_str in [19000101,19010101],0,(integer)l.dob_str);
		self.tnt := '';
		self.dt_first_seen := (integer)(l.date_first_seen[1..6]);
		self.dt_last_seen := (integer)(l.date_last_seen[1..6]);
		self.dt_vendor_last_reported := (integer)(l.date_last_seen[1..6]);
		self.dt_vendor_first_reported := (integer)(l.date_first_seen[1..6]);
		self.dt_nonglb_last_seen := 0;
		self.RawAID	:=	choose(c,l.Append_ResRawAID,l.Append_MailRawAID);
		self.prim_range := choose(c,l.AID_ResClean_prim_range,l.AID_MailClean_prim_range);
		self.predir := choose(c,l.AID_ResClean_predir,l.AID_MailClean_predir);
		self.prim_name := choose(c,l.AID_ResClean_prim_name,l.AID_MailClean_prim_name);
		self.suffix := choose(c,l.AID_ResClean_addr_suffix,l.AID_MailClean_addr_suffix);
		self.postdir := choose(c,l.AID_ResClean_postdir,l.AID_MailClean_postdir);
		self.unit_desig := choose(c,l.AID_ResClean_unit_desig,l.AID_MailClean_unit_desig);
		self.sec_range := choose(c,l.AID_ResClean_sec_range,l.AID_MailClean_sec_range);
		self.city_name := choose(c,l.AID_ResClean_v_city_name,l.AID_MailClean_v_city_name);
		self.st := choose(c,l.AID_ResClean_st,l.AID_MailClean_st);
		self.zip := choose(c,l.AID_ResClean_zip,l.AID_MailClean_zip);
		self.zip4 := choose(c,l.AID_ResClean_zip4,l.AID_MailClean_zip4);
		self.county := choose(c,l.AID_ResClean_fipscounty,l.AID_MailClean_fipscounty);
		self.cbsa := choose(c,l.AID_ResClean_msa + '0',l.AID_MailClean_msa + '0');
		self.geo_blk := choose(c,l.AID_ResClean_geo_blk,l.AID_MailClean_geo_blk);
		self := L;
	end;

	pre_master_as_Header := normalize(deMergesAsSource((AID_ResClean_prim_name != '' or AID_MailClean_prim_name!='')and lname != ''),2,header_trans(LEFT,counter));

	dFiltered	:=	pre_master_as_Header(prim_name <> '', 
										 lname <> '',
										 length(trim(fname)) > 1,
										 zip4 <> ''
										);
    return dFiltered;
  end
 ;
