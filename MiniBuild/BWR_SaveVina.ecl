import VehLic;

vina := VehLic.Vin_Matches(VehLic.ValidVin(vin));
output(vina,,'~thor_data400::out::VinaShrunk',overwrite);