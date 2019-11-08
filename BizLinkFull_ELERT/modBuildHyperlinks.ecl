EXPORT modBuildHyperlinks := MODULE
  //Change all of this to match your data. -ZRS 4/8/2019    
  EXPORT fBuildMeowService(modLayouts.lSampleLayout rRec, modLayouts.lHyperlinkProfile rHyperLinkProfile) := FUNCTION
    sInput := 'uniqueid=' + rRec.UniqueID +
    '&usecompletefullmatch=0&maxids=&leadthreshold=&dt_first_effective=&dt_last_effective=' + 
    '&npi_number=' + rRec.NPI_NUMBER + 
    '&dea_number=' + rRec.DEA_NUMBER + 
    '&upin=' + rRec.UPIN + 
    '&lic_state=' + rRec.LIC_STATE + 
    '&lic_nbr_num=' + rRec.LIC_NBR_NUM + 
    '&csr_state=' + rRec.CSR_STATE + 
    '&csr_nbr_num=' + rRec.CSR_NBR_NUM + 
    '&lexid=' + rRec.LEXID + 
    '&ssn=' + rRec.SSN + 
    '&dob=' + rRec.DOB + 
    '&tax_id=' + rRec.TAX_ID + 
    '&billing_npi=' + rRec.BILLING_NPI + 
    '&fname=' + rRec.FNAME + 
    '&mname=' + rRec.MNAME + 
    '&lname=' + rRec.LNAME + 
    '&sname=' + rRec.SNAME + 
    '&medschool=' + rRec.MEDSCHOOL + 
    '&medschool_year=' + rRec.MEDSCHOOL_YEAR + 
    '&derived_gender=' + rRec.GENDER + 
    '&taxonomy=' + rRec.TAXONOMY + 
    '&practitioner_type=' + rRec.PRACTITIONER_TYPE + 
    '&classification=' + rRec.CLASSIFICATION + 
    '&prim_range=' + rRec.PRIM_RANGE + 
    '&prim_name=' + rRec.PRIM_NAME + 
    '&sec_range=' + rRec.SEC_RANGE + 
    '&city=' + rRec.CITY + 
    '&st=' + rRec.ST + 
    '&prac_phone=' + rRec.PRAC_PHONE + 
    '&hms_piid=' + rRec.HMS_PIID + 
    '&zip_cases.Row.zip=' + rRec.ZIP + 
    '&zip_cases.Row.weight=100'; 
    RETURN rHyperLinkProfile.sIPAddress + '/WsEcl/xslt/query/' + rHyperLinkProfile.sClusterName + '/' + rHyperLinkProfile.sServiceName + '?' + sInput;
  END;
   EXPORT fBuildHeaderService(modLayouts.lSampleLayout rRec, modLayouts.lHyperlinkProfile rHyperLinkProfile) := FUNCTION
    sInput := 'uniqueid=' + rRec.UniqueID +
    '&usecompletefullmatch=0&maxids=&leadthreshold=&dt_first_effective=&dt_last_effective=' + 
    '&lnpid=' + rRec.LNPID_Out ; 
    RETURN rHyperLinkProfile.sIPAddress + '/WsEcl/xslt/query/' + rHyperLinkProfile.sClusterName + '/' + rHyperLinkProfile.sServiceName + '?' + sInput;
  END;  
END;
