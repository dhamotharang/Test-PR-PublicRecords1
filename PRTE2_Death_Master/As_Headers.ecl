import ut, _Validate, HEADER, prte2_death_master;
EXPORT As_Headers := MODULE
	export	Death_as_Header(dataset(header.Layout_Did_Death_MasterV2) pDeath_Master = Files.Death_Master_Header
													,  BOOLEAN buildSSARestricted=false)  := function

  
	ExpDeathMaster := header.Layout_DID_Death_MasterV2_expanded;
	ExpDeathMaster AddClnAddress(pDeath_Master l) := TRANSFORM
				self.clnstate := l.state;
				self := l;
				self := [];
	end;
	dDeathsSrcV2 := PROJECT(pDeath_Master, AddClnAddress(LEFT));
	src_rec := header.layouts_SeqdSrc.DE_src_rec;
	header.Mac_Set_Header_Source(dDeathsSrcV2(crlf<>'SA'),ExpDeathMaster,src_rec, header.Death_src_for_header(l.state_death_id[1..2],l.death_rec_src,l.dod8), with_id)
  dDeathAsSource := with_id;	
	
	setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
	string fGetSuffix(string SuffixIn) := map(SuffixIn = '1' => 'I',SuffixIn in ['2','ND'] => 'II'
								,SuffixIn in ['3','RD'] => 'III'
								,SuffixIn = '4' => 'IV'
								,SuffixIn = '5' => 'V'
								,SuffixIn = '6' => 'VI'
								,SuffixIn = '7' => 'VII'
								,SuffixIn = '8' => 'VIII'
								,SuffixIn = '9' => 'IX'
								,SuffixIn in setValidSuffix => SuffixIn
								,'');
	header.Layout_New_Records into_fat(dDeathAsSource le) := transform
	  self.did        := (integer) le.did;
	  self.rid        := 0;
		tempDOD8 := (unsigned)_validate.date.fCorrectedDateString((string)le.dod8,false);
	  self.dt_first_seen            := ut.MOB(tempDOD8);
	  self.dt_last_seen             := ut.MOB(tempDOD8);
	  self.dt_vendor_first_reported := ut.MOB(tempDOD8);
	  self.dt_vendor_last_reported  := ut.MOB(tempDOD8);
	  self.dt_nonglb_last_seen      := ut.MOB(tempDOD8);
	  self.vendor_id  := '';
	  self.phone      := '';
	  self.dob        := (unsigned)_validate.date.fCorrectedDateString((string)le.dob8,false);
	  self.title      := '';
		self.name_suffix := fGetSuffix(le.name_suffix);
	  self.suffix     := le.addr_suffix;
	  self.city_name  := le.v_city_name;
	  self.st         := le.state;
	  self.county     := le.county;//IF(le.fips_county <> '',trim(le.fips_county,left,right),'');
	  self.cbsa       := '';
	  self.zip        := if(le.zip5<>'',le.zip5,
				IF(le.zip_lastres <>'',le.zip_lastres,le.zip_lastpayment));
	  //self.rawaid := (integer)le.rawaid;
	  self            := le;
	  end;

	death_in := project(dDeathAsSource,into_fat(left));
	
	//drop records that only have a name and date_of_death
	keep_these := death_in(fname<>'' and lname<>'' and (ssn<>'' or dob>0));

    return keep_these;
  end;
END;