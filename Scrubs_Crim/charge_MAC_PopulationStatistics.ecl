 
EXPORT charge_MAC_PopulationStatistics(infile,Ref='',vendor='',Input_recordid = '',Input_statecode = '',Input_caseid = '',Input_warrantnumber = '',Input_warrantdate = '',Input_warrantdesc = '',Input_warrantissuedate = '',Input_warrantissuingagency = '',Input_warrantstatus = '',Input_citationnumber = '',Input_bookingnumber = '',Input_arrestdate = '',Input_arrestingagency = '',Input_bookingdate = '',Input_custodydate = '',Input_custodylocation = '',Input_initialcharge = '',Input_initialchargedate = '',Input_initialchargecancelleddate = '',Input_chargedisposed = '',Input_chargedisposeddate = '',Input_chargeseverity = '',Input_chargedisposition = '',Input_amendedcharge = '',Input_amendedchargedate = '',Input_bondsman = '',Input_bondamount = '',Input_bondtype = '',Input_sourcename = '',Input_sourceid = '',Input_vendor = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Crim;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(vendor)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_recordid)='' )
      '' 
    #ELSE
        IF( le.Input_recordid = (TYPEOF(le.Input_recordid))'','',':recordid')
    #END
 
+    #IF( #TEXT(Input_statecode)='' )
      '' 
    #ELSE
        IF( le.Input_statecode = (TYPEOF(le.Input_statecode))'','',':statecode')
    #END
 
+    #IF( #TEXT(Input_caseid)='' )
      '' 
    #ELSE
        IF( le.Input_caseid = (TYPEOF(le.Input_caseid))'','',':caseid')
    #END
 
+    #IF( #TEXT(Input_warrantnumber)='' )
      '' 
    #ELSE
        IF( le.Input_warrantnumber = (TYPEOF(le.Input_warrantnumber))'','',':warrantnumber')
    #END
 
+    #IF( #TEXT(Input_warrantdate)='' )
      '' 
    #ELSE
        IF( le.Input_warrantdate = (TYPEOF(le.Input_warrantdate))'','',':warrantdate')
    #END
 
+    #IF( #TEXT(Input_warrantdesc)='' )
      '' 
    #ELSE
        IF( le.Input_warrantdesc = (TYPEOF(le.Input_warrantdesc))'','',':warrantdesc')
    #END
 
+    #IF( #TEXT(Input_warrantissuedate)='' )
      '' 
    #ELSE
        IF( le.Input_warrantissuedate = (TYPEOF(le.Input_warrantissuedate))'','',':warrantissuedate')
    #END
 
+    #IF( #TEXT(Input_warrantissuingagency)='' )
      '' 
    #ELSE
        IF( le.Input_warrantissuingagency = (TYPEOF(le.Input_warrantissuingagency))'','',':warrantissuingagency')
    #END
 
+    #IF( #TEXT(Input_warrantstatus)='' )
      '' 
    #ELSE
        IF( le.Input_warrantstatus = (TYPEOF(le.Input_warrantstatus))'','',':warrantstatus')
    #END
 
+    #IF( #TEXT(Input_citationnumber)='' )
      '' 
    #ELSE
        IF( le.Input_citationnumber = (TYPEOF(le.Input_citationnumber))'','',':citationnumber')
    #END
 
+    #IF( #TEXT(Input_bookingnumber)='' )
      '' 
    #ELSE
        IF( le.Input_bookingnumber = (TYPEOF(le.Input_bookingnumber))'','',':bookingnumber')
    #END
 
+    #IF( #TEXT(Input_arrestdate)='' )
      '' 
    #ELSE
        IF( le.Input_arrestdate = (TYPEOF(le.Input_arrestdate))'','',':arrestdate')
    #END
 
+    #IF( #TEXT(Input_arrestingagency)='' )
      '' 
    #ELSE
        IF( le.Input_arrestingagency = (TYPEOF(le.Input_arrestingagency))'','',':arrestingagency')
    #END
 
