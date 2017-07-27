#warning('Deprecated. Use Royalty.RoyaltyFares instead')
import doxie_crs;

export royalties(dataset(doxie_crs.layout_property_ln) propswithrestrictions, 
	dataset(doxie_crs.layout_foreclosure_report) foreclosures =dataset([],doxie_crs.layout_foreclosure_report)) 
	:= FUNCTION;

royal :=dataset([{'Fares',count(propswithrestrictions(ln_fares_id[1]='R'))+count(foreclosures),
	count(propswithrestrictions(ln_fares_id[1]<>'R'))}], layout_royalties);

return(royal);
END;