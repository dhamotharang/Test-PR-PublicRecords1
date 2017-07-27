import BIPV2;
export File_OIG_KeyBaseTemp :=project(Files().KeyBase.qa,transform(OIG.Layouts.KeyBuild -NPI-WAIVERDATE-WVRSTATE-BIPV2.IDlayouts.l_xlink_IDs,self:=left;));
 