/*
This is a data build for Consumer Disclosures (CD) protected entities.
Any time our consume advocacy department receives a
legitimate, vetted, and bonafied request to block all
data for a given entity for
which we do not yet have public records (Lexid)
a record with said entity is created manually
by the CD team in a CSV file that is to be loaded to
\\bctwptpl103.risk.regn.net\K\metadata\protected_consumer
by data receiving and tracked in ORBIT.

CD_Seed._BWR_Build will standardize and prepare the records
to be ingested by public records and insurance header.
Once a Lexid is assigned to the added entities, the Lexid
should be communicated to the Consumer Disclosures team
so that they can block the Lexid from LN reports
should new public records be ingested by header
from other sources in the future.

Contacts:
CD Team Manager: Paul Wahbe - Paul.Wahbe@lexisnexisrisk.com
Developer: Keith Hesser - James.Hesser@lexisnexisrisk.com
Data Receiving: Jesse Imsand - robert.imsand@lexisnexisrisk.com
*/