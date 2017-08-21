import lib_fileservices,lib_stringlib;
EXPORT Wdog_WU_All := module

shared stored_wu := record
string wtype := '';
string WUID := '';
end;

export nonglbds     :=      dataset('~thor::wdog::wuinfo::nonglb',stored_wu,thor);
export nonglb_nonutds :=    dataset('~thor::wdog::wuinfo::nonglb_nonutility',stored_wu,thor);
export nonutilityds :=      dataset('~thor::wdog::wuinfo::nonutility',stored_wu,thor);
export glbnonends :=        dataset('~thor::wdog::wuinfo::glb_nonen',stored_wu,thor);
export glbnoneneqds :=   dataset('~thor::wdog::wuinfo::glb_nonen_noneq',stored_wu,thor);
export glbds :=             dataset('~thor::wdog::wuinfo::glb',stored_wu,thor);
export glbnoneqds :=        dataset('~thor::wdog::wuinfo::glb_noneq',stored_wu,thor);


export  wuid_nonglb := Stringlib.StringToLowerCase(nonglbds[1].WUID);
export wuid_nonglb_nonut := Stringlib.StringToLowerCase(nonglb_nonutds[1].WUID);
export wuid_nonutility := Stringlib.StringToLowerCase(nonutilityds[1].WUID);
export wuid_glbnonen := Stringlib.StringToLowerCase(glbnonends[1].WUID);
export wuid_glbnoneneq := Stringlib.StringToLowerCase(glbnoneneqds[1].WUID);
export wuid_glb := Stringlib.StringToLowerCase(glbds[1].WUID);
export wuid_glbnoneq := Stringlib.StringToLowerCase(glbnoneqds[1].WUID);

export clear_sf := Sequential(fileservices.DeleteLogicalfile('~thor::wdog::wuinfo::nonglb'),
                              fileservices.DeleteLogicalfile('~thor::wdog::wuinfo::nonglb_nonutility'),
															fileservices.DeleteLogicalfile('~thor::wdog::wuinfo::nonutility'),
															fileservices.DeleteLogicalfile('~thor::wdog::wuinfo::glb_nonen'),
															fileservices.DeleteLogicalfile('~thor::wdog::wuinfo::glb_nonen_noneq'),
															fileservices.DeleteLogicalfile('~thor::wdog::wuinfo::glb'),
															fileservices.DeleteLogicalfile('~thor::wdog::wuinfo::glb_noneq'));

end;
