EXPORT string20 fn_chkdobDate(string cln_iss_Dte,string cln_exp_Dte, string20 cln_dob) := FUNCTION
			result := if(((unsigned4)cln_exp_Dte<=(unsigned4)cln_dob and (unsigned4)cln_exp_Dte>0) or  ((unsigned4)cln_exp_Dte<=0 and (unsigned4)cln_iss_Dte<=(unsigned4)cln_dob and (unsigned4)cln_iss_Dte>0),0,(unsigned4)cln_dob);
  RETURN (string20)result;
END;
