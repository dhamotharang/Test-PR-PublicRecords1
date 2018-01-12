#OPTION('multiplePersistInstances',FALSE);
import Business_Header,Business_HeaderV2;
bfiles := Business_HeaderV2.Source_Files;

export LiensV2_As_Business_Header(
	 boolean																				pShouldPersist	= true
	,dataset(layout_liens_party_ssn_for_hogan_BIPV2_with_LinkFlags	)	pHogan					= bfiles.liens_party_Hogan.BusinessHeader
	,dataset(Layout_liens_party_ssn_BIPV2_with_LinkFlags						)	pILFDLN					= bfiles.liens_party_ILFDLN.BusinessHeader			
	,dataset(Layout_liens_party_ssn_BIPV2_with_LinkFlags						)	pNYC						= bfiles.liens_party_NYC.BusinessHeader					
	,dataset(Layout_liens_party_ssn_BIPV2_with_LinkFlags						)	pNYFDLN					= bfiles.liens_party_NYFDLN.BusinessHeader			
	,dataset(Layout_liens_party_ssn_BIPV2_with_LinkFlags						)	pSA							= bfiles.liens_party_SA.BusinessHeader					
	,dataset(Layout_liens_party_ssn_BIPV2_with_LinkFlags						)	pChicago				= bfiles.liens_party_chicago_law.BusinessHeader	
	,dataset(Layout_liens_party_ssn_BIPV2_with_LinkFlags						)	pCA							= bfiles.liens_party_CA.BusinessHeader					
	,dataset(Layout_liens_party_ssn_BIPV2_with_LinkFlags						)	pSuperior				= bfiles.liens_party_Superior.BusinessHeader		
	,string																					pPersistname		= thor_cluster + 'persist::LiensV2::LiensV2_As_Business_Header'
) :=                                                        			
function

	LiensV2.Layout_liens_party_ssn_BIPV2_with_LinkFlags refHGPTY(LiensV2.layout_liens_party_ssn_for_hogan_BIPV2_with_LinkFlags l) := transform
		self := l;
	end;

	Hogan_party := project(pHogan, refHGPTY(left));


	dfile_liens_party := 
	Hogan_party		((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
	+ pILFDLN			((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
	+ pNYC				((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
	+ pNYFDLN			((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
	+ pSA					((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
	+ pChicago		((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
	+ pCA					((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
	+ pSuperior		((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
	;
	dasbh 					:= fliensV2_As_Business_Header(dfile_liens_party) ;
	dasbh_persisted := dasbh : persist(pPersistname);
	
	return if(pShouldPersist	,dasbh_persisted
														,dasbh
				);
				
end;






