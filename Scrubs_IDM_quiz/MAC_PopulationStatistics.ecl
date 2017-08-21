EXPORT MAC_PopulationStatistics(infile,Ref='',Input_TRANS_NUM_ID = '',Input_TRANSACTION_DATE = '',Input_ACCOUNT = '',Input_OPER_USERNAME = '',Input_TRANS_CLIENT_ID = '',Input_INPUTED_FIRST_NAME = '',Input_INPUTED_LAST_NAME = '',Input_INPUTED_SSN = '',Input_INPUTED_STREET = '',Input_INPUTED_CITY = '',Input_INPUTED_STATE = '',Input_INPUTED_ZIP = '',Input_INPUTED_DOB = '',Input_UNIQUE_IDENTITY_COUNT = '',Input_IDENTITY_LOCATED = '',Input_IDENTITY_NOT_LOCATED = '',Input_SELECTED_FIRST_NAME = '',Input_SELECTED_LAST_NAME = '',Input_SELECTED_SSN = '',Input_SELECTED_DOB = '',Input_SELECTED_STREET = '',Input_SELECTED_CITY = '',Input_SELECTED_STATE = '',Input_SELECTED_ZIP = '',Input_VERIF_PASS = '',Input_VERIF_FAIL = '',Input_VERIF_ERROR = '',Input_VERIF_NO_DATA_FOUND = '',Input_NUM_VERIF_CHKS = '',Input_NUM_VERIF_CHKS_PASS = '',Input_AUTH_SCORE = '',Input_AUTH_REQU_SCORE = '',Input_AUTH_PASS = '',Input_AUTH_FAIL = '',Input_AUTH_OPT_OUT = '',Input_AUTH_UNABLE_TO_GEN = '',Input_AUTH_ERROR = '',Input_AUTH_QUIZ_EXPIRE = '',Input_CLIENT_REFERENCE_ID = '',Input_AUTH_RESPONSE_TIME = '',Input_VERIF_RESPONSE_TIME = '',Input_NAME = '',Input_IS_VERIFICATION = '',Input_IS_AUTHENTICATION = '',Input_ITEM_STATUS = '',Input_AUTH_STATUS = '',Input_VERIF_STATUS = '',Input_PROID_ALIAS = '',Input_PROCHECK_ALIAS = '',Input_ID_DISCOVERY_ALIAS = '',Input_QUIZ1_STATUS = '',Input_QUIZ2_STATUS = '',Input_ALIAS_NAME = '',Input_PRODUCT_SEQUENCE = '',Input_QUIZ_STATUS = '',Input_IS_RESERVED = '',Input_INPUTED_LINK_ID = '',Input_SELECTED_LINK_ID = '',Input_ID_DISCOVERY_LINK_ID = '',Input_PROCHECK_LINK_ID = '',Input_PROID_LINK_ID = '',Input_INPUTED_PHONE_NUMBER = '',Input_ACCOUNT_VERIF_PASS = '',Input_ACCOUNT_VERIF_FAIL = '',Input_ACCOUNT_VERIF_ERROR = '',Input_ACCOUNT_VERIF_NO_DATA_FOUND = '',Input_ACCOUNT_NUM_VERIF_CHKS = '',Input_ACCOUNT_NUM_VERIF_CHKS_PASS = '',Input_ACCOUNT_VERIF_RESPONSE_TIME = '',Input_IS_ACCOUNT_VERIFICATION = '',Input_ACCOUNT_VERIF_STATUS = '',Input_ACCOUNT_VERIFICATION_ALIAS = '',Input_ACCOUNT_VERIF_LINK_ID = '',Input_BUSINESS_NAME = '',Input_FEIN = '',Input_TAXID = '',Input_GROUP_NAME = '',Input_GROUP_SEQUENCE = '',Input_SUB_PRODUCT_NAME = '',Input_SUB_PRODUCT_SEQUENCE = '',Input_IS_SURVEY = '',Input_SURVEY_STATUS = '',Input_SURVEY_QUESTION = '',Input_QUESTION_SEQUENCE = '',Input_QUESTION_CHOICE = '',Input_CHOICE_SEQUENCE = '',Input_USER_CHOICE = '',Input_ACTUAL_PROID_ALIAS = '',Input_ACTUAL_PROCHECK_ALIAS = '',Input_ACTUAL_ID_DISCOVERY_ALIAS = '',Input_REAL_PROID_ALIAS = '',Input_REAL_PROCHECK_ALIAS = '',Input_REAL_ID_DISCOVERY_ALIAS = '',Input_IS_CUSTOM = '',Input_SOURCE_IP = '',Input_IDENTITY_LOCATED_STATUS = '',Input_IDENTITY_NOT_LOCATED_STATUS = '',Input_VERIF_ERROR_STATUS = '',Input_VERIF_NO_DATA_FOUND_STATUS = '',Input_ACCOUNT_VERIF_ERROR_STATUS = '',Input_ACCOUNT_VERIF_NO_DATA_FOUND_STATUS = '',Input_AUTH_FAIL_STATUS = '',Input_AUTH_STATUS_CODE = '',Input_QUIZ_STATUS_CODE = '',Input_CONVERSATION_ID = '',Input_CUST_USERNAME = '',OutFile) := MACRO
  IMPORT SALT32,SCRUBS_IDM_QUIZ;
  #uniquename(of)
  %of% := RECORD
    SALT32.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_TRANS_NUM_ID)='' )
      '' 
    #ELSE
        IF( le.Input_TRANS_NUM_ID = (TYPEOF(le.Input_TRANS_NUM_ID))'','',':TRANS_NUM_ID')
    #END
