NumSet := ['0','1','2','3','4','5','6','7','8','9'];

EXPORT STRING10 CleanPhone(STRING10 phone) :=
  MAP( phone = '0000000000' => '',
       phone <> '' AND
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
       phone <> '' AND
       LENGTH(TRIM(phone))=7 AND
       phone[1] IN NumSet AND
       phone[2] IN NumSet AND
       phone[3] IN NumSet AND
       phone[4] IN NumSet AND
       phone[5] IN NumSet AND
       phone[6] IN NumSet AND
       phone[7] IN NumSet => '000'+TRIM(phone),
       '');