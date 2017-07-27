import tools, idl_header; 

export AncillaryKeys(
	 string pversion = ''
) := module

  // Sources allowed Insurance policy, Insurance claim, Mvr inquiry and all the DMVs except (NM and KS) , filter out Noise did's
 
  shared pBaseheaderBuilt   := project(idl_header.header_ins (src in IDl_header.sourceTools.set_Business_services_DL_verification ), Layouts.DL) :independent;
         bestfile           := corecheck(ind = 'NOISE'); 
	shared PfilterNoise       := join (pBaseheaderBuilt , bestfile , left.did = right.did, transform(left) ,left only, hash); 
	shared pBaseDL            := PfilterNoise(trim(Dl_nbr,left,right) <> ''); 	

  tools.mac_FilesIndex('PfilterNoise,{DID}     ,{PfilterNoise}'      ,keynames(pversion).did    ,did);
 	tools.mac_FilesIndex('pBaseDL     ,{Dl_nbr}  ,{pBaseDL}'           ,keynames(pversion).dln    ,dln);
	
end;