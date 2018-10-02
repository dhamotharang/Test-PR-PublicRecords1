
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_ACTION_CODE = '',Input_RECORD_ID = '',Input_RECORD_TYPE = '',Input_TELEPHONE = '',Input_LISTING_TYPE = '',Input_BUSINESS_NAME = '',Input_BUSINESS_CAPTIONS = '',Input_CATEGORY = '',Input_INDENT = '',Input_LAST_NAME = '',Input_SUFFIX_NAME = '',Input_FIRST_NAME = '',Input_MIDDLE_NAME = '',Input_PRIMARY_STREET_NUMBER = '',Input_PRE_DIR = '',Input_PRIMARY_STREET_NAME = '',Input_PRIMARY_STREET_SUFFIX = '',Input_POST_DIR = '',Input_SECONDARY_ADDRESS_TYPE = '',Input_SECONDARY_RANGE = '',Input_CITY = '',Input_STATE = '',Input_ZIP_CODE = '',Input_ZIP_PLUS4 = '',Input_LATITUDE = '',Input_LONGITUDE = '',Input_LAT_LONG_MATCH_LEVEL = '',Input_UNLICENSED = '',Input_ADD_DATE = '',Input_OMIT_ADDRESS = '',Input_DATA_SOURCE = '',Input_unknownField = '',Input_TransactionID = '',Input_Original_Suffix = '',Input_Original_First_Name = '',Input_Original_Middle_Name = '',Input_Original_Last_Name = '',Input_Original_Address = '',Input_Original_Last_Line = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT33,Scrubs_Gong;
  #uniquename(of)
  %of% := RECORD
    SALT33.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ACTION_CODE)='' )
      '' 
    #ELSE
        IF( le.Input_ACTION_CODE = (TYPEOF(le.Input_ACTION_CODE))'','',':ACTION_CODE')
    #END

+    #IF( #TEXT(Input_RECORD_ID)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_ID = (TYPEOF(le.Input_RECORD_ID))'','',':RECORD_ID')
    #END

+    #IF( #TEXT(Input_RECORD_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_TYPE = (TYPEOF(le.Input_RECORD_TYPE))'','',':RECORD_TYPE')
    #END

+    #IF( #TEXT(Input_TELEPHONE)='' )
      '' 
    #ELSE
        IF( le.Input_TELEPHONE = (TYPEOF(le.Input_TELEPHONE))'','',':TELEPHONE')
    #END

+    #IF( #TEXT(Input_LISTING_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_LISTING_TYPE = (TYPEOF(le.Input_LISTING_TYPE))'','',':LISTING_TYPE')
    #END

+    #IF( #TEXT(Input_BUSINESS_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_NAME = (TYPEOF(le.Input_BUSINESS_NAME))'','',':BUSINESS_NAME')
    #END

+    #IF( #TEXT(Input_BUSINESS_CAPTIONS)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_CAPTIONS = (TYPEOF(le.Input_BUSINESS_CAPTIONS))'','',':BUSINESS_CAPTIONS')
    #END

+    #IF( #TEXT(Input_CATEGORY)='' )
      '' 
    #ELSE
        IF( le.Input_CATEGORY = (TYPEOF(le.Input_CATEGORY))'','',':CATEGORY')
    #END

+    #IF( #TEXT(Input_INDENT)='' )
      '' 
    #ELSE
        IF( le.Input_INDENT = (TYPEOF(le.Input_INDENT))'','',':INDENT')
    #END

+    #IF( #TEXT(Input_LAST_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_LAST_NAME = (TYPEOF(le.Input_LAST_NAME))'','',':LAST_NAME')
    #END

+    #IF( #TEXT(Input_SUFFIX_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_SUFFIX_NAME = (TYPEOF(le.Input_SUFFIX_NAME))'','',':SUFFIX_NAME')
    #END

+    #IF( #TEXT(Input_FIRST_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_FIRST_NAME = (TYPEOF(le.Input_FIRST_NAME))'','',':FIRST_NAME')
    #END

+    #IF( #TEXT(Input_MIDDLE_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_MIDDLE_NAME = (TYPEOF(le.Input_MIDDLE_NAME))'','',':MIDDLE_NAME')
    #END

+    #IF( #TEXT(Input_PRIMARY_STREET_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_PRIMARY_STREET_NUMBER = (TYPEOF(le.Input_PRIMARY_STREET_NUMBER))'','',':PRIMARY_STREET_NUMBER')
    #END

+    #IF( #TEXT(Input_PRE_DIR)='' )
      '' 
    #ELSE
        IF( le.Input_PRE_DIR = (TYPEOF(le.Input_PRE_DIR))'','',':PRE_DIR')
    #END

+    #IF( #TEXT(Input_PRIMARY_STREET_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_PRIMARY_STREET_NAME = (TYPEOF(le.Input_PRIMARY_STREET_NAME))'','',':PRIMARY_STREET_NAME')
    #END

+    #IF( #TEXT(Input_PRIMARY_STREET_SUFFIX)='' )
      '' 
    #ELSE
        IF( le.Input_PRIMARY_STREET_SUFFIX = (TYPEOF(le.Input_PRIMARY_STREET_SUFFIX))'','',':PRIMARY_STREET_SUFFIX')
    #END