+    #IF( #TEXT(Input_TRANSACTION_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_TRANSACTION_DATE = (TYPEOF(le.Input_TRANSACTION_DATE))'','',':TRANSACTION_DATE')
    #END
+    #IF( #TEXT(Input_ACCOUNT)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT = (TYPEOF(le.Input_ACCOUNT))'','',':ACCOUNT')
    #END
+    #IF( #TEXT(Input_OPER_USERNAME)='' )
      '' 
    #ELSE
        IF( le.Input_OPER_USERNAME = (TYPEOF(le.Input_OPER_USERNAME))'','',':OPER_USERNAME')
    #END
+    #IF( #TEXT(Input_TRANS_CLIENT_ID)='' )
      '' 
    #ELSE
        IF( le.Input_TRANS_CLIENT_ID = (TYPEOF(le.Input_TRANS_CLIENT_ID))'','',':TRANS_CLIENT_ID')
    #END
+    #IF( #TEXT(Input_INPUTED_FIRST_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_FIRST_NAME = (TYPEOF(le.Input_INPUTED_FIRST_NAME))'','',':INPUTED_FIRST_NAME')
    #END
+    #IF( #TEXT(Input_INPUTED_LAST_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_LAST_NAME = (TYPEOF(le.Input_INPUTED_LAST_NAME))'','',':INPUTED_LAST_NAME')
    #END
+    #IF( #TEXT(Input_INPUTED_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_SSN = (TYPEOF(le.Input_INPUTED_SSN))'','',':INPUTED_SSN')
    #END
+    #IF( #TEXT(Input_INPUTED_STREET)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_STREET = (TYPEOF(le.Input_INPUTED_STREET))'','',':INPUTED_STREET')
    #END
+    #IF( #TEXT(Input_INPUTED_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_CITY = (TYPEOF(le.Input_INPUTED_CITY))'','',':INPUTED_CITY')
    #END
+    #IF( #TEXT(Input_INPUTED_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_STATE = (TYPEOF(le.Input_INPUTED_STATE))'','',':INPUTED_STATE')
    #END
