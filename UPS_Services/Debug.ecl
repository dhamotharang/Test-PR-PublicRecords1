EXPORT Debug := MODULE
  EXPORT debug_flag := FALSE;
  
  EXPORT MAC_Output(rset, rset_name=#TEXT('')) := MACRO
    #IF(UPS_Services.Debug.debug_flag)
      #UNIQUENAME(rsn)
      %rsn% := IF(rset_name <> '', rset_name, #TEXT(rset));
      OUTPUT(rset, NAMED(%rsn%));
    #END
  ENDMACRO;
END;