+    #IF( #TEXT(Input_POST_DIR)='' )
      '' 
    #ELSE
        IF( le.Input_POST_DIR = (TYPEOF(le.Input_POST_DIR))'','',':POST_DIR')
    #END

+    #IF( #TEXT(Input_SECONDARY_ADDRESS_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_SECONDARY_ADDRESS_TYPE = (TYPEOF(le.Input_SECONDARY_ADDRESS_TYPE))'','',':SECONDARY_ADDRESS_TYPE')
    #END

+    #IF( #TEXT(Input_SECONDARY_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_SECONDARY_RANGE = (TYPEOF(le.Input_SECONDARY_RANGE))'','',':SECONDARY_RANGE')
    #END

+    #IF( #TEXT(Input_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_CITY = (TYPEOF(le.Input_CITY))'','',':CITY')
    #END

+    #IF( #TEXT(Input_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_STATE = (TYPEOF(le.Input_STATE))'','',':STATE')
    #END

+    #IF( #TEXT(Input_ZIP_CODE)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP_CODE = (TYPEOF(le.Input_ZIP_CODE))'','',':ZIP_CODE')
    #END

+    #IF( #TEXT(Input_ZIP_PLUS4)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP_PLUS4 = (TYPEOF(le.Input_ZIP_PLUS4))'','',':ZIP_PLUS4')
    #END

+    #IF( #TEXT(Input_LATITUDE)='' )
      '' 
    #ELSE
        IF( le.Input_LATITUDE = (TYPEOF(le.Input_LATITUDE))'','',':LATITUDE')
    #END

+    #IF( #TEXT(Input_LONGITUDE)='' )
      '' 
    #ELSE
        IF( le.Input_LONGITUDE = (TYPEOF(le.Input_LONGITUDE))'','',':LONGITUDE')
    #END

+    #IF( #TEXT(Input_LAT_LONG_MATCH_LEVEL)='' )
      '' 
    #ELSE
        IF( le.Input_LAT_LONG_MATCH_LEVEL = (TYPEOF(le.Input_LAT_LONG_MATCH_LEVEL))'','',':LAT_LONG_MATCH_LEVEL')
    #END

+    #IF( #TEXT(Input_UNLICENSED)='' )
      '' 
    #ELSE
        IF( le.Input_UNLICENSED = (TYPEOF(le.Input_UNLICENSED))'','',':UNLICENSED')
    #END

+    #IF( #TEXT(Input_ADD_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_ADD_DATE = (TYPEOF(le.Input_ADD_DATE))'','',':ADD_DATE')
    #END

+    #IF( #TEXT(Input_OMIT_ADDRESS)='' )
      '' 
    #ELSE
        IF( le.Input_OMIT_ADDRESS = (TYPEOF(le.Input_OMIT_ADDRESS))'','',':OMIT_ADDRESS')
    #END

+    #IF( #TEXT(Input_DATA_SOURCE)='' )
      '' 
    #ELSE
        IF( le.Input_DATA_SOURCE = (TYPEOF(le.Input_DATA_SOURCE))'','',':DATA_SOURCE')
    #END

+    #IF( #TEXT(Input_unknownField)='' )
      '' 
    #ELSE
        IF( le.Input_unknownField = (TYPEOF(le.Input_unknownField))'','',':unknownField')
    #END

+    #IF( #TEXT(Input_TransactionID)='' )
      '' 
    #ELSE
        IF( le.Input_TransactionID = (TYPEOF(le.Input_TransactionID))'','',':TransactionID')
    #END

+    #IF( #TEXT(Input_Original_Suffix)='' )
      '' 
    #ELSE
        IF( le.Input_Original_Suffix = (TYPEOF(le.Input_Original_Suffix))'','',':Original_Suffix')
    #END

+    #IF( #TEXT(Input_Original_First_Name)='' )
      '' 
    #ELSE
        IF( le.Input_Original_First_Name = (TYPEOF(le.Input_Original_First_Name))'','',':Original_First_Name')
    #END

+    #IF( #TEXT(Input_Original_Middle_Name)='' )
      '' 
    #ELSE
        IF( le.Input_Original_Middle_Name = (TYPEOF(le.Input_Original_Middle_Name))'','',':Original_Middle_Name')
    #END

+    #IF( #TEXT(Input_Original_Last_Name)='' )
      '' 
    #ELSE
        IF( le.Input_Original_Last_Name = (TYPEOF(le.Input_Original_Last_Name))'','',':Original_Last_Name')
    #END

+    #IF( #TEXT(Input_Original_Address)='' )
      '' 
    #ELSE
        IF( le.Input_Original_Address = (TYPEOF(le.Input_Original_Address))'','',':Original_Address')
    #END

+    #IF( #TEXT(Input_Original_Last_Line)='' )
      '' 
    #ELSE
        IF( le.Input_Original_Last_Line = (TYPEOF(le.Input_Original_Last_Line))'','',':Original_Last_Line')
    #END

+    #IF( #TEXT(Input_filename)='' )
      '' 
    #ELSE
        IF( le.Input_filename = (TYPEOF(le.Input_filename))'','',':filename')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
