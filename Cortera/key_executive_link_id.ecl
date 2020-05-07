IMPORT _control, doxie, data_services, Cortera, Cortera_Tradeline, Suppress;


#IF(_control.environment.onThor and ~_control.Environment.onVault)
dExecLinkID := Cortera.Files.ExecLinkID(link_id<>0);
dExecLinkIDwDID := dExecLinkID(did<>0);
dExecLinkIDwoDID := dExecLinkID(did=0);
mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
suppress_global_sid := Suppress.MAC_SuppressSource(dExecLinkIDwDID, mod_access, , , TRUE);
#ELSE
suppress_global_sid := dataset([], $.Layout_Executive_Link_Id);
#END

after_suppress_all := suppress_global_sid + dExecLinkIDwoDID;

EXPORT Key_Executive_Link_id := INDEX(after_suppress_all, {Link_ID, persistent_record_id}, {after_suppress_all},
  data_services.Data_Location.Prefix('')+'thor::cortera::key::' + doxie.version_superkey + '::executive_linkid');