+    #IF( #TEXT(Input_INPUTED_ZIP)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_ZIP = (TYPEOF(le.Input_INPUTED_ZIP))'','',':INPUTED_ZIP')
    #END
+    #IF( #TEXT(Input_INPUTED_DOB)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_DOB = (TYPEOF(le.Input_INPUTED_DOB))'','',':INPUTED_DOB')
    #END
+    #IF( #TEXT(Input_UNIQUE_IDENTITY_COUNT)='' )
      '' 
    #ELSE
        IF( le.Input_UNIQUE_IDENTITY_COUNT = (TYPEOF(le.Input_UNIQUE_IDENTITY_COUNT))'','',':UNIQUE_IDENTITY_COUNT')
    #END
+    #IF( #TEXT(Input_IDENTITY_LOCATED)='' )
      '' 
    #ELSE
        IF( le.Input_IDENTITY_LOCATED = (TYPEOF(le.Input_IDENTITY_LOCATED))'','',':IDENTITY_LOCATED')
    #END
+    #IF( #TEXT(Input_IDENTITY_NOT_LOCATED)='' )
      '' 
    #ELSE
        IF( le.Input_IDENTITY_NOT_LOCATED = (TYPEOF(le.Input_IDENTITY_NOT_LOCATED))'','',':IDENTITY_NOT_LOCATED')
    #END
+    #IF( #TEXT(Input_SELECTED_FIRST_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_FIRST_NAME = (TYPEOF(le.Input_SELECTED_FIRST_NAME))'','',':SELECTED_FIRST_NAME')
    #END
+    #IF( #TEXT(Input_SELECTED_LAST_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_LAST_NAME = (TYPEOF(le.Input_SELECTED_LAST_NAME))'','',':SELECTED_LAST_NAME')
    #END
+    #IF( #TEXT(Input_SELECTED_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_SSN = (TYPEOF(le.Input_SELECTED_SSN))'','',':SELECTED_SSN')
    #END
+    #IF( #TEXT(Input_SELECTED_DOB)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_DOB = (TYPEOF(le.Input_SELECTED_DOB))'','',':SELECTED_DOB')
    #END
+    #IF( #TEXT(Input_SELECTED_STREET)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_STREET = (TYPEOF(le.Input_SELECTED_STREET))'','',':SELECTED_STREET')
    #END
+    #IF( #TEXT(Input_SELECTED_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_CITY = (TYPEOF(le.Input_SELECTED_CITY))'','',':SELECTED_CITY')
    #END
+    #IF( #TEXT(Input_SELECTED_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_STATE = (TYPEOF(le.Input_SELECTED_STATE))'','',':SELECTED_STATE')
    #END
+    #IF( #TEXT(Input_SELECTED_ZIP)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_ZIP = (TYPEOF(le.Input_SELECTED_ZIP))'','',':SELECTED_ZIP')
    #END
+    #IF( #TEXT(Input_VERIF_PASS)='' )
      '' 
    #ELSE
        IF( le.Input_VERIF_PASS = (TYPEOF(le.Input_VERIF_PASS))'','',':VERIF_PASS')
    #END
+    #IF( #TEXT(Input_VERIF_FAIL)='' )
      '' 
    #ELSE
        IF( le.Input_VERIF_FAIL = (TYPEOF(le.Input_VERIF_FAIL))'','',':VERIF_FAIL')
    #END
+    #IF( #TEXT(Input_VERIF_ERROR)='' )
      '' 
    #ELSE
        IF( le.Input_VERIF_ERROR = (TYPEOF(le.Input_VERIF_ERROR))'','',':VERIF_ERROR')
    #END
+    #IF( #TEXT(Input_VERIF_NO_DATA_FOUND)='' )
      '' 
    #ELSE
        IF( le.Input_VERIF_NO_DATA_FOUND = (TYPEOF(le.Input_VERIF_NO_DATA_FOUND))'','',':VERIF_NO_DATA_FOUND')
    #END
