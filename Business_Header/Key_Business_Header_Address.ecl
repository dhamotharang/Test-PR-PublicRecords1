Import Data_Services, doxie, ut, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
df := PRTE2_Business_Header.File_Business_Header_Base_for_keybuild(prim_name != '' or state != '');
#ELSE
df := Business_Header.File_Business_Header_Base_for_keybuild(prim_name != '' or state != '');
#END;

export Key_Business_Header_Address := index(df,{string28 pn := ut.stripordinal(df.prim_name),string2 st := df.state,string10 pr := df.prim_range,zip,string8 sr := df.sec_range,__filepos},'~thor_data400::key::business_header.address_' + doxie.Version_SuperKey);
