import business_header,mdr;

export fMap_Business_Best_to_Abius(

	dataset(business_header.Layout_BH_Best) pBusinessBestFile = business_header.files(, business_header.Flags.istesting).base.business_header_best.qa

) :=
function

	lBusinessBestFile	:= pBusinessBestFile(
													 not(MDR.sourceTools.SourceIsInfousa(source) or MDR.sourceTools.SourceIsFBNV2_INF(source))
													,(integer)((string)dt_last_seen[1..4]) >= 2007
												);
	
	Layout_ABIUS_Company_Base tMap2Infousa(business_header.Layout_BH_Best l) :=
	transform
	
		STREET1 :=
							trim(l.prim_range	) 
			+ ' ' + trim(l.predir			)
			+ ' ' + trim(l.prim_name	) 
			+ ' ' + trim(l.addr_suffix)
			+ ' ' + trim(l.postdir 		)
			+ ' ' + trim(l.unit_desig )
			+ ' ' + trim(l.sec_range	)
			;
	
		self.bdid                           := l.bdid;
		self.process_date                   := (string8)l.dt_last_seen;
		self.COMPANY_NAME                   := l.company_name;
		self.STREET1                        := STREET1;
		self.CITY1                          := l.city;
		self.STATE1                         := l.state;
		self.ZIP1_5                         := (string)l.zip;
		self.ZIP1_4                         := (string)l.zip4;
		self.PHONE                          := (string)l.phone;
		self.ABI_NUMBER                     := 'business';
		self.prim_range                     := l.prim_range;
		self.predir                         := l.predir;
		self.prim_name                      := l.prim_name;
		self.addr_suffix                    := l.addr_suffix;
		self.postdir                        := l.postdir;
		self.unit_desig                     := l.unit_desig;
		self.sec_range                      := l.sec_range;
		self.p_city_name                    := l.city;
		self.v_city_name                    := l.city;
		self.st                             := l.state;
		self.z5                             := (string)l.zip;
		self.zip4                           := (string)l.zip4;
		self																:= [];

	end;
	
	result := project(pBusinessBestFile, tMap2Infousa(left));

	return result;

end;
