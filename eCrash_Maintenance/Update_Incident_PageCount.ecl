import ut;
EXPORT Update_Incident_PageCount := function


Incident_PageCount_Layout := Record
	string11 incident_id,
	string20 page_count
End;


ds_Incident_PC   :=	dataset('~thor_data400::in::ecrash::incidnt_pagecount'
													,Incident_PageCount_Layout
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(10000)))(Incident_ID != 'Incident_ID');                    

ds_incident := dataset(ut.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
													,FLAccidents_Ecrash.Layout_Infiles.incident_new
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID')
												/*	+   

							dataset('~thor_data400::in::ecrash::incidnt_raw_new_qc'
											,FLAccidents_Ecrash.Layout_Infiles.incident_new
											,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID') */ ;                    

FLAccidents_Ecrash.Layout_Infiles.incident_new updateIncidents(ds_incident L, ds_incident_PC R) := transform
	self.Page_Count := IF ( L.Page_Count <> '',L.Page_Count,R.Page_Count);
	self := L;
end;

cmbnd_incidents := join(distribute(ds_incident,hash(incident_id)),distribute(ds_incident_PC,hash(incident_id)),
			  left.incident_id = right.incident_id,
			  updateIncidents(left,right), left outer, local);

 output(cmbnd_incidents,,'~thor_data400::in::ecrash::incident_patch_PageCount_'+workunit,overwrite, __compressed__,
csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));


do_all :=  sequential(
	FileServices.StartSuperFileTransaction(),
	FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_patch_PageCount_'+workunit),
	FileServices.FinishSuperFileTransaction()
);
 
return do_all;

end;