+    #IF( #TEXT(Input_NUM_VERIF_CHKS)='' )
      '' 
    #ELSE
        IF( le.Input_NUM_VERIF_CHKS = (TYPEOF(le.Input_NUM_VERIF_CHKS))'','',':NUM_VERIF_CHKS')
    #END
+    #IF( #TEXT(Input_NUM_VERIF_CHKS_PASS)='' )
      '' 
    #ELSE
        IF( le.Input_NUM_VERIF_CHKS_PASS = (TYPEOF(le.Input_NUM_VERIF_CHKS_PASS))'','',':NUM_VERIF_CHKS_PASS')
    #END
+    #IF( #TEXT(Input_AUTH_SCORE)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_SCORE = (TYPEOF(le.Input_AUTH_SCORE))'','',':AUTH_SCORE')
    #END
+    #IF( #TEXT(Input_AUTH_REQU_SCORE)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_REQU_SCORE = (TYPEOF(le.Input_AUTH_REQU_SCORE))'','',':AUTH_REQU_SCORE')
    #END
+    #IF( #TEXT(Input_AUTH_PASS)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_PASS = (TYPEOF(le.Input_AUTH_PASS))'','',':AUTH_PASS')
    #END
+    #IF( #TEXT(Input_AUTH_FAIL)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_FAIL = (TYPEOF(le.Input_AUTH_FAIL))'','',':AUTH_FAIL')
    #END
+    #IF( #TEXT(Input_AUTH_OPT_OUT)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_OPT_OUT = (TYPEOF(le.Input_AUTH_OPT_OUT))'','',':AUTH_OPT_OUT')
    #END
+    #IF( #TEXT(Input_AUTH_UNABLE_TO_GEN)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_UNABLE_TO_GEN = (TYPEOF(le.Input_AUTH_UNABLE_TO_GEN))'','',':AUTH_UNABLE_TO_GEN')
    #END
+    #IF( #TEXT(Input_AUTH_ERROR)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_ERROR = (TYPEOF(le.Input_AUTH_ERROR))'','',':AUTH_ERROR')
    #END
+    #IF( #TEXT(Input_AUTH_QUIZ_EXPIRE)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_QUIZ_EXPIRE = (TYPEOF(le.Input_AUTH_QUIZ_EXPIRE))'','',':AUTH_QUIZ_EXPIRE')
    #END
+    #IF( #TEXT(Input_CLIENT_REFERENCE_ID)='' )
      '' 
    #ELSE
        IF( le.Input_CLIENT_REFERENCE_ID = (TYPEOF(le.Input_CLIENT_REFERENCE_ID))'','',':CLIENT_REFERENCE_ID')
    #END
+    #IF( #TEXT(Input_AUTH_RESPONSE_TIME)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_RESPONSE_TIME = (TYPEOF(le.Input_AUTH_RESPONSE_TIME))'','',':AUTH_RESPONSE_TIME')
    #END
+    #IF( #TEXT(Input_VERIF_RESPONSE_TIME)='' )
      '' 
    #ELSE
        IF( le.Input_VERIF_RESPONSE_TIME = (TYPEOF(le.Input_VERIF_RESPONSE_TIME))'','',':VERIF_RESPONSE_TIME')
    #END
+    #IF( #TEXT(Input_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_NAME = (TYPEOF(le.Input_NAME))'','',':NAME')
    #END
+    #IF( #TEXT(Input_IS_VERIFICATION)='' )
      '' 
    #ELSE
        IF( le.Input_IS_VERIFICATION = (TYPEOF(le.Input_IS_VERIFICATION))'','',':IS_VERIFICATION')
    #END
+    #IF( #TEXT(Input_IS_AUTHENTICATION)='' )
      '' 
    #ELSE
        IF( le.Input_IS_AUTHENTICATION = (TYPEOF(le.Input_IS_AUTHENTICATION))'','',':IS_AUTHENTICATION')
    #END
