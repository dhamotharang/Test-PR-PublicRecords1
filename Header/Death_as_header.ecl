import ut, _Validate, Std;
//Death Master into header layout and create source key
#STORED ('_Validate_Year_Range_Low', '1800'); 
#STORED ('_Validate_Year_Range_high', ((STRING8)Std.Date.Today())[1..4]);
export	Death_as_Header(dataset(header.Layout_Did_Death_MasterV2) pDeath_Master = dataset([],header.Layout_Did_Death_MasterV2), boolean pForHeaderBuild=false, BOOLEAN buildSSARestricted=false)
 :=
  function
	dDeathAsSource	:=	if(pForHeaderBuild,header.Files_SeqdSrc().DE,Death_as_Source(pDeath_Master,pForHeaderBuild,buildSSARestricted));

    //216 is the number of months equivalent to 18 years
	dDropMinors := dDeathAsSource((trim(dod8) ='' and trim(dob8) ='')
	                           or (trim(dod8)!='' and trim(dob8)!='' and (header.ConvertYYYYMMToNumberOfMonths((integer)dod8) - header.ConvertYYYYMMToNumberOfMonths((integer)dob8) >= 216))
	                           or header.ConvertYYYYMMToNumberOfMonths((integer)dob8) between 0 and header.ConvertYYYYMMToNumberOfMonths((integer)ut.GetDate)-216
							   );

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
	
	
	Layout_New_Records into_fat(dDeathAsSource le) := transform
	  self.did        := 0;
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
	  self.st         := IF(le.clnstate <> '',le.clnstate,le.state);
	  self.county     := le.county;
	  self.cbsa       := '';
	  self.zip        := if(le.zip5<>'',le.zip5,
													IF(le.zip_lastres <>'',le.zip_lastres,le.zip_lastpayment));
	  self            := le;
	  end;

	death_in := project(dDeathAsSource,into_fat(left));
	
	//drop records that only have a name and date_of_death
	keep_these := death_in(fname<>'' and lname<>'' and (ssn<>'' or dob>0));

    return keep_these;
  end
 ;