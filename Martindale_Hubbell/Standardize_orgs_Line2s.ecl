import address;
export Standardize_orgs_Line2s(

	 dataset(layouts.Base.Organizations) pOrgBase		= Files().base.Organizations.qa
	
) :=
function

	ftrim(string pstring) := stringlib.stringtouppercase(trim(pstring,left,right));

	dOrgbasecleanedaddr2 := project(pOrgBase, transform(layouts.Base.Organizations,
			mailing_address1 :=	
														ftrim(left.rawfields.MAILADDR_MPOBOX		) + ' ' 
													;                      
			mailing_address2 :=	               
														ftrim(left.rawfields.MAILADDR_MCITY			) + ', ' 
													+ ftrim(left.rawfields.MAILADDR_MSTATE		) + ' ' 
													+ ftrim(left.rawfields.MAILADDR_MZIP			)
													;
																							
			location_address1 :=	
														ftrim(left.rawfields.MAILADDR_MSTREET	) + ' ' 
													;        
			location_address2 := mailing_address2;	
			
			mail_addr2_only		:= mailing_address1  = '' and mailing_address2  != '' and left.RawAid_mailing  = 0;
			addr2_only				:= location_address1 = '' and location_address2 != '' and left.RawAid_Location = 0;
			
			self.Clean_mailing_address	:= if(mail_addr2_only		,Address.CleanAddressParsed(mailing_address1	,mailing_address2	).addressrecord, left.Clean_mailing_address	);
      self.Clean_location_address	:= if(addr2_only				,Address.CleanAddressParsed(location_address1	,location_address2).addressrecord, left.Clean_location_address);
			
			self																	:= left;
	));
	
	return dOrgbasecleanedaddr2;

end;