IMPORT _validate,ut,hms_stlic;

EXPORT fn_IsValidDate(string in_Dt) := FUNCTION
			out_dt := if(in_Dt in ['19010101','19000101','18000101','18010101'],'0',in_Dt);
  RETURN out_dt;
END;