+    #IF( #TEXT(Input_ITEM_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_ITEM_STATUS = (TYPEOF(le.Input_ITEM_STATUS))'','',':ITEM_STATUS')
    #END
+    #IF( #TEXT(Input_AUTH_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_STATUS = (TYPEOF(le.Input_AUTH_STATUS))'','',':AUTH_STATUS')
    #END
+    #IF( #TEXT(Input_VERIF_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_VERIF_STATUS = (TYPEOF(le.Input_VERIF_STATUS))'','',':VERIF_STATUS')
    #END
+    #IF( #TEXT(Input_PROID_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_PROID_ALIAS = (TYPEOF(le.Input_PROID_ALIAS))'','',':PROID_ALIAS')
    #END
+    #IF( #TEXT(Input_PROCHECK_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_PROCHECK_ALIAS = (TYPEOF(le.Input_PROCHECK_ALIAS))'','',':PROCHECK_ALIAS')
    #END
+    #IF( #TEXT(Input_ID_DISCOVERY_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_ID_DISCOVERY_ALIAS = (TYPEOF(le.Input_ID_DISCOVERY_ALIAS))'','',':ID_DISCOVERY_ALIAS')
    #END
+    #IF( #TEXT(Input_QUIZ1_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_QUIZ1_STATUS = (TYPEOF(le.Input_QUIZ1_STATUS))'','',':QUIZ1_STATUS')
    #END
+    #IF( #TEXT(Input_QUIZ2_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_QUIZ2_STATUS = (TYPEOF(le.Input_QUIZ2_STATUS))'','',':QUIZ2_STATUS')
    #END
+    #IF( #TEXT(Input_ALIAS_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_ALIAS_NAME = (TYPEOF(le.Input_ALIAS_NAME))'','',':ALIAS_NAME')
    #END
+    #IF( #TEXT(Input_PRODUCT_SEQUENCE)='' )
      '' 
    #ELSE
        IF( le.Input_PRODUCT_SEQUENCE = (TYPEOF(le.Input_PRODUCT_SEQUENCE))'','',':PRODUCT_SEQUENCE')
    #END
+    #IF( #TEXT(Input_QUIZ_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_QUIZ_STATUS = (TYPEOF(le.Input_QUIZ_STATUS))'','',':QUIZ_STATUS')
    #END
+    #IF( #TEXT(Input_IS_RESERVED)='' )
      '' 
    #ELSE
        IF( le.Input_IS_RESERVED = (TYPEOF(le.Input_IS_RESERVED))'','',':IS_RESERVED')
    #END
+    #IF( #TEXT(Input_INPUTED_LINK_ID)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_LINK_ID = (TYPEOF(le.Input_INPUTED_LINK_ID))'','',':INPUTED_LINK_ID')
    #END
+    #IF( #TEXT(Input_SELECTED_LINK_ID)='' )
      '' 
    #ELSE
        IF( le.Input_SELECTED_LINK_ID = (TYPEOF(le.Input_SELECTED_LINK_ID))'','',':SELECTED_LINK_ID')
    #END
+    #IF( #TEXT(Input_ID_DISCOVERY_LINK_ID)='' )
      '' 
    #ELSE
        IF( le.Input_ID_DISCOVERY_LINK_ID = (TYPEOF(le.Input_ID_DISCOVERY_LINK_ID))'','',':ID_DISCOVERY_LINK_ID')
    #END
+    #IF( #TEXT(Input_PROCHECK_LINK_ID)='' )
      '' 
    #ELSE
        IF( le.Input_PROCHECK_LINK_ID = (TYPEOF(le.Input_PROCHECK_LINK_ID))'','',':PROCHECK_LINK_ID')
    #END
