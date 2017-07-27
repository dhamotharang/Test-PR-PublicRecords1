export layout_value_fields := record
  string1 land_use_code;
  string25 land_use_description;
  string8 recording_date;
  string4 assessed_value_year;
  string11 sales_price;  
  string11 assessed_total_value;
  string11 market_total_value;
  integer tax_assessment_valuation;
  integer price_index_valuation;
  integer hedonic_valuation;
  integer automated_valuation;
  integer confidence_score;
  dataset(avm.layout_property_hedonic) comparable;
  dataset(avm.layout_property_hedonic) nearby;
end;