import fcra, data_services;

kf := Pii_for_FCRA (ssn<>'');

export Key_Override_pii_ssn := index (kf, 
                                      {ssn}, 
                                      {kf}, 
                                      data_services.data_location.prefix() + 'thor_data400::key::override::pii::qa::ssn');