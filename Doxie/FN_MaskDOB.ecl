import doxie, Suppress;

export FN_MaskDOB(dataset(doxie.Layout_Rollup.KeyRec_feedback) dsIn, dobMaskValue = 0) := function

  doxie.Layout_Rollup.DobRecMasked XformMaskDOB(doxie.Layout_Rollup.DobRec l) := transform
    maskedDate := Suppress.date_mask(l.dob, dobMaskValue);
    self.dob := maskedDate.year + maskedDate.month + maskedDate.day;
    self.age := l.age;
  end;

  dsInMasked := project(dsIn, transform(doxie.Layout_Rollup.KeyRec_feedback_Masked,
                                self.dobRecs := project(left.dobRecs, XformMaskDOB(left)),
                                self := left));

  return dsInMasked;

end;