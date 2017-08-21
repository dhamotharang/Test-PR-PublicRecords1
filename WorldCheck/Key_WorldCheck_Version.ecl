import doxie;

f_worldck 		:= WorldCheck.File_Main;

f_worldcheck 	:=  f_worldck(trim(updated, left, right)[1..2] between '19' and '20' 
								                 and length(trim(updated, left, right))>=4 
								                 and updated<=stringlib.GetDateYYYYMMDD());

m := max(f_worldcheck,updated);

d := dataset([{m}],{unsigned version});

export Key_WorldCheck_Version := index(d
                                  ,{version},{},'~thor_data400::key::WorldCheck::version_'+doxie.Version_SuperKey);
