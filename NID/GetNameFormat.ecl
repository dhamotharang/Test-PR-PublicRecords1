IMPORT Python;

boolean TestRegex(string rgx, string s) := EMBED(Python)
   import re
   if re.search(rgx, s):
      return True
   else:
      return False	 
ENDEMBED;

EXPORT integer GetNameFormat(string s) := EMBED(Python)
   import re;
	 
   def TestRegex(string rgx, string s):
      if re.search(rgx, s):
         return True
      else:
         return False	 	 
	 
   rgxConnector = r"( AND |&| OR | AND/OR |&/OR |& OR |& ETUX |\\+)"
   rgxBasic = r"([A-Z]+)"
   rgxLast = r"(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELA |DELLA |DELLO |DOS |DU |LA |MC |VON |VAN DEN |VAN DER |VAN DE |VAN |VANDER |VANDEN |ST |SAN |EL |LE |ABU |[ODANL]\')?([A-Z]+[A-Z\'-]+)"
   rgxGen = r"(JR|SR|I|II|III|IV|V|VI|VII|VIII|IX|2ND|3RD|THRD|03|4TH|5TH|6TH|1|2|3|4|5|6|7|8|9)"
   rgxSureGen = r"(JR|SR|II|III|IV|VI|VII|VIII|IX|2ND|3RD|THRD|03|4TH|5TH|6TH|1|2|3|4|5|6|7|8|9)"
   rgxHonor = r"(MD|DMD|DDS|CNFP|CNM|CNP|CPA|CSW|DR|PHD|ESQ|RN|LN|DO|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|AS|NP|FNP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|MA|PT|SJ|MBA|MSD|CTM|DTM|CPS|ADJ|DWP|SEC|VDM|VMD|PA-C|PA|RPA-C|RPA|APA-C|CRNA|MBBS|PNP|RNP|CNS)"
   rgxSuffix = "(" + rgxGen + "|" + rgxHonor + ")"
   rgxLScFMM = "^(" + rgxLast + ") +" + rgxSuffix + " *, *"  + rgxBasic + " +([A-Z]+ +[A-Z]+)$"

   if TestRegex(rgxConnector, s):
	    return 1
   else:
      return 0;

ENDEMBED;
