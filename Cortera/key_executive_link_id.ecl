IMPORT $, _control, doxie, data_services, Cortera, Cortera_Tradeline, Suppress;

#IF(_control.environment.onThor and ~_control.Environment.onVault)
dExecLinkID := Cortera.Files.ExecLinkID(link_id<>0);
#ELSE
dExecLinkID := dataset([], $.Layout_ExecLinkID);
#END

EXPORT Key_Executive_Link_id := INDEX(dExecLinkID, {Link_ID, persistent_record_id}, {dExecLinkID},
  data_services.Data_Location.Prefix('')+'thor::cortera::key::' + doxie.version_superkey + '::executive_linkid');