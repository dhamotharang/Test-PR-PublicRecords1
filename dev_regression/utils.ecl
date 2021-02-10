IMPORT STD, iesp;

EXPORT utils := MODULE
  // making sure xml is surrounded by <Row> tag, or else FROMXML fails.
  EXPORT wrapXML(UTF8 xml) := FUNCTION
    RETURN IF (TRIM(STD.STR.ToLowerCase((STRING) xml))[1..5] = '<row>', xml, '<Row>' + xml + '</Row>');
  END;

  // making sure xml is surrounded by <Row> tag, or else FROMXML fails.
  EXPORT wrapTOXML(rec) := FUNCTIONMACRO
    RETURN '<Row>'+TOXML(rec)+'</Row>';
  ENDMACRO;

  // drop customer's specific info when creating test cases from ROxie input logs
  EXPORT iesp.share.t_User CleanUser (iesp.share.t_User L) := TRANSFORM
    SELF.GLBPurpose := L.GLBPurpose;
    SELF.DLPurpose := L.DLPurpose;
    SELF.IndustryClass := L.IndustryClass;
    SELF.SSNMask := L.SSNMask;
    SELF.DOBMask := L.DOBMask;
    SELF.ExcludeDMVPII := L.ExcludeDMVPII;
    SELF.DLMask := L.DLMask;
    SELF.DataPermissionMask := L.DataPermissionMask;
    SELF.DataRestrictionMask := L.DataRestrictionMask;
    SELF.ApplicationType := L.ApplicationType;
    SELF.SSNMaskingOn := L.SSNMaskingOn;
    SELF.DLMaskingOn := L.DLMaskingOn;
    SELF.LnBranded := L.LnBranded;
    SELF.DeathMasterPurpose := L.DeathMasterPurpose;
    SELF.ResellerType := L.ResellerType;
    SELF := [];
  END;

END;
