/*--SOAP--
<message name="headerFileSearchRequest">
  <part name="SSN" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AccountNumber" type="xsd:string"/>
  <part name="PerId" type="xsd:string"/>
  <part name="Usage" type="xsd:string"/>
 </message>
*/
/*--INFO-- This service searches the credit file. */

export CreditDataService := macro

string9 ssn_value := '' : stored('ssn');
string30 FirstName := '' : stored('FirstName');
unsigned4 PerId := 0 : stored('PerId');
string20 AccountNumber := '' : stored('AccountNumber');
string1 Usage := '': stored('Usage');

I2 := CreditFile.Key_Person_SSN_FName(soc=(unsigned4)SSN_value,
FirstName='' or stringlib.stringtouppercase(FirstName)=Frst[..length(trim(FirstName))] );

I1 := CreditFile.Key_Person(per_id=PerId);

typeof(creditfile.file_indic_plus) xt(creditfile.file_indic_plus le) := transform
  self := le;
  end;

f1 := fetch(creditfile.File_Indic_Plus,i1,right.__filepos,xt(left));
f2 := fetch(creditfile.File_Indic_Plus,i2,right.__filepos,xt(left));
f3 := join(CreditFile.Key_Trade_Acct(actno='0'+AccountNumber),
           creditfile.File_Indic_Plus,
           left.per_id=right.per_id,
           xt(right),KEYED(creditfile.Key_Person));

f := IF((unsigned4)perid<>0,F1,
         IF(AccountNumber='',F2,F3)
       );

// Output main person(s) found
cft := creditfile.File_Trade_Plus;


cft_o := record
  string10 CardType;
  string10 MemberName := '';
  cft;
  end;

/*
mastercard: Must have a prefix of 51 to 55, and must be 16 digits in length. 
Visa: Must have a prefix of 4, and must be either 13 or 16 digits in length. 
American Express: Must have a prefix of 34 or 37, and must be 15 digits in length. 
Diners Club: Must have a prefix of 300 to 305, 36, or 38, and must be 14 digits in length. 
Discover: Must have a prefix of 6011, and must be 16 digits in length. 
JCB: Must have a prefix of 3, 1800, or 2131, and must be either 15 or 16 digits in length. 
*/

cft_o take_right(cft le) := transform
  self.CardType := MAP(
             le.actno[2..3] IN ['51','52','53','54','55'] and length(trim(le.actno))=17 => 'MASTERCARD',
             le.actno[2]='4' and length(trim(le.actno)) IN [14,17] => 'VISA',
             le.actno[2..3] IN ['34','37'] and length(trim(le.actno)) = 16 => 'AMEX',
             ( le.actno[2..3] IN ['36','38'] or le.actno[2..4] IN ['300','305'] )
               and length(trim(le.actno))=15 => 'DINERS',
             le.actno[2..5]='6011' and length(trim(le.actno))=17 => 'DISCOVER',
             (le.actno[2]='3' or le.actno[2..5] IN ['1800','2131']) and
			  length(trim(le.actno)) IN [16,17] => 'JCB', 'UNKNOWN' );
                   
  self := le;
  end;

j := join(f,cft,left.per_id=right.per_id,
            take_right(right),KEYED(creditfile.Key_Trade_Person));

cft_o take_memname(cft_o le, creditfile.Key_Member ri) := transform
  self.MemberName := ri.name;
  self := le;
  end;

//j11 := join(j,creditfile.Key_Member,intformat((unsigned8)left.member,8,1)[1..3]+left.indust_cd+intformat((unsigned8)left.member,8,1)[4..8]=right.memnum,
j11 := join(j,creditfile.Key_Member,intformat((unsigned8)left.member,8,1)[6..8]+left.indust_cd+intformat((unsigned8)left.member,8,1)[1..5]=right.memnum,
             take_memname(left,right),left outer);

sj := sort(j11,per_id,-date_activity);


cfp := creditfile.File_Pubrec_Plus;

typeof(cfp) take_right_p(cfp le) := transform
  self := le;
  end;

jp := join(f,creditfile.File_Pubrec_Plus,left.per_id=right.per_id,
            take_right_p(right),KEYED(creditfile.Key_Pubrec_Person));

sjp := sort(jp,per_id,casenum);

per_rec := record
   unsigned4 per_id;
   string20 actno;
   unsigned decimal8 member;
  end;

per_rec take_perid(creditfile.Key_Trade_Acct le) := transform
  self := le;
  end;

j1 := join(j,creditfile.Key_Trade_Acct,left.actno=right.actno and
                                        left.member=right.member,take_perid(right));

rcnt := record
  j1.per_id;
  unsigned4 Account_Links := count(group);
  end;

t := j1;  // table(j1,rcnt,per_id);

typeof(t) take_left(t le) := transform
  self := le;
  end;

j2 := join(t,f,left.per_id=right.per_id,take_left(left),left only);

LRes := record
  //unsigned4 Account_Links;
   string20 actno;
   unsigned decimal8 member;
  creditfile.file_indic_plus;
  end;

LRes xt1(j2 le, creditfile.file_indic_plus ri) := transform
  //self.Account_Links := le.Account_Links;
  self := le;
  self := ri;
  end;

j3 := join(j2,creditfile.File_Indic_Plus,left.per_id=right.per_id,xt1(left,right),
              KEYED(creditfile.Key_Person));
//output(sort(j3,-Account_Links));
output(f);
// Output trades
putout := ~Usage IN ['5','7'];
output(choosen(sj(putout),1000));
output(choosen(sjp(putout),1000));
output(sort(j3(putout),actno,did))

/*all_trades := join(j2,cft,left.per_id=right.per_id,
            take_right(right),KEYED(creditfile.Key_Trade_Person));

ats := sort(all_trades,per_id,CardType,actno);

// Output trades
output(choosen(ats,10000))*/

endmacro;