Anonymize Person HIPIE Plugin

This plugin will REPLACE the existing PII with fake data.

Firstname, Lastname are required.
SSN, Date of Birth are optional.

This plugin will typically be used when either a set of demo dashboards will need to be produced
off real data and you do not want to expose PII or you deliberately want to obscure the PII in 
an engagement so that you can show the value but not have the customer write down the answers and 
then not need to pay for it.

It specifically replaces the existing data and does not append to make sure that it absolutely 
does not open the opportunity for someone to accidentally put the PII SSN instead of the fake 
SSN column in. That way all the data burnt into the services has been anonymized before indexes 
are created.

It uses a technique so that person who have the same lastname will still have the same fake lastname.
This is important in examples where a graph might show a family and you want them to still look
like a family. 

It also, leaves the Date of Birth Year the same so that it keeps the same shape for yearly aggregations.

Platform Requirements
This plugin requires HPCC 5.x or later.
