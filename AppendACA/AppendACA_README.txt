AppendACA HIPIE Plugin -

This plugin appends correctional institution information to an incoming dataset.

INCOMING DATA NOTES

* Matching is performed based on a cleaned address.  Most cleaned address
  fields are allowed:  primary range, primary name, secondary range, address
  suffix, pre- and post-directional, city, state, and (five-digit) zip.  All
  fields are required.

* Searching is performed via string-equality JOINs; fuzzy matching is not used.

APPENDED ATTRIBUTE NOTES

* The following attributes are appended:

- HitFound:  Boolean indicating if the incoming record was matched with a
  correctional institution's address.

- Institution:  The name of the institution.

- InstitutionType:  A code for the type of institution (juvenile, adult, etc.).
  This may be blank if unknown.

- InstitutionTypeExp:  A text description for InstitutionType.  This may be
  blank if unknown.

- AddressType:  M=Mailing address, R=Physical address
