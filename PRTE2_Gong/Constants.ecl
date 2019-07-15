import gong_neustar;

EXPORT Constants := module

EXPORT Gong_Weekly := '~prte::key::gong_weekly::';

EXPORT Gong_Key := '~prte::key::gong::';

EXPORT Gong_History := '~prte::key::gong_history::';

EXPORT Gong_History_FCRA := '~prte::key::gong_history::fcra::';

EXPORT allowedBellIdForFCRA := ['LSS','LSI','LSP','NEU'];	

//DF-22185 - FCRA Consumer Date Field Decpreciation
EXPORT fields_to_clear := gong_neustar.Constants.fields_to_clear;
	
END;