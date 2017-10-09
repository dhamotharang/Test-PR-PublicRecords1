import PRTE2_BIPV2_BusHeader;

EXPORT File_BizHead_Contacts := dataset('~prte::base::bipv2_business_header::qa::contacts',PRTE2_BIPV2_BusHeader.layouts.base.layout_contacts,flat)(ultid <> 0);