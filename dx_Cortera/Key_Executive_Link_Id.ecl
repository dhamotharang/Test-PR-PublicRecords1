IMPORT $, _control, doxie, data_services;

// ---------------------------------------------------------------
// For delta rollup logic use: $.Key_Delta_Rid_Executive
// ---------------------------------------------------------------

#IF(_control.environment.onThor and ~_control.Environment.onVault)
  InFile := $.Layouts.Layout_ExecLinkID;
#ELSE
  InFile := dataset([], $.Layouts.Layout_ExecLinkID);	
#END

EXPORT Key_Executive_Link_Id := INDEX ({InFile.Link_ID, InFile.persistent_record_id}, {InFile}, $.Keynames().Executive_Link_Id.QA);
