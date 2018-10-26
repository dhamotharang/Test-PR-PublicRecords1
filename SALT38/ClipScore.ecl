EXPORT INTEGER2 ClipScore(INTEGER i) := MAP( i < -32000 => -32000,
                                             i > 32000 => 32000,
																						 i );