+    #IF( #TEXT(Input_bookingdate)='' )
      '' 
    #ELSE
        IF( le.Input_bookingdate = (TYPEOF(le.Input_bookingdate))'','',':bookingdate')
    #END
 
+    #IF( #TEXT(Input_custodydate)='' )
      '' 
    #ELSE
        IF( le.Input_custodydate = (TYPEOF(le.Input_custodydate))'','',':custodydate')
    #END
 
+    #IF( #TEXT(Input_custodylocation)='' )
      '' 
    #ELSE
        IF( le.Input_custodylocation = (TYPEOF(le.Input_custodylocation))'','',':custodylocation')
    #END
 
+    #IF( #TEXT(Input_initialcharge)='' )
      '' 
    #ELSE
        IF( le.Input_initialcharge = (TYPEOF(le.Input_initialcharge))'','',':initialcharge')
    #END
 
+    #IF( #TEXT(Input_initialchargedate)='' )
      '' 
    #ELSE
        IF( le.Input_initialchargedate = (TYPEOF(le.Input_initialchargedate))'','',':initialchargedate')
    #END
 
+    #IF( #TEXT(Input_initialchargecancelleddate)='' )
      '' 
    #ELSE
        IF( le.Input_initialchargecancelleddate = (TYPEOF(le.Input_initialchargecancelleddate))'','',':initialchargecancelleddate')
    #END
 
+    #IF( #TEXT(Input_chargedisposed)='' )
      '' 
    #ELSE
        IF( le.Input_chargedisposed = (TYPEOF(le.Input_chargedisposed))'','',':chargedisposed')
    #END
 
+    #IF( #TEXT(Input_chargedisposeddate)='' )
      '' 
    #ELSE
        IF( le.Input_chargedisposeddate = (TYPEOF(le.Input_chargedisposeddate))'','',':chargedisposeddate')
    #END
 
+    #IF( #TEXT(Input_chargeseverity)='' )
      '' 
    #ELSE
        IF( le.Input_chargeseverity = (TYPEOF(le.Input_chargeseverity))'','',':chargeseverity')
    #END
 
+    #IF( #TEXT(Input_chargedisposition)='' )
      '' 
    #ELSE
        IF( le.Input_chargedisposition = (TYPEOF(le.Input_chargedisposition))'','',':chargedisposition')
    #END
 
+    #IF( #TEXT(Input_amendedcharge)='' )
      '' 
    #ELSE
        IF( le.Input_amendedcharge = (TYPEOF(le.Input_amendedcharge))'','',':amendedcharge')
    #END
 
+    #IF( #TEXT(Input_amendedchargedate)='' )
      '' 
    #ELSE
        IF( le.Input_amendedchargedate = (TYPEOF(le.Input_amendedchargedate))'','',':amendedchargedate')
    #END
 
+    #IF( #TEXT(Input_bondsman)='' )
      '' 
    #ELSE
        IF( le.Input_bondsman = (TYPEOF(le.Input_bondsman))'','',':bondsman')
    #END
 
+    #IF( #TEXT(Input_bondamount)='' )
      '' 
    #ELSE
        IF( le.Input_bondamount = (TYPEOF(le.Input_bondamount))'','',':bondamount')
    #END
 
+    #IF( #TEXT(Input_bondtype)='' )
      '' 
    #ELSE
        IF( le.Input_bondtype = (TYPEOF(le.Input_bondtype))'','',':bondtype')
    #END
 
+    #IF( #TEXT(Input_sourcename)='' )
      '' 
    #ELSE
        IF( le.Input_sourcename = (TYPEOF(le.Input_sourcename))'','',':sourcename')
    #END
 
+    #IF( #TEXT(Input_sourceid)='' )
      '' 
    #ELSE
        IF( le.Input_sourceid = (TYPEOF(le.Input_sourceid))'','',':sourceid')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
;
    #IF (#TEXT(vendor)<>'')
    SELF.source := le.vendor;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(vendor)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(vendor)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(vendor)<>'' ) source, #END -cnt );
ENDMACRO;
