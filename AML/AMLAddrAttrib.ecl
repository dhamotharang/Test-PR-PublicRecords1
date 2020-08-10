import Easi, risk_indicators, Riskwise, ADVO, business_risk, Address_Attributes, AML, doxie;

export AMLAddrAttrib(GROUPED DATASET(Risk_indicators.layout_output) AMLAddr, doxie.IDataAccess mod_access) := FUNCTION 


used_census := EASI.Layout_Easi_Census;
crimeGeolink := Address_Attributes.key_crime_geolink;


	Layout_AMLAddr := record
		Risk_indicators.layout_output;
		integer   dt_first_seen;
		string4	  EasiTotCrime;
		string1		Address_Vacancy_Indicator;
	  string1		Throw_Back_Indicator;
	  string1		Seasonal_Delivery_Indicator;
	  string1		Residential_or_Business_Ind;
		string15  bdid;
		string1   AddrType;
		boolean   BusAddr;
		boolean   HRBusPct;
		
	ENd;
	
// easi census	
	easiCensus := join(AMLAddr, Easi.Key_Easi_Census,
		keyed(right.geolink=left.st+left.county+left.geo_blk),
		transform(Layout_AMLAddr, 
      self.EasiTotCrime := right.totcrime;
						self := left;
			self := [];
		), left outer,
		ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));
																						
//high risk

Layout_AMLAddr hrtrans(AMLAddr l, risk_indicators.key_HRI_Address_To_SIC r) := transform
  baddrtype		 := if (L.prim_name = '', '', risk_indicators.iid_constants.dwelltype(L.addr_type));
	self.hriskaddrflag := MAP(baddrtype = 'M' => '3',
						 l.prim_name='' OR l.z5='' => '5',
						 r.sic_code='' => '0',            
						 r.sic_code<>'' => '4',
						 '');
	self.dwelltype := Risk_Indicators.iid_constants.dwelltype(L.addr_type);	
	self 			:= l;
	self      := [];
END;


AddrHRrec := join(AMLAddr,  risk_indicators.key_HRI_Address_To_SIC,
				keyed(left.z5=right.z5) and 
				keyed(left.prim_name=right.prim_name) and 
				keyed(left.addr_suffix=right.suffix) and 
				keyed(left.predir=right.predir) and 
				keyed(left.postdir=right.postdir) and 
				keyed(left.prim_range=right.prim_range) and
				keyed(left.sec_range=right.sec_range) and right.dt_first_seen < left.historydate,
			   hrtrans(left,right),
			   left outer, atmost(100));

//high number of high risk business at geolink

addHRBusiness :=  join(AddrHRrec, Address_Attributes.key_business_risk_geolink,
                        keyed(right.geolink=left.st+left.county+left.geo_blk),
												transform(Layout_AMLAddr, 
                              		 Self.HRBusPct :=if(((right.cnt_shell+right.cnt_shelf) / right.cnt_businesses)>= .1, TRUE, FALSE),
																	 self := left),
												atmost(Riskwise.max_atmost),
												left outer);	
												
bha := business_risk.Key_Business_Header_Address;

withBusHeader := join(AMLAddr, bha,
						left.prim_name!='' and left.z5!='' and
						keyed((unsigned)left.z5=right.zip) and
						keyed(left.prim_name=right.prim_name) and
						keyed(right.prim_range=left.prim_range) and
						keyed(right.sec_range=left.sec_range) and
						(unsigned)(((STRING)right.dt_first_seen)[1..6]) < left.historydate AND 
						doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
			      transform(Layout_AMLAddr, self.bdid := (string)right.bdid, self := left, self := []), 
						atmost(1000),
						keep(1),
			 left outer);			 
				 
				 
				 
//ADVO

withAdvo := join(withBusHeader, Advo.Key_Addr1_history,

					left.z5 != '' and 
					left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range)  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					transform(Layout_AMLAddr,
											self.Address_Vacancy_Indicator := right.Address_Vacancy_Indicator,
											self.Throw_Back_Indicator  :=  right.Throw_Back_Indicator ,
								      self.Seasonal_Delivery_Indicator  := right.Seasonal_Delivery_Indicator,
											self.Residential_or_Business_Ind   := right.Residential_or_Business_Ind ,
											self.dt_first_seen   := (integer)right.date_first_seen,
											self := left,
											self := []), left outer,
					atmost(riskwise.max_atmost));
					
withAdvo1DD :=  dedup(sort(withAdvo, seq, did, z5,prim_range,
															prim_name, addr_suffix, predir, postdir, sec_range, -dt_first_seen), 
															seq, did,	z5, prim_range, prim_name, addr_suffix, predir, postdir, sec_range	);


															
withAdvoHR := join(addHRBusiness, withAdvo1DD, 
							left.seq=right.seq and left.did=right.did,
							transform(Layout_AMLAddr, 
									self.hriskaddrflag := left.hriskaddrflag, 
									self.dwelltype := left.dwellType,
							self := right, self := left), left outer);


								
risk_indicators.layout_bocashell_neutral  addAddrInfo(withAdvoHR le, easiCensus ri) := TRANSFORM
       self.SEQ  := le.seq;
			 self.did  := le.did;
			 self.AMLPrimRange := le.prim_range;
			 self.AMLPredir := le.predir;
			 self.AMLPrimName := le.prim_name;
			 self.AMLAddrSuffix := le.addr_suffix;
			 self.AMLPostdir := le.postdir;
			 self.AMLUnitDesig := le.unit_desig;
			 self.AMLSecRange := le.sec_range;
			 self.AMLPCityName := le.p_city_name;
			 self.AMLst := le.st;
			 self.AMLZ5 := le.z5;
			 self.AMLCounty :=  le.county;
			 self.AMLGeoBlk := le.geo_blk;
			 self.AMLEasiTotCrime           := ri.EasiTotCrime;
		   self.AMLAddressVacancyInd  := le.Address_Vacancy_Indicator;
	     self.AMLThrowBackInd     := le.Throw_Back_Indicator;
	     self.AMLSeasonalDeliveryInd   := le.Seasonal_Delivery_Indicator;
	     self.AMLResidentialorBusiness_Ind   := le.Residential_or_Business_Ind;
		   self.AMLHRiskAddrflag     := le.hriskaddrflag;
			 self.AMLBusAddr  := if(le.bdid<>'0',true,false);
			 self.age            := (integer)le.age;
			 self  := le;
			 self := [];
END;


withAddrAttrib	:=  join(withAdvoHR, easiCensus, left.seq=right.seq 
												and left.did=right.did,
                        addAddrInfo(left,right), left outer);
												
// crime geolink
	GeoCrime := join(AMLAddr, crimeGeolink,
		keyed(right.geolink=left.st+left.county+left.geo_blk),
		transform({recordof(crimeGeolink), unsigned4 seq, unsigned6 did}, 
     
						self.seq := left.seq;
						self.did := left.did;
						self := right;
						self := [];
		), left outer,
		ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));
		
withGeoCrime	:=  join(withAddrAttrib, GeoCrime, 
												left.seq=right.seq 
												and left.did=right.did,
                        transform(risk_indicators.layout_bocashell_neutral, 
                              		 self.HighFelonNeighborhood := (100 * right.felon_ratio) > 8,
																	 self := left),
												left outer);
	 
	 
return withGeoCrime;

END;
