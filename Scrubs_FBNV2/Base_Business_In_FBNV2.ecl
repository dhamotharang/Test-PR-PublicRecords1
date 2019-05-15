import Data_Services;

Base_Business_FBNV2 := DATASET(data_services.foreign_prod +'thor_data400::base::fbnv2::Business',
												  Base_Business_Layout_FBNV2,
													THOR);

EXPORT Base_Business_In_FBNV2 := Base_Business_FBNV2(dt_vendor_last_reported > 20180101);
// EXPORT Base_Business_In_FBNV2 := Base_Business_FBNV2;