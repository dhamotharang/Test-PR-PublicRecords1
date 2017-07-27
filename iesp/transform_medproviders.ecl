import iesp, doxie;

in_layout := doxie.ingenix_provider_module.layout_ingenix_provider_report ;
out_layout := iesp.proflicense.t_ProviderRecord;

EXPORT out_layout transform_medproviders (dataset(in_layout) providers) := FUNCTION
iesp.share.t_date dobTrans(doxie.ingenix_provider_module.ingenix_dob_rec l) := TRANSFORM
  self := iesp.ECL2ESP.toDatestring8(L.birthDate);
END;	

iesp.share.t_StringArrayItem didTrans(doxie.ingenix_provider_module.ingenix_did_rec L) := TRANSFORM
  SELF.VALUE := l.DID;
END;

iesp.share.t_StringArrayItem sancIDTrans(doxie.ingenix_provider_module.ingenix_sanc_child_rec L) := TRANSFORM
  SELF.VALUE := (String)l.SANC_ID;
END;
iesp.share.t_StringArrayItem taxIDTrans(doxie.ingenix_provider_module.ingenix_taxid_rec L) := TRANSFORM
  SELF.VALUE := l.TAXID;
END;
iesp.share.t_StringArrayItem upinTrans(doxie.ingenix_provider_module.ingenix_upin_rec L) := TRANSFORM
  SELF.VALUE := l.UPIN;
END;
iesp.share.t_StringArrayItem degreeTrans(doxie.ingenix_provider_module.ingenix_degree_rec L) := TRANSFORM
  SELF.VALUE := l.DEGREE;
END;

iesp.share.t_name nameTrans(doxie.ingenix_provider_module.ingenix_name_rec l) := TRANSFORM
 self.first := L.Prov_Clean_fname;
 self.middle := L.Prov_Clean_mname;
 self.last := L.Prov_Clean_lname;
 self.suffix := L.Prov_Clean_name_suffix;
 self := [];
END;
iesp.proflicense.t_PL2LicenseInfo licTrans(doxie.ingenix_provider_module.ingenix_license_rpt_rec l) := TRANSFORM
self.state  := L.LicenseState;	
self.number :=	L.LicenseNumber;
self.effectivedate := iesp.ECL2ESP.todate((integer)L.Effective_Date);
self.terminationdate :=	iesp.ECL2ESP.todate((integer)L.Termination_Date);
END;

iesp.proflicense.t_PL2ProviderSpecialty SpecTrans(doxie.ingenix_provider_module.ingenix_specialty_rec l) := TRANSFORM
self.id  := L.SpecialtyID;	
self.name :=	L.SpecialtyName;
self.groupid :=  L.SpecialtyGroupID;
self.groupname := L.SpecialtyGroupName;
END;

iesp.proflicense.t_PL2PhoneInfo phoneTrans(doxie.ingenix_provider_module.ingenix_phone_slim_rec Le) := TRANSFORM
  self.number := le.phoneNumber;
  self._type := le.phoneType;
END;

iesp.proflicense.t_PL2BusAddrAndPhone AddrTrans(doxie.ingenix_provider_module.ingenix_addr_rpt_rec l) := TRANSFORM
self.Address.StreetName := L.Prov_Clean_prim_name;	        	
self.Address.StreetNumber := L.Prov_Clean_prim_range;			
self.Address.StreetPreDirection := L.Prov_Clean_predir;		
self.Address.StreetPostDirection := L.Prov_Clean_postdir;							
self.Address.StreetSuffix := L.Prov_Clean_addr_suffix;								
self.Address.UnitDesignation :=	L.Prov_Clean_unit_desig;		
self.Address.UnitNumber := L.Prov_Clean_sec_range;				
//self.Address.StreetAddress1 :=			
//self.Address.StreetAddress2 :=			
self.Address.State := L.Prov_Clean_st;				
self.Address.City := L.Prov_Clean_p_city_name;				
self.Address.Zip5 := L.Prov_Clean_zip;									
self.Address.Zip4 := L.Prov_Clean_zip4;		
self.PhonesInfo := 	choosen(project(l.phone,phoneTrans(LEFT)),1);						
//self.County :=	        		
//self.PostalCode :=	        	
//self.StateCityZip :=	
  self := [];				
