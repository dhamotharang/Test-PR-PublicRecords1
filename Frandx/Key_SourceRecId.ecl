Import Data_Services, Doxie, Frandx, ut;

slim_rec := record
		frandx.layouts.base.source_rec_id;
		frandx.layouts.base.franchisee_id;
		frandx.layouts.base.fruns;
end;

slim_file := project(Frandx.Files().Base.Built,transform(slim_rec,self:=left));

export Key_SourceRecId := index(slim_file, {source_rec_id}, {slim_file},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::frandx::'+ doxie.Version_SuperKey + '::Source_Rec_Id');