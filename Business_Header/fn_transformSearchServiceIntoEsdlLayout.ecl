import business_header, iesp;

export fn_transformSearchServiceIntoEsdlLayout(	
	dataset(Business_Header.layout_biz_search.result_with_input_and_dt_first_seen) in_recs
) := function

	iesp.business.t_BusinessRecord xform(Business_Header.layout_biz_search.result_with_input_and_dt_first_seen l) := TRANSFORM
	self.BusinessId            			:= (string12) l.bdid,			
	self.DateFirstSeen 							:= iesp.ECL2ESP.toDatestring8((string8) l.dt_first_seen);
	self.DateLastSeen 							:= iesp.ECL2ESP.toDatestring8((string8) l.dt_last_seen);
	self.Verified      							:= l.verified,   
	self.Address.StreetNumber       := l.prim_range,
	self.Address.StreetPreDirection := l.predir,
	self.Address.StreetName         := l.prim_name,
	self.Address.StreetSuffix       := l.addr_suffix,
	self.Address.StreetPostDirection:= l.postdir,
	self.Address.UnitDesignation    := l.unit_desig,
	self.Address.UnitNumber         := l.sec_range,
	self.Address.State              := l.state,
	self.Address.City               := l.city,
	self.Address.Zip5               := if(l.zip = 0,'',intformat(l.zip,5,1)),
	self.Address.Zip4               := if(l.zip4 = 0,'',intformat(l.zip4,4,1)),
	// CA: next 5 fields are blanked as they are not in the data
	self.Address.StreetAddress1     := '',
	self.Address.StreetAddress2     := '',
	self.Address.County             := '', 
	self.Address.PostalCode         := '', 
	self.Address.StateCityZip       := '',																		
	self.Phone10      							:= (string10) l.phone,                                                  				
	self.Name.Full               		:= '',				
	self.Name.First               	:= l.fname,				
	self.Name.Middle               	:= l.mname,				
	self.Name.Last               		:= l.lname,				
	self.Name.Prefix               	:= l.title,				
	self.Name.Suffix               	:= l.name_suffix,				
	self.SSN               					:= if(l.ssn = 0,'',intformat(l.ssn,9,1)),
	self.Title               				:= l.company_title,				
	self.TimeZone               		:= l.timezone,	//  To be filled in afte TZ changes incorporated			
	self.CompanyName               	:= l.company_name,				
	self.FEIN               				:= if(l.fein = 0,'',intformat(l.fein,9,1)),							
	end;          		

	// project them into the ESDL layout
	temp_filter := project(in_recs,
	xform(left));

	return(temp_filter);         
	
end;
