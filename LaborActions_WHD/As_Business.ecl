export As_Business :=
module
   
	 export Header := LaborActions_WHD.fAs_business.fHeader(files().keybuild.BusinessHeader)
      : PERSIST(persistnames.asbusinessheader);
   
	 export Contact := LaborActions_WHD.fAs_business.fContact(files().keybuild.BusinessHeader)
      : PERSIST(persistnames.asbusinessContact);
   
end;