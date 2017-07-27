export moxie_fname_typo := module 

  //checking conflicting O/A vowels
  export l0(string20 nm1, string20 nm2) := function
     
	    n1 := trim(nm1);
	    n2 := trim(nm2);
       
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return l_nm[l_ln]='O' and s_nm[s_ln]='A' or
	           l_nm[l_ln]='A' and s_nm[s_ln]='O';
  end;

  //identical except for their suffixes are of the form Y, I, IE, EY
  export l1(string20 nm1, string20 nm2) := function
     
	    n1 := trim(nm1);
	    n2 := trim(nm2);
       
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>4 and l_ln-s_ln<2,
	              map(l_nm[l_ln-1..l_ln] in ['IE','EY'] and s_nm[s_ln-1..s_ln] in ['IE','EY'] => 
			        l_nm[1..l_ln-2]=s_nm[1..s_ln-2],
				   l_nm[l_ln-1..l_ln] in ['IE','EY'] and s_nm[s_ln] in ['I','Y'] => 
			        l_nm[1..l_ln-2]=s_nm[1..s_ln-1],
			        l_nm[l_ln] in ['I','Y'] and s_nm[s_ln] in ['I','Y'] => 
			        l_nm[1..l_ln-1]=s_nm[1..s_ln-1],
			        false),
	              false);
  end;

  //shorter is long than 3, longer 1 character longer, shorter match trailing of longer 
  export l2(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>3 and l_ln=s_ln+1, l_nm[2..]=s_nm, false);
  end;

  //shorter is long than 4, longer 2 character longer, shorter match trailing of longer 
  export l3(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>4 and l_ln=s_ln+2, l_nm[3..]=s_nm, false);
  end;
  
  //matches except for the first character is Z/X or Z/S replacement 
  export l4(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>3 and l_ln=s_ln, 
	              l_nm[2..]=s_nm[2..] and 
			    (l_nm[1]='Z' and s_nm[1] in ['X','S'] or 
			     l_nm[1] in ['X','S'] and s_nm[1] ='Z'), false);
  end;

  //first characters match(or M/N, K/C repalcement) and names phonetically match
  export l5(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
	    
	    n1_ph := metaphonelib.DMetaPhone1(n1);
	    n2_ph := metaphonelib.DMetaPhone1(n2);
  
	    n1_ln := length(n1);
	    n2_ln := length(n2);
	    
	    return if(n1_ln > 3 and  n2_ln > 3 and n1_ph=n2_ph,
	              (n1[1]=n2[1] or 
			     n1[1]='M' and n2[1]='N' or
				n1[1]='N' and n2[1]='M' or
				n1[1]='K' and n2[1]='C' or
				n1[1]='C' and n2[1]='K'), false);
  end;

  //first characters match and edit distance following the rule
  export l6(string20 nm1, string20 nm2) := function
  
	    n1 := trim(nm1);
	    n2 := trim(nm2);
  
         l_nm := if(length(n1)>length(n2), n1, n2);
	    s_nm := if(l_nm=n1, n2, n1);
	    
	    l_ln := length(l_nm);
	    s_ln := length(s_nm);
	    
	    return if(s_ln>1 and n1[1]=n2[1], 
	              map(s_ln=4 => datalib.StringSimilar100(n1,n2)<26,
				   s_ln=5 => datalib.StringSimilar100(n1,n2)<21,
				   //s_ln>=6 => stringlib.EditDistance(n1,n2)<=2,
				   s_ln>=6 => datalib.StringSimilar100(n1,n2)*s_ln<201,
			        false), 
			    false);
	    
  end;

end;