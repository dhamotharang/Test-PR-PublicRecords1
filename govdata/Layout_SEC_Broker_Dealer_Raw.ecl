EXPORT Layout_SEC_Broker_Dealer_Raw := 
 record
  string cie_number;
  string name;
  string reporting_filing_number;
  string address1;
  string address2;
  string city;
  string state;
  string  zip;
  //string('\r\n') taxpayer_id; -- layout has changed and the new layout does not have this field. 
  //				   The vendor is changed but the LN/Seisint Layout remains the same.
  //				   We are blanking the taxpayer_id.
end;