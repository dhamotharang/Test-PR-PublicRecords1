import Sanctn_Mari,std;

EXPORT fn_CodeCheck_Licence(string code) := function

LicenceLookup:= Sanctn_Mari.files_Midex_common_raw.LicenseTypeLookup(trim(srce_updt,left,right)='SANCTN');

return if(code='',1,
					if(count(LicenceLookup(std.str.ToUpperCase(trim(LICENSE_TYPE,left,right))=std.str.touppercase(trim(code,left,right))))>0,1,0));
					


end;