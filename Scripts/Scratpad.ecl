


// Iterate examples
integerListRec := Record
    Integer num;
End;
 
integerListEmpy := Loop(Dataset( [{0}], integerListRec ), 4, Rows(left) + Rows(left));


/*integer sequence by using counter*/
Icountup := Iterate(integerListEmpy, Transform(integerListRec, Self.num := Counter));

Output(Icountup, Named('ListOfIntegers'));
 
/*integer sequence by adding one to previous record*/
/*LEFT represents the previous record, after it has been transformed */
integerSequence := Iterate(integerListEmpy, Transform( integerListRec, Self.num := Left.num + 1 ));
Output(integerSequence, Named('integerSequence'));

/*powers of two by doubling previous record*/
integerListRec doubleUp( integerListRec PreviousRec ) := Transform
    Self.num := if( PreviousRec.num = 0, 1, PreviousRec.num * 2 );
End;

powerOfTwo := Iterate(integerListEmpy, doubleUp(Left));
Output(powerOfTwo, Named('powerOfTwo')); 

/* running sum, transform the count-up list using original record and previous record */
integerListRec runningSum( IntegerListRec PreviousRec, IntegerListRec originalRec ):=transform
    self.num:=PreviousRec.num + originalRec.num;
end;

running_Sum := Iterate( Icountup, runningSum(Left, Right));
Output(running_Sum, Named('runningSum'));

/*Factorial*/
/*LEFT is always zero value originally. RIGHT represents the original record before the iteration transform*/
integerListRec fact(IntegerListRec PreviousRec, IntegerListRec originalRec) := Transform
    Self.num := if( PreviousRec.num=0, 1, PreviousRec.num ) * originalRec.num;
End;

factorialSequence := Iterate( Icountup, fact(Left, Right));
Output(factorialSequence, Named('FactorialSequence'));


/*Fibonacci sequence by retaining previous value in an extra column*/
fibRec := record
    integer num;
    integer prev;
End;

initialFib := Dataset( [{1,0}], fibRec ); //base condition
fibListEmpty := initialFib + loop( Dataset([{0,0}], fibRec ), 4, rows(Left) + rows(Left));
//dataset with base condition in first record
 
fibRec fibStep( fibRec Prevrec, fibRec originalRec ) := Transform
Self.prev := if( Prevrec.num = 0, originalRec.prev, Prevrec.num );
Self.num := if( Prevrec.num = 0, originalRec.num, Prevrec.num + Prevrec.prev );
End;
 
fibonacciSequence := Iterate(fibListEmpty,fibStep(left,right));
Output(fibonacciSequence, Named('FibonaciSequence'));