+    #IF( #TEXT(Input_PROID_LINK_ID)='' )
      '' 
    #ELSE
        IF( le.Input_PROID_LINK_ID = (TYPEOF(le.Input_PROID_LINK_ID))'','',':PROID_LINK_ID')
    #END
+    #IF( #TEXT(Input_INPUTED_PHONE_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_INPUTED_PHONE_NUMBER = (TYPEOF(le.Input_INPUTED_PHONE_NUMBER))'','',':INPUTED_PHONE_NUMBER')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_PASS)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_PASS = (TYPEOF(le.Input_ACCOUNT_VERIF_PASS))'','',':ACCOUNT_VERIF_PASS')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_FAIL)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_FAIL = (TYPEOF(le.Input_ACCOUNT_VERIF_FAIL))'','',':ACCOUNT_VERIF_FAIL')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_ERROR)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_ERROR = (TYPEOF(le.Input_ACCOUNT_VERIF_ERROR))'','',':ACCOUNT_VERIF_ERROR')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_NO_DATA_FOUND)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_NO_DATA_FOUND = (TYPEOF(le.Input_ACCOUNT_VERIF_NO_DATA_FOUND))'','',':ACCOUNT_VERIF_NO_DATA_FOUND')
    #END
+    #IF( #TEXT(Input_ACCOUNT_NUM_VERIF_CHKS)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_NUM_VERIF_CHKS = (TYPEOF(le.Input_ACCOUNT_NUM_VERIF_CHKS))'','',':ACCOUNT_NUM_VERIF_CHKS')
    #END
+    #IF( #TEXT(Input_ACCOUNT_NUM_VERIF_CHKS_PASS)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_NUM_VERIF_CHKS_PASS = (TYPEOF(le.Input_ACCOUNT_NUM_VERIF_CHKS_PASS))'','',':ACCOUNT_NUM_VERIF_CHKS_PASS')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_RESPONSE_TIME)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_RESPONSE_TIME = (TYPEOF(le.Input_ACCOUNT_VERIF_RESPONSE_TIME))'','',':ACCOUNT_VERIF_RESPONSE_TIME')
    #END
+    #IF( #TEXT(Input_IS_ACCOUNT_VERIFICATION)='' )
      '' 
    #ELSE
        IF( le.Input_IS_ACCOUNT_VERIFICATION = (TYPEOF(le.Input_IS_ACCOUNT_VERIFICATION))'','',':IS_ACCOUNT_VERIFICATION')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_STATUS = (TYPEOF(le.Input_ACCOUNT_VERIF_STATUS))'','',':ACCOUNT_VERIF_STATUS')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIFICATION_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIFICATION_ALIAS = (TYPEOF(le.Input_ACCOUNT_VERIFICATION_ALIAS))'','',':ACCOUNT_VERIFICATION_ALIAS')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_LINK_ID)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_LINK_ID = (TYPEOF(le.Input_ACCOUNT_VERIF_LINK_ID))'','',':ACCOUNT_VERIF_LINK_ID')
    #END
+    #IF( #TEXT(Input_BUSINESS_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_NAME = (TYPEOF(le.Input_BUSINESS_NAME))'','',':BUSINESS_NAME')
    #END
+    #IF( #TEXT(Input_FEIN)='' )
      '' 
    #ELSE
        IF( le.Input_FEIN = (TYPEOF(le.Input_FEIN))'','',':FEIN')
    #END
+    #IF( #TEXT(Input_TAXID)='' )
      '' 
    #ELSE
        IF( le.Input_TAXID = (TYPEOF(le.Input_TAXID))'','',':TAXID')
    #END
+    #IF( #TEXT(Input_GROUP_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_GROUP_NAME = (TYPEOF(le.Input_GROUP_NAME))'','',':GROUP_NAME')
    #END
+    #IF( #TEXT(Input_GROUP_SEQUENCE)='' )
      '' 
    #ELSE
        IF( le.Input_GROUP_SEQUENCE = (TYPEOF(le.Input_GROUP_SEQUENCE))'','',':GROUP_SEQUENCE')
    #END
