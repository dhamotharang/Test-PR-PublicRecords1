
import mdr,business_header,ut,_Validate,address,business_headerv2,lib_stringlib, dnb_dmi;
EXPORT AS_HEADERS := MODULE

	export as_business_contact := DNB_DMI.as_business_contact(,,files.header_base,'N' , '',DATASET([],Business_Header.Layout_Business_Contact_Full_New));

	export as_business_header  := DNB_DMI.as_business_header(false,,files.dnb_linkids,'N' , '',DATASET([],business_header.Layout_Business_Header_New));

	export As_Business_Linking :=  DNB_DMI.As_Business_Linking(,files.dnb_linkids,dataset([],layouts.Base_contacts), true);

END;