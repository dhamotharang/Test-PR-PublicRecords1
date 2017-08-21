flk(unsigned i ) := (string) i;
f3(unsigned i) := intformat(i,3,1 );
f6(unsigned i) := flk(i div 1000) + ',' + f3(i%1000);
f9(unsigned i) := f6( i div 1000) + ',' + f3(i % 1000);
f12(unsigned i) := f9(i div 1000) + ',' + f3(i % 1000);

UnsignedWithCommas(unsigned i) := MAP( i < 1000 => flk(i),
                                        i < 1000000 => f6(i), 
																				i < 1000000000 => f9(i),
																				i < 1000000000000 => f12(i),
																				f12(i div 1000) + f3(i%1000) );

export IntWithCommas(integer i) := if ( i < 0, '-'+UnsignedWithCommas(-i),UnsignedWithCommas(i));