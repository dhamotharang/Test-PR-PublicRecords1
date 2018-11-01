import driversv2;
export in_mo_medcert(string filedate) := dataset('~thor_200::in::dl2::mo_medcert_update::'+filedate+'::cleaned', scrubs_dl_mo_medcert.layout_in_mo_medcert, thor);
																				 