END;

iesp.proflicense.t_PL2BusinessIdAndName groupTrans(doxie.ingenix_provider_module.ingenix_group_rec L) := TRANSFORM
  self.businessId := l.bdid;
  self.name := l.groupName;
END;
iesp.proflicense.t_PL2BusinessIdAndName hospitalTrans(doxie.ingenix_provider_module.ingenix_hospital_rec L) := TRANSFORM
  self.businessId := l.bdid;
  self.name := l.hospitalName;
END;
iesp.proflicense.t_PL2Residency resTrans(doxie.ingenix_provider_module.ingenix_residency_rec L) := TRANSFORM
  self.BusinessId := l.bdid;
  self.Residency := l.Residency;
END;
iesp.proflicense.t_PL2MedicalSchoolInfo medTrans(doxie.ingenix_provider_module.ingenix_medschool_rec L) := TRANSFORM
  self.BusinessId := l.bdid;
  self.SchoolName:= l.MedSchoolName;
  self.GraduationYear   := (integer)l.GraduationYear;
END;

out_layout toOut (in_layout L) := transform
 	self.ProviderNumber := 	l.ProviderID;
	self.Gender := 			l.Gender_Name;
	self.SanctionFlag := 	l.sanc_flag; 
	self.SanctionIds := 	choosen(project(l.sanction_id, sancIDTrans(LEFT)),Constants.PROFLIC.MAX_SANCTIONIDS);	
	self.Providers := 		choosen(project(l.providerdid, didTrans(LEFT)),Constants.PROFLIC.MAX_PROVIDERS);	
	self.Names := 			choosen(project(l.name,nameTrans(LEFT)),Constants.PROFLIC.MAX_NAMES);	
	self.TaxIds := 			choosen(project(l.taxid,taxidTrans(LEFT)),Constants.PROFLIC.MAX_TAXIDS);	
	self.DOBs := 			choosen(project(l.dob,dobTrans(LEFT)),Constants.PROFLIC.MAX_DOBS);	
	self.UPINs := 			choosen(project(l.upin,upinTrans(LEFT)),Constants.PROFLIC.MAX_UPINS);	
	self.LicenseInfos := 	choosen(project(l.license,licTrans(LEFT)),Constants.PROFLIC.MAX_LICENSEINFOS);	
	self.Degrees := 		choosen(project(l.degree,degreeTrans(LEFT)),Constants.PROFLIC.MAX_DEGREES);		
	self.Specialties := 	choosen(project(l.specialty,specTrans(LEFT)),Constants.PROFLIC.MAX_SPECIALTIES); 	
	self.BusAddrAndPhones := choosen(project(l.business_address,addrTrans(LEFT)),Constants.PROFLIC.MAX_BUSADDRANDPHONES);	
	self.GroupAffiliations := 	choosen(project(l.group_affiliation,groupTrans(LEFT)),Constants.PROFLIC.MAX_GROUPAFFILIATIONS);	
	self.HospitalAffiliations := choosen(project(l.hospital_affiliation,hospitalTrans(LEFT)),Constants.PROFLIC.MAX_HOSPITALAFFILIATIONS);	
	self.Residencies :=  		choosen(project(l.residency,resTrans(LEFT)),Constants.PROFLIC.MAX_RESIDENCIES);	
	self.MedicalSchoolInfos := 	choosen(project(l.medschool,medTrans(LEFT)),Constants.PROFLIC.MAX_MEDICALSCHOOLINFOS);	
	self.NationalProviderIdentifiers := [];
	self.Languages := [];
	self.Taxonomies := [];
 end;
 
    RETURN project (providers, toOut (Left));
 end;
