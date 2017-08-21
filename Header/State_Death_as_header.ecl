import ut,Std;
//  State Death Master into header layout

export	State_Death_as_Header(dataset(header.layout_state_death) pState_Death_Master = dataset([],header.layout_state_death), boolean pForHeaderBuild=false)
 :=
  function
	dStateDeathAsSource	:=	if(pForHeaderBuild,header.Files_SeqdSrc().DS,State_Death_as_Source(pState_Death_Master,pForHeaderBuild));

    //216 is the number of months equivalent to 18 years
	dDropMinors := dStateDeathAsSource((trim(dod) ='' and trim(dob) ='')
	                           or (trim(dod)!='' and trim(dob)!='' and (header.ConvertYYYYMMToNumberOfMonths((integer)dod) - header.ConvertYYYYMMToNumberOfMonths((integer)dob) >= 216))
	                           or header.ConvertYYYYMMToNumberOfMonths((integer)dob) between 0 and header.ConvertYYYYMMToNumberOfMonths((integer)(STRING8)Std.Date.Today())-216
							   );
					 
	Layout_New_Records into_fat(dDropMinors le) := transform
	  self.did                      := 0;
	  self.rid                      := 0;
	  self.dt_first_seen            := ut.MOB((integer)le.dod);
	  self.dt_last_seen             := ut.MOB((integer)le.dod);
	  self.dt_vendor_first_reported := ut.MOB((integer)le.dod);
	  self.dt_vendor_last_reported  := ut.MOB((integer)le.dod);
	  self.dt_nonglb_last_seen      := ut.MOB((integer)le.dod);
	  self.vendor_id                := le.vdi;
	  self.phone                    := '';
	  self.dob                      := (integer)le.dob;
		self.city_name                := le.v_city_name;
		self.st                       := le.state;
	  self.county := le.fips_county;
		//self.prim_name                := 'DOD: ' + le.dod;
	  self                          := le;
	//	self                          := [];
	end;

	death_in := project(dDropMinors, into_fat(left));

    return death_in;
  end
 ;
