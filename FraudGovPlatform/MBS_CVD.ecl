
				MBSTableCol         := Files().Input.MBSTableCol.Sprayed; 
				MBSColValDesc       := Files().Input.MBSColValDesc.Sprayed; 
				MBS_Field_Desc      := join(MBSTableCol, MBSColValDesc,  left.table_column_id = right.table_column_id,
																													transform({qstring255 table_name, qstring255 column_name, unsigned2  status, unsigned2 desc_value, qstring300 description }, 
																																		self.table_name    := trim(StringLib.StringToUppercase(left.table_name),left,right);
																																		self.column_name   := trim(StringLib.StringToUppercase(left.column_name),left,right);
																																		self.status        := right.status;
																																		self.desc_value    := (unsigned2)right.desc_value;
																																		self.description   := trim(StringLib.StringToUppercase(right.description),left,right);
																																		));
EXPORT MBS_CVD              := MBS_Field_Desc(table_name ='FDN_FILE_INFO'):independent;
