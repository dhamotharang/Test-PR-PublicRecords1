//TODO: most likely this can be combined with data_key_AptBuildings
import doxie, header, ut;

export data_key_AptBuildings_fcra_en(string filedate) :=  function

df := header.fn_ApartmentBuildings(true,filedate);

return df;

end;
