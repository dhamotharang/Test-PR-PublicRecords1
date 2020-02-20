// TODO: create common defaults to use in AutoStandardI.GlobalModule, here, etc.

// Encapsulates input parameters for each particular component
// (probably will be split and moved to each correspondent service)

// Currently almost all of these are "fake": just synonyms of a superset input

import AutoStandardI, Accident_Services,
  suppress, FCRA;

EXPORT input := MODULE

  /////////////// STAND ALONE (SINGLE SOURCE)  ///////////////
  export accidents := INTERFACE (Accident_Services.IParam.searchRecords)
  end;

END;
