Import Data_Services, LN_Property, doxie,ut, LN_PropertyV2;

export Key_Search_BDID(boolean isFast = false) := FUNCTION

keyPrefix	:= if(isFast,'property_fast','ln_propertyv2');


df0	:= LN_PropertyV2_Fast.CleanSearch(false);
df1	:= LN_PropertyV2_Fast.CleanSearch(true, true);

df2	:= if(isFast,df1,df0);

df := df2((integer)bdid != 0);


return index(df,
{unsigned6 s_bid := (integer)bdid},
{df},
Constants.keyServerPointer+ 'thor_data400::key::'+keyPrefix+'::' + doxie.Version_SuperKey + '::search.bdid');

END;