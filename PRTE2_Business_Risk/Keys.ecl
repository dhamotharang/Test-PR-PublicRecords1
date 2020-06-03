IMPORT PRTE2_Business_Risk, Address_Attributes, doxie, ut, Data_Services, STD;

EXPORT Keys := MODULE

  EXPORT address_siccode := index(Files.address_siccode, {z5, prim_name, suffix, predir, postdir, prim_range, sec_range }, 
                                  {Files.address_siccode},
                                   Constants.KEY_PREFIX + doxie.Version_SuperKey + '::address_siccode');

  EXPORT business_risk_bdid := index(Files.business_Property, {bdid}, {Files.business_Property},
                                     Constants.KEY_PREFIX + doxie.Version_SuperKey + '::business_risk_bdid');

  EXPORT hri_address_siccode := index(Files.hri_address_siccode, {z5, prim_name, suffix, predir, postdir, prim_range, sec_range}, {Files.hri_address_siccode},
                                      Constants.KEY_PREFIX + doxie.Version_SuperKey + '::hri::address_siccode');

  EXPORT hri_address := index(Files.hri_address, {z5, prim_name, suffix, predir, postdir, prim_range, sec_range, dt_first_seen}, {Files.hri_address},
                              Constants.KEY_PREFIX + doxie.Version_SuperKey + '::hri::address');

  EXPORT hri_sic := index(Files.hri_sic, {sic_code, z5}, {Files.hri_sic},
                          Constants.KEY_PREFIX + doxie.Version_SuperKey + '::hri::sic.z5');



END;