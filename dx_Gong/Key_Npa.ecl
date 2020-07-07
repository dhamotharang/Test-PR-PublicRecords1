//former: Gong_Neustar.Key_Npa

IMPORT $, data_services;

rec := $.layouts.i_areacode;

EXPORT key_npa (integer data_category = 0) := 
         INDEX ({rec.areacode}, rec, $.names().i_npa);