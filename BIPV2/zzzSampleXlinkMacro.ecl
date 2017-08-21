EXPORT 
	zzzSampleXlinkMacro(
	ExistingInfileParameter,
	ExistingOutfileParameter,
	ExistingOutrecParameter,	// BIPV2.layouts.l_xlink_ids must be added to your outrec layout when AppendBIPids is set to true
	OtherExistingParameters,
	
	AppendBIPids = 'false', 			//or true.  set to true the append of the new BIP ids
																//An alternative here would be a second outfile parameter.  The only reason to do this would be that builds may not be ready for multiple results from one input. 
	OtherNewParameters	= 'junk'				//contact fname, contact lname, url, etc
	
	):= 
MACRO

#uniquename(proj)

%proj% :=
project(
	ExistingInfileParameter,
	transform(
		ExistingOutrecParameter,
		#if(AppendBIPids)
			
			self.DotID := if(counter < 5 or counter > 10, counter, 0),
			self.Dotscore := if(self.dotid > 0, if(self.dotid > 1, 100, 50), 0),
			self.dotweight := 20,
			
			self.proxID := self.DotID,
			self.proxscore := 100,
			self.proxweight := 20,
			
			self.orgID := self.proxID,
			self.orgscore := self.proxscore,
			self.orgweight := self.proxweight,
			
			self.ultID := self.proxID,
			self.ultscore := self.proxscore,
			self.ultweight := self.proxweight,

			self.EmpID := 0,
			self.Empscore := 0,
			self.Empweight := 0,
			
			self.POWID := 0,
			self.POWscore := 0,
			self.POWweight := 0,			
		#end
			self.bdid := counter,
			self := left
	)
);


ExistingOutfileParameter :=
		#if(AppendBIPids)
			%proj% + project(%proj%(dotscore > 0 and dotscore < 100), transform(ExistingOutrecParameter, self.dotid := left.dotid + 1000, self.dotscore := 100 - left.dotscore, self := left))
		#else
			%proj%
		#end
;
ENDMACRO;