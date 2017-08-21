/*
Vern - I need you to work on this one next week.  It's due on 12/1.  In the first spreadsheet 
you'll see some leading columns followed by up to 5 individuals.  Lastly there's up to 4 vehicles.

We basically need to fill the holes.  For any person they've given us, what can we enhance?  
SSN's, DOB's, DL Number, everything for the fields which they're provided.  Don’t add any new people.
In the Vehicle fields only enhance existing VIN's (from VINA).  Do not add new VIN’s.
We’re not replacing anything - only populate those fields which are empty today.  
Field formats should also adhere to the format they gave us.  Resulting layout should not 
change – we’re giving back a layout in the same format we received.  There are no data restrictions.  

I think this can be achieved hitting the following attributes:
1) header.mac_best_address (for former address rec_type=2)
2) watchdog.file_best (ssn, dob, address, dl number, gender use title field)
3) driversv2.file_dl (dl state)
4) vehlic.file_vina (vin year, vin make)

Let me know if you have any questions.

*/