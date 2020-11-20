#Input data
param nRows;
param cashierCount;
param cashierLength;

set ProductGroups;

param space{ProductGroups};

set Rows := 1..nRows;

set Cashiers := 1..cashierCount;

#Variables
var RowLength {Rows} >= 0;

var PutProduct{ProductGroups, Rows} binary;
var MaxLength >= 0;

#Constraints
s.t. PutExactlyInOneRow {p in ProductGroups}:
	sum{r in Rows} PutProduct[p,r] = 1;

s.t. DontPutTooMuch{r in Rows}:
	sum{p in ProductGroups} PutProduct[p,r] * space[p] <= RowLength[r];

s.t. CashiersPlace{r in Rows : r <= cashierCount}:
	cashierLength + sum{p in ProductGroups} PutProduct[p,r] * space[p] <= RowLength[r];

s.t. MaximumRowLength{r in Rows}:
	MaxLength >= RowLength[r];

#Objective function
minimize BuildLength: MaxLength;

solve;

printf "%f", MaxLength;


end;
