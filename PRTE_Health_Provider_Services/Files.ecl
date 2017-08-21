import HealthCareProvider;
export Files := MODULE

	EXPORT Provider_Header_DS := DATASET ([],HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header);	

	EXPORT Provider_DS := Provider_Header_DS;

	SHARED fileDate	:=	thorlib.wuid () [2..9] + thorlib.wuid () [11..16] ;
	
	EXPORT Key_Prefix_Name 		     		  := '~prte::key::healthcareprovider';
	EXPORT Suffix_Name_Specificities		:= 'specificities::debug';
	EXPORT Suffix_Name_Header						:= 'header';
	EXPORT Suffix_Name_Header_Refs			:= 'header::refs';
	EXPORT Suffix_Name_Header_Words			:= 'header::words';
	EXPORT Suffix_Name_FName			 			:= 'fname';
	EXPORT Suffix_Name_MName			 			:= 'mname';	
	EXPORT Suffix_Name_LName			 			:= 'lname';
	EXPORT Suffix_Name_Name_ST_Lic			:= 'namestlic';	
	EXPORT Suffix_Name_Name       			:= 'name';
	EXPORT Suffix_Name_Address    			:= 'address';
	EXPORT Suffix_Name_SSN	       			:= 'ssn';
	EXPORT Suffix_Name_CNSMR_SSN	      := 'cnsmr::ssn';
	EXPORT Suffix_Name_DOB		     			:= 'dob';
	EXPORT Suffix_Name_CNSMR_DOB		 		:= 'cnsmr::dob';
	EXPORT Suffix_Name_PHONE	     			:= 'phone';
	EXPORT Suffix_Name_ZIP        			:= 'zip';
	EXPORT Suffix_Name_Lic        			:= 'lic';
	EXPORT Suffix_Name_VendorID    			:= 'vendorid';
	EXPORT Suffix_Name_Tax	       			:= 'tax';
	EXPORT Suffix_Name_Billing_Tax	   	:= 'billing::tax';
	EXPORT Suffix_Name_DEA	      			:= 'dea';
	EXPORT Suffix_Name_NPI		    			:= 'npi';
	EXPORT Suffix_Name_BILLING_NPI			:= 'billing::npi';
	EXPORT Suffix_Name_UPIN		    			:= 'upin';
	EXPORT Suffix_Name_LexID	    			:= 'lexid';
	EXPORT Suffix_Name_BDID		    			:= 'bdid';
	EXPORT Suffix_Name_Source_RID		    := 'source::rid';
	EXPORT Suffix_Name_RID		    			:= 'rid';

	EXPORT FILE_Spec										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Specificities;
	EXPORT FILE_Header									:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Header;
	EXPORT FILE_Header_Refs							:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Header_Refs;
	EXPORT FILE_Header_Words						:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Header_Words;
	EXPORT FILE_FName										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_FName;
	EXPORT FILE_MName										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_MName;
	EXPORT FILE_LName										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_LName;
	EXPORT FILE_Name_ST_Lic							:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Name_ST_Lic;			
	EXPORT FILE_Name										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Name;
	EXPORT FILE_Address									:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Address;
	EXPORT FILE_SSN											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_SSN;
	EXPORT FILE_CNSMR_SSN								:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_CNSMR_SSN;
	EXPORT FILE_DOB											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_DOB;
	EXPORT FILE_CNSMR_DOB								:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_CNSMR_DOB;
	EXPORT FILE_PHONE										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_PHONE;
	EXPORT FILE_ZIP											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_ZIP;
	EXPORT FILE_LIC											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Lic;
	EXPORT FILE_VendorID								:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_VendorID;
	EXPORT FILE_Tax											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Tax;
	EXPORT FILE_Billing_Tax							:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Billing_Tax;
	EXPORT FILE_DEA											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_DEA;
	EXPORT FILE_NPI											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_NPI;
	EXPORT FILE_Billing_NPI							:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Billing_NPI;
	EXPORT FILE_UPIN										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_UPIN;
	EXPORT FILE_LexID										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_LexID;
	EXPORT FILE_BDID										:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_BDID;	
	EXPORT FILE_Source_RID							:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_Source_RID;	
	EXPORT FILE_RID											:= Key_Prefix_Name + '::' + fileDate + '::' + Suffix_Name_RID;	
END;