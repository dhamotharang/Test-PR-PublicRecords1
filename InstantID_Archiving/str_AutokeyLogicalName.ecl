IMPORT ut, Data_Services;

export str_AutokeyLogicalName(string filedate = ut.GetDate) := Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+filedate+'::autokey_';