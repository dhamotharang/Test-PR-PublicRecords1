/*

There is one other record type in the sprayed files, delimited by the <AGENCY> tag.  This is in addition to the <ORG>
<AFF.INDV> tags being used now.  Not sure what value this record will add, but we seem to get only 
one record of this type per update.

May want to revisit the use of the ISLN number for the vendor id in business header.  It does allow
us to link back to the business contact record from that org record, but it is tied to the attorney,
and not the business.  Should be fine for now, but when we get a true data dictionary, should revisit

looks like for the records with no ISLN, most of them are deceased, the header_aff_indiv_deceased field has a 'Y'.
I wonder if, in those cases of records with no ISLN, you could use header_aff_indiv_indiv_audit_attyno ?

*/