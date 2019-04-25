IMPORT Python; 

EXPORT CreateBins:= MODULE

EXPORT string80 CreateBins_ranges( string name,string  score_in,integer min_valid,integer Max_valid,integer range_bin,set default_values) := embed(Python)
result = ''
float_default_values = [float(x) for x in default_values]

if len(str.strip(str(score_in)))==0:
    result = 'NULL'
# return result
elif  score_in == 'NOT_SCORED':
    result = 'UNDEFINED'
else:
     score1 = float(score_in)
     if float(score_in) in float_default_values:
      result = str(score1)
     else:       
   			#***********Rest of the BINS****************
   		  	if score1 < min_valid or score1 > Max_valid:
			       result = 'UNDEFINED'    	
     for i in range(int(min_valid),int(Max_valid),int(range_bin)):
    						if i + range_bin > Max_valid:
    								if score1 >= i and score1 <= Max_valid:
    										result = str(i) + "_"+ str(i+range_bin)
    						else:
    								if score1 >= i and score1 <= i+range_bin:
    										result = str(i) + "_"+ str(i+range_bin)  
return result												
endembed;

EXPORT string80 CreateBins_valid_default( string name,string  score_in,integer min_valid,integer Max_valid, set default_values) := embed(Python)
result = ''
float_default_values = [float(x) for x in default_values]

if len(str.strip(str(score_in)))==0:
    result = 'NULL'
# return result
elif  score_in == 'NOT_SCORED':
    result = 'UNDEFINED'
else:
     score1 = float(score_in)
     if float(score_in) in float_default_values:
       result = 'DEFAULT'
     else:       
        	#***********Rest of the BINS****************
             if score1>= min_valid and score1<=Max_valid:
                   result = 'VALID'
             else:
                   result = 'UNDEFINED'                               
return result

endembed;

EXPORT string80 CreateBins_Range( string name,string  score_in,integer min_valid,integer Max_valid, set default_values) := embed(Python)
result = ''
float_default_values = [float(x) for x in default_values]

if len(str.strip(str(score_in)))==0:
    result = 'NULL'
# return result
elif  score_in == 'NOT_SCORED':
    result = 'UNDEFINED'
else:
     score1 = float(score_in)
     if float(score_in) in float_default_values:
       result = 'DEFAULT'
     else:       
        	#***********Rest of the BINS****************
             if score1>= min_valid and score1<=Max_valid:
                   result = str(min_valid) + '_' + str(Max_valid)
             else:
                   result = 'UNDEFINED'                               
return result

endembed;
END;