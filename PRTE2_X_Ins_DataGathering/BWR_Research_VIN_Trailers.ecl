/*  ********************************************************************************
It is quite hard to find odd vehicles like trailers - I finally had to look up a specific VIN
that we ended up with in our base file - that showed me best_body_code was always TL for that trailer
and then searching on the TL - I found I also needed to search TRAILER inside vina_make_desc

Someday we'll probably have to search for MotorHomes, ATVs, 4-wheelers, dirt bikes, etc so it'll take some research
see BWR_Research_VIN_NonAuto
********************************************************************************  */

IMPORT VehicleV2,STD;

Years := ['2016','2017','2018','2019','2020','2021'];
// DS2 := VehicleV2.file_VehicleV2_main(vina_vin ='5A7BB22263T001241');
DS2 := VehicleV2.file_VehicleV2_main(vina_model_year in Years AND vina_vin <>'' AND best_body_code='TL' AND STD.Str.Contains(vina_make_desc,'TRAILER',TRUE));

COUNT(DS2);
CHOOSEN(DS2,200);

/* ********************************************************************************

This found 149709 - I just collected the first 200

*********************************************************************************** */