+    #IF( #TEXT(Input_SUB_PRODUCT_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_SUB_PRODUCT_NAME = (TYPEOF(le.Input_SUB_PRODUCT_NAME))'','',':SUB_PRODUCT_NAME')
    #END
+    #IF( #TEXT(Input_SUB_PRODUCT_SEQUENCE)='' )
      '' 
    #ELSE
        IF( le.Input_SUB_PRODUCT_SEQUENCE = (TYPEOF(le.Input_SUB_PRODUCT_SEQUENCE))'','',':SUB_PRODUCT_SEQUENCE')
    #END
+    #IF( #TEXT(Input_IS_SURVEY)='' )
      '' 
    #ELSE
        IF( le.Input_IS_SURVEY = (TYPEOF(le.Input_IS_SURVEY))'','',':IS_SURVEY')
    #END
+    #IF( #TEXT(Input_SURVEY_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_SURVEY_STATUS = (TYPEOF(le.Input_SURVEY_STATUS))'','',':SURVEY_STATUS')
    #END
+    #IF( #TEXT(Input_SURVEY_QUESTION)='' )
      '' 
    #ELSE
        IF( le.Input_SURVEY_QUESTION = (TYPEOF(le.Input_SURVEY_QUESTION))'','',':SURVEY_QUESTION')
    #END
+    #IF( #TEXT(Input_QUESTION_SEQUENCE)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTION_SEQUENCE = (TYPEOF(le.Input_QUESTION_SEQUENCE))'','',':QUESTION_SEQUENCE')
    #END
+    #IF( #TEXT(Input_QUESTION_CHOICE)='' )
      '' 
    #ELSE
        IF( le.Input_QUESTION_CHOICE = (TYPEOF(le.Input_QUESTION_CHOICE))'','',':QUESTION_CHOICE')
    #END
+    #IF( #TEXT(Input_CHOICE_SEQUENCE)='' )
      '' 
    #ELSE
        IF( le.Input_CHOICE_SEQUENCE = (TYPEOF(le.Input_CHOICE_SEQUENCE))'','',':CHOICE_SEQUENCE')
    #END
+    #IF( #TEXT(Input_USER_CHOICE)='' )
      '' 
    #ELSE
        IF( le.Input_USER_CHOICE = (TYPEOF(le.Input_USER_CHOICE))'','',':USER_CHOICE')
    #END
+    #IF( #TEXT(Input_ACTUAL_PROID_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_ACTUAL_PROID_ALIAS = (TYPEOF(le.Input_ACTUAL_PROID_ALIAS))'','',':ACTUAL_PROID_ALIAS')
    #END
+    #IF( #TEXT(Input_ACTUAL_PROCHECK_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_ACTUAL_PROCHECK_ALIAS = (TYPEOF(le.Input_ACTUAL_PROCHECK_ALIAS))'','',':ACTUAL_PROCHECK_ALIAS')
    #END
+    #IF( #TEXT(Input_ACTUAL_ID_DISCOVERY_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_ACTUAL_ID_DISCOVERY_ALIAS = (TYPEOF(le.Input_ACTUAL_ID_DISCOVERY_ALIAS))'','',':ACTUAL_ID_DISCOVERY_ALIAS')
    #END
+    #IF( #TEXT(Input_REAL_PROID_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_REAL_PROID_ALIAS = (TYPEOF(le.Input_REAL_PROID_ALIAS))'','',':REAL_PROID_ALIAS')
    #END
+    #IF( #TEXT(Input_REAL_PROCHECK_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_REAL_PROCHECK_ALIAS = (TYPEOF(le.Input_REAL_PROCHECK_ALIAS))'','',':REAL_PROCHECK_ALIAS')
    #END
