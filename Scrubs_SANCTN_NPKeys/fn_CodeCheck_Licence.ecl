import Sanctn_Mari,std;

EXPORT fn_CodeCheck_Licence(string code, string field) := function

LicenceLookup:= Sanctn_Mari.files_Midex_common_raw.LicenseTypeLookup(trim(srce_updt,left,right)='SANCTN_MARI');

return if(trim(field,left,right)='INTERNALCODE' or trim(field,left,right)='PROFESSIONCODE' or code='',1,
					if(count(LicenceLookup(std.str.ToUpperCase(trim(LICENSE_TYPE,left,right))=std.str.touppercase(trim(code,left,right))))>0,1,0));
					


end;