#workunit('name','Build Cellphones vs' + CellPhone.version );

sequential(CellPhone.Cellphones_DID(CellPhone.version),
	Cellphone.proc_build_cellphones_keys(CellPhone.version),
	CellPhone.Build_Field_Population);

