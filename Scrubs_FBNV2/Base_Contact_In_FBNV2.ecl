import Data_Services;

Base_Contact_FBNV2 := DATASET(data_services.foreign_prod +'thor_data400::base::fbnv2::contact',
												  Base_Contact_Layout_FBNV2,
													THOR);

EXPORT Base_Contact_In_FBNV2 := Base_Contact_FBNV2(dt_vendor_last_reported > 20180101);
// EXPORT Base_Contact_In_FBNV2 := Base_Contact_FBNV2;