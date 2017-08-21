import BIPV2, OIG;
export File_OIG_KeyBaseTemp :=project(OIG.Files().KeyBase.qa,transform(OIG.Layouts.KeyBuild -NPI-WAIVERDATE-WVRSTATE-BIPV2.IDlayouts.l_xlink_IDs,self:=left;));
 