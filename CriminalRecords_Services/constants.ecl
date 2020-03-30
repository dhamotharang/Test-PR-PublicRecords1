IMPORT iesp;
export constants := module
	export max_crims := iesp.constants.CRIM.MaxSearchRecords;

  // to be used instead of zero dates when calculating fcra minimum dates.
  export integer date_max := 99999999;

  export FELONY := 'FELONY';

end;