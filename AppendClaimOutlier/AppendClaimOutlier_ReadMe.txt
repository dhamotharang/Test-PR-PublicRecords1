AppendClaimOutlier HIPIE Plugin

Note : This plugin is specific to HealthCare product.

This plugin appends claims outlier information to an incoming dataset as well as a few
computed attributes.

INCOMING DATA NOTES

* The plugins takes four input dataset Provider, Patient, Medical Claim and Exclusion List.

* Provider Key, Patient Key should be unique.

APPENDED ATTRIBUTE NOTES

* Custom function is used to calculate outliers.

* High Patient Volume - Identify professional outliers who have higher patient volume 
  compared to their peers belonging to the same speciality.
    
* High Claim Volume - Identify professional outliers who have higher claim volume 
  compared to their peers belonging to the same speciality.

* High Paid Dollars Per Patient - Identify professional outliers who were paid higher amount of 
  dollars per patient compared to their peers belonging to the same specialty
  
* High Paid Dollars Per Claim - Identify professional outliers who were paid higher amount of
  dollars per claim compared to their peers belonging to the same specialty

* Long Patient Driving Distance - Identify professionals with 75% or more of patients for 75% or more of their 
  visits are driving longer distances ( when compared to patients that see 
  professionals belonging to the same specialty
