import Enclarity,Data_Services,doxie;

d1:=Enclarity.Files(,true).individual_base.qa (lnpid>0);
d2:=Enclarity.Files(,true).facility_base.qa    (lnpid>0);
d3:=Ingenix_NatlProf.File_EnclaritySanctionGap (lnpid>0);
r:={unsigned6 lnpid, unsigned6 sanc_id};
d := dedup(
						project(d1,transform(r,self.sanc_id:=left.pid,self:=left))
					+ project(d2,transform(r,self.sanc_id:=left.pid,self:=left))
					+ project(d3,transform(r,self.sanc_id:=(Unsigned6)left.sanc_id,self:=left))
				,lnpid,sanc_id,all);

i:=index(d,{lnpid},{sanc_id}
		,Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_lnpid_' + doxie.Version_SuperKey);

EXPORT key_lnpid := i;