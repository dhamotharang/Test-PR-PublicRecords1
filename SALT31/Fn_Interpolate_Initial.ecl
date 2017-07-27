export Fn_Interpolate_Initial(StrType d,StrType param,unsigned d100,unsigned di100) := di100 + if ( length(trim(d))=1,0,(d100-di100) * (length(trim(param))-1)/(length(trim(d))-1));
