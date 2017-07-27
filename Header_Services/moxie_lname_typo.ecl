export moxie_lname_typo := module 

  //shorter is longer than 6, match the leading or trailing portion of longer
  export r1(string20 nm1, string20 nm2) := function
     
	    n1 := trim(nm1);
	    n2 := trim(nm2);
       
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>6,l_nm[1..s_ln]=s_nm or l_nm[l_ln-s_ln+1..l_ln]=s_nm, false);
  end;
  
  //phonetically the same, same length and allow first character is different
  export r2(string20 nm1, string20 nm2) := function

	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         n1_ph := metaphonelib.DMetaPhone1(n1);
	    n2_ph := metaphonelib.DMetaPhone1(n2);
	    
	    n1_ln := length(n1);
	    n2_ln := length(n2);
	    
	    return if(n1_ln=n2_ln and n1_ph=n2_ph, n1[2..n1_ln]=n2[2..n2_ln], false);
  end;  

  //shorter is long than 2, longer 1 character longer, shorter match trailing of longer 
  export r3(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>2 and l_ln=s_ln+1, l_nm[2..]=s_nm, false);
  end;

  //names are longer than 5 characters and only the first differs 
  export r4(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>5 and l_ln=s_ln, l_nm[2..l_ln]=s_nm[2..s_ln], false);
  end;
  
  //shorter name longer than 2 characters, and shorter than 2 of the longer
  //match the trailing of longer, and first two of longer are of 'DX' - X is a vowel
  export r5(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>2 and l_ln=s_ln+2, 
	              l_nm[3..l_ln]=s_nm and l_nm[1..2] in ['DA','DE','DO','DI','DU'], false);
  end;

  //first characters match and edit distance following the rule
  export r6(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>1 and n1[1]=n2[1], 
	              map(s_ln=2 => datalib.StringSimilar100(n1,n2)<51,
			        s_ln=3 => datalib.StringSimilar100(n1,n2)<34,
				   s_ln=4 => datalib.StringSimilar100(n1,n2)<26,
				   s_ln=5 => datalib.StringSimilar100(n1,n2)<21,
				   //s_ln=6 => stringlib.EditDistance(n1,n2)<=2,
				   //s_ln=7 => stringlib.EditDistance(n1,n2)<=2,
				   //s_ln>=8 => stringlib.EditDistance(n1,n2)<=3,
				   s_ln=6 => datalib.StringSimilar100(n1,n2)<34,
				   s_ln=7 => datalib.StringSimilar100(n1,n2)<29,
				   s_ln>8 => datalib.StringSimilar100(n1,n2)*s_ln<301,
			        false), 
			    false);
  end;

  //on a word boundary
  export r7(string20 nm1, string20 nm2) := function
     
	    n1 := trim(nm1);
	    n2 := trim(nm2);
       
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>3 and l_ln>s_ln+1,l_nm[1..s_ln]=s_nm and l_nm[s_ln+1] in ['','-']
	                     or l_nm[l_ln-s_ln+1..l_ln]=s_nm and l_nm[l_ln-s_ln] in ['','-'], false);
  end;

end;