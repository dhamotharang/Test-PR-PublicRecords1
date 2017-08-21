//See Header.Death_as_header

//-	Header.File_DID_Death_MasterV3_ssa (All sources, including restricted SSA recs)
//-	Header.File_DID_Death_MasterV2_ssa (SSA, state and obit sources; excludes bureau sources)


IMPORT Header,Death_Master,ut, _Validate;
//Death Master into header layout and create source key
//#STORED ('_Validate_Year_Range_Low', '1800'); 
//#STORED ('_Validate_Year_Range_high', ut.GetDate[1..4]);


EXPORT	Death_restricted_as_Header(DATASET(Header.Layout_Did_Death_MasterV3) pDeath_Master = dataset([],header.Layout_Did_Death_MasterV3)):=
	FUNCTION
		dDeathAsSource	:=	Header.File_DID_Death_MasterV3_ssa((death_rec_src='SSA' AND Death_Master.isDateSSARestricted(dod8))
																													 OR death_rec_src = 'TEX'
																													 );

/*
			//216 is the number of months equivalent to 18 years
		dDropMinors := dDeathAsSource((trim(dod8) ='' and trim(dob8) ='')
															 or (trim(dod8)!='' and trim(dob8)!='' and (header.ConvertYYYYMMToNumberOfMonths((integer)dod8) - header.ConvertYYYYMMToNumberOfMonths((integer)dob8) >= 216))
															 or header.ConvertYYYYMMToNumberOfMonths((integer)dob8) between 0 and header.ConvertYYYYMMToNumberOfMonths((integer)ut.GetDate)-216
									 );
*/
	setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
	string fGetSuffix(string SuffixIn) := MAP(SuffixIn = '1' => 'I',SuffixIn in ['2','ND'] => 'II'
																																	,SuffixIn in ['3','RD'] => 'III'																																	,'');
		
Layout_Header_base_plus_DOD := 
	RECORD
		unsigned6    did := 0;
		unsigned6    rid := 0;
		string1 	 pflag1 := '';
		string1		 pflag2 := '';
		string1		 pflag3 := '';
		string2      src := '';
		unsigned3    dt_first_seen := 0;
		unsigned3    dt_last_seen := 0;
		unsigned3    dt_vendor_last_reported := 0;
		unsigned3    dt_vendor_first_reported := 0;
		unsigned3    dt_nonglb_last_seen := 0;
		string1      rec_type := '';
		qstring18    vendor_id := '';
		qstring10    phone := '';
		qstring9     ssn := '';
		integer4     dob := 0;
		qstring5     title := '';
		qstring20    fname := '';
		qstring20    mname := '';
		qstring20    lname := '';
		qstring5     name_suffix := '';
		qstring10    prim_range := '';
		string2      predir := '';
		qstring28    prim_name := '';
		qstring4     suffix := '';
		string2      postdir := '';
		qstring10    unit_desig := '';
		qstring8     sec_range := '';
		qstring25    city_name := '';
		string2      st := '';
		qstring5     zip := '';
		qstring4     zip4 := '';
		string3      county := '';
		qstring7	   geo_blk := '';
		qstring5     cbsa := '';
		string1      tnt := ' ';
		string1	   valid_SSN := '';
		string1	   jflag1 := '';
		string1      jflag2 := '';
		string1	   jflag3 := '';
		unsigned8   RawAID := 0; 
		string5    Dodgy_tracking:= '';
		unsigned8  NID:=0;
		unsigned2  address_ind:=0;
		unsigned2  name_ind:=0;
		unsigned8 persistent_record_ID := 0; //tracking the record between full header and individual dataset
		
		string8 DOD_from_LNDMF := '';
	END;


//		Header.Layout_New_Records into_fat(dDeathAsSource le) := transform
		Layout_Header_base_plus_DOD into_fat(dDeathAsSource le) := TRANSFORM
			self.did        := (unsigned6) le.did;
			self.rid        := 0;
			self.src        := MAP(le.death_rec_src = 'SSA' => 'D$'
														,le.death_rec_src = 'TEX' => 'DX'
														 ,'');
			tempDOD8 := (unsigned)_validate.date.fCorrectedDateString((string)le.dod8,false);
			self.dt_first_seen            := ut.MOB(tempDOD8);
			self.dt_last_seen             := ut.MOB(tempDOD8);
			self.dt_vendor_first_reported := ut.MOB(tempDOD8);
			self.dt_vendor_last_reported  := ut.MOB(tempDOD8);
			self.dt_nonglb_last_seen      := ut.MOB(tempDOD8);
//			self.vendor_id  := '';
			self.vendor_id  := le.state_death_id;
			self.dob        := (unsigned)_validate.date.fCorrectedDateString((string)le.dob8,false);
			self.name_suffix := fGetSuffix(le.name_suffix);
			self.st         := le.state;
			self.county     := le.fipscounty;
			self.zip        := IF(le.zip_lastres <>'',le.zip_lastres,le.zip_lastpayment);
			
			self.DOD_from_LNDMF  := le.dod8;
			self            := le;
			end;

		death_in := PROJECT(dDeathAsSource,into_fat(left));
		
		//drop records that only have a name and date_of_death
//		keep_these := death_in(fname<>'' and lname<>'' and (ssn<>'' or dob>0));

//    return keep_these;
    return death_in;
  END;
	
//-------------------------------------------------------------------------------------------------
