#OPTION('multiplePersistInstances',FALSE);
export As_Business :=
module
   
	 export Header := Workers_Compensation.fAs_business.fHeader(files().keybuild.BusinessHeader)
      : PERSIST(persistnames.asbusinessheader);
   	  
end;