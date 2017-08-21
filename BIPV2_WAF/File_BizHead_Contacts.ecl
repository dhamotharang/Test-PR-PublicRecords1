//EXPORT File_BizHead_Contacts := BIPV2_WAF.File_BizHead(fname <> '' or lname <> '');

import BIPV2, Data_Services;

layoutOrigFile :=
  record
	  BIPV2.IDlayouts.l_xlink_ids; 
    BIPV2.Layout_Business_Linking_Full;
		boolean executive_ind:=false;
		integer8 executive_ind_order:=0;
  end;
	
//EXPORT File_BizHead_Contacts := dataset(Data_Services.foreign_prod +'thor400_20::persist::bip_contacts',layoutOrigFile,flat)(ultid <> 0);
EXPORT File_BizHead_Contacts := dataset('~thor_data400::base::bipv2::business_header::qa::contacts',layoutOrigFile,flat)(ultid <> 0);