+    #IF( #TEXT(Input_REAL_ID_DISCOVERY_ALIAS)='' )
      '' 
    #ELSE
        IF( le.Input_REAL_ID_DISCOVERY_ALIAS = (TYPEOF(le.Input_REAL_ID_DISCOVERY_ALIAS))'','',':REAL_ID_DISCOVERY_ALIAS')
    #END
+    #IF( #TEXT(Input_IS_CUSTOM)='' )
      '' 
    #ELSE
        IF( le.Input_IS_CUSTOM = (TYPEOF(le.Input_IS_CUSTOM))'','',':IS_CUSTOM')
    #END
+    #IF( #TEXT(Input_SOURCE_IP)='' )
      '' 
    #ELSE
        IF( le.Input_SOURCE_IP = (TYPEOF(le.Input_SOURCE_IP))'','',':SOURCE_IP')
    #END
+    #IF( #TEXT(Input_IDENTITY_LOCATED_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_IDENTITY_LOCATED_STATUS = (TYPEOF(le.Input_IDENTITY_LOCATED_STATUS))'','',':IDENTITY_LOCATED_STATUS')
    #END
+    #IF( #TEXT(Input_IDENTITY_NOT_LOCATED_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_IDENTITY_NOT_LOCATED_STATUS = (TYPEOF(le.Input_IDENTITY_NOT_LOCATED_STATUS))'','',':IDENTITY_NOT_LOCATED_STATUS')
    #END
+    #IF( #TEXT(Input_VERIF_ERROR_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_VERIF_ERROR_STATUS = (TYPEOF(le.Input_VERIF_ERROR_STATUS))'','',':VERIF_ERROR_STATUS')
    #END
+    #IF( #TEXT(Input_VERIF_NO_DATA_FOUND_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_VERIF_NO_DATA_FOUND_STATUS = (TYPEOF(le.Input_VERIF_NO_DATA_FOUND_STATUS))'','',':VERIF_NO_DATA_FOUND_STATUS')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_ERROR_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_ERROR_STATUS = (TYPEOF(le.Input_ACCOUNT_VERIF_ERROR_STATUS))'','',':ACCOUNT_VERIF_ERROR_STATUS')
    #END
+    #IF( #TEXT(Input_ACCOUNT_VERIF_NO_DATA_FOUND_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_ACCOUNT_VERIF_NO_DATA_FOUND_STATUS = (TYPEOF(le.Input_ACCOUNT_VERIF_NO_DATA_FOUND_STATUS))'','',':ACCOUNT_VERIF_NO_DATA_FOUND_STATUS')
    #END
+    #IF( #TEXT(Input_AUTH_FAIL_STATUS)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_FAIL_STATUS = (TYPEOF(le.Input_AUTH_FAIL_STATUS))'','',':AUTH_FAIL_STATUS')
    #END
+    #IF( #TEXT(Input_AUTH_STATUS_CODE)='' )
      '' 
    #ELSE
        IF( le.Input_AUTH_STATUS_CODE = (TYPEOF(le.Input_AUTH_STATUS_CODE))'','',':AUTH_STATUS_CODE')
    #END
+    #IF( #TEXT(Input_QUIZ_STATUS_CODE)='' )
      '' 
    #ELSE
        IF( le.Input_QUIZ_STATUS_CODE = (TYPEOF(le.Input_QUIZ_STATUS_CODE))'','',':QUIZ_STATUS_CODE')
    #END
+    #IF( #TEXT(Input_CONVERSATION_ID)='' )
      '' 
    #ELSE
        IF( le.Input_CONVERSATION_ID = (TYPEOF(le.Input_CONVERSATION_ID))'','',':CONVERSATION_ID')
    #END
+    #IF( #TEXT(Input_CUST_USERNAME)='' )
      '' 
    #ELSE
        IF( le.Input_CUST_USERNAME = (TYPEOF(le.Input_CUST_USERNAME))'','',':CUST_USERNAME')
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
