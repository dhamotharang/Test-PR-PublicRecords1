Import PRTE2_Watercraft, Data_Services;

Alpha_Base	:= DATASET(Data_Services.foreign_dataland+'prte::base::prte2::watercraft::qa::alldata_alpha', PRTE2_WaterCraft_Ins.Layouts.Base, THOR);

output(Alpha_Base,,'~prte::base::prte2::watercraft::20161011c::alldata_alpha',overwrite);