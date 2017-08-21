import Sanctn_Mari,std;

EXPORT fn_CodeCheck_Professional(string code, string field) := function;

ProfessionLookup:= sanctn_mari.files_Midex_common_raw.ProfessionCodeLookup;

return if(trim(field,left,right)='INTERNALCODE' or trim(field,left,right)='LICENSECODE' or code='',1,
					if(count(ProfessionLookup(std.str.ToUpperCase(trim(code,left,right))=std.str.touppercase(trim(code,left,right))))>0,1,0));
					


end;