IMPORT iesp;
EXPORT constants := MODULE
  EXPORT max_crims := iesp.constants.CRIM.MaxSearchRecords;
  EXPORT BlankIncarcerationRecord := DATASET([], iesp.criminal_possibleincarceration_fcra.t_FcraPossibleIncarcerationRecord);
  // to be used instead of zero dates when calculating fcra minimum dates.
  EXPORT INTEGER date_max := 99999999;

  EXPORT FELONY := 'FELONY';

END;
