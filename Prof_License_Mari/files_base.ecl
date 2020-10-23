export files_base := MODULE

  export individual_detail := dataset('~thor_data400::base::proflic_mari::individual_detail',Prof_License_Mari.layouts.Individual_Reg_Base,thor);
  export regulatory_actions := dataset('~thor_data400::base::proflic_mari::regulatory_actions',Prof_License_Mari.layouts.Regulatory_Action_Base,thor);
  export disciplinary_actions := dataset('~thor_data400::base::proflic_mari::disciplinary_actions',Prof_License_Mari.layouts.Disciplinary_Action_Base,thor);

END;
