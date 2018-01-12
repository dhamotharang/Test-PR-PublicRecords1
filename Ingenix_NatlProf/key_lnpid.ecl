import Enclarity,Enclarity_Facility_Sanctions,Data_Services,doxie;

// as of 20170617 - changing base file to the sanctions_all file created by Enclarity.As_Ingenix and
// Enclarity_Facility_Sanctions.As_Ingenix.  The original method, below, includes facilities and individuals
// that do not have sanctions
// d1:=Enclarity.Files(,true).individual_base.qa(lnpid>0);
// d2:=Enclarity.Files(,true).facility_base.qa(lnpid>0);
// as of 20160630 - no longer receiving Ingenix data - turning off the call to the Ingenix in files
// d3:=Ingenix_NatlProf.File_EnclaritySanctionGap (lnpid>0);
// d3a:=Enclarity_Facility_Sanctions.Files(,true).facility_sanctions_base.qa (lnfid>0);
// new_rec	:= record
	// Enclarity_Facility_Sanctions.Layouts.Base.Facility_Sanctions - [lnfid];
	// unsigned6 lnpid;
// end;
// d3 :=project(d3a, transform({new_rec},self.lnpid := left.lnfid, self := left));
r:={unsigned6 lnpid, unsigned6 sanc_id};
// d := dedup(
						// project(d1,transform(r,self.sanc_id:=left.pid,self:=left))
					// + project(d2,transform(r,self.sanc_id:=left.pid,self:=left))
					// + project(d3,transform(r,self.sanc_id:=left.pid,self:=left))
				// ,lnpid,sanc_id,all);
d	:= dedup(project(Ingenix_NatlProf.Basefile_Sanctions_Bdid (lnpid > 0),transform(r,self.sanc_id:=(unsigned6)left.sanc_id,self:=left)),lnpid,sanc_id,all);

i:=index(d,{lnpid},{sanc_id}
		,Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_lnpid_' + doxie.Version_SuperKey);

EXPORT key_lnpid := i;