/*2015-09-18T21:09:21Z (Srilatha Katukuri)
#189488
*/
EXPORT Update_Incident_ReportLinkId := function
import ut;

Incident_reportLinkId_Layout := Record
	string11 incident_id,
	string20 reportlinkid
End;


ds_Incident_RL   :=	dataset('~thor_data400::in::ecrash::incidnt_reportlinkid'
													,Incident_reportLinkId_Layout
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(10000)))(Incident_ID != 'Incident_ID');                    


ds_incident := /*dataset(ut.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
													,FLAccidents_Ecrash.Layout_Infiles.incident_new
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID')+   */ 

							dataset(ut.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
											,FLAccidents_Ecrash.Layout_Infiles.incident_new
											,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');                    


FLAccidents_Ecrash.Layout_Infiles.incident_new updateIncidents(ds_incident L, ds_incident_RL R) := transform
	self.reportlinkid := IF ( L.reportlinkid <> '',L.reportlinkid,R.reportlinkid);
	self := L;
end;

cmbnd_incidents := join(distribute(ds_incident,hash(incident_id)),distribute(ds_incident_RL,hash(incident_id)),
			  left.incident_id = right.incident_id,
			  updateIncidents(left,right), left outer, local);


 output(cmbnd_incidents,,'~thor_data400::in::ecrash::incident_patch_rptlinkid_'+workunit,overwrite, __compressed__,
csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

return sequential(
	FileServices.StartSuperFileTransaction(),
	FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new_srk','~thor_data400::in::ecrash::incident_patch_rptlinkid_'+workunit),
	FileServices.FinishSuperFileTransaction()
);

end;