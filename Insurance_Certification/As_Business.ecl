export As_Business :=
module
   
	 export Header := Insurance_Certification.fAs_business.fHeader(files().keybuild_cert.BusinessHeader)
      : PERSIST(persistnames.asbusinessHeader);
   
	 export Contact := Insurance_Certification.fAs_business.fContact(files().keybuild_cert.BusinessHeader)
      : PERSIST(persistnames.asbusinessContact);
   
end;