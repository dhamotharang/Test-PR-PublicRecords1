import header, Data_Services, doxie, ut;

export keys := module
	did_rid_ds := project(Header.File_LAB_pairs,transform(recordof(LEFT),SELF.rid:=LEFT.alpha_rid,SELF:=LEFT));
	export key_rid := INDEX(did_rid_ds, {rid}, {did}, Data_Services.Data_Location.Person_header + 'thor_data400::key::LAB.DID_RID_' + doxie.version_superkey);
end;