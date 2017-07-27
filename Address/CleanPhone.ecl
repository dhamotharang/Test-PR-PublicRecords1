NumSet := ['0','1','2','3','4','5','6','7','8','9'];

SeparatorSet := ['-','.','/',' '];

string10 clph(string30 phone) :=

map(length(trim(phone)) = 7 and
       phone[1] IN NumSet AND
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[4] IN NumSet AND
       phone[5] IN NumSet AND
       phone[6] IN NumSet AND
       phone[7] IN NumSet => '000'+TRIM(phone), 
    length(trim(phone)) = 8 and phone[4] in SeparatorSet and
       phone[1] IN NumSet AND
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[5] IN NumSet AND
       phone[6] IN NumSet AND
       phone[7] IN NumSet AND
       phone[8] IN NumSet => '000'+ phone[1..3] + phone[5..8], 
    length(trim(phone)) = 10 and phone <> '0000000000' and
       phone[1] IN NumSet AND
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[4] IN NumSet AND
       phone[5] IN NumSet AND
       phone[6] IN NumSet AND
       phone[7] IN NumSet AND
       phone[8] IN NumSet AND
       phone[9] IN NumSet AND
       phone[10] IN NumSet => phone,
    length(trim(phone)) = 11 and phone[1] = '1' and
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[4] IN NumSet AND
       phone[5] IN NumSet AND
       phone[6] IN NumSet AND
       phone[7] IN NumSet AND
       phone[8] IN NumSet AND
       phone[9] IN NumSet AND
       phone[10] IN NumSet AND
       phone[11] IN NumSet => phone[2..11],
	length(trim(phone)) = 11 and phone[7] in SeparatorSet and
       phone[1] IN NumSet AND
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[4] IN NumSet AND
       phone[5] IN NumSet AND
       phone[6] IN NumSet AND
       phone[8] IN NumSet AND
       phone[9] IN NumSet AND
       phone[10] IN NumSet AND
       phone[11] IN NumSet => phone[1..6] + phone[8..11],
    length(trim(phone)) = 12 and phone[4] in SeparatorSet and phone[8] in SeparatorSet and
       phone[1] IN NumSet AND
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[5] IN NumSet AND
       phone[6] IN NumSet AND
       phone[7] IN NumSet AND
       phone[9] IN NumSet AND
       phone[10] IN NumSet AND
       phone[11] IN NumSet AND
       phone[12] IN NumSet => phone[1..3] + phone[5..7] + phone[9..12],
    length(trim(phone)) = 13 and phone[1] = '(' and phone[5] = ')' and phone[9] in SeparatorSet and
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[4] IN NumSet AND
       phone[6] IN NumSet AND
       phone[7] IN NumSet AND
       phone[8] IN NumSet AND
       phone[10] IN NumSet AND
       phone[11] IN NumSet AND
       phone[12] IN NumSet AND
       phone[13] IN NumSet => phone[2..4] + phone[6..8] + phone[10..13],
    length(trim(phone)) = 14 and phone[1] = '(' and phone[5] = ')' and phone[6] = ' ' and phone[10] in SeparatorSet and
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[4] IN NumSet AND
       phone[7] IN NumSet AND
       phone[8] IN NumSet AND
       phone[9] IN NumSet AND
       phone[11] IN NumSet AND
       phone[12] IN NumSet AND
       phone[13] IN NumSet AND
       phone[14] IN NumSet => phone[2..4] + phone[7..9] + phone[11..14],
       phone[1] IN NumSet AND
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[4] IN NumSet AND
       phone[5] IN NumSet AND
       phone[6] IN NumSet AND
       phone[7] IN NumSet AND
       phone[8] IN NumSet AND
       phone[9] IN NumSet AND
       phone[10] IN NumSet => phone[1..10],
    '');

export string10 CleanPhone(string30 phone) :=
  if(phone[1] = '1' and phone[2] in SeparatorSet, clph(phone[3..length(phone)]), clph(phone));