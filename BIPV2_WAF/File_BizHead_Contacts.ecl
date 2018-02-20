//EXPORT File_BizHead_Contacts := BIPV2_WAF.File_BizHead(fname <> '' or lname <> '');

import BIPV2, ut;

layoutOrigFile :=
  record
	  BIPV2.IDlayouts.l_xlink_ids; 
    BIPV2.Layout_Business_Linking_Full;
		boolean executive_ind:=FALSE;
		integer executive_ind_order:=0;
  end;
	
EXPORT File_BizHead_Contacts := dataset('~thor400_20::persist::bip_contacts',layoutOrigFile,flat)(ultid <> 0);