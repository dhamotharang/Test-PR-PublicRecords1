import fcra, ut;

kf := Pii_for_FCRA (ssn<>'');

export Key_Override_pii_ssn := 
index (kf, {ssn}, {kf}, '~thor_data400::key::override::pii::qa::ssn');