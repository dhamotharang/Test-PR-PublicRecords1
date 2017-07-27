import suppress;

nss := Suppress.Constants;

// Returns a directive on how no-subject record must be handled by application; 
// so far it is used in certain FCRA products.

// Function reads from #stored value to accommodate non-esdl queries (batch, for instance),
// !!! #stored value will necessarily be used as long as it is valid.

// Caller has an option to provide a default, which will be used in absence of #stored
//   (this can be used, for instance, when a value taken from esdl-input).

EXPORT integer GetNonSubjectSuppression (integer nss_default = nss.NonSubjectSuppression.doNothing) := function
  nonSS := nss.NonSubjectSuppression.notSpecified : stored('NonSubjectSuppression');

  return map (nonSS in nss.ValidNSS_Set => nonSS, // #stored has a valid value
              nss_default in nss.ValidNSS_Set => nss_default, //default provided has a valid value
              nss.NonSubjectSuppression.doNothing);  //gave up on the caller intentions
END;
