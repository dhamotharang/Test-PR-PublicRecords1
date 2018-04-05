EXPORT Files_raw := module

  export Alachua := module
	
	 export    File_In_raw_document := dataset('~thor_200::in::official_records::fl::alachua_index',Layouts_Alachua.document.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   export    File_In_raw_party    := dataset('~thor_200::in::official_records::fl::alachua_party',Layouts_Alachua.party.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
  end;
	
	export Baker := module
	 
	  export  File_In_raw_document := dataset('~thor_200::in::official_records::fl::baker_document',Layouts_Baker.document.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
    export File_In_raw_Prior    := dataset('~thor_200::in::official_records::fl::baker_prior',Layouts_Baker.prior.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
     export File_In_raw_Party    := dataset('~thor_200::in::official_records::fl::baker_party',Layouts_Baker.party.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
end;

  export Brevard := module
	
	   export  File_In_raw_document := dataset('~thor_200::in::official_records::fl::brevard_document',Layouts_Brevard.document.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
     export  File_In_raw_prior := dataset('~thor_200::in::official_records::fl::brevard_Prior',Layouts_Brevard.prior.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
     export  File_In_raw_party := dataset('~thor_200::in::official_records::fl::brevard_Party',Layouts_Brevard.party.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
end;

  export Broward := module
	
	 export  File_CFN := dataset('~thor_200::in::official_records::fl::broward_cfn',Layouts_Broward.CFN.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   export  File_NME := dataset('~thor_200::in::official_records::fl::broward_nme',Layouts_Broward.NME.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   export  File_LNK :=  dataset('~thor_200::in::official_records::fl::broward_lnk',Layouts_Broward.LNK.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
 end;
 
  export Charlotte := module
	
	export File_In_raw_document := dataset('~thor_200::in::official_records::fl::charlotte_document',Layouts_Charlotte.document.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
  export File_In_raw_prior := dataset('~thor_200::in::official_records::fl::charlotte_prior',Layouts_Charlotte.prior.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
  export File_In_raw_party := dataset('~thor_200::in::official_records::fl::charlotte_party',Layouts_Charlotte.party.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
  end;

  export Citrus := module
	
	export File_In_master := dataset('~thor_200::in::official_records::fl::citrus_master',Layouts_Citrus.master.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
  export File_In_raw_party := dataset('~thor_200::in::official_records::fl::citrus_party',Layouts_Citrus.party.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));

  end;
	
	export Flagler := module
	
  export File_In_raw_document := dataset('~thor_200::in::official_records::fl::flagler_document',Layouts_Flagler.document.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
  export File_In_raw_prior := dataset('~thor_200::in::official_records::fl::flagler_prior',Layouts_Flagler.prior.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
  export File_In_raw_party := dataset('~thor_200::in::official_records::fl::flagler_party',Layouts_Flagler.party.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));

  end;
	
	export Hernando := module
	export File_in_raw := dataset('~thor_200::in::official_records::fl::hernando',Layouts_Hernando.raw,csv(separator(','),terminator(['\n','\r\n']),quote('"')));

  end;
	
	 export Hillsborough := module
	 export File_in_raw_document := dataset('~thor_200::in::official_records::fl::hillsborough_document',Layouts_Hillsborough.document,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   export File_in_raw_party := dataset('~thor_200::in::official_records::fl::hillsborough_party',Layouts_Hillsborough.party,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   end;
	 
	 export IndianRiver := module
	 export File_in_raw_document := dataset('~thor_200::in::official_records::fl::indian_river_document',Layouts_IndianRiver.document.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   export File_in_raw_party := dataset('~thor_200::in::official_records::fl::indian_river_party',Layouts_IndianRiver.party.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   end;
	 
	 export Lake := module
	 export File_in_raw_document := dataset('~thor_200::in::official_records::fl::lake_document',Layouts_Lake.document.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   export File_in_raw_party := dataset('~thor_200::in::official_records::fl::lake_party',Layouts_Lake.party.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   export File_in_relative_doc := dataset('~thor_200::in::official_records::fl::lake_rel',Layouts_Lake.relative_document.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   end;
	 
	 export Marion := module
	 export File_raw_name := dataset('~thor_200::in::official_records::fl::marion_name',Layouts_Marion.name.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   export File_raw_cfn := dataset('~thor_200::in::official_records::fl::marion_cfn',Layouts_Marion.cfn.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
   end;
	 
   export Martin := module
	 export File_in_raw := dataset('~thor_200::in::official_records::fl::martin',Layouts_Martin.raw,csv(separator('\t'),terminator(['\n','\r\n']),quote('')));
   end;
	 
	 export MiamiDade := module
	 export File_in_raw := dataset('~thor_200::in::official_records::fl::miami_dade',Layouts_MiamiDade.raw,csv(separator('^'),terminator(['\n','\r\n']),quote('')));
   end;
	 
	 export Monroe := module
	 export File_in_raw := dataset('~thor_200::in::official_records::fl::monroe',Layouts_Monroe.raw,csv(heading(1),separator('|'),terminator(['\n','\r\n']),quote('')));
   end;
	 
	 export Orange := module
	 export File_in_raw := dataset('~thor_200::in::official_records::fl::orange',Layouts_Orange.raw,csv(separator('|'),terminator(['\n','\r\n']),quote('"'))) (regexfind('[A-Z]',document_number,0) = '');
   end;
	 
	 export Polk := module
	 export File_in_raw := dataset('~thor_200::in::official_records::fl::polk',Layouts_Polk.raw,csv(separator('\t'),terminator(['\n','\r\n']),quote('')));
   end;
	 
	 export Sarasota := module
	  export File_raw_document := dataset('~thor_200::in::official_records::fl::sarasota_document',Layouts_Sarasota.raw.document,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
    export File_raw_grantor := dataset('~thor_200::in::official_records::fl::sarasota_grantor',Layouts_Sarasota.raw.grantor,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
	  export File_raw_grantee := dataset('~thor_200::in::official_records::fl::sarasota_grantee',Layouts_Sarasota.raw.grantee,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
	  export File_raw_legal := dataset('~thor_200::in::official_records::fl::sarasota_legal',Layouts_Sarasota.raw.legal,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
	  export File_raw_crossref := dataset('~thor_200::in::official_records::fl::sarasota_crossref',Layouts_Sarasota.raw.crossref,csv(separator('|'),terminator(['\n','\r\n']),quote('')));
 end;
end;