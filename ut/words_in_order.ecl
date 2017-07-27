export words_in_order(string40 l,string40 r) := MODULE

	shared max_word_check := 5;
	shared sl := trim(l,left,right);
	shared len_sl :=length(stringlib.stringfilter(sl,' '));
	shared sr := trim(r,left,right); 
	shared len_sr := length(stringlib.stringfilter(sr,' '));

	shared longer_s := if(len_sl>=len_sr,sl,sr);
	shared spaces_longer_s :=if(len_sl>=len_sr,len_sl,len_sr);
	shared shorter_s := if(len_sl>=len_sr,sr,sl);
	shared spaces_shorter_s := if(len_sl>=len_sr,len_sr,len_sl);

	shared mini(integer l, integer r) := IF(l < r, l, r);

	shared numwords_short_s := mini(if(length(shorter_s)=0,0,spaces_shorter_s+1),max_word_check);
	shared numwords_long_s := if(length(longer_s)=0,0,spaces_longer_s+1);
	
	export numwords_long := numwords_long_s;
	export numwords_short := numwords_short_s;
	export substring := stringlib.stringfind(longer_s,shorter_s,1);
	
	shared get_word(string40 in_string,string40 in_string_long, unsigned1 space_no, unsigned1 num_words, unsigned2 startfrom,unsigned1 incr):= FUNCTION

		wrd :=	map(/*space_no = 0 and incr=1=>in_string[1..(stringlib.stringfind(in_string,' ',1)-1)], */
									space_no = (num_words-1) =>
									in_string[(stringlib.stringfind(in_string,' ',space_no)+1)..length(in_string)],
									in_string[(stringlib.stringfind(in_string,' ',space_no)+1)..(stringlib.stringfind(in_string,' ',space_no+incr)-1)]);


		return if(stringlib.stringfind(in_string_long[startfrom..length(in_string_long)],trim(wrd),1)= 1,1,
					stringlib.stringfind(in_string_long[startfrom..length(in_string_long)],' '+trim(wrd),1));
		
	end;

	


	shared s1 := if(numwords_short_s >= 1,get_word(shorter_s,longer_s,0,numwords_short_s,1,1),0);
	shared s2 := if(numwords_short_s >= 2,get_word(shorter_s,longer_s,1,numwords_short_s,s1+1,1),0);
	shared s3 := if(numwords_short_s >= 3,get_word(shorter_s,longer_s,2,numwords_short_s,s2+1,1),0);
	shared s4 := if(numwords_short_s >= 4,get_word(shorter_s,longer_s,3,numwords_short_s,s3+1,1),0);
	shared s5 := if(numwords_short_s >= 5,get_word(shorter_s,longer_s,4,numwords_short_s,s4+1,1),0);	

	shared w1 :=   (s1 > 0);
	shared w2 :=   (w1 and s2 > 0);
	shared w3 :=   (w2 and s3 > 0);
	shared w4 :=   (w3 and s4 > 0);
	shared w5 :=   (w4 and s5 > 0);
	shared nw1 :=  (s1 = 0);
	shared nw2 :=  (nw1 and s2 = 0);
	shared nw3 :=  (nw2 and s3 = 0);
	shared nw4 :=  (nw3 and s4 = 0);
	shared nw5 :=  (nw4 and s5 = 0);
	

	export words :=choose(numwords_short_s,w1,w2,w3,w4,w5);
	export no_words := choose(numwords_short_s,nw1,nw2,nw3,nw4,nw5);
	
	export first_two := if(numwords_short_s >= 2,get_word(shorter_s,longer_s,0,numwords_short_s,1,2),0);

end;


