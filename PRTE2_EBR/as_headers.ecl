IMPORT Business_Header, ut,mdr,EBR, std, address;

EXPORT as_headers := module

export old_business_header_ebr := ebr.fEBR_As_Business_Header(Files.ds_0010_Header_Base(company_name <> '' and bdid <> 0),true);
																													 
export new_business_header_ebr := ebr.fEBR_As_Business_Linking(Files.BASE_0010_Header_linkids,
																															 Files.BASE_5610_Demographic_linkIds,
																															 Files.Base_5600_Demographic_LinkIds); 

export old_business_contacts_ebr := ebr.fEBR_As_Business_Contact(Files.ds_0010_Header_Base, Files.BASE_5610_Demographic_linkIds,true);  
		
end;	