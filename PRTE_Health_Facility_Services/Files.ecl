import HealthCareFacility, HealthCareProvider;
export Files := MODULE

	EXPORT Facility_Header_DS := DATASET ([],HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header);

	EXPORT Facility_DS := Facility_Header_DS;

	SHARED fileDate	:=	thorlib.wuid () [2..9] + thorlib.wuid () [11..16] ;
	
	EXPORT Key_Prefix_Name 		     		  := '~prte::key::healthcarefacility';
	EXPORT Suffix_Name_Specificities		:= 'specificities::debug';
	EXPORT Suffix_Name_Header						:= 'header';
	EXPORT Suffix_Name_Header_Refs			:= 'header::refs';
	EXPORT Suffix_Name_Header_Words			:= 'header::words';
	EXPORT Suffix_Name_BName			 			:= 'bname';
	EXPORT Suffix_Name_BName_Values			:= 'bname::words';
	EXPORT Suffix_Name_BName_St		 			:= 'bnamest';
	EXPORT Suffix_Name_BName_Zip	 			:= 'bnamezip';	
	EXPORT Suffix_Name_Address    			:= 'address';
	EXPORT Suffix_Name_ZIP        			:= 'zip';
	EXPORT Suffix_Name_City        			:= 'city';	
	EXPORT Suffix_Name_PHONE	     			:= 'phone';
	EXPORT Suffix_Name_FAX	 	    			:= 'fax';
	EXPORT Suffix_Name_Lic        			:= 'lic';
	EXPORT Suffix_Name_VendorID    			:= 'vendorid';
	EXPORT Suffix_Name_Tax	       			:= 'tax';
	EXPORT Suffix_Name_Fein	       			:= 'fein';
	EXPORT Suffix_Name_DEA	      			:= 'dea';
	EXPORT Suffix_Name_NPI		    			:= 'npi';
	EXPORT Suffix_Name_ADDR_NPI	   			:= 'address::npi';
	EXPORT Suffix_Name_CLIA		    			:= 'clia';			
	EXPORT Suffix_Name_MEDICARE    			:= 'medicare';	
	EXPORT Suffix_Name_MEDICAID    			:= 'medicaid';	
	EXPORT Suffix_Name_NCPDP	    			:= 'ncpdp';	
	EXPORT Suffix_Name_BDID		    			:= 'bdid';

	EXPORT FILE_Spec												:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Specificities;
	EXPORT FILE_Header											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Header;
	EXPORT FILE_Header_Refs									:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Header_Refs;
	EXPORT FILE_Header_Words								:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Header_Words;
	EXPORT FILE_BName												:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_BName;
	EXPORT FILE_BName_Values								:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_BName_Values;
	EXPORT FILE_BName_St										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_BName_St;
	EXPORT FILE_BName_Zip										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_BName_Zip;			
	EXPORT FILE_Address											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Address;
	EXPORT FILE_ZIP													:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_ZIP;
	EXPORT FILE_City												:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_City;
	EXPORT FILE_PHONE												:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_PHONE;
	EXPORT FILE_FAX													:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_FAX;
	EXPORT FILE_LIC													:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Lic;
	EXPORT FILE_VendorID										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_VendorID;
	EXPORT FILE_Tax													:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Tax;
	EXPORT FILE_Fein												:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Fein;
	EXPORT FILE_DEA													:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_DEA;
	EXPORT FILE_NPI													:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_NPI;
	EXPORT FILE_ADDR_NPI										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_ADDR_NPI;
	EXPORT FILE_CLIA												:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_CLIA;	
	EXPORT FILE_MEDICARE										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_MEDICARE;	
	EXPORT FILE_MEDICAID										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_MEDICAID;	
	EXPORT FILE_NCPDP												:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_NCPDP;	
	EXPORT FILE_BDID												:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_BDID;	
END;