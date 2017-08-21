Import Data_Services, Ingenix_NatlProf, doxie, Data_Services,BIPV2;

temp_rec:=record
		Ingenix_NatlProf.layout_sanctions_bdid -BIPV2.IDlayouts.l_xlink_ids -source_rec_id -DerivedReinstateDate;
end;
base_file := project(Ingenix_NatlProf.Basefile_Sanctions_Bdid(bdid<>0),transform(temp_rec,self:=left;));

export key_sanctions_bdid :=index(base_file,
                                  {bdid}, {sanc_id}, '~thor_data400::key::ingenix_sanctions_bdid_' + doxie.Version_